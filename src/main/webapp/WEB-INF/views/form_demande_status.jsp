<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn"   uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Ajouter un statut — ForageWeb</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
<style>
:root{
  --bg:#0d1117;--surface:#161b22;--surface2:#21262d;--border:#30363d;
  --primary:#2f81f7;--primary-dim:rgba(47,129,247,.15);
  --success:#3fb950;--success-dim:rgba(63,185,80,.15);
  --text:#e6edf3;--muted:#8b949e;
  --font-head:'Syne',sans-serif;--font-body:'DM Sans',sans-serif;
  --radius:12px;--radius-sm:8px;
}
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:var(--font-body);background:var(--bg);color:var(--text);min-height:100vh}
.nav{position:sticky;top:0;z-index:100;background:rgba(13,17,23,.85);backdrop-filter:blur(16px);border-bottom:1px solid var(--border);padding:0 24px;height:56px;display:flex;align-items:center;justify-content:space-between}
.brand{font-family:var(--font-head);font-size:1.15rem;color:var(--text);text-decoration:none}
.brand em{color:var(--primary);font-style:normal}
.nav-links{display:flex;gap:4px}
.nav-links a{color:var(--muted);text-decoration:none;padding:6px 12px;border-radius:var(--radius-sm);font-size:.9rem;font-weight:500;transition:all .15s}
.nav-links a:hover{background:var(--surface2);color:var(--text)}
.nav-links a.active{background:var(--primary-dim);color:var(--primary)}

.page{max-width:720px;margin:40px auto;padding:0 20px;display:flex;flex-direction:column;gap:24px}
.page-head{display:flex;align-items:flex-start;justify-content:space-between;flex-wrap:wrap;gap:12px}
.page-title{font-family:var(--font-head);font-size:1.8rem;letter-spacing:-.03em}
.page-sub{color:var(--muted);margin-top:4px;font-size:.95rem}

.alert{padding:14px 18px;border-radius:var(--radius);font-size:.95rem;display:flex;align-items:center;gap:10px;border:1px solid}
.alert-ok{background:var(--success-dim);color:var(--success);border-color:rgba(63,185,80,.3)}
.alert-err{background:rgba(248,81,73,.1);color:#f85149;border-color:rgba(248,81,73,.3)}

.card{background:var(--surface);border:1px solid var(--border);border-radius:16px;padding:28px}
.card-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;padding-bottom:16px;border-bottom:1px solid var(--border)}
.card-title{font-family:var(--font-head);font-size:1.05rem}

.form-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}
.full{grid-column:1/-1}
.field{display:flex;flex-direction:column;gap:7px}
.field label{font-size:.83rem;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.06em}
.field input,.field select,.field textarea{background:var(--surface2);border:1px solid var(--border);border-radius:var(--radius-sm);padding:11px 14px;color:var(--text);font-family:var(--font-body);font-size:.95rem;outline:none;transition:border-color .2s,box-shadow .2s}
.field input:focus,.field select:focus,.field textarea:focus{border-color:var(--primary);box-shadow:0 0 0 3px var(--primary-dim)}
.field select option{background:var(--surface2)}
.field textarea{min-height:80px;resize:vertical}
.field-hint{font-size:.8rem;color:var(--muted);margin-top:2px}

