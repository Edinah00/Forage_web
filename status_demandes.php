<?php
function fetchApiJson(string $url): ?array {
    $ch = curl_init($url);
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);
    curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
    curl_setopt($ch, CURLOPT_TIMEOUT, 10);
    $response = curl_exec($ch);
    $error = curl_error($ch);
    $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
    curl_close($ch);

    if ($response === false || $httpCode >= 400) {
        return ['error' => $error ?: "HTTP $httpCode", 'body' => $response];
    }

    $data = json_decode($response, true);
    if ($data === null && json_last_error() !== JSON_ERROR_NONE) {
        return ['error' => 'JSON parse error: ' . json_last_error_msg(), 'body' => $response];
    }

    return $data;
}

$apiBase = $_GET['api_base'] ?? 'http://localhost:8080/forage';
$ref = trim($_GET['ref'] ?? '');
$date = trim($_GET['date'] ?? '');

$apiUrl = rtrim($apiBase, '/') . '/demande_status/api';
$query = [];
if ($ref !== '') {
    $query['ref'] = $ref;
}
if ($date !== '') {
    $query['date'] = $date;
}
if (!empty($query)) {
    $apiUrl .= '?' . http_build_query($query);
}

$apiResult = fetchApiJson($apiUrl);
$apiError = null;
$statuses = [];
$demande = null;
$total = 0;

if (isset($apiResult['error'])) {
    $apiError = $apiResult['error'];
} else {
    if (!empty($apiResult['found']) || array_key_exists('found', $apiResult)) {
        if (!empty($apiResult['demande'])) {
            $demande = $apiResult['demande'];
        }
        $statuses = $apiResult['statuses'] ?? [];
        $total = $apiResult['total'] ?? count($statuses);
    } else {
        $apiError = 'Réponse API invalide.';
    }
}

function niceDuration($minutes) {
    if ($minutes === null || $minutes === '') {
        return '-';
    }
    $m = (int)$minutes;
    if ($m <= 0) {
        return '-';
    }
    $hours = intdiv($m, 60);
    $rest = $m % 60;
    return ($hours > 0 ? $hours . ' h' : '') . ($rest > 0 ? ' ' . $rest . ' min' : '');
}

function statusLabel($idStatus) {
    $map = [
        1 => 'DC',
        2 => 'DA',
        3 => 'DEC',
        4 => 'DER',
        5 => 'DFC',
        6 => 'DFR',
    ];
    return $map[$idStatus] ?? 'S' . $idStatus;
}

function statusColor($idStatus, $fallback = '#999999') {
    $map = [
        1 => '#6c757d',
        2 => '#28a745',
        3 => '#fd7e14',
        4 => '#007bff',
        5 => '#20c997',
        6 => '#dc3545',
    ];
    return $map[$idStatus] ?? $fallback;
}

function mapColorName($colorName) {
    $colorMap = [
        'vert' => '#28a745',
        'jaune' => '#ffc107',
        'rouge' => '#dc3545',
        'gris' => '#6c757d',
        'bleu' => '#007bff',
        'cyan' => '#20c997',
        'orange' => '#fd7e14',
    ];
    $colorLower = strtolower(trim($colorName));
    return $colorMap[$colorLower] ?? $colorName;
}


