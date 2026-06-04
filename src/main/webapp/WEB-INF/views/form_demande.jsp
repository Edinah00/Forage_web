<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Demandes — ForageWeb</title>
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

/* ── NAV ── */
.nav{
  position:sticky;top:0;z-index:100;
  background:rgba(13,17,23,.85);backdrop-filter:blur(16px);
  border-bottom:1px solid var(--border);
  padding:0 24px;height:56px;
  display:flex;align-items:center;justify-content:space-between;
}
.brand{font-family:var(--font-head);font-size:1.15rem;color:var(--text);text-decoration:none;letter-spacing:-.02em}
.brand em{color:var(--primary);font-style:normal}
.nav-links{display:flex;gap:4px}
.nav-links a{
  color:var(--muted);text-decoration:none;padding:6px 12px;
  border-radius:var(--radius-sm);font-size:.9rem;font-weight:500;
  transition:all .15s;
}
.nav-links a:hover{background:var(--surface2);color:var(--text)}
.nav-links a.active{background:var(--primary-dim);color:var(--primary)}

/* ── LAYOUT ── */
.page{max-width:1180px;margin:32px auto;padding:0 20px;display:flex;flex-direction:column;gap:24px}
.page-title{font-family:var(--font-head);font-size:1.8rem;letter-spacing:-.03em}
.page-sub{color:var(--muted);margin-top:4px;font-size:.95rem}

/* ── ALERT ── */
.alert{
  padding:14px 18px;border-radius:var(--radius);font-size:.95rem;
  display:flex;align-items:center;gap:10px;border:1px solid;
}
.alert-ok{background:var(--success-dim);color:var(--success);border-color:rgba(63,185,80,.3)}
.alert-err{background:var(--danger-dim);color:var(--danger);border-color:rgba(248,81,73,.3)}

/* ── CARD ── */
.card{background:var(--surface);border:1px solid var(--border);border-radius:16px;padding:24px}
.card-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;padding-bottom:16px;border-bottom:1px solid var(--border)}
.card-title{font-family:var(--font-head);font-size:1.05rem;letter-spacing:-.02em}

/* ── FORM ── */
.form-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}
.full{grid-column:1/-1}
.field{display:flex;flex-direction:column;gap:7px}
.field label{font-size:.85rem;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.06em}
.field input,.field select,.field textarea{
  background:var(--surface2);border:1px solid var(--border);border-radius:var(--radius-sm);
  padding:11px 14px;color:var(--text);font-family:var(--font-body);font-size:.95rem;outline:none;
  transition:border-color .2s,box-shadow .2s;
}
.field input:focus,.field select:focus,.field textarea:focus{
  border-color:var(--primary);box-shadow:0 0 0 3px var(--primary-dim);
}
.field select option{background:var(--surface2)}
.form-actions{margin-top:20px;display:flex;justify-content:flex-end;gap:10px}