.form-actions{margin-top:20px;display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:10px}
.form-actions-right{display:flex;gap:10px}
.btn{display:inline-flex;align-items:center;gap:6px;padding:9px 16px;border-radius:var(--radius-sm);font-family:var(--font-body);font-size:.9rem;font-weight:600;text-decoration:none;cursor:pointer;border:1px solid transparent;transition:all .15s}
.btn-primary{background:var(--primary);color:#fff}
.btn-primary:hover{background:#388bfd;transform:translateY(-1px);box-shadow:0 4px 14px rgba(47,129,247,.3)}
.btn-ghost{background:transparent;color:var(--muted);border-color:var(--border)}
.btn-ghost:hover{background:var(--surface2);color:var(--text)}

.sel-info{font-size:.85rem;color:var(--primary);margin-top:6px;min-height:20px}
</style>
</head>
<body>

<nav class="nav">
  <a class="brand" href="${pageContext.request.contextPath}/accueil">Forage<em>Web</em></a>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/accueil">Accueil</a>
    <a href="${pageContext.request.contextPath}/formulaire">Demandes</a>
    <a href="${pageContext.request.contextPath}/devis">Devis</a>
    <a href="${pageContext.request.contextPath}/form_demande_status" class="active">Statuts</a>
  </div>
</nav>

<div class="page">

  <div class="page-head">
    <div>
      <h1 class="page-title">Ajouter un statut</h1>
      <p class="page-sub">Enregistrez une transition de statut pour une demande.</p>
    </div>
    <a class="btn btn-ghost" href="${pageContext.request.contextPath}/demande_status/liste">Voir la liste →</a>
  </div>

  <c:if test="${not empty message}">
    <div class="alert alert-ok">✅ ${message}</div>
  </c:if>
  <c:if test="${not empty erreur}">
    <div class="alert alert-err">❌ ${erreur}</div>
  </c:if>

  <div class="card">
    <div class="card-header">
      <span class="card-title">Nouveau statut</span>
    </div>

    <form:form action="${pageContext.request.contextPath}/demande_status/ajouter"
               method="post" modelAttribute="demandeStatus">

      <div class="form-grid">

        <div class="field">
          <label>Demande <span style="color:#f85149">*</span></label>
          <select id="refDemande" onchange="syncDemandeId(this)">
            <option value="">— Sélectionner une demande —</option>
            <c:forEach items="${demandes}" var="d">
              <option value="${d.id_demande}" data-ref="${fn:trim(d.ref_demande)}">
                ${fn:trim(d.ref_demande)} (#${d.id_demande})
              </option>
            </c:forEach>
          </select>
          <form:input path="id_demande" type="hidden" id="idDemandeInput"/>
          <div id="selInfo" class="sel-info"></div>
        </div>

        <div class="field">
          <label>Statut <span style="color:#f85149">*</span></label>
          <form:select path="id_status" id="idStatus">
            <form:option value="">— Sélectionner un statut —</form:option>
            <c:forEach items="${statuses}" var="st">
              <form:option value="${st.value}">${st.key}</form:option>
            </c:forEach>
          </form:select>
        </div>

        <div class="field">
          <label>Date et heure <span style="color:#f85149">*</span></label>
          <form:input path="date_status" type="datetime-local" id="dateStatus" step="60"/>
          <div class="field-hint">L'heure exacte sera enregistrée automatiquement.</div>
        </div>

        <div class="field full">
          <label>Observation</label>
          <form:textarea path="observation" id="observation"
                         placeholder="Remarques, motif de refus, informations complémentaires…"/>
        </div>

      </div>

      <div class="form-actions">
        <span></span>
        <div class="form-actions-right">
          <a class="btn btn-ghost" href="${pageContext.request.contextPath}/demande_status/liste">Annuler</a>
          <button type="submit" class="btn btn-primary">Enregistrer le statut</button>
        </div>
      </div>

    </form:form>
  </div>

</div>

<script>
window.syncDemandeId = function(sel) {
  const opt = sel?.selectedOptions?.[0];
  const val = opt ? opt.value : '';
  document.getElementById('idDemandeInput').value = val;
  document.getElementById('selInfo').textContent  = val
    ? 'Demande sélectionnée : ' + (opt.dataset.ref || '') + ' (ID ' + val + ')'
    : '';
};

document.addEventListener('DOMContentLoaded', () => {
  const dt = document.getElementById('dateStatus');
  if (dt && !dt.value) {
    const now = new Date();
    const pad = n => String(n).padStart(2,'0');
    dt.value = now.getFullYear()
      + '-' + pad(now.getMonth() + 1)
      + '-' + pad(now.getDate())
      + 'T' + pad(now.getHours())
      + ':' + pad(now.getMinutes());
  }
});
</script>
</body>
</html>
