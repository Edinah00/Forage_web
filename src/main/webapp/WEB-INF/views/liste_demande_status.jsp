<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Statuts des demandes - ForageWeb</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css">
<style>


.status-badge {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 4px 10px;
  border-radius: 999px;
  font-size: .78rem;
  font-weight: 600;
  letter-spacing: .02em;
  white-space: nowrap;
}
 
.status-dot {
  width: 7px;
  height: 7px;
  border-radius: 50%;
  flex-shrink: 0;
}
 
/* ── Vert ── */
.status-vert {
  background: rgba(63, 185, 80, .15);
  color: #3fb950;
  border: 1px solid rgba(63, 185, 80, .25);
}
.status-vert .status-dot {
  background: #3fb950;
  box-shadow: 0 0 5px rgba(63, 185, 80, .6);
}
 
/* ── Jaune ── */
.status-jaune {
  background: rgba(210, 153, 34, .15);
  color: #d29922;
  border: 1px solid rgba(210, 153, 34, .25);
}
.status-jaune .status-dot {
  background: #d29922;
  box-shadow: 0 0 5px rgba(210, 153, 34, .6);
}
 
/* ── Rouge ── */
.status-rouge {
  background: rgba(248, 81, 73, .15);
  color: #f85149;
  border: 1px solid rgba(248, 81, 73, .25);
}
.status-rouge .status-dot {
  background: #f85149;
  box-shadow: 0 0 5px rgba(248, 81, 73, .6);
}
 
/* ── Bleu (fallback / durée = 0) ── */
.status-bleu {
  background: rgba(47, 129, 247, .15);
  color: #2f81f7;
  border: 1px solid rgba(47, 129, 247, .25);
}
.status-bleu .status-dot {
  background: #2f81f7;
  box-shadow: 0 0 5px rgba(47, 129, 247, .6);
}
 

</style>
</head>
<body>
<c:set var="activeMenu" value="statuts" scope="page"/>
<div class="layout">
  <%@ include file="/WEB-INF/views/fragments/sidebar.jspf" %>
  <div class="main">
    <div class="topbar">
      <span class="topbar-title">Statuts des demandes</span>
      <div class="topbar-actions">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/form_demande_status">
          <i class="ti ti-plus"></i> Ajouter un statut
        </a>
      </div>
    </div>

    <div class="page">
      <div class="page-shell">
        <c:if test="${not empty message}"><div class="alert alert-ok">✅ ${message}</div></c:if>
        <c:if test="${not empty erreur}"><div class="alert alert-err">❌ ${erreur}</div></c:if>

        <div class="card">
          <div class="card-header">
            <span class="card-title">Historique</span>
            <span class="badge badge-blue">${demandesStatus.size()} statut(s)</span>
          </div>
          <div class="table-wrap">
            <table>
              <thead>
                <tr>
                  <th>ID</th>
                  <th>Demande</th>
                  <th>Statut</th>
                  <th>Date</th>
                  <th>Durée</th>
                  <th>Couleur</th>
                  <th>Observation</th>
                  <th>Actions</th>
                </tr>
              </thead>
              <tbody>
                <c:choose>
                  <c:when test="${not empty demandesStatus}">
                    <c:forEach var="ds" items="${demandesStatus}">
                      <tr>
                        <td><span class="badge badge-gray">${ds.id}</span></td>
                        <td>${ds.id_demande}</td>
                        <td>${ds.id_status}</td>
                        <td>${ds.date_status}</td>
                        <td>
                          <c:choose>
                            <c:when test="${not empty ds.duree_travail_minutes}">
                              ${ds.duree_travail_minutes} min
                            </c:when>
                            <c:otherwise>—</c:otherwise>
                          </c:choose>
                        </td>

                        <%-- Badge dynamique coloré --%>
                        <td>
                          <c:choose>
                            <c:when test="${ds.couleur == 'vert'}">
                              <span class="status-badge status-vert">
                                <span class="status-dot"></span>Vert
                              </span>
                            </c:when>
                            <c:when test="${ds.couleur == 'jaune'}">
                              <span class="status-badge status-jaune">
                                <span class="status-dot"></span>Jaune
                              </span>
                            </c:when>
                            <c:when test="${ds.couleur == 'rouge'}">
                              <span class="status-badge status-rouge">
                                <span class="status-dot"></span>Rouge
                              </span>
                            </c:when>
                            <c:when test="${ds.couleur == 'bleu'}">
                              <span class="status-badge status-bleu">
                                <span class="status-dot"></span>Bleu
                              </span>
                            </c:when>
                            <c:otherwise>
                              <span style="color:var(--muted)">—</span>
                            </c:otherwise>
                          </c:choose>
                        </td>

                        <td>${ds.observation}</td>
                        <td>
                          <div class="row-actions">
                            <a class="btn btn-ghost btn-sm"
                               href="${pageContext.request.contextPath}/demande_status/modifier/${ds.id}">Modifier</a>
                            <a class="btn btn-danger-sm"
                               href="${pageContext.request.contextPath}/demande_status/supprimer/${ds.id}"
                               onclick="return confirm('Supprimer ce statut ?')">Supprimer</a>
                          </div>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <tr>
                      <td colspan="8">
                        <div class="empty-state">
                          <div class="icon">🕒</div>
                          <p>Aucun statut enregistré.</p>
                        </div>
                      </td>
                    </tr>
                  </c:otherwise>
                </c:choose>
              </tbody>
            </table>
          </div>
        </div>

      </div>
    </div>
  </div>
</div>
</body>
</html>
