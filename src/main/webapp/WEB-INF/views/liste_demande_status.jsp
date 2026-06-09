<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Statuts des demandes - ForageWeb</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css">
</head>
<body>
<c:set var="activeMenu" value="statuts" scope="page"/>
<div class="layout">
  <%@ include file="/WEB-INF/views/fragments/sidebar.jspf" %>
  <div class="main">
    <div class="topbar">
      <span class="topbar-title">Statuts des demandes</span>
      <div class="topbar-actions">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/form_demande_status"><i class="ti ti-plus"></i> Ajouter un statut</a>
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
                      <td>${ds.observation}</td>
                      <td>
                        <div class="row-actions">
                          <a class="btn btn-ghost btn-sm" href="${pageContext.request.contextPath}/demande_status/modifier/${ds.id}">Modifier</a>
                          <a class="btn btn-danger-sm" href="${pageContext.request.contextPath}/demande_status/supprimer/${ds.id}" onclick="return confirm('Supprimer ce statut ?')">Supprimer</a>
                        </div>
                      </td>
                    </tr>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <tr>
                    <td colspan="6"><div class="empty-state"><div class="icon">🕒</div><p>Aucun statut enregistré.</p></div></td>
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
