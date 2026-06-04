<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Modifier statut — ForageWeb</title>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link href="https://fonts.googleapis.com/css2?family=Syne:wght@600;700;800&family=DM+Sans:wght@400;500;600&display=swap" rel="stylesheet">
<style>
:root{
  --bg:#0d1117;--surface:#161b22;--surface2:#21262d;--border:#30363d;
  --primary:#2f81f7;--primary-dim:rgba(47,129,247,.15);
  --text:#e6edf3;--muted:#8b949e;
  --font-head:'Syne',sans-serif;--font-body:'DM Sans',sans-serif;
  --radius:12px;--radius-sm:8px;
}
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:var(--font-body);background:var(--bg);color:var(--text);min-height:100vh}
.nav{position:sticky;top:0;z-index:100;background:rgba(13,17,23,.85);backdrop-filter:blur(16px);border-bottom:1px solid var(--border);padding:0 24px;height:56px;display:flex;align-items:center;justify-content:space-between}
.brand{font-family:var(--font-head);font-size:1.15rem;color:var(--text);text-decoration:none}
.brand em{color:var(--primary);font-style:normal}
.nav-links{display:flex;gap:4px}
.nav-links a{color:var(--muted);text-decoration:none;padding:6px 12px;border-radius:var(--radius-sm);font-size:.9rem;font-weight:500;transition:all .15s}
.nav-links a:hover{background:var(--surface2);color:var(--text)}
.nav-links a.active{background:var(--primary-dim);color:var(--primary)}
.page{max-width:680px;margin:40px auto;padding:0 20px}
.page-title{font-family:var(--font-head);font-size:1.6rem;letter-spacing:-.03em;margin-bottom:6px}
.page-sub{color:var(--muted);font-size:.95rem;margin-bottom:24px}
.card{background:var(--surface);border:1px solid var(--border);border-radius:16px;padding:28px}
.form-grid{display:grid;grid-template-columns:1fr 1fr;gap:16px}
.full{grid-column:1/-1}
.field{display:flex;flex-direction:column;gap:7px}
.field label{font-size:.83rem;font-weight:600;color:var(--muted);text-transform:uppercase;letter-spacing:.06em}
.field input,.field select,.field textarea{background:var(--surface2);border:1px solid var(--border);border-radius:var(--radius-sm);padding:11px 14px;color:var(--text);font-family:var(--font-body);font-size:.95rem;outline:none;transition:border-color .2s,box-shadow .2s}
.field input:focus,.field select:focus,.field textarea:focus{border-color:var(--primary);box-shadow:0 0 0 3px var(--primary-dim)}
.field input:disabled{opacity:.45;cursor:not-allowed}
.field select option{background:var(--surface2)}
.field textarea{min-height:80px;resize:vertical}
.form-actions{margin-top:24px;display:flex;justify-content:flex-end;gap:10px}
.btn{display:inline-flex;align-items:center;gap:6px;padding:9px 18px;border-radius:var(--radius-sm);font-family:var(--font-body);font-size:.9rem;font-weight:600;text-decoration:none;cursor:pointer;border:1px solid transparent;transition:all .15s}
.btn-primary{background:var(--primary);color:#fff}
.btn-primary:hover{background:#388bfd;transform:translateY(-1px)}
.btn-ghost{background:transparent;color:var(--muted);border-color:var(--border)}
.btn-ghost:hover{background:var(--surface2);color:var(--text)}
.info-box{background:var(--surface2);border:1px solid var(--border);border-radius:var(--radius-sm);padding:14px 16px;font-size:.9rem;color:var(--muted);margin-bottom:20px;line-height:1.6}
.info-box strong{color:var(--text)}
</style>
</head>
<body>

<nav class="nav">
  <a class="brand" href="${pageContext.request.contextPath}/accueil">Forage<em>Web</em></a>
  <div class="nav-links">
    <a href="${pageContext.request.contextPath}/accueil">Accueil</a>
    <a href="${pageContext.request.contextPath}/formulaire">Demandes</a>
    <a href="${pageContext.request.contextPath}/devis">Devis</a>
    <a href="${pageContext.request.contextPath}/form_demande_status" class="active">Statuts</a>
  </div>
</nav>

<div class="page">
  <h1 class="page-title">Modifier un statut</h1>
  <p class="page-sub">Mettez à jour la date ou l'observation de ce statut.</p>

  <div class="card">

    <div class="info-box">
      <strong>Demande #${demandeStatus.id_demande}</strong> — Statut actuel :
      <strong>
        <c:forEach items="${statuses}" var="st">
          <c:if test="${st.value == demandeStatus.id_status}">${st.key}</c:if>
        </c:forEach>
      </strong>
    </div>

    <%-- CORRECTION : id séquentiel au lieu de (idDemande + idStatus) --%>
    <form:form action="${pageContext.request.contextPath}/demande_status/modifier"
               method="post" modelAttribute="demandeStatus">

      <form:input path="id"         type="hidden"/>
      <form:input path="id_demande" type="hidden"/>
      <form:input path="id_status"  type="hidden"/>

      <div class="form-grid">

        <div class="field">
          <label for="dateStatus">Date et heure <span style="color:#f85149">*</span></label>
          <form:input path="date_status" type="datetime-local" id="dateStatus"/>
        </div>

        <div class="field full">
          <label for="observation">Observation</label>
          <form:textarea path="observation" id="observation"
                         placeholder="Remarques ou informations complémentaires…"/>
        </div>

      </div>

      <div class="form-actions">
        <a class="btn btn-ghost" href="${pageContext.request.contextPath}/demande_status/liste">Annuler</a>
        <button type="submit" class="btn btn-primary">Mettre à jour</button>
      </div>

    </form:form>
  </div>
</div>
</body>
</html>
