<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Devis — ForageWeb</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
<style>
:root{
  --bg:#0d1117; --surface:#161b22; --surface2:#21262d;
  --border:#30363d; --border-light:#21262d;
  --primary:#2f81f7; --primary-dim:rgba(47,129,247,.15);
  --success:#3fb950; --success-dim:rgba(63,185,80,.15);
  --danger:#f85149;  --danger-dim:rgba(248,81,73,.15);
  --warn:#d29922;    --warn-dim:rgba(210,153,34,.15);
  --text:#e6edf3; --muted:#8b949e; --muted2:#6e7681;
  --radius:12px; --radius-sm:8px;
  --font-head:'Syne',sans-serif; --font-body:'DM Sans',sans-serif;
}
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:var(--font-body);background:var(--bg);color:var(--text);min-height:100vh;font-size:15px}
.nav{position:sticky;top:0;z-index:100;background:rgba(13,17,23,.85);backdrop-filter:blur(16px);border-bottom:1px solid var(--border);padding:0 24px;height:56px;display:flex;align-items:center;justify-content:space-between}
.brand{font-family:var(--font-head);font-size:1.15rem;color:var(--text);text-decoration:none;letter-spacing:-.02em}
.brand em{color:var(--primary);font-style:normal}
.nav-links{display:flex;gap:4px}
.nav-links a{color:var(--muted);text-decoration:none;padding:6px 12px;border-radius:var(--radius-sm);font-size:.9rem;font-weight:500;transition:all .15s}
.nav-links a:hover{background:var(--surface2);color:var(--text)}
.nav-links a.active{background:var(--primary-dim);color:var(--primary)}
.page{max-width:1180px;margin:32px auto;padding:0 20px;display:flex;flex-direction:column;gap:24px}
.page-title{font-family:var(--font-head);font-size:1.8rem;letter-spacing:-.03em}
.page-sub{color:var(--muted);margin-top:4px;font-size:.95rem}
.alert{padding:14px 18px;border-radius:var(--radius);font-size:.95rem;display:flex;align-items:center;gap:10px;border:1px solid}
.alert-ok{background:var(--success-dim);color:var(--success);border-color:rgba(63,185,80,.3)}
.alert-err{background:var(--danger-dim);color:var(--danger);border-color:rgba(248,81,73,.3)}
.card{background:var(--surface);border:1px solid var(--border);border-radius:16px;padding:24px}
.card-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;padding-bottom:16px;border-bottom:1px solid var(--border)}
.card-title{font-family:var(--font-head);font-size:1.05rem;letter-spacing:-.02em}
.form-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}
.full{grid-column:1/-1}
.field{display:flex;flex-direction:column;gap:7px}
.field label{font-size:.85rem;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.06em}
.field input,.field select,.field textarea{background:var(--surface2);border:1px solid var(--border);border-radius:var(--radius-sm);padding:11px 14px;color:var(--text);font-family:var(--font-body);font-size:.95rem;outline:none;transition:border-color .2s,box-shadow .2s}
.field input:focus,.field select:focus,.field textarea:focus{border-color:var(--primary);box-shadow:0 0 0 3px var(--primary-dim)}
.field select option{background:var(--surface2)}
.form-actions{margin-top:20px;display:flex;justify-content:flex-end;gap:10px}
.btn{display:inline-flex;align-items:center;gap:6px;padding:9px 16px;border-radius:var(--radius-sm);font-family:var(--font-body);font-size:.9rem;font-weight:600;text-decoration:none;cursor:pointer;border:1px solid transparent;transition:all .15s}
.btn-primary{background:var(--primary);color:#fff}
.btn-primary:hover{background:#388bfd;transform:translateY(-1px);box-shadow:0 4px 14px rgba(47,129,247,.3)}
.btn-ghost{background:transparent;color:var(--muted);border-color:var(--border)}
.btn-ghost:hover{background:var(--surface2);color:var(--text)}
.btn-sm{padding:6px 12px;font-size:.83rem}
table{width:100%;border-collapse:collapse;margin-top:12px}
th{padding:10px 14px;text-align:left;font-size:.78rem;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.06em;border-bottom:1px solid var(--border)}
td{padding:12px 14px;border-bottom:1px solid var(--border-light);vertical-align:middle;font-size:.93rem}
tbody tr:hover{background:var(--surface2)}
.badge{display:inline-flex;align-items:center;gap:4px;padding:3px 10px;border-radius:999px;font-size:.8rem;font-weight:600}
.badge-blue{background:var(--primary-dim);color:var(--primary)}
.badge-gray{background:rgba(139,148,158,.15);color:var(--muted)}
.badge-red{background:var(--danger-dim);color:var(--danger)}
.row-actions{display:flex;gap:6px;flex-wrap:wrap}
.section{margin-top:12px;padding-top:12px}
.detail-item{background:var(--surface2);border:1px solid var(--border);border-radius:var(--radius-sm);padding:12px;display:grid;grid-template-columns:1.2fr .7fr .7fr .7fr 1.2fr auto;gap:10px;align-items:center}
.muted{color:var(--muted);font-size:.9rem}
.hidden{display:none}
.search-error{margin-top:8px;padding:10px 12px;border-radius:var(--radius-sm);border:1px solid rgba(248,81,73,.3);background:var(--danger-dim);color:var(--danger);font-size:.9rem;display:none}
.search-error.visible{display:block}
.input-error{border-color:var(--danger)!important;box-shadow:0 0 0 3px var(--danger-dim)}
@media(max-width:700px){.form-grid{grid-template-columns:1fr}.detail-item{grid-template-columns:1fr}.nav{padding:0 14px}.page{padding:0 12px;margin:16px auto}}
</style>
</head>
<body>

<nav class="nav">
  <a class="brand" href="${pageContext.request.contextPath}/accueil">Forage<em>Web</em></a>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/accueil">Accueil</a>
    <a href="${pageContext.request.contextPath}/formulaire">Demandes</a>
    <a href="${pageContext.request.contextPath}/devis" class="active">Devis</a>
    <a href="${pageContext.request.contextPath}/form_demande_status">Statuts</a>
  </div>
</nav>

<div class="page">
  <div>
    <h1 class="page-title">Devis</h1>
    <p class="page-sub">Créez et gérez les devis associés aux demandes.</p>
  </div>

  <c:if test="${not empty message}">
    <div class="alert alert-ok">✅ ${message}</div>
  </c:if>
  <c:if test="${not empty error}">
    <div class="alert alert-err">❌ ${error}</div>
  </c:if>

<div class="card">
    <div class="card-header">
      <span class="card-title">Nouveau devis</span>
    </div>
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
                        <option value="${type.idTypeDevis}" <c:if test="${type.idTypeDevis == 2}">id="typeForageOption"</c:if>>${type.libelle}</option>
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
                    mettreAJourForage(false);
                    document.getElementById('demandeId').textContent = 'Introuvable';
                    document.getElementById('demandeRef').textContent = ref;
                    document.getElementById('demandeClient').textContent = '-';
                    document.getElementById('demandeLieu').textContent = '-';
                    document.getElementById('demandeCommune').textContent = '-';
                    document.getElementById('demandeDate').textContent = '-';
                    return;
                }

                const d = data.demande;
                const peutForage = !!data.peut_forage;
                message.textContent = 'Demande chargée.';
                refInput.classList.remove('input-error');
                refError.classList.remove('visible');
                box.classList.remove('hidden');
                mettreAJourForage(peutForage);
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
        const forageOption = document.getElementById('typeForageOption');

        if (!ref) {
            alert('La référence de demande est obligatoire.');
            return;
        }

        if (!idType) {
            alert('Le type de devis est obligatoire.');
            return;
        }

        if (forageOption && forageOption.disabled && String(idType) === String(forageOption.value)) {
            alert('Le devis Forage n’est pas encore autorisé pour cette demande.');
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

    function mettreAJourForage(autorise) {
        const forageOption = document.getElementById('typeForageOption');
        if (!forageOption) {
            return;
        }
        forageOption.disabled = !autorise;
        forageOption.title = autorise
            ? ''
            : 'Disponible seulement après le statut DEC';

        const typeSelect = document.getElementById('typeDevis');
        if (!autorise && String(typeSelect.value) === String(forageOption.value)) {
            typeSelect.value = '';
        }
    }

    renderDetails();
</script>
</body>
</html>
