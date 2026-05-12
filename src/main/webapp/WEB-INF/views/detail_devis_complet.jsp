<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Détail devis #${devis.id_devis} — Forage Web</title>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:Arial,Helvetica,sans-serif;background:#f0f4fa;color:#1e293b;min-height:100vh}

.navbar{background:linear-gradient(90deg,#0f172a,#1e3a8a);padding:0 24px;display:flex;align-items:center;justify-content:space-between;height:60px;box-shadow:0 2px 12px rgba(15,23,42,.25)}
.navbar-brand{color:#fff;font-size:1.2rem;font-weight:700;text-decoration:none}
.navbar-brand span{color:#60a5fa}
.navbar-links{display:flex;gap:6px}
.navbar-links a{color:#cbd5e1;text-decoration:none;padding:7px 13px;border-radius:8px;font-size:.93rem;transition:background .15s}
.navbar-links a:hover,.navbar-links a.active{background:rgba(255,255,255,.12);color:#fff}

.page{max-width:1050px;margin:28px auto;padding:0 16px;display:flex;flex-direction:column;gap:20px}

/* Header devis */
.devis-header{background:linear-gradient(135deg,#1e3a8a,#2563eb);color:#fff;border-radius:16px;padding:28px 32px;display:flex;justify-content:space-between;align-items:flex-start;flex-wrap:wrap;gap:16px;box-shadow:0 8px 28px rgba(37,99,235,.25)}
.devis-header h1{font-size:1.7rem;margin-bottom:6px}
.devis-header .meta{font-size:.93rem;color:#bfdbfe;line-height:1.8}
.devis-header .meta strong{color:#fff}
.header-actions{display:flex;gap:8px;flex-wrap:wrap;align-items:flex-start}

.btn{display:inline-flex;align-items:center;gap:6px;padding:9px 16px;border-radius:10px;font-size:.9rem;font-weight:700;text-decoration:none;cursor:pointer;border:0;transition:transform .15s,background .15s}
.btn-white{background:#fff;color:#1e3a8a}
.btn-white:hover{background:#f0f4fa}
.btn-ghost-white{background:rgba(255,255,255,.15);color:#fff;border:1px solid rgba(255,255,255,.3)}
.btn-ghost-white:hover{background:rgba(255,255,255,.25)}
.btn-danger{background:#fef2f2;color:#dc2626}
.btn-danger:hover{background:#fee2e2}
.btn-primary{background:#2563eb;color:#fff;box-shadow:0 4px 14px rgba(37,99,235,.2)}
.btn-primary:hover{background:#1d4ed8;transform:translateY(-1px)}
.btn-ghost{background:#eff6ff;color:#2563eb}
.btn-ghost:hover{background:#dbeafe}
.btn-sm{padding:6px 12px;font-size:.82rem}

/* Card */
.card{background:#fff;border-radius:14px;padding:24px;box-shadow:0 4px 20px rgba(15,23,42,.07)}
.card-title{font-size:1.05rem;font-weight:700;color:#0f172a;margin-bottom:16px;padding-bottom:10px;border-bottom:2px solid #e5e7eb;display:flex;align-items:center;gap:8px}

/* Info grid */
.info-grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:16px}
.info-item .label{font-size:.8rem;font-weight:700;color:#94a3b8;text-transform:uppercase;letter-spacing:.06em;margin-bottom:4px}
.info-item .value{font-size:1rem;color:#0f172a;font-weight:600}

/* Table */
.table-wrap{overflow-x:auto}
table{width:100%;border-collapse:collapse}
th,td{padding:11px 12px;border-bottom:1px solid #e5e7eb;text-align:left;vertical-align:middle}
th{background:#eef4ff;color:#1e3a8a;font-size:.84rem;font-weight:700;text-transform:uppercase;letter-spacing:.05em}
tbody tr:hover{background:#f8faff}
.num{text-align:right}
.total-row td{background:#f0f7ff;font-weight:800;color:#1e3a8a;font-size:1.05rem;border-top:2px solid #2563eb}

/* Badge */
.badge{display:inline-block;padding:4px 11px;border-radius:999px;font-size:.82rem;font-weight:700}
.badge-green{background:#f0fdf4;color:#15803d}
.badge-amber{background:#fffbeb;color:#b45309}
.badge-gray{background:#f1f5f9;color:#475569}
.badge-red{background:#fef2f2;color:#b91c1c}
.badge-blue{background:#eff6ff;color:#1d4ed8}

/* Statuts actions */
.statut-actions{display:flex;gap:8px;flex-wrap:wrap;margin-top:14px}

/* Timeline */
.timeline{display:flex;flex-direction:column;gap:0}
.tl-item{display:flex;gap:14px;padding:10px 0;border-left:2px solid #e5e7eb;margin-left:8px;padding-left:16px;position:relative}
.tl-item:last-child{border-left-color:transparent}
.tl-dot{position:absolute;left:-7px;top:14px;width:12px;height:12px;border-radius:50%;background:#2563eb;border:2px solid #fff;box-shadow:0 0 0 2px #2563eb}
.tl-date{font-size:.82rem;color:#94a3b8;white-space:nowrap;min-width:140px}
.tl-label{font-weight:600;color:#0f172a}

.alert{padding:12px 16px;border-radius:10px;margin-bottom:16px;font-size:.95rem}
.alert-success{background:#f0fdf4;color:#15803d;border:1px solid #bbf7d0}

.two-col{display:grid;grid-template-columns:1fr 1fr;gap:20px}
@media(max-width:680px){.two-col{grid-template-columns:1fr}.devis-header{padding:20px}}
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

  <c:if test="${not empty message}">
    <div class="alert alert-success">${message}</div>
  </c:if>

  <!-- ── En-tête du devis ─────────────────────────────────────────────────── -->
  <div class="devis-header">
    <div>
      <h1>Devis N° ${devis.id_devis}</h1>
      <div class="meta">
        <strong>Date :</strong> ${devis.date_devis}<br>
        <c:if test="${not empty demande}">
          <strong>Demande :</strong> #${demande.id_demande} — ${demande.lieu_demande}<br>
          <c:forEach var="cl" items="${clients}">
            <c:if test="${cl.idClient == demande.id_client}">
              <strong>Client :</strong> ${cl.nomClient} (${cl.telephoneClient})
            </c:if>
          </c:forEach>
        </c:if>
      </div>
    </div>
    <div class="header-actions">
      <a class="btn btn-white" href="${pageContext.request.contextPath}/devis/modifier/${devis.id_devis}">✏️ Modifier</a>
      <a class="btn btn-ghost-white" href="${pageContext.request.contextPath}/devis">← Retour liste</a>
      <a class="btn btn-danger btn-sm"
         href="${pageContext.request.contextPath}/devis/supprimer/${devis.id_devis}"
         onclick="return confirm('Supprimer ce devis ?')">🗑 Supprimer</a>
    </div>
  </div>

  <!-- ── Lignes de détail ─────────────────────────────────────────────────── -->
  <div class="card">
    <div class="card-title">🧾 Lignes de détail</div>
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>#</th>
            <th>Libellé</th>
            <th>Description</th>
            <th>Unité</th>
            <th class="num">Quantité</th>
            <th class="num">Prix unit.</th>
            <th class="num">Montant (Ar)</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:set var="grandTotal" value="0"/>
          <c:choose>
            <c:when test="${not empty details}">
              <c:forEach var="det" items="${details}" varStatus="st">
                <tr>
                  <td><span class="badge badge-gray">${st.index + 1}</span></td>
                  <td><strong>${det.libelle}</strong></td>
                  <td style="color:#64748b;font-size:.9rem">${det.description}</td>
                  <td>${det.unite}</td>
                  <td class="num">${det.quantite}</td>
                  <td class="num">${det.prix_unitaire}</td>
                  <td class="num"><strong>${det.montantCalcule}</strong></td>
                  <td>
                    <a class="btn btn-danger btn-sm"
                       href="${pageContext.request.contextPath}/devis/detail/supprimer/${det.id_detail}/devis/${devis.id_devis}"
                       onclick="return confirm('Supprimer cette ligne ?')">✕</a>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr><td colspan="8" style="text-align:center;color:#94a3b8;padding:20px">Aucune ligne de détail.</td></tr>
            </c:otherwise>
          </c:choose>
        </tbody>
        <tfoot>
          <tr class="total-row">
            <td colspan="6" style="text-align:right;padding-right:16px">TOTAL</td>
            <td class="num">${total} Ar</td>
            <td></td>
          </tr>
        </tfoot>
      </table>
    </div>
  </div>

  <!-- ── Statut + Historique ─────────────────────────────────────────────── -->
  <div class="two-col">

    <!-- Changer le statut -->
    <div class="card">
      <div class="card-title">🔄 Changer le statut</div>
      <p style="font-size:.9rem;color:#64748b;margin-bottom:12px">Faites évoluer le statut de ce devis selon son avancement.</p>
      <div class="statut-actions">
        <a class="btn btn-ghost" href="${pageContext.request.contextPath}/devis/${devis.id_devis}/statut/1">📝 Brouillon</a>
        <a class="btn btn-ghost" style="background:#fffbeb;color:#b45309"
           href="${pageContext.request.contextPath}/devis/${devis.id_devis}/statut/2">📤 Marquer Envoyé</a>
        <a class="btn btn-ghost" style="background:#f0fdf4;color:#15803d"
           href="${pageContext.request.contextPath}/devis/${devis.id_devis}/statut/3"
           onclick="return confirm('Marquer ce devis comme Accepté ?')">✔ Accepté</a>
        <a class="btn btn-danger btn-sm"
           href="${pageContext.request.contextPath}/devis/${devis.id_devis}/statut/4"
           onclick="return confirm('Marquer ce devis comme Refusé ?')">✘ Refusé</a>
      </div>
    </div>

    <!-- Historique des statuts -->
    <div class="card">
      <div class="card-title">📅 Historique des statuts</div>
      <c:choose>
        <c:when test="${not empty historique}">
          <div class="timeline">
            <c:forEach var="h" items="${historique}">
              <div class="tl-item">
                <div class="tl-dot"></div>
                <div class="tl-date">${h.date_status}</div>
                <div class="tl-label">
                  <c:forEach var="sd" items="${statusDevis}">
                    <c:if test="${sd.id_status_devis == h.id_status_devis}">
                      <c:choose>
                        <c:when test="${sd.id_status_devis == 1}"><span class="badge badge-gray">${sd.libelle}</span></c:when>
                        <c:when test="${sd.id_status_devis == 2}"><span class="badge badge-amber">${sd.libelle}</span></c:when>
                        <c:when test="${sd.id_status_devis == 3}"><span class="badge badge-green">${sd.libelle}</span></c:when>
                        <c:when test="${sd.id_status_devis == 4}"><span class="badge badge-red">${sd.libelle}</span></c:when>
                      </c:choose>
                    </c:if>
                  </c:forEach>
                </div>
              </div>
            </c:forEach>
          </div>
        </c:when>
        <c:otherwise>
          <p style="color:#94a3b8;font-size:.9rem">Aucun historique disponible.</p>
        </c:otherwise>
      </c:choose>
    </div>

  </div>

</div>
</body>
</html>
