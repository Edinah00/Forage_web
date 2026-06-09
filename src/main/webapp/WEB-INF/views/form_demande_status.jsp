<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="fr">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>Ajouter un statut - ForageWeb</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css">
</head>
<body>
<c:set var="activeMenu" value="statuts" scope="page"/>
<div class="layout">
  <%@ include file="/WEB-INF/views/fragments/sidebar.jspf" %>
  <div class="main">
    <div class="topbar">
      <span class="topbar-title">Ajouter un statut</span>
      <div class="topbar-actions">
        <a class="btn btn-ghost" href="${pageContext.request.contextPath}/demande_status/liste">Voir la liste</a>
      </div>
    </div>

    <div class="page">
      <div class="page-shell">
        <c:if test="${not empty message}"><div class="alert alert-ok">✅ ${message}</div></c:if>
        <c:if test="${not empty erreur}"><div class="alert alert-err">❌ ${erreur}</div></c:if>

        <div class="card">
          <div class="card-header"><span class="card-title">Nouveau statut</span></div>

          <form:form action="${pageContext.request.contextPath}/demande_status/ajouter" method="post" modelAttribute="demandeStatus">
            <div class="form-grid">
              <div class="field">
                <label>Demande</label>
                <select id="refDemande" onchange="syncDemandeId(this)">
                  <option value="">-- Sélectionner --</option>
                  <c:forEach items="${demandes}" var="d">
                    <option value="${d.id_demande}" data-ref="${fn:trim(d.ref_demande)}">${fn:trim(d.ref_demande)} (#${d.id_demande})</option>
                  </c:forEach>
                </select>
                <form:input path="id_demande" type="hidden" id="idDemandeInput"/>
                <div id="selInfo" class="field-hint"></div>
              </div>
              <div class="field">
                <label>Statut</label>
                <form:select path="id_status" id="idStatus">
                  <form:option value="">-- Sélectionner --</form:option>
                  <c:forEach items="${statuses}" var="st">
                    <form:option value="${st.value}">${st.key}</form:option>
                  </c:forEach>
                </form:select>
              </div>
              <div class="field">
                <label>Date et heure</label>
                <form:input path="date_status" type="datetime-local" id="dateStatus" step="60"/>
              </div>
              <div class="field full">
                <label>Observation</label>
                <form:textarea path="observation" id="observation" placeholder="Remarques, motif de refus, informations complémentaires..."/>
              </div>
            </div>
            <div class="form-actions">
              <a class="btn btn-ghost" href="${pageContext.request.contextPath}/demande_status/liste">Annuler</a>
              <button type="submit" class="btn btn-primary">Enregistrer le statut</button>
            </div>
          </form:form>
        </div>
      </div>
    </div>
  </div>
</div>
<script>
window.syncDemandeId = function(sel) {
  const opt = sel?.selectedOptions?.[0];
  const val = opt ? opt.value : '';
  document.getElementById('idDemandeInput').value = val;
  document.getElementById('selInfo').textContent = val ? 'Demande sélectionnée : ' + (opt.dataset.ref || '') + ' (ID ' + val + ')' : '';
};
document.addEventListener('DOMContentLoaded', () => {
  const dt = document.getElementById('dateStatus');
  if (dt && !dt.value) {
    const now = new Date();
    const pad = n => String(n).padStart(2,'0');
    dt.value = now.getFullYear() + '-' + pad(now.getMonth() + 1) + '-' + pad(now.getDate()) + 'T' + pad(now.getHours()) + ':' + pad(now.getMinutes());
  }
});
</script>
</body>
</html>
