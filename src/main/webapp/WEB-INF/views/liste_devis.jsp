<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Devis — Forage Web</title>
<style>
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:Arial,Helvetica,sans-serif;background:#f0f4fa;color:#1e293b;min-height:100vh}

.navbar{background:linear-gradient(90deg,#0f172a 0%,#1e3a8a 100%);padding:0 24px;display:flex;align-items:center;justify-content:space-between;height:60px;box-shadow:0 2px 12px rgba(15,23,42,.25)}
.navbar-brand{color:#fff;font-size:1.2rem;font-weight:700;text-decoration:none}
.navbar-brand span{color:#60a5fa}
.navbar-links{display:flex;gap:6px}
.navbar-links a{color:#cbd5e1;text-decoration:none;padding:7px 13px;border-radius:8px;font-size:.93rem;transition:background .15s}
.navbar-links a:hover,.navbar-links a.active{background:rgba(255,255,255,.12);color:#fff}

.page{max-width:1200px;margin:28px auto;padding:0 16px;display:flex;flex-direction:column;gap:20px}
.page-header{display:flex;align-items:flex-start;justify-content:space-between;flex-wrap:wrap;gap:12px}
.page-header h1{font-size:1.6rem;color:#0f172a}
.page-header p{font-size:.95rem;color:#64748b;margin-top:4px}

.card{background:#fff;border-radius:14px;padding:24px;box-shadow:0 4px 20px rgba(15,23,42,.07)}
.card h2{font-size:1.15rem;color:#0f172a;margin-bottom:18px;padding-bottom:10px;border-bottom:2px solid #e5e7eb}

.alert{padding:12px 16px;border-radius:10px;margin-bottom:16px;font-size:.95rem}
.alert-success{background:#f0fdf4;color:#15803d;border:1px solid #bbf7d0}
.alert-error{background:#fef2f2;color:#b91c1c;border:1px solid #fecaca}

.btn{display:inline-flex;align-items:center;gap:7px;padding:10px 18px;border-radius:10px;font-size:.93rem;font-weight:700;text-decoration:none;cursor:pointer;border:0;transition:transform .15s,background .15s}
.btn-primary{background:#2563eb;color:#fff;box-shadow:0 4px 14px rgba(37,99,235,.2)}
.btn-primary:hover{background:#1d4ed8;transform:translateY(-1px)}
.btn-ghost{background:#eff6ff;color:#2563eb}
.btn-ghost:hover{background:#dbeafe}
.btn-danger{background:#fef2f2;color:#dc2626}
.btn-danger:hover{background:#fee2e2}

.table-wrap{overflow-x:auto}
table{width:100%;border-collapse:collapse;min-width:750px}
th,td{padding:11px 12px;border-bottom:1px solid #e5e7eb;text-align:left;vertical-align:middle}
th{background:#eef4ff;color:#1e3a8a;font-size:.86rem;font-weight:700;text-transform:uppercase;letter-spacing:.05em}
tbody tr:hover{background:#f8faff}

.badge{display:inline-block;padding:4px 10px;border-radius:999px;font-size:.82rem;font-weight:700}
.badge-blue{background:#eff6ff;color:#1d4ed8}
.badge-green{background:#f0fdf4;color:#15803d}
.badge-amber{background:#fffbeb;color:#b45309}
.badge-gray{background:#f1f5f9;color:#475569}
.badge-red{background:#fef2f2;color:#b91c1c}

.row-actions{display:flex;gap:6px;flex-wrap:wrap}
.empty{text-align:center;color:#94a3b8;padding:28px;font-size:.95rem}
.total-cell{font-weight:700;color:#0f172a}
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
    <div>
      <h1>📄 Liste des devis</h1>
      <p>Seules les demandes acceptées peuvent avoir un devis.</p>
    </div>
    <a class="btn btn-primary" href="${pageContext.request.contextPath}/devis/nouveau">➕ Nouveau devis</a>
  </div>

  <c:if test="${not empty message}">
    <div class="alert alert-success">${message}</div>
  </c:if>
  <c:if test="${not empty erreur}">
    <div class="alert alert-error">${erreur}</div>
  </c:if>

  <div class="card">
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>N° Devis</th>
            <th>Demande</th>
            <th>Client</th>
            <th>Date devis</th>
            <th>Nb lignes</th>
            <th>Total (Ar)</th>
            <th>Statut</th>
            <th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${not empty devisList}">
              <c:forEach var="dv" items="${devisList}">
                <%-- Trouver la demande correspondante --%>
                <c:set var="demandeTrouvee" value=""/>
                <c:set var="clientNom" value="—"/>
                <c:forEach var="dem" items="${demandes}">
                  <c:if test="${dem.id_demande == dv.id_demande}">
                    <c:set var="demandeTrouvee" value="${dem}"/>
                    <c:forEach var="cl" items="${clients}">
                      <c:if test="${cl.idClient == dem.id_client}">
                        <c:set var="clientNom" value="${cl.nomClient}"/>
                      </c:if>
                    </c:forEach>
                  </c:if>
                </c:forEach>

                <tr>
                  <td><span class="badge badge-blue">#${dv.id_devis}</span></td>
                  <td>Demande #${dv.id_demande}<c:if test="${not empty demandeTrouvee}"> — ${demandeTrouvee.lieu_demande}</c:if></td>
                  <td>${clientNom}</td>
                  <td>${dv.date_devis}</td>
                  <td>
                    <%-- Compter les détails via le service --%>
                    <span class="badge badge-gray">${devisService.getDetails(dv.id_devis).size()} ligne(s)</span>
                  </td>
                  <td class="total-cell">
                    <fmt:formatNumber xmlns:fmt="http://java.sun.com/jsp/jstl/fmt"
                      value="${devisService.getTotalDevis(dv.id_devis)}"
                      type="number" minFractionDigits="0" maxFractionDigits="0"/>
                    <c:set var="total" value="${devisService.getTotalDevis(dv.id_devis)}"/>
                    ${total} Ar
                  </td>
                  <td>
                    <c:set var="dernierSt" value="${devisService.getDernierStatut(dv.id_devis)}"/>
                    <c:choose>
                      <c:when test="${not empty dernierSt && dernierSt.present}">
                        <c:set var="stId" value="${dernierSt.get().id_status_devis}"/>
                        <c:choose>
                          <c:when test="${stId == 1}"><span class="badge badge-gray">Brouillon</span></c:when>
                          <c:when test="${stId == 2}"><span class="badge badge-amber">Envoyé</span></c:when>
                          <c:when test="${stId == 3}"><span class="badge badge-green">Accepté</span></c:when>
                          <c:when test="${stId == 4}"><span class="badge badge-red">Refusé</span></c:when>
                          <c:otherwise><span class="badge badge-gray">—</span></c:otherwise>
                        </c:choose>
                      </c:when>
                      <c:otherwise><span class="badge badge-gray">—</span></c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <div class="row-actions">
                      <a class="btn btn-ghost" href="${pageContext.request.contextPath}/devis/${dv.id_devis}">👁 Voir</a>
                      <a class="btn btn-ghost" href="${pageContext.request.contextPath}/devis/modifier/${dv.id_devis}">✏️ Modifier</a>
                      <a class="btn btn-danger"
                         href="${pageContext.request.contextPath}/devis/supprimer/${dv.id_devis}"
                         onclick="return confirm('Supprimer ce devis et tous ses détails ?')">🗑</a>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr><td class="empty" colspan="8">Aucun devis créé pour le moment.</td></tr>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>
  </div>

</div>
</body>
</html>
