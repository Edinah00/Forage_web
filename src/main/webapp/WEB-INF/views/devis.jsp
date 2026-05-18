<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Nouveau devis</title>
    <style>
        body { font-family: Arial, Helvetica, sans-serif; background: linear-gradient(135deg, #f3f7ff, #eef7f0); margin: 0; padding: 28px; color: #1f2937; }
        .card { max-width: 1100px; margin: 0 auto; background: #fff; border-radius: 18px; padding: 24px; box-shadow: 0 16px 36px rgba(15,23,42,.10); }
        h2 { margin-top: 0; }
        .grid { display: grid; gap: 16px; }
        .two { grid-template-columns: repeat(2, minmax(0, 1fr)); }
        .three { grid-template-columns: repeat(3, minmax(0, 1fr)); }
        label { display: block; font-weight: 700; margin-bottom: 6px; color: #334155; }
        input, select, textarea { width: 100%; padding: 11px 12px; border: 1px solid #cbd5e1; border-radius: 10px; box-sizing: border-box; font-size: 14px; }
        textarea { min-height: 90px; resize: vertical; }
        .btn { border: 0; border-radius: 10px; padding: 11px 16px; cursor: pointer; font-weight: 700; }
        .btn-primary { background: #2563eb; color: #fff; }
        .btn-secondary { background: #0f766e; color: #fff; }
        .btn-danger { background: #dc2626; color: #fff; }
        .btn-light { background: #e2e8f0; color: #0f172a; }
        .section { margin-top: 22px; padding-top: 22px; border-top: 1px solid #e2e8f0; }
        .muted { color: #64748b; font-size: 13px; }
        .panel { background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 14px; padding: 16px; }
        .detail-list { margin-top: 14px; display: grid; gap: 10px; }
        .detail-item { background: #fff; border: 1px solid #dbe4f0; border-radius: 12px; padding: 12px; display: grid; grid-template-columns: 1.2fr .7fr .7fr .7fr 1.2fr auto; gap: 10px; align-items: end; }
        .detail-item .value { font-size: 14px; }
        .actions { display: flex; gap: 10px; flex-wrap: wrap; }
        .alert { padding: 12px 14px; border-radius: 10px; margin-bottom: 14px; }
        .alert-success { background: #ecfdf5; color: #065f46; }
        .alert-error { background: #fef2f2; color: #991b1b; }
        .search-error {
            margin-top: 10px;
            padding: 12px 14px;
            border-radius: 12px;
            border: 1px solid #fca5a5;
            background: linear-gradient(135deg, #fff1f2, #ffe4e6);
            color: #9f1239;
            font-weight: 700;
            display: none;
        }
        .search-error.visible { display: block; }
        .search-error small {
            display: block;
            margin-top: 4px;
            font-weight: 400;
            color: #be123c;
        }
        .input-error {
            border-color: #f87171 !important;
            background: #fff1f2;
            box-shadow: 0 0 0 3px rgba(248, 113, 113, 0.14);
        }
        .hidden { display: none; }
        .table { width: 100%; border-collapse: collapse; margin-top: 14px; }
        .table th, .table td { border-bottom: 1px solid #e2e8f0; padding: 10px 8px; text-align: left; vertical-align: top; }
        .badge { display: inline-block; background: #dbeafe; color: #1d4ed8; padding: 4px 10px; border-radius: 999px; font-size: 12px; font-weight: 700; }
        .topbar { display:flex; justify-content:space-between; align-items:center; gap: 12px; margin-bottom: 18px; }
        @media (max-width: 900px) {
            .two, .three, .detail-item { grid-template-columns: 1fr; }
        }
    </style>
</head>
<body>
<div class="card">
    <div class="topbar">
        <div>
            <h2>Création de devis</h2>
            <div class="muted">Recherche de demande par référence, puis ajout des détails avant enregistrement final.</div>
        </div>
        <a class="btn btn-light" href="${pageContext.request.contextPath}/accueil">Retour accueil</a>
    </div>

    <c:if test="${not empty message}">
        <div class="alert alert-success">${message}</div>
    </c:if>
    <c:if test="${not empty error}">
        <div class="alert alert-error">${error}</div>
    </c:if>

        <div class="panel">
            <div class="grid two">
                <div>
                    <label for="refDemande">Référence demande</label>
                    <select id="refDemande">
                        <option value="">-- choisir une référence --</option>
                        <c:forEach items="${demandes}" var="demande">
                            <option value="${demande.ref_demande}">${demande.ref_demande}</option>
                        </c:forEach>
                    </select>
                    <div id="refError" class="search-error">
                        Référence introuvable.
                        <small>Choisis une référence existante dans la liste.</small>
                    </div>
                </div>
            <div>
                <label>Type de devis</label>
                <select id="typeDevis">
                    <option value="">-- choisir --</option>
                    <c:forEach items="${typesDevis}" var="type">
                        <option value="${type.idTypeDevis}">${type.libelle}</option>
                    </c:forEach>
                </select>
            </div>
        </div>

        <div id="chargementMessage" class="muted" style="margin-top: 10px;"></div>

        <div id="demandeBox" class="section hidden">
            <h3>Détail de la demande</h3>
            <table class="table">
                <tbody>
                    <tr><th>ID</th><td id="demandeId"></td></tr>
                    <tr><th>Référence</th><td id="demandeRef"></td></tr>
                    <tr><th>Client</th><td id="demandeClient"></td></tr>
                    <tr><th>Lieu</th><td id="demandeLieu"></td></tr>
                    <tr><th>Commune</th><td id="demandeCommune"></td></tr>
                    <tr><th>Date</th><td id="demandeDate"></td></tr>
                </tbody>
            </table>
        </div>
    </div>

    <div class="section">
        <div class="actions">
            <button type="button" class="btn btn-secondary" onclick="ouvrirFormulaireDetail()">+ Ajouter un détail</button>
        </div>

        <div id="formDetail" class="section hidden panel">
            <div class="grid three">
                <div>
                    <label>Libellé</label>
                    <input id="detailLibelle" type="text">
                </div>
                <div>
                    <label>Unité</label>
                    <input id="detailUnite" type="text">
                </div>
                <div>
                    <label>Quantité</label>
                    <input id="detailQuantite" type="number" step="any">
                </div>
            </div>
            <div class="grid two" style="margin-top: 12px;">
                <div>
                    <label>Prix unitaire</label>
                    <input id="detailPrix" type="number" step="any">
                </div>
                <div>
                    <label>Description</label>
                    <textarea id="detailDescription"></textarea>
                </div>
            </div>
            <div class="actions" style="margin-top: 12px;">
                <button type="button" class="btn btn-primary" onclick="enregistrerDetail()">Enregistrer le détail</button>
                <button type="button" class="btn btn-light" onclick="fermerFormulaireDetail()">Annuler</button>
            </div>
        </div>

        <div class="section">
            <h3>Détails du devis</h3>
            <div class="muted">CRUD uniquement côté JavaScript avant l'envoi final.</div>
            <div id="detailsVide" class="muted" style="margin-top: 10px;">Aucun détail ajouté.</div>
            <div id="detailsList" class="detail-list"></div>
        </div>
    </div>

    <form id="devisForm" method="post" action="${pageContext.request.contextPath}/devis/ajouter" class="section">
        <input type="hidden" name="refDemande" id="refDemandeInput">
        <input type="hidden" name="idTypeDevis" id="idTypeDevisInput">
        <div id="hiddenDetails"></div>
        <button type="button" class="btn btn-primary" onclick="soumettreDevis()">Ajouter un devis</button>
    </form>
</div>

<script>
    const contextPath = '${pageContext.request.contextPath}';
    let details = [];
    let editIndex = -1;
    window.chargerDemande = function (refValue) {
        const ref = (refValue ?? document.getElementById('refDemande').value).trim();
        const message = document.getElementById('chargementMessage');
        const refInput = document.getElementById('refDemande');
        const refError = document.getElementById('refError');

        refInput.classList.remove('input-error');
        refError.classList.remove('visible');

        if (!ref) {
            message.textContent = '';
            return;
        }

        message.textContent = 'Recherche de la demande...';

        fetch(contextPath + '/devis/demande/' + encodeURIComponent(ref))
            .then(response => {
                if (!response.ok) {
                    throw new Error('HTTP ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                if (!data) {
                    return;
                }
                const box = document.getElementById('demandeBox');
                if (!data.found || !data.demande) {
                    message.textContent = 'Aucune demande trouvée pour cette référence.';
                    refInput.classList.add('input-error');
                    refError.classList.add('visible');
                    box.classList.remove('hidden');
                    document.getElementById('demandeId').textContent = 'Introuvable';
                    document.getElementById('demandeRef').textContent = ref;
                    document.getElementById('demandeClient').textContent = '-';
                    document.getElementById('demandeLieu').textContent = '-';
                    document.getElementById('demandeCommune').textContent = '-';
                    document.getElementById('demandeDate').textContent = '-';
                    return;
                }

                const d = data.demande;
                message.textContent = 'Demande chargée.';
                refInput.classList.remove('input-error');
                refError.classList.remove('visible');
                box.classList.remove('hidden');
                document.getElementById('demandeId').textContent = d.id_demande ?? '';
                document.getElementById('demandeRef').textContent = d.ref_demande ?? '';
                document.getElementById('demandeClient').textContent = d.id_client ?? '';
                document.getElementById('demandeLieu').textContent = d.lieu_demande ?? '';
                document.getElementById('demandeCommune').textContent = d.id_commune ?? '';
                document.getElementById('demandeDate').textContent = d.date_demande ?? '';
            })
            .catch((error) => {
                message.textContent = 'Erreur lors du chargement de la demande.';
                refInput.classList.add('input-error');
                refError.classList.add('visible');
                refError.innerHTML = 'Impossible de charger la demande.<small>Vérifie la console ou réessaie après correction du serveur.</small>';
                console.error('chargement demande impossible', error);
            });
    };

    document.addEventListener('DOMContentLoaded', () => {
        const refInput = document.getElementById('refDemande');
        if (refInput) {
            refInput.addEventListener('change', () => chargerDemande(refInput.value));
            if (refInput.value) {
                chargerDemande(refInput.value);
            }
        }
    });

    function ouvrirFormulaireDetail() {
        editIndex = -1;
        document.getElementById('detailLibelle').value = '';
        document.getElementById('detailUnite').value = '';
        document.getElementById('detailQuantite').value = '';
        document.getElementById('detailPrix').value = '';
        document.getElementById('detailDescription').value = '';
        document.getElementById('formDetail').classList.remove('hidden');
    }

    function fermerFormulaireDetail() {
        document.getElementById('formDetail').classList.add('hidden');
    }

    function enregistrerDetail() {
        const detail = {
            libelle: document.getElementById('detailLibelle').value.trim(),
            unite: document.getElementById('detailUnite').value.trim(),
            quantite: document.getElementById('detailQuantite').value,
            prix_unitaire: document.getElementById('detailPrix').value,
            description: document.getElementById('detailDescription').value.trim()
        };

        if (!detail.libelle) {
            alert('Le libellé est obligatoire.');
            return;
        }

        if (editIndex >= 0) {
            details[editIndex] = detail;
        } else {
            details.push(detail);
        }

        renderDetails();
        fermerFormulaireDetail();
    }

    function editDetail(index) {
        const d = details[index];
        editIndex = index;
        document.getElementById('detailLibelle').value = d.libelle || '';
        document.getElementById('detailUnite').value = d.unite || '';
        document.getElementById('detailQuantite').value = d.quantite || '';
        document.getElementById('detailPrix').value = d.prix_unitaire || '';
        document.getElementById('detailDescription').value = d.description || '';
        document.getElementById('formDetail').classList.remove('hidden');
    }

    function deleteDetail(index) {
        details.splice(index, 1);
        renderDetails();
    }

    function renderDetails() {
        const container = document.getElementById('detailsList');
        const empty = document.getElementById('detailsVide');
        container.innerHTML = '';

        if (!details.length) {
            empty.classList.remove('hidden');
            return;
        }

        empty.classList.add('hidden');

        details.forEach((d, index) => {
            const item = document.createElement('div');
            item.className = 'detail-item';
            item.innerHTML =
                '<div><div class="muted">Libellé</div><div class="value">' + escapeHtml(d.libelle) + '</div></div>' +
                '<div><div class="muted">Unité</div><div class="value">' + escapeHtml(d.unite) + '</div></div>' +
                '<div><div class="muted">Quantité</div><div class="value">' + escapeHtml(d.quantite) + '</div></div>' +
                '<div><div class="muted">Prix</div><div class="value">' + escapeHtml(d.prix_unitaire) + '</div></div>' +
                '<div><div class="muted">Description</div><div class="value">' + escapeHtml(d.description) + '</div></div>' +
                '<div class="actions">' +
                    '<button type="button" class="btn btn-light" onclick="editDetail(' + index + ')">Modifier</button>' +
                    '<button type="button" class="btn btn-danger" onclick="deleteDetail(' + index + ')">Supprimer</button>' +
                '</div>';
            container.appendChild(item);
        });
    }

    function soumettreDevis() {
        const ref = document.getElementById('refDemande').value.trim();
        const idType = document.getElementById('typeDevis').value;

        if (!ref) {
            alert('La référence de demande est obligatoire.');
            return;
        }

        if (!idType) {
            alert('Le type de devis est obligatoire.');
            return;
        }

        if (!details.length) {
            alert('Ajoute au moins un détail avant d’enregistrer le devis.');
            return;
        }

        document.getElementById('refDemandeInput').value = ref;
        document.getElementById('idTypeDevisInput').value = idType;

        const hiddenDetails = document.getElementById('hiddenDetails');
        hiddenDetails.innerHTML = '';

        details.forEach((d, index) => {
            hiddenDetails.insertAdjacentHTML('beforeend',
                '<input type="hidden" name="libelles" value="' + escapeAttribute(d.libelle) + '">' +
                '<input type="hidden" name="unites" value="' + escapeAttribute(d.unite) + '">' +
                '<input type="hidden" name="quantites" value="' + escapeAttribute(d.quantite) + '">' +
                '<input type="hidden" name="prixUnitaires" value="' + escapeAttribute(d.prix_unitaire) + '">' +
                '<input type="hidden" name="descriptions" value="' + escapeAttribute(d.description) + '">'
            );
        });

        document.getElementById('devisForm').submit();
    }

    function escapeHtml(value) {
        return String(value ?? '')
            .replaceAll('&', '&amp;')
            .replaceAll('<', '&lt;')
            .replaceAll('>', '&gt;')
            .replaceAll('"', '&quot;')
            .replaceAll("'", '&#039;');
    }

    function escapeAttribute(value) {
        return escapeHtml(value).replaceAll('`', '&#096;');
    }

    renderDetails();
</script>
</body>
</html>
