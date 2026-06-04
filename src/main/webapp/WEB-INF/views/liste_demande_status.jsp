<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Statuts des demandes — ForageWeb</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
<style>
:root{
  --bg:#0d1117;--surface:#161b22;--surface2:#21262d;--border:#30363d;--border-light:#21262d;
  --primary:#2f81f7;--primary-dim:rgba(47,129,247,.15);
  --success:#3fb950;--success-dim:rgba(63,185,80,.15);
  --danger:#f85149;--danger-dim:rgba(248,81,73,.15);
  --warn:#d29922;--warn-dim:rgba(210,153,34,.15);
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

.page{max-width:1280px;margin:32px auto;padding:0 20px;display:flex;flex-direction:column;gap:24px}
.page-head{display:flex;align-items:flex-start;justify-content:space-between;flex-wrap:wrap;gap:12px}
.page-title{font-family:var(--font-head);font-size:1.8rem;letter-spacing:-.03em}
.page-sub{color:var(--muted);margin-top:4px;font-size:.95rem}

.alert{padding:14px 18px;border-radius:var(--radius);font-size:.95rem;display:flex;align-items:center;gap:10px;border:1px solid}
.alert-ok{background:var(--success-dim);color:var(--success);border-color:rgba(63,185,80,.3)}
.alert-err{background:var(--danger-dim);color:var(--danger);border-color:rgba(248,81,73,.3)}

.card{background:var(--surface);border:1px solid var(--border);border-radius:16px;padding:24px}
.card-header{display:flex;align-items:center;justify-content:space-between;margin-bottom:20px;padding-bottom:16px;border-bottom:1px solid var(--border)}
.card-title{font-family:var(--font-head);font-size:1.05rem}

.table-wrap{overflow-x:auto}
table{width:100%;border-collapse:collapse;min-width:860px}
th{padding:10px 14px;text-align:left;font-size:.78rem;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.06em;border-bottom:1px solid var(--border);white-space:nowrap}
td{padding:12px 14px;border-bottom:1px solid var(--border-light);vertical-align:middle;font-size:.93rem}
tbody tr{transition:background .1s}
tbody tr:hover{background:var(--surface2)}
tbody tr:last-child td{border-bottom:0}

.badge{display:inline-flex;align-items:center;gap:4px;padding:3px 10px;border-radius:999px;font-size:.8rem;font-weight:600}
.badge-blue{background:var(--primary-dim);color:var(--primary)}
.badge-green{background:var(--success-dim);color:var(--success)}
.badge-red{background:var(--danger-dim);color:var(--danger)}
.badge-warn{background:var(--warn-dim);color:var(--warn)}
.badge-gray{background:rgba(139,148,158,.15);color:var(--muted)}

/* Couleur dot */
.dot{display:inline-block;width:10px;height:10px;border-radius:50%;margin-right:5px}
.dot-vert{background:var(--success)}
.dot-jaune{background:var(--warn)}
.dot-rouge{background:var(--danger)}

.row-actions{display:flex;gap:6px;flex-wrap:wrap}
.btn{display:inline-flex;align-items:center;gap:5px;padding:6px 12px;border-radius:var(--radius-sm);font-family:var(--font-body);font-size:.83rem;font-weight:600;text-decoration:none;cursor:pointer;border:1px solid transparent;transition:all .15s}
.btn-ghost{background:transparent;color:var(--muted);border-color:var(--border)}
.btn-ghost:hover{background:var(--surface2);color:var(--text)}
.btn-primary{background:var(--primary);color:#fff}
.btn-primary:hover{background:#388bfd}
.btn-danger{background:var(--danger-dim);color:var(--danger);border-color:rgba(248,81,73,.3)}
.btn-danger:hover{background:rgba(248,81,73,.25)}

.empty-state{text-align:center;padding:48px 24px;color:var(--muted)}
.empty-state .icon{font-size:2.5rem;margin-bottom:12px}

/* Durée pill */
.dur{
  display:inline-flex;align-items:center;gap:5px;
  padding:3px 10px;border-radius:999px;font-size:.82rem;font-weight:600;
  background:rgba(139,148,158,.12);color:var(--muted);
}
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
      <h1 class="page-title">Statuts des demandes</h1>
      <p class="page-sub">Historique complet des transitions de statut avec durées ouvrées et indicateurs couleur.</p>
    </div>
    <a class="btn btn-primary" style="padding:9px 16px;font-size:.9rem"
       href="${pageContext.request.contextPath}/form_demande_status">+ Ajouter un statut</a>
  </div>

  <c:if test="${not empty message}">
    <div class="alert alert-ok">✅ ${message}</div>
  </c:if>
  <c:if test="${not empty erreur}">
    <div class="alert alert-err">❌ ${erreur}</div>
  </c:if>

  <div class="card">
    <div class="card-header">
      <span class="card-title">Historique des statuts</span>
      <span class="badge badge-blue">${demandesStatus.size()} entrée(s)</span>
    </div>

    <c:choose>
      <c:when test="${empty demandesStatus}">
        <div class="empty-state">
          <div class="icon">📊</div>
          <p>Aucun statut enregistré pour le moment.<br>
             <a href="${pageContext.request.contextPath}/form_demande_status"
                style="color:var(--primary);text-decoration:none">Ajouter le premier statut →</a></p>
        </div>
      </c:when>
      <c:otherwise>
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>#</th>
                <th>ID Demande</th>
                <th>Statut</th>
                <th>Date & Heure</th>
                <th>Durée ouvrée</th>
                <th>Indicateur</th>
                <th>Observation</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${demandesStatus}" var="s">
                <tr>
                  <td><span class="badge badge-gray">${s.id}</span></td>
                  <td><span class="badge badge-blue">#${s.id_demande}</span></td>
                  <td>
                    <c:forEach items="${statuses}" var="st">
                      <c:if test="${st.value == s.id_status}">
                        <span class="badge
                          <c:choose>
                            <c:when test="${st.value == 2}">badge-green</c:when>
                            <c:when test="${st.value == 3}">badge-red</c:when>
                            <c:when test="${st.value == 1}">badge-gray</c:when>
                            <c:otherwise>badge-warn</c:otherwise>
                          </c:choose>
                        ">${st.key}</span>
                      </c:if>
                    </c:forEach>
                  </td>
                  <td style="color:var(--muted);font-size:.87rem">${s.date_status}</td>
                  <td>
                    <c:choose>
                      <c:when test="${s.duree_travail_minutes != null}">
                        <span class="dur">⏱ ${s.duree_travail_minutes} min</span>
                      </c:when>
                      <c:otherwise><span style="color:var(--muted)">—</span></c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${s.couleur == 'vert'}">
                        <span class="badge badge-green"><span class="dot dot-vert"></span>Vert</span>
                      </c:when>
                      <c:when test="${s.couleur == 'jaune'}">
                        <span class="badge badge-warn"><span class="dot dot-jaune"></span>Jaune</span>
                      </c:when>
                      <c:when test="${s.couleur == 'rouge'}">
                        <span class="badge badge-red"><span class="dot dot-rouge"></span>Rouge</span>
                      </c:when>
                      <c:otherwise><span style="color:var(--muted)">—</span></c:otherwise>
                    </c:choose>
                  </td>
                  <td style="color:var(--muted);max-width:200px;overflow:hidden;text-overflow:ellipsis;white-space:nowrap">
                    ${not empty s.observation ? s.observation : '—'}
                  </td>
                  <td>
                    <div class="row-actions">
                      <%-- CORRECTION : route basée sur l'id séquentiel --%>
                      <a class="btn btn-ghost" href="${pageContext.request.contextPath}/demande_status/modifier/${s.id}">✏️ Modifier</a>
                      <a class="btn btn-danger" onclick="if(confirm('Supprimer ce statut ?')){window.location='${pageContext.request.contextPath}/demande_status/supprimer/${s.id}'}">🗑</a>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:otherwise>
    </c:choose>

  </div>
</div>
</body>
</html>
