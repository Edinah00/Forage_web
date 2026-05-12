<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="UTF-8">
<title>Demandes — Forage Web</title>
<style>
/* ─── Reset ─────────────────────────────────────────────────────────── */
*{box-sizing:border-box;margin:0;padding:0}
body{font-family:Arial,Helvetica,sans-serif;background:#f0f4fa;color:#1e293b;min-height:100vh}

/* ─── Navbar ────────────────────────────────────────────────────────── */
.navbar{
  background:linear-gradient(90deg,#0f172a 0%,#1e3a8a 100%);
  padding:0 24px;display:flex;align-items:center;justify-content:space-between;
  height:60px;box-shadow:0 2px 12px rgba(15,23,42,.25);
}
.navbar-brand{color:#fff;font-size:1.2rem;font-weight:700;text-decoration:none}
.navbar-brand span{color:#60a5fa}
.navbar-links{display:flex;gap:6px}
.navbar-links a{color:#cbd5e1;text-decoration:none;padding:7px 13px;border-radius:8px;font-size:.93rem;transition:background .15s}
.navbar-links a:hover,.navbar-links a.active{background:rgba(255,255,255,.12);color:#fff}

/* ─── Layout ────────────────────────────────────────────────────────── */
.page{max-width:1200px;margin:28px auto;padding:0 16px;display:flex;flex-direction:column;gap:20px}

/* ─── Page header ───────────────────────────────────────────────────── */
.page-header{display:flex;align-items:center;justify-content:space-between;flex-wrap:wrap;gap:12px}
.page-header h1{font-size:1.6rem;color:#0f172a}
.page-header p{font-size:.95rem;color:#64748b;margin-top:4px}

/* ─── Card ──────────────────────────────────────────────────────────── */
.card{background:#fff;border-radius:14px;padding:24px;box-shadow:0 4px 20px rgba(15,23,42,.07)}
.card h2{font-size:1.15rem;color:#0f172a;margin-bottom:18px;padding-bottom:10px;border-bottom:2px solid #e5e7eb}

/* ─── Alert ─────────────────────────────────────────────────────────── */
.alert{padding:12px 16px;border-radius:10px;margin-bottom:16px;font-size:.95rem}
.alert-success{background:#f0fdf4;color:#15803d;border:1px solid #bbf7d0}
.alert-error{background:#fef2f2;color:#b91c1c;border:1px solid #fecaca}

/* ─── Form grid ─────────────────────────────────────────────────────── */
.form-grid{display:grid;grid-template-columns:repeat(2,1fr);gap:14px}
.field{display:flex;flex-direction:column;gap:7px}
.field label{font-size:.91rem;font-weight:700;color:#334155}
.field input,.field select{
  border:1px solid #dbe3ef;border-radius:10px;padding:11px 14px;
  font-size:.97rem;background:#fff;outline:none;transition:border-color .2s,box-shadow .2s;
}
.field input:focus,.field select:focus{
  border-color:#2563eb;box-shadow:0 0 0 3px rgba(37,99,235,.1);
}
.full{grid-column:1/-1}
.actions{margin-top:16px;display:flex;justify-content:flex-end;gap:10px}

/* ─── Buttons ───────────────────────────────────────────────────────── */
.btn{
  display:inline-flex;align-items:center;gap:7px;padding:10px 18px;
  border-radius:10px;font-size:.95rem;font-weight:700;text-decoration:none;
  cursor:pointer;border:0;transition:transform .15s,background .15s,box-shadow .15s;
}
.btn-primary{background:#2563eb;color:#fff;box-shadow:0 4px 14px rgba(37,99,235,.2)}
.btn-primary:hover{background:#1d4ed8;transform:translateY(-1px)}
.btn-ghost{background:#eff6ff;color:#2563eb}
.btn-ghost:hover{background:#dbeafe}
.btn-danger{background:#fef2f2;color:#dc2626}
.btn-danger:hover{background:#fee2e2}
.btn-success{background:#f0fdf4;color:#16a34a}
.btn-success:hover{background:#dcfce7}

/* ─── Table ─────────────────────────────────────────────────────────── */
.table-wrap{overflow-x:auto}
table{width:100%;border-collapse:collapse;min-width:800px}
th,td{padding:11px 12px;border-bottom:1px solid #e5e7eb;text-align:left;vertical-align:middle}
th{background:#eef4ff;color:#1e3a8a;font-size:.88rem;font-weight:700;text-transform:uppercase;letter-spacing:.05em}
tbody tr:hover{background:#f8faff}

/* ─── Badge ─────────────────────────────────────────────────────────── */
.badge{display:inline-block;padding:4px 10px;border-radius:999px;font-size:.82rem;font-weight:700}
.badge-blue{background:#eff6ff;color:#1d4ed8}
.badge-green{background:#f0fdf4;color:#15803d}
.badge-red{background:#fef2f2;color:#b91c1c}
.badge-gray{background:#f1f5f9;color:#475569}

.row-actions{display:flex;gap:6px;flex-wrap:wrap}
.empty{text-align:center;color:#94a3b8;padding:24px;font-size:.95rem}

@media(max-width:680px){
  .form-grid{grid-template-columns:1fr}
  .navbar-links a{padding:6px 9px;font-size:.85rem}
}
</style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar">
  <a class="navbar-brand" href="${pageContext.request.contextPath}/accueil">Forage<span>Web</span></a>
  <div class="navbar-links">
    <a href="${pageContext.request.contextPath}/accueil">Accueil</a>
    <a class="active" href="${pageContext.request.contextPath}/formulaire">Demandes</a>
    <a href="${pageContext.request.contextPath}/devis">Devis</a>
  </div>
</nav>

<div class="page">

  <!-- Page header -->
  <div class="page-header">
    <div>
      <h1>📋 Gestion des demandes</h1>
      <p>Ajoutez une demande et consultez / gérez la liste ci-dessous.</p>
    </div>
  </div>

  <!-- Alerts -->
  <c:if test="${not empty message}">
    <div class="alert alert-success">${message}</div>
  </c:if>
  <c:if test="${not empty erreur}">
    <div class="alert alert-error">${erreur}</div>
  </c:if>

  <!-- ── Formulaire ajout ──────────────────────────────────────────── -->
  <div class="card">
    <h2>➕ Ajouter une demande</h2>

    <%-- Le modelAttribute "demande" DOIT être présent dans le model --%>
    <form:form action="${pageContext.request.contextPath}/Ajout_demande"
               method="post" modelAttribute="demande">

      <%-- ref_demande auto-générée côté serveur, on la cache --%>
      <form:hidden path="ref_demande"/>

      <div class="form-grid">
        <div class="field">
          <label for="id_client">Demandeur</label>
          <form:select path="id_client" id="id_client">
            <form:option value="">— Choisir un client —</form:option>
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
            <form:option value="">— Choisir une commune —</form:option>
            <c:forEach var="commune" items="${communes}">
              <form:option value="${commune.idCommune}">${commune.nomCommune}</form:option>
            </c:forEach>
          </form:select>
        </div>
      </div>

      <div class="actions">
        <input class="btn btn-primary" type="submit" value="✔ Enregistrer la demande"/>
      </div>
    </form:form>
  </div>

  <!-- ── Liste des demandes ────────────────────────────────────────── -->
  <div class="card">
    <h2>📑 Liste des demandes</h2>
    <div class="table-wrap">
      <table>
        <thead>
          <tr>
            <th>ID</th><th>Référence</th><th>Client</th>
            <th>Lieu</th><th>Commune</th><th>Date</th><th>Actions</th>
          </tr>
        </thead>
        <tbody>
          <c:choose>
            <c:when test="${not empty demandes}">
              <c:forEach var="d" items="${demandes}">
                <tr>
                  <td><span class="badge badge-blue">#${d.id_demande}</span></td>
                  <td>${d.ref_demande}</td>
                  <td>${d.id_client}</td>
                  <td>${d.lieu_demande}</td>
                  <td>${d.id_commune}</td>
                  <td>${d.date_demande}</td>
                  <td>
                    <div class="row-actions">
                      <a class="btn btn-ghost" href="${pageContext.request.contextPath}/demande/${d.id_demande}">👁 Voir</a>
                      <a class="btn btn-ghost" href="${pageContext.request.contextPath}/demande/modifier/${d.id_demande}">✏️ Modifier</a>
                      <a class="btn btn-success" href="${pageContext.request.contextPath}/demande/valider/${d.id_demande}"
                         onclick="return confirm('Accepter cette demande ?')">✔ Accepter</a>
                      <a class="btn btn-danger" href="${pageContext.request.contextPath}/demande/refuser/${d.id_demande}"
                         onclick="return confirm('Refuser cette demande ?')">✘ Refuser</a>
                      <a class="btn btn-danger" href="${pageContext.request.contextPath}/demande/supprimer/${d.id_demande}"
                         onclick="return confirm('Supprimer cette demande ?')">🗑</a>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </c:when>
            <c:otherwise>
              <tr><td class="empty" colspan="7">Aucune demande enregistrée.</td></tr>
            </c:otherwise>
          </c:choose>
        </tbody>
      </table>
    </div>
  </div>

</div><!-- /page -->
</body>
</html>
