<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Modifier devis #${devis.id_devis} — Forage Web</title>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:Arial,Helvetica,sans-serif;background:#f0f4fa;color:#1e293b;min-height:100vh}
.navbar{background:linear-gradient(90deg,#0f172a,#1e3a8a);padding:0 24px;display:flex;align-items:center;justify-content:space-between;height:60px;box-shadow:0 2px 12px rgba(15,23,42,.25)}
.navbar-brand{color:#fff;font-size:1.2rem;font-weight:700;text-decoration:none}
.navbar-brand span{color:#60a5fa}
.navbar-links{display:flex;gap:6px}
.navbar-links a{color:#cbd5e1;text-decoration:none;padding:7px 13px;border-radius:8px;font-size:.93rem;transition:background .15s}
.navbar-links a:hover,.navbar-links a.active{background:rgba(255,255,255,.12);color:#fff}

.page{max-width:1100px;margin:28px auto;padding:0 16px;display:flex;flex-direction:column;gap:20px}
.page-header h1{font-size:1.55rem;color:#0f172a}
.page-header p{font-size:.93rem;color:#64748b;margin-top:4px}

.card{background:#fff;border-radius:14px;padding:24px;box-shadow:0 4px 20px rgba(15,23,42,.07)}
.card-title{font-size:1.05rem;font-weight:700;color:#0f172a;margin-bottom:18px;padding-bottom:10px;border-bottom:2px solid #e5e7eb}

.form-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:14px}
.field{display:flex;flex-direction:column;gap:7px}
.field label{font-size:.9rem;font-weight:700;color:#334155}
.field input,.field select,.field textarea{border:1px solid #dbe3ef;border-radius:10px;padding:10px 13px;font-size:.95rem;background:#fff;outline:none;transition:border-color .2s,box-shadow .2s;font-family:inherit}
.field input:focus,.field select:focus,.field textarea:focus{border-color:#2563eb;box-shadow:0 0 0 3px rgba(37,99,235,.1)}
.field textarea{resize:vertical;min-height:60px}

.lines-table-wrap{overflow-x:auto;margin-top:8px}
#lines-table{width:100%;border-collapse:collapse;min-width:800px}
#lines-table th{background:#eef4ff;color:#1e3a8a;font-size:.84rem;font-weight:700;text-transform:uppercase;letter-spacing:.04em;padding:10px}
#lines-table td{padding:8px 6px;border-bottom:1px solid #f1f5f9;vertical-align:top}
#lines-table input,#lines-table select,#lines-table textarea{width:100%;border:1px solid #dbe3ef;border-radius:8px;padding:8px 10px;font-size:.9rem;background:#fff;outline:none;font-family:inherit}
#lines-table input:focus,#lines-table textarea:focus{border-color:#2563eb;box-shadow:0 0 0 2px rgba(37,99,235,.1)}
#lines-table .montant-cell{font-weight:700;color:#1e3a8a;text-align:right;padding-right:8px;white-space:nowrap}
#lines-table .del-btn{background:#fef2f2;color:#dc2626;border:0;border-radius:8px;padding:7px 12px;cursor:pointer;font-size:1rem;transition:background .15s}
#lines-table .del-btn:hover{background:#fee2e2}
.tfoot-total{background:#f8faff;font-weight:700;text-align:right;padding:10px;border-top:2px solid #2563eb;color:#1e3a8a;font-size:1rem}

.add-line-btn{display:inline-flex;align-items:center;gap:6px;margin-top:12px;padding:9px 16px;border-radius:10px;background:#eff6ff;color:#2563eb;font-weight:700;font-size:.92rem;border:0;cursor:pointer;transition:background .15s}
.add-line-btn:hover{background:#dbeafe}
.actions{margin-top:20px;display:flex;justify-content:flex-end;gap:10px}
.btn{display:inline-flex;align-items:center;gap:7px;padding:11px 20px;border-radius:10px;font-size:.95rem;font-weight:700;text-decoration:none;cursor:pointer;border:0;transition:transform .15s,background .15s}
.btn-primary{background:#2563eb;color:#fff;box-shadow:0 4px 14px rgba(37,99,235,.2)}
.btn-primary:hover{background:#1d4ed8;transform:translateY(-1px)}
.btn-secondary{background:#f1f5f9;color:#475569}
.btn-secondary:hover{background:#e2e8f0}
</style>
</head>
<body>

<nav class="navbar">
  <a class="navbar-brand" href="${pageContext.request.contextPath}/accueil">Forage<span>Web</span></a>
  <div class="navbar-links">
    <a href="${pageContext.request.contextPath}/accueil">Accueil</a>
    <a href="${pageContext.request.contextPath}/formulaire">Demandes</a>
    <a class="active" href="${pageContext.request.contextPath}/devis">Devis</a>
  </div>
</nav>

<div class="page">
  <div class="page-header">
    <h1>✏️ Modifier le devis #${devis.id_devis}</h1>
    <p>Modifiez les informations et les lignes, puis enregistrez.</p>
  </div>

  <div class="card">
    <div class="card-title">📋 Informations générales</div>
    <form id="devis-form"
          action="${pageContext.request.contextPath}/devis/modifier"
          method="post">
      <input type="hidden" name="id_devis" value="${devis.id_devis}"/>

      <div class="form-grid">
        <div class="field">
          <label>Demande concernée *</label>
          <select name="id_demande" required>
            <option value="">— Choisir —</option>
            <c:forEach var="dem" items="${demandes}">
              <c:set var="nomCl" value="Client #${dem.id_client}"/>
              <c:forEach var="cl" items="${clients}">
                <c:if test="${cl.idClient == dem.id_client}"><c:set var="nomCl" value="${cl.nomClient}"/></c:if>
              </c:forEach>
              <option value="${dem.id_demande}" <c:if test="${dem.id_demande == devis.id_demande}">selected</c:if>>
                #${dem.id_demande} — ${dem.lieu_demande} (${nomCl})
              </option>
            </c:forEach>
          </select>
        </div>
        <div class="field">
          <label>Date du devis *</label>
          <input type="date" name="date_devis" value="${devis.date_devis}" required/>
        </div>
      </div>

      <div class="card-title" style="margin-top:24px">🧾 Lignes de détail</div>
      <div class="lines-table-wrap">
        <table id="lines-table">
          <thead>
            <tr>
              <th style="width:22%">Libellé *</th>
              <th style="width:9%">Unité</th>
              <th style="width:9%">Qté *</th>
              <th style="width:12%">Prix unit. *</th>
              <th style="width:20%">Description</th>
              <th style="width:12%">Montant</th>
              <th style="width:5%"></th>
            </tr>
          </thead>
          <tbody id="lines-body"></tbody>
          <tfoot>
            <tr>
              <td colspan="5"></td>
              <td class="tfoot-total" id="grand-total">0 Ar</td>
              <td></td>
            </tr>
          </tfoot>
        </table>
      </div>
      <button type="button" class="add-line-btn" onclick="addLine()">➕ Ajouter une ligne</button>

      <div class="actions">
        <a class="btn btn-secondary" href="${pageContext.request.contextPath}/devis/${devis.id_devis}">Annuler</a>
        <button class="btn btn-primary" type="submit">💾 Enregistrer les modifications</button>
      </div>
    </form>
  </div>
</div>

<%-- Données des lignes existantes injectées en JSON pour JS --%>
<script>
const existingLines = [
  <c:forEach var="det" items="${details}" varStatus="st">
  {
    libelle: "${det.libelle}",
    unite:   "${det.unite}",
    qty:     ${det.quantite},
    pu:      ${det.prix_unitaire},
    desc:    "${det.description != null ? det.description : ''}"
  }<c:if test="${!st.last}">,</c:if>
  </c:forEach>
];

function fmt(n){return Number(n).toLocaleString('fr-FR')+' Ar'}

function updateTotal(){
  let total=0;
  document.querySelectorAll('.line-row').forEach(row=>{
    const q=parseFloat(row.querySelector('.qty').value)||0;
    const p=parseFloat(row.querySelector('.pu').value)||0;
    row.querySelector('.montant').textContent=fmt(q*p);
    total+=q*p;
  });
  document.getElementById('grand-total').textContent=fmt(total);
}

function addLine(l){
  l=l||{};
  const tbody=document.getElementById('lines-body');
  const tr=document.createElement('tr');
  tr.className='line-row';
  tr.innerHTML=`
    <td><input type="text"   name="libelles"       class="libelle" value="${'${l.libelle||''}'}" required></td>
    <td><input type="text"   name="unites"         class="unite"   value="${'${l.unite||''}'}"></td>
    <td><input type="number" name="quantites"      class="qty"     value="${'${l.qty||1}'}" min="0" step="0.01"></td>
    <td><input type="number" name="prix_unitaires" class="pu"      value="${'${l.pu||''}'}" min="0" step="0.01" required></td>
    <td><textarea name="descriptions" class="desc" rows="2">${'${l.desc||''}'}</textarea></td>
    <td class="montant-cell"><span class="montant">0 Ar</span></td>
    <td><button type="button" class="del-btn" onclick="removeLine(this)">✕</button></td>
  `;
  tbody.appendChild(tr);
  tr.querySelector('.qty').addEventListener('input',updateTotal);
  tr.querySelector('.pu').addEventListener('input',updateTotal);
  updateTotal();
}

function removeLine(btn){
  if(document.querySelectorAll('.line-row').length<=1){alert('Au moins une ligne requise.');return;}
  btn.closest('tr').remove();
  updateTotal();
}

// Charger les lignes existantes
if(existingLines.length>0){existingLines.forEach(addLine);}
else{addLine();}
</script>
</body>
</html>
