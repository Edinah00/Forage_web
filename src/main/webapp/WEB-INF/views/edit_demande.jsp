<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Modifier demande - ForageWeb</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css">
</head>
<body>
<c:set var="activeMenu" value="demandes" scope="page"/>
<div class="layout">
  <%@ include file="/WEB-INF/views/fragments/sidebar.jspf" %>
  <div class="main">
    <div class="topbar">
      <span class="topbar-title">Modifier la demande</span>
      <div class="topbar-actions">
        <a class="btn btn-ghost" href="${pageContext.request.contextPath}/formulaire">Retour</a>
      </div>
    </div>

    <div class="page">
      <div class="page-shell">
        <div class="card">
          <div class="card-header"><span class="card-title">Mise à jour</span></div>

          <form:form action="${pageContext.request.contextPath}/demande/modifier" method="post" modelAttribute="demande">
            <form:input path="id_demande" type="hidden"/>
            <form:input path="ref_demande" type="hidden"/>

            <div class="form-grid">
              <div class="field full">
                <label>Référence</label>
                <input type="text" value="${demande.ref_demande}" disabled>
              </div>
              <div class="field">
                <label for="id_client">Client</label>
                <form:select path="id_client" id="id_client">
                  <form:option value="">-- Choisir --</form:option>
                  <c:forEach var="client" items="${clients}">
                    <form:option value="${client.idClient}">${client.nomClient}</form:option>
                  </c:forEach>
                </form:select>
              </div>
              <div class="field">
                <label for="date_demande">Date</label>
                <form:input path="date_demande" id="date_demande" type="date"/>
              </div>
              <div class="field">
                <label for="lieu_demande">Lieu</label>
                <form:input path="lieu_demande" id="lieu_demande" placeholder="Ex : Antananarivo"/>
              </div>
              <div class="field">
                <label for="id_commune">Commune</label>
                <form:select path="id_commune" id="id_commune">
                  <form:option value="">-- Choisir --</form:option>
                  <c:forEach var="commune" items="${communes}">
                    <form:option value="${commune.idCommune}">${commune.nomCommune}</form:option>
                  </c:forEach>
                </form:select>
              </div>
            </div>

            <div class="form-actions">
              <a class="btn btn-ghost" href="${pageContext.request.contextPath}/formulaire">Annuler</a>
              <button type="submit" class="btn btn-primary">Enregistrer les modifications</button>
            </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
