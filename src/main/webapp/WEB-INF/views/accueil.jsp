<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Tableau de bord — ForageWeb</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/app.css">
</head>
<body>
<c:set var="activeMenu" value="accueil" scope="page"/>
<div class="layout">
  <%@ include file="/WEB-INF/views/fragments/sidebar.jspf" %>
  <div class="main">
    <div class="topbar">
      <span class="topbar-title">Tableau de bord</span>
      <div class="topbar-actions">
        <a class="btn btn-primary" href="${pageContext.request.contextPath}/formulaire">
          <i class="ti ti-plus"></i> Nouvelle demande
        </a>
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

        <div class="metrics">
          <div class="metric-card"><div class="metric-label"><i class="ti ti-file-text" style="color:var(--primary)"></i> Demandes totales</div><div class="metric-value blue">${totalDemandes}</div></div>
          <div class="metric-card"><div class="metric-label"><i class="ti ti-circle-check" style="color:var(--success)"></i> Validées</div><div class="metric-value green">${demandesValidees}</div></div>
          <div class="metric-card"><div class="metric-label"><i class="ti ti-clock-hour-4" style="color:var(--warn)"></i> En attente</div><div class="metric-value amber">${demandesEnAttente}</div></div>
          <div class="metric-card"><div class="metric-label"><i class="ti ti-file-dollar" style="color:var(--purple)"></i> Devis générés</div><div class="metric-value purple">${totalDevis}</div></div>
        </div>

        <div class="two-col" style="display:grid;grid-template-columns:1.4fr .9fr;gap:16px">
          <div class="card">
            <div class="section-header" style="display:flex;align-items:center;justify-content:space-between;margin-bottom:12px">
              <h2 class="section-title" style="font-family:var(--font-head);font-size:1rem">Pipeline des demandes</h2>
              <a class="btn btn-sm" href="${pageContext.request.contextPath}/formulaire"><i class="ti ti-list-check"></i> Voir les demandes</a>
            </div>
            <div class="pipeline">
              <div class="pipe-col"><div class="status-bar gray"></div><div class="pipe-head"><span class="pipe-label">Créées</span><span class="pipe-count">${demandesParStatut['DC'] != null ? demandesParStatut['DC'].size() : 0}</span></div></div>
              <div class="pipe-col"><div class="status-bar blue"></div><div class="pipe-head"><span class="pipe-label">Acceptées</span><span class="pipe-count">${demandesParStatut['DA'] != null ? demandesParStatut['DA'].size() : 0}</span></div></div>
              <div class="pipe-col"><div class="status-bar amber"></div><div class="pipe-head"><span class="pipe-label">En étude</span><span class="pipe-count">${demandesParStatut['DE'] != null ? demandesParStatut['DE'].size() : 0}</span></div></div>
              <div class="pipe-col"><div class="status-bar green"></div><div class="pipe-head"><span class="pipe-label">Validées</span><span class="pipe-count">${demandesParStatut['DV'] != null ? demandesParStatut['DV'].size() : 0}</span></div></div>
              <div class="pipe-col"><div class="status-bar red"></div><div class="pipe-head"><span class="pipe-label">Refusées</span><span class="pipe-count">${demandesParStatut['DR'] != null ? demandesParStatut['DR'].size() : 0}</span></div></div>
            </div>
          </div>

          <div class="card">
            <div class="section-header" style="display:flex;align-items:center;justify-content:space-between;margin-bottom:12px">
              <h2 class="section-title" style="font-family:var(--font-head);font-size:1rem">Actions rapides</h2>
            </div>
            <a class="quick-action" href="${pageContext.request.contextPath}/formulaire"><span class="qa-icon blue"><i class="ti ti-file-plus"></i></span><span><div class="qa-label">Nouvelle demande</div><div class="qa-desc">Créer une demande de forage</div></span></a>
            <a class="quick-action" href="${pageContext.request.contextPath}/demande_status/liste"><span class="qa-icon green"><i class="ti ti-timeline"></i></span><span><div class="qa-label">Consulter les statuts</div><div class="qa-desc">Voir l'historique des demandes</div></span></a>
            <a class="quick-action" href="${pageContext.request.contextPath}/devis"><span class="qa-icon purple"><i class="ti ti-receipt"></i></span><span><div class="qa-label">Générer un devis</div><div class="qa-desc">Passer à la création de devis</div></span></a>
          </div>
        </div>
      </div>
    </div>
  </div>
</div>
</body>
</html>