?>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Statuts Demandes - API Forage</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 24px; background: #f5f7fb; color: #212529; }
        .container { max-width: 1100px; margin: 0 auto; background: #fff; padding: 24px; border-radius: 12px; box-shadow: 0 12px 30px rgba(0,0,0,0.08); }
        h1 { margin-top: 0; font-size: 2rem; }
        .form-row { display: flex; flex-wrap: wrap; gap: 14px; margin-bottom: 20px; }
        label { display: block; margin-bottom: 6px; font-weight: 600; }
        input[type="text"], input[type="date"] { width: 100%; padding: 10px 12px; border: 1px solid #ccd0d5; border-radius: 8px; }
        .form-group { flex: 1 1 220px; min-width: 180px; }
        button { border: none; background: #007bff; color: #fff; padding: 12px 20px; border-radius: 8px; cursor: pointer; font-weight: 600; }
        button:hover { background: #0069d9; }
        .alert { padding: 14px 16px; border-radius: 10px; margin-bottom: 20px; }
        .alert-error { background: #ffe3e3; color: #842029; border: 1px solid #f5c2c7; }
        .meta { margin-bottom: 20px; }
        .meta strong { display: inline-block; width: 150px; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 14px 12px; border-bottom: 1px solid #e9ecef; text-align: left; }
        th { background: #f8f9fa; font-weight: 700; }
        tr:hover { background: #f8f9ff; }
        .badge { display: inline-flex; align-items: center; gap: 6px; padding: 6px 10px; border-radius: 999px; font-size: 0.92rem; color: #212529; background: transparent; border: 1px solid #e9ecef; }
        .legend { display: grid; grid-template-columns: repeat(auto-fit, minmax(180px,1fr)); gap: 10px; margin-top: 18px; }
        .legend-item { padding: 10px 14px; border-radius: 10px; background: #f8f9fa; }
        .meta-row { display: flex; flex-wrap: wrap; gap: 14px; }
        .meta-row div { min-width: 220px; }
    </style>
</head>
<body>
<div class="container">
    <h1>Statuts des demandes</h1>

    <form method="get" class="form-row">
        
        <div class="form-group">
            <label for="ref">Référence demande</label>
            <input id="ref" name="ref" type="text" value="<?php echo htmlspecialchars($ref); ?>" placeholder="Ex: DEM-20240602-0001" />
        </div>
        <div class="form-group">
            <label for="date">Date du statut</label>
            <input id="date" name="date" type="date" value="<?php echo htmlspecialchars($date); ?>" />
        </div>
        <div class="form-group" style="align-self:flex-end;">
            <button type="submit">Rechercher</button>
        </div>
    </form>

    <?php if ($apiError !== null): ?>
        <div class="alert alert-error">Erreur API : <?php echo htmlspecialchars($apiError); ?></div>
    <?php else: ?>
        <div class="meta">
            <div class="meta-row">
                <div><strong>Total statut(s) :</strong> <?php echo (int)$total; ?></div>
                <div><strong>Référence filtre :</strong> <?php echo $ref !== '' ? htmlspecialchars($ref) : 'Aucun'; ?></div>
                <div><strong>Date filtre :</strong> <?php echo $date !== '' ? htmlspecialchars($date) : 'Aucune'; ?></div>
            </div>
        </div>

        <?php if ($demande !== null): ?>
            <div class="meta-row">
                <div><strong>Demande ID :</strong> <?php echo htmlspecialchars($demande['id_demande']); ?></div>
                <div><strong>Ref :</strong> <?php echo htmlspecialchars($demande['ref_demande']); ?></div>
                <div><strong>Lieu :</strong> <?php echo htmlspecialchars($demande['lieu_demande']); ?></div>
                <div><strong>Date demande :</strong> <?php echo htmlspecialchars($demande['date_demande']); ?></div>
            </div>
        <?php endif; ?>

        <?php if (empty($statuses)): ?>
            <div class="alert alert-error">Aucun statut trouvé pour ces filtres.</div>
        <?php else: ?>
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Demande</th>
                        <th>Statut</th>
                        <th>Couleur</th>
                        <th>Date statut</th>
                        <th>Durée travail</th>
                        <th>Observation</th>
                    </tr>
                </thead>
                <tbody>
                <?php foreach ($statuses as $status): ?>
                        <?php
                            $duration = $status['duree_travail_minutes'] ?? null;
                            $color = $status['couleur'] ?? '';
                        ?>
                    <tr>
                        <td><?php echo htmlspecialchars($status['id']); ?></td>
                        <td><?php echo htmlspecialchars($status['id_demande']); ?></td>
                        <td>
                            <span class="badge">
                                <?php echo htmlspecialchars(statusLabel($status['id_status'])); ?>
                            </span>
                        </td>
                        <td>
                            <?php echo htmlspecialchars($color !== '' ? $color : '-'); ?>
                        </td>
                        <td><?php echo htmlspecialchars($status['date_status'] ?? '-'); ?></td>
                        <td><?php echo htmlspecialchars(niceDuration($status['duree_travail_minutes'] ?? null)); ?></td>
                        <td><?php echo htmlspecialchars($status['observation'] ?? '-'); ?></td>
                    </tr>
                <?php endforeach; ?>
                </tbody>
            </table>

            <div class="legend">
                <div class="legend-item"><strong>DC</strong> : Demande créée</div>
                <div class="legend-item"><strong>DA</strong> : Demande acceptée</div>
                <div class="legend-item"><strong>DEC</strong> : En cours</div>
                <div class="legend-item"><strong>DER</strong> : En révision</div>
                <div class="legend-item"><strong>DFC</strong> : Fermée confirmée</div>
                <div class="legend-item"><strong>DFR</strong> : Fermée refusée</div>
            </div>
        <?php endif; ?>
    <?php endif; ?>
</div>
</body>
</html>