/* ── BUTTONS ── */
.btn{
  display:inline-flex;align-items:center;gap:6px;padding:9px 16px;
  border-radius:var(--radius-sm);font-family:var(--font-body);font-size:.9rem;font-weight:600;
  text-decoration:none;cursor:pointer;border:1px solid transparent;transition:all .15s;
}
.btn-primary{background:var(--primary);color:#fff;border-color:var(--primary)}
.btn-primary:hover{background:#388bfd;transform:translateY(-1px);box-shadow:0 4px 14px rgba(47,129,247,.3)}
.btn-ghost{background:transparent;color:var(--muted);border-color:var(--border)}
.btn-ghost:hover{background:var(--surface2);color:var(--text)}
.btn-success{background:var(--success-dim);color:var(--success);border-color:rgba(63,185,80,.3)}
.btn-success:hover{background:rgba(63,185,80,.25)}
.btn-danger{background:var(--danger-dim);color:var(--danger);border-color:rgba(248,81,73,.3)}
.btn-danger:hover{background:rgba(248,81,73,.25)}
.btn-warn{background:var(--warn-dim);color:var(--warn);border-color:rgba(210,153,34,.3)}
.btn-warn:hover{background:rgba(210,153,34,.25)}
.btn-sm{padding:6px 12px;font-size:.83rem}
.btn-icon{padding:7px 10px}

/* ── TABLE ── */
.table-wrap{overflow-x:auto}
table{width:100%;border-collapse:collapse}
th{
  padding:10px 14px;text-align:left;font-size:.78rem;font-weight:600;
  color:var(--muted);text-transform:uppercase;letter-spacing:.06em;
  border-bottom:1px solid var(--border);white-space:nowrap;
}
td{padding:12px 14px;border-bottom:1px solid var(--border-light);vertical-align:middle;font-size:.93rem}
tbody tr{transition:background .1s}
tbody tr:hover{background:var(--surface2)}
tbody tr:last-child td{border-bottom:0}

/* ── BADGE ── */
.badge{
  display:inline-flex;align-items:center;gap:4px;
  padding:3px 10px;border-radius:999px;font-size:.8rem;font-weight:600;
}
.badge-blue{background:var(--primary-dim);color:var(--primary)}
.badge-green{background:var(--success-dim);color:var(--success)}
.badge-red{background:var(--danger-dim);color:var(--danger)}
.badge-gray{background:rgba(139,148,158,.15);color:var(--muted)}
.badge-warn{background:var(--warn-dim);color:var(--warn)}

/* ── ROW ACTIONS ── */
.row-actions{display:flex;gap:6px;flex-wrap:wrap}

/* ── EMPTY ── */
.empty-state{text-align:center;padding:48px 24px;color:var(--muted)}
.empty-state .icon{font-size:2.5rem;margin-bottom:12px}
.empty-state p{font-size:.95rem;line-height:1.6}

/* ── STAT STRIP ── */
.stat-strip{display:flex;gap:12px;flex-wrap:wrap}
.stat-pill{
  background:var(--surface);border:1px solid var(--border);border-radius:var(--radius);
  padding:12px 20px;display:flex;align-items:center;gap:12px;flex:1;min-width:140px;
}
.stat-pill .num{font-family:var(--font-head);font-size:1.6rem;line-height:1}
.stat-pill .lbl{font-size:.82rem;color:var(--muted);margin-top:3px}

@media(max-width:700px){
  .form-grid{grid-template-columns:1fr}
  .nav{padding:0 14px}
  .page{padding:0 12px;margin:16px auto}
}
</style>
</head>
<body>

<nav class="nav">
  <a class="brand" href="${pageContext.request.contextPath}/accueil">Forage<em>Web</em></a>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/accueil">Accueil</a>
    <a href="${pageContext.request.contextPath}/formulaire" class="active">Demandes</a>
    <a href="${pageContext.request.contextPath}/devis">Devis</a>
    <a href="${pageContext.request.contextPath}/form_demande_status">Statuts</a>
  </div>
</nav>

<div class="page">

  <div>
    <h1 class="page-title">Demandes</h1>
    <p class="page-sub">Gérez les demandes de forage et suivez leur progression.</p>
  </div>

  <c:if test="${not empty message}">
    <div class="alert alert-ok">✅ ${message}</div>
  </c:if>
  <c:if test="${not empty erreur}">
    <div class="alert alert-err">❌ ${erreur}</div>
  </c:if>

  <!-- ── Formulaire ajout ── -->
  <div class="card">
    <div class="card-header">
      <span class="card-title">Nouvelle demande</span>
    </div>

    <%-- CORRECTION : ref_demande n'est plus dans le formulaire, générée côté serveur --%>
    <form:form action="${pageContext.request.contextPath}/Ajout_demande"
               method="post" modelAttribute="demande">

      <div class="form-grid">
        <div class="field">
          <label for="id_client">Client</label>
          <form:select path="id_client" id="id_client">
            <form:option value="">— Sélectionner un client —</form:option>
            <c:forEach var="client" items="${clients}">
              <form:option value="${client.idClient}">${client.nomClient}</form:option>
            </c:forEach>
          </form:select>
        </div>

        <div class="field">
          <label for="date_demande">Date de la demande</label>
          <form:input path="date_demande" id="date_demande" type="date"/>
        </div>

        <div class="field">
          <label for="lieu_demande">Lieu</label>
          <form:input path="lieu_demande" id="lieu_demande" placeholder="Ex : Antananarivo, Toamasina…"/>
        </div>

        <div class="field">
          <label for="id_commune">Commune</label>
          <form:select path="id_commune" id="id_commune">
            <form:option value="">— Sélectionner une commune —</form:option>
            <c:forEach var="commune" items="${communes}">
              <form:option value="${commune.idCommune}">${commune.nomCommune}</form:option>
            </c:forEach>
          </form:select>
        </div>
      </div>

      <div class="form-actions">
        <button type="submit" class="btn btn-primary">Enregistrer la demande</button>
      </div>
    </form:form>
  </div>

  <!-- ── Liste ── -->
  <div class="card">
    <div class="card-header">
      <span class="card-title">Liste des demandes</span>
      <span class="badge badge-blue">${demandes.size()} demande(s)</span>
    </div>

    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>#</th><th>Référence</th><th>Client</th>
            <th>Lieu</th><th>Commune</th><th>Date</th><th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${not empty demandes}">
              <c:forEach var="d" items="${demandes}">
                <tr>
                  <td><span class="badge badge-gray">${d.id_demande}</span></td>
                  <td style="font-weight:600;color:var(--primary)">${d.ref_demande}</td>
                  <td>${d.id_client}</td>
                  <td>${d.lieu_demande}</td>
                  <td>${d.id_commune}</td>
                  <td>${d.date_demande}</td>
                  <td>
                    <div class="row-actions">
                      <a class="btn btn-ghost btn-sm" href="${pageContext.request.contextPath}/demande/${d.id_demande}" title="Voir">👁</a>
                      <a class="btn btn-ghost btn-sm" href="${pageContext.request.contextPath}/demande/modifier/${d.id_demande}" title="Modifier">✏️</a>
                      <a class="btn btn-success btn-sm" href="${pageContext.request.contextPath}/demande/valider/${d.id_demande}"
                         onclick="return confirm('Accepter cette demande ?')">✔ Accepter</a>
                      <a class="btn btn-warn btn-sm" href="${pageContext.request.contextPath}/demande/refuser/${d.id_demande}"
                         onclick="return confirm('Refuser cette demande ?')">✘ Refuser</a>
                      <a class="btn btn-danger btn-sm" href="${pageContext.request.contextPath}/demande/supprimer/${d.id_demande}"
                         onclick="return confirm('Supprimer définitivement cette demande ?')" title="Supprimer">🗑</a>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr>
                <td colspan="7">
                  <div class="empty-state">
                    <div class="icon">📋</div>
                    <p>Aucune demande enregistrée.<br>Utilisez le formulaire ci-dessus pour en créer une.</p>
                  </div>
                </td>
              </tr>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>
  </div>

</div><!-- /page -->

<script>
  // Pré-sélectionner la date d'aujourd'hui si vide
  document.addEventListener('DOMContentLoaded', () => {
    const d = document.getElementById('date_demande');
    if (d && !d.value) {
      const now = new Date();
      d.value = now.toISOString().slice(0, 10);
    }
  });
</script>
</body>
</html>
