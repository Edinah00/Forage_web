<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Demandes - ForageWeb</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css">
</head>
<body>
<c:set var="activeMenu" value="demandes" scope="page"/>
<div class="layout">
  <%@ include file="/WEB-INF/views/fragments/sidebar.jspf" %>
  <div class="main">
    <div class="topbar">
      <span class="topbar-title">Demandes</span>
      <div class="topbar-actions">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/formulaire"><i class="ti ti-plus"></i> Nouvelle demande</a>
      </div>
    </div>

    <div class="page">
      <div class="page-shell">
        <c:if test="${not empty message}">
          <div class="alert alert-ok">✅ ${message}</div>
        </c:if>
        <c:if test="${not empty erreur}">
          <div class="alert alert-err">❌ ${erreur}</div>
        </c:if>

        <div class="card">
          <div class="card-header">
            <span class="card-title">Nouvelle demande</span>
          </div>

          <form:form action="${pageContext.request.contextPath}/Ajout_demande" method="post" modelAttribute="demande">
            <div class="form-grid">
              <div class="field">
                <label for="id_client">Client</label>
                <form:select path="id_client" id="id_client">
                  <form:option value="">-- Sélectionner --</form:option>
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
                <form:input path="lieu_demande" id="lieu_demande" placeholder="Ex : Antananarivo"/>
              </div>
              <div class="field">
                <label for="id_commune">Commune</label>
                <form:select path="id_commune" id="id_commune">
                  <form:option value="">-- Sélectionner --</form:option>
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

        <div class="card">
          <div class="card-header">
            <span class="card-title">Liste des demandes</span>
            <span class="badge badge-blue">${demandes.size()} demande(s)</span>
          </div>

          <div class="table-wrap">
            <table>
              <thead>
              <tr>
                <th>#</th>
                <th>Référence</th>
                <th>Client</th>
                <th>Lieu</th>
                <th>Commune</th>
                <th>Date</th>
                <th>Actions</th>
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
                          <a class="btn btn-ghost btn-sm" href="${pageContext.request.contextPath}/demande/${d.id_demande}">Voir</a>
                          <a class="btn btn-ghost btn-sm" href="${pageContext.request.contextPath}/demande/modifier/${d.id_demande}">Modifier</a>
                          <a class="btn btn-sm" href="${pageContext.request.contextPath}/demande/valider/${d.id_demande}" onclick="return confirm('Accepter cette demande ?')">Accepter</a>
                          <a class="btn btn-sm" href="${pageContext.request.contextPath}/demande/refuser/${d.id_demande}" onclick="return confirm('Refuser cette demande ?')">Refuser</a>
                          <a class="btn btn-danger-sm" href="${pageContext.request.contextPath}/demande/supprimer/${d.id_demande}" onclick="return confirm('Supprimer définitivement cette demande ?')">Supprimer</a>
                        </div>
                      </td>
                    </tr>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <tr>
                    <td colspan="7">
                      <div class="empty-state">
                        <div class="icon">📭</div>
                        <p>Aucune demande enregistrée.</p>
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
