<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Modifier statut - ForageWeb</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css">
</head>
<body>
<c:set var="activeMenu" value="statuts" scope="page"/>
<div class="layout">
  <%@ include file="/WEB-INF/views/fragments/sidebar.jspf" %>
  <div class="main">
    <div class="topbar">
      <span class="topbar-title">Modifier un statut</span>
      <div class="topbar-actions">
        <a class="btn btn-ghost" href="${pageContext.request.contextPath}/demande_status/liste">Retour</a>
      </div>
    </div>

    <div class="page">
      <div class="page-shell">
        <div class="card">
          <div class="card-header"><span class="card-title">Mise à jour</span></div>

          <div class="alert" style="margin-bottom:16px;background:var(--surface2);color:var(--muted);border-color:var(--border);">
            Demande #${demandeStatus.id_demande}
            <c:forEach items="${statuses}" var="st">
              <c:if test="${st.value == demandeStatus.id_status}"> - ${st.key}</c:if>
            </c:forEach>
          </div>

          <form:form action="${pageContext.request.contextPath}/demande_status/modifier" method="post" modelAttribute="demandeStatus">
            <form:input path="id" type="hidden"/>
            <form:input path="id_demande" type="hidden"/>
            <form:input path="id_status" type="hidden"/>

            <div class="form-grid">
              <div class="field">
                <label for="dateStatus">Date et heure</label>
                <form:input path="date_status" type="datetime-local" id="dateStatus"/>
              </div>
              <div class="field full">
                <label for="observation">Observation</label>
                <form:textarea path="observation" id="observation" placeholder="Remarques ou informations complémentaires..."/>
              </div>
            </div>

            <div class="form-actions">
              <a class="btn btn-ghost" href="${pageContext.request.contextPath}/demande_status/liste">Annuler</a>
              <button type="submit" class="btn btn-primary">Mettre à jour</button>
            </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
