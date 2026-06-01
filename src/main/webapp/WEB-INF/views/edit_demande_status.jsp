<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Modifier un statut — Forage Web</title>
    <style>
        /* ─── Reset et styles de base ─────────────────────────────────────── */
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: Arial, Helvetica, sans-serif; background: #f0f4fa; color: #1e293b; min-height: 100vh; }

        /* ─── Navbar ────────────────────────────────────────────────────────── */
        .navbar {
          background: linear-gradient(90deg, #0f172a 0%, #1e3a8a 100%);
          padding: 0 24px; display: flex; align-items: center; justify-content: space-between;
          height: 60px; box-shadow: 0 2px 12px rgba(15, 23, 42, .25);
        }
        .navbar-brand { color: #fff; font-size: 1.2rem; font-weight: 700; text-decoration: none; }
        .navbar-brand span { color: #60a5fa; }
        .navbar-links { display: flex; gap: 6px; }
        .navbar-links a { color: #cbd5e1; text-decoration: none; padding: 7px 13px; border-radius: 8px; font-size: .93rem; transition: background .15s; }
        .navbar-links a:hover, .navbar-links a.active { background: rgba(255, 255, 255, .12); color: #fff; }

        /* ─── Layout ────────────────────────────────────────────────────────── */
        .page { max-width: 1000px; margin: 28px auto; padding: 0 16px; display: flex; flex-direction: column; gap: 20px; }

        /* ─── Page header ───────────────────────────────────────────────────── */
        .page-header { display: flex; align-items: center; justify-content: space-between; flex-wrap: wrap; gap: 12px; }
        .page-header h1 { font-size: 1.6rem; color: #0f172a; }
        .page-header p { font-size: .95rem; color: #64748b; margin-top: 4px; }

        /* ─── Card ──────────────────────────────────────────────────────────── */
        .card { background: #fff; border-radius: 14px; padding: 24px; box-shadow: 0 4px 20px rgba(15, 23, 42, .07); }
        .card h2 { font-size: 1.15rem; color: #0f172a; margin-bottom: 18px; padding-bottom: 10px; border-bottom: 2px solid #e5e7eb; }

        /* ─── Alert ─────────────────────────────────────────────────────────── */
        .alert { padding: 12px 16px; border-radius: 10px; margin-bottom: 16px; font-size: .95rem; }
        .alert-success { background: #f0fdf4; color: #15803d; border: 1px solid #bbf7d0; }
        .alert-error { background: #fef2f2; color: #b91c1c; border: 1px solid #fecaca; }

        /* ─── Form grid ─────────────────────────────────────────────────────── */
        .form-grid { display: grid; grid-template-columns: repeat(2, 1fr); gap: 14px; }
        .field { display: flex; flex-direction: column; gap: 7px; }
        .field label { font-size: .91rem; font-weight: 700; color: #334155; }
        .field input, .field select, .field textarea {
          border: 1px solid #dbe3ef; border-radius: 10px; padding: 11px 14px;
          font-size: .97rem; background: #fff; outline: none; transition: border-color .2s, box-shadow .2s;
        }
        .field input:focus, .field select:focus, .field textarea:focus {
          border-color: #2563eb; box-shadow: 0 0 0 3px rgba(37, 99, 235, .1);
        }
        .field textarea { min-height: 80px; resize: vertical; }
        .full { grid-column: 1 / -1; }
        .actions { margin-top: 20px; display: flex; justify-content: flex-end; gap: 10px; }

        /* ─── Buttons ───────────────────────────────────────────────────────── */
        .btn {
          display: inline-flex; align-items: center; gap: 7px; padding: 10px 18px;
          border-radius: 10px; font-size: .95rem; font-weight: 700; text-decoration: none;
          cursor: pointer; border: 0; transition: transform .15s, background .15s, box-shadow .15s;
        }
        .btn-primary { background: #2563eb; color: #fff; box-shadow: 0 4px 14px rgba(37, 99, 235, .2); }
        .btn-primary:hover { background: #1d4ed8; transform: translateY(-1px); }
        .btn-ghost { background: #eff6ff; color: #2563eb; }
        .btn-ghost:hover { background: #dbeafe; }
        .btn-danger { background: #fef2f2; color: #dc2626; }
        .btn-danger:hover { background: #fee2e2; }

        /* ─── Message ────────────────────────────────────────────────────────── */
        .muted { color: #64748b; font-size: 0.91rem; margin-top: 6px; }
        
        @media(max-width: 680px) {
          .form-grid { grid-template-columns: 1fr; }
          .navbar-links a { padding: 6px 9px; font-size: .85rem; }
        }
    </style>
</head>
<body>

<!-- NAVBAR -->
<nav class="navbar">
  <a class="navbar-brand" href="${pageContext.request.contextPath}/accueil">Forage<span>Web</span></a>
  <div class="navbar-links">
    <a href="${pageContext.request.contextPath}/accueil">Accueil</a>
    <a href="${pageContext.request.contextPath}/formulaire">Demandes</a>
    <a href="${pageContext.request.contextPath}/devis">Devis</a>
    <a class="active" href="${pageContext.request.contextPath}/form_demande_status">Status</a>
  </div>
</nav>

<div class="page">

  <!-- Page header -->
  <div class="page-header">
    <div>
      <h1>✏️ Modifier un statut de demande</h1>
      <p>Mettez à jour les informations du statut.</p>
    </div>
  </div>

  <!-- Alerts -->
  <c:if test="${not empty message}">
    <div class="alert alert-success">${message}</div>
  </c:if>
  <c:if test="${not empty erreur}">
    <div class="alert alert-error">${erreur}</div>
  </c:if>

  <!-- ── Formulaire modification ──────────────────────────────────────────── -->
  <div class="card">
    <h2>🔄 Modifier le statut</h2>

    <form:form action="${pageContext.request.contextPath}/demande_status/modifier"
               method="post" modelAttribute="demandeStatus">

      <div class="form-grid">

        <!-- Référence demande (lecture seule) -->
        <div class="field">
          <label>Référence demande</label>
          <input type="text" value="${demandeStatus.id_demande}" disabled />
          <form:input path="id_demande" type="hidden" />
          <form:input path="id_status" type="hidden" />
        </div>

        <!-- Status actuel -->
        <div class="field">
          <label>Statut</label>
          <input type="text" value="${demandeStatus.id_status}" disabled />
        </div>

        <!-- Date et heure -->
        <div class="field">
          <label for="dateStatus">Date et heure <span style="color:#dc2626;">*</span></label>
          <form:input path="date_status" type="datetime-local" id="dateStatus" />
        </div>

        <!-- Observation -->
        <div class="field full">
          <label for="observation">Observation</label>
          <form:textarea path="observation" id="observation" placeholder="Entrez vos observations (optionnel)"></form:textarea>
        </div>

      </div>

      <div class="actions">
        <a class="btn btn-ghost" href="${pageContext.request.contextPath}/demande_status/liste">Annuler</a>
        <button type="submit" class="btn btn-primary">Mettre à jour</button>
      </div>

    </form:form>

  </div>

</div>

</body>
</html>
