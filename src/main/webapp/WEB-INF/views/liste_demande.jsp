<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Demandes — ForageWeb</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css">
</head>
<body>
<c:set var="activeMenu" value="demandes" scope="page"/>
<div class="layout">
  <%@ include file="/WEB-INF/views/fragments/sidebar.jspf" %>
  <div class="main">
    <div class="topbar">
      <div class="topbar-left">
        <span class="topbar-title">Demandes</span>
        <div class="view-toggle">
          <button class="view-btn active" id="btnKanban" onclick="setView('kanban')"><i class="ti ti-layout-kanban"></i> Kanban</button>
          <button class="view-btn" id="btnListe" onclick="setView('liste')"><i class="ti ti-list"></i> Liste</button>
        </div>
      </div>
      <div class="topbar-actions">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/formulaire"><i class="ti ti-plus"></i> Nouvelle demande</a>
      </div>
    </div>

    <div class="page">
      <div class="page-shell">
        <c:if test="${not empty message}"><div class="alert alert-ok">✅ ${message}</div></c:if>

        <div class="kanban-board" id="kanbanView">
          <div class="kanban-col">
            <div class="col-header"><div class="col-bar gray"></div><div class="col-title-row"><span class="col-title">DC</span><span class="col-count">${demandesParStatut['DC'] != null ? demandesParStatut['DC'].size() : 0}</span></div></div>
            <div class="col-cards">
              <c:forEach items="${demandesParStatut['DC']}" var="d"><div class="demand-card"><div class="dc-ref">${d.ref_demande}</div><div class="dc-client"><i class="ti ti-user"></i> Client #${d.id_client}</div><c:if test="${not empty d.lieu_demande}"><div class="dc-lieu"><i class="ti ti-map-pin"></i> ${d.lieu_demande}</div></c:if><div class="dc-date"><i class="ti ti-calendar"></i> ${d.date_demande}</div><div class="dc-footer"><span class="sigle gray">DC</span></div></div></c:forEach>
              <c:if test="${empty demandesParStatut['DC']}"><div class="col-empty">Aucune demande</div></c:if>
            </div>
          </div>
          <div class="kanban-col">
            <div class="col-header"><div class="col-bar blue"></div><div class="col-title-row"><span class="col-title">DA</span><span class="col-count">${demandesParStatut['DA'] != null ? demandesParStatut['DA'].size() : 0}</span></div></div>
            <div class="col-cards">
              <c:forEach items="${demandesParStatut['DA']}" var="d"><div class="demand-card"><div class="dc-ref">${d.ref_demande}</div><div class="dc-client"><i class="ti ti-user"></i> Client #${d.id_client}</div><c:if test="${not empty d.lieu_demande}"><div class="dc-lieu"><i class="ti ti-map-pin"></i> ${d.lieu_demande}</div></c:if><div class="dc-date"><i class="ti ti-calendar"></i> ${d.date_demande}</div><div class="dc-footer"><span class="sigle blue">DA</span></div></div></c:forEach>
              <c:if test="${empty demandesParStatut['DA']}"><div class="col-empty">Aucune demande</div></c:if>
            </div>
          </div>
          <div class="kanban-col">
            <div class="col-header"><div class="col-bar amber"></div><div class="col-title-row"><span class="col-title">DE</span><span class="col-count">${demandesParStatut['DE'] != null ? demandesParStatut['DE'].size() : 0}</span></div></div>
            <div class="col-cards">
              <c:forEach items="${demandesParStatut['DE']}" var="d"><div class="demand-card"><div class="dc-ref">${d.ref_demande}</div><div class="dc-client"><i class="ti ti-user"></i> Client #${d.id_client}</div><c:if test="${not empty d.lieu_demande}"><div class="dc-lieu"><i class="ti ti-map-pin"></i> ${d.lieu_demande}</div></c:if><div class="dc-date"><i class="ti ti-calendar"></i> ${d.date_demande}</div><div class="dc-footer"><span class="sigle amber">DE</span></div></div></c:forEach>
              <c:if test="${empty demandesParStatut['DE']}"><div class="col-empty">Aucune demande</div></c:if>
            </div>
          </div>
          <div class="kanban-col">
            <div class="col-header"><div class="col-bar green"></div><div class="col-title-row"><span class="col-title">DV</span><span class="col-count">${demandesParStatut['DV'] != null ? demandesParStatut['DV'].size() : 0}</span></div></div>
            <div class="col-cards">
              <c:forEach items="${demandesParStatut['DV']}" var="d"><div class="demand-card"><div class="dc-ref">${d.ref_demande}</div><div class="dc-client"><i class="ti ti-user"></i> Client #${d.id_client}</div><c:if test="${not empty d.lieu_demande}"><div class="dc-lieu"><i class="ti ti-map-pin"></i> ${d.lieu_demande}</div></c:if><div class="dc-date"><i class="ti ti-calendar"></i> ${d.date_demande}</div><div class="dc-footer"><span class="sigle green">DV</span></div></div></c:forEach>
              <c:if test="${empty demandesParStatut['DV']}"><div class="col-empty">Aucune demande</div></c:if>
            </div>
          </div>
          <div class="kanban-col">
            <div class="col-header"><div class="col-bar red"></div><div class="col-title-row"><span class="col-title">DR</span><span class="col-count">${demandesParStatut['DR'] != null ? demandesParStatut['DR'].size() : 0}</span></div></div>
            <div class="col-cards">
              <c:forEach items="${demandesParStatut['DR']}" var="d"><div class="demand-card"><div class="dc-ref">${d.ref_demande}</div><div class="dc-client"><i class="ti ti-user"></i> Client #${d.id_client}</div><c:if test="${not empty d.lieu_demande}"><div class="dc-lieu"><i class="ti ti-map-pin"></i> ${d.lieu_demande}</div></c:if><div class="dc-date"><i class="ti ti-calendar"></i> ${d.date_demande}</div><div class="dc-footer"><span class="sigle red">DR</span></div></div></c:forEach>
              <c:if test="${empty demandesParStatut['DR']}"><div class="col-empty">Aucune demande</div></c:if>
            </div>
          </div>
        </div>

        <div class="table-view" id="listeView">
          <div class="card">
            <div class="table-wrap">
              <table>
                <thead>
                  <tr><th>Référence</th><th>Client</th><th>Lieu</th><th>Date</th><th>Statut</th></tr>
                </thead>
                <tbody>
                  <c:forEach items="${demandes}" var="d">
                    <tr>
                      <td>${d.ref_demande}</td>
                      <td>${d.id_client}</td>
                      <td>${d.lieu_demande}</td>
                      <td>${d.date_demande}</td>
                      <td><span class="sigle gray">${d.id_status}</span></td>
                    </tr>
                  </c:forEach>
                </tbody>
              </table>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>

<script>
function setView(view) {
  const kanban = document.getElementById('kanbanView');
  const liste = document.getElementById('listeView');
  const btnKanban = document.getElementById('btnKanban');
  const btnListe = document.getElementById('btnListe');
  const showListe = view === 'liste';
  kanban.classList.toggle('hide', showListe);
  liste.classList.toggle('show', showListe);
  btnKanban.classList.toggle('active', !showListe);
  btnListe.classList.toggle('active', showListe);
}
</script>
</body>
</html>
