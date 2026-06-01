<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c"    uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <title>Liste des statuts — Forage Web</title>
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
        .page { max-width: 1200px; margin: 28px auto; padding: 0 16px; display: flex; flex-direction: column; gap: 20px; }

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

        /* ─── Table ─────────────────────────────────────────────────────────── */
        .table-wrap { overflow-x: auto; }
        table { width: 100%; border-collapse: collapse; min-width: 800px; }
        th, td { padding: 11px 12px; border-bottom: 1px solid #e5e7eb; text-align: left; vertical-align: middle; }
        th { background: #eef4ff; color: #1e3a8a; font-size: .88rem; font-weight: 700; text-transform: uppercase; letter-spacing: .05em; }
        tbody tr:hover { background: #f8faff; }

        /* ─── Badge ─────────────────────────────────────────────────────────── */
        .badge { display: inline-block; padding: 4px 10px; border-radius: 999px; font-size: .82rem; font-weight: 700; }
        .badge-blue { background: #eff6ff; color: #1d4ed8; }
        .badge-green { background: #f0fdf4; color: #15803d; }
        .badge-gray { background: #f1f5f9; color: #475569; }

        /* ─── Actions ────────────────────────────────────────────────────────── */
        .row-actions { display: flex; gap: 6px; flex-wrap: wrap; }
        .btn {
          display: inline-flex; align-items: center; gap: 4px; padding: 6px 12px;
          border-radius: 8px; font-size: .88rem; font-weight: 700; text-decoration: none;
          cursor: pointer; border: 0; transition: transform .15s, background .15s;
        }
        .btn-primary { background: #2563eb; color: #fff; }
        .btn-primary:hover { background: #1d4ed8; transform: translateY(-1px); }
        .btn-danger { background: #fef2f2; color: #dc2626; }
        .btn-danger:hover { background: #fee2e2; }
        .btn-ghost { background: #eff6ff; color: #2563eb; }
        .btn-ghost:hover { background: #dbeafe; }

        /* ─── Empty state ────────────────────────────────────────────────────── */
        .empty { text-align: center; color: #94a3b8; padding: 40px 24px; font-size: .95rem; }

        /* ─── Actions bar ────────────────────────────────────────────────────── */
        .actions-bar { display: flex; justify-content: flex-end; gap: 10px; margin-bottom: 16px; }

        @media(max-width: 768px) {
          .navbar-links a { padding: 6px 9px; font-size: .85rem; }
          table { font-size: .9rem; }
          th, td { padding: 8px; }
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
      <h1>📊 Liste des statuts de demandes</h1>
      <p>Gérez et consultez tous les statuts assignés aux demandes.</p>
    </div>
  </div>

  <!-- Alerts -->
  <c:if test="${not empty message}">
    <div class="alert alert-success">${message}</div>
  </c:if>
  <c:if test="${not empty erreur}">
    <div class="alert alert-error">${erreur}</div>
  </c:if>

  <!-- ── Card Liste ──────────────────────────────────────────── -->
  <div class="card">
    <div style="display: flex; align-items: center; justify-content: space-between; margin-bottom: 16px;">
      <h2>Statuts enregistrés</h2>
      <a class="btn btn-ghost" href="${pageContext.request.contextPath}/form_demande_status">➕ Ajouter</a>
    </div>

    <c:choose>
      <c:when test="${empty demandesStatus}">
        <div class="empty">
          <p>Aucun statut de demande enregistré pour le moment.</p>
          <p style="margin-top: 8px;"><a href="${pageContext.request.contextPath}/form_demande_status" style="color: #2563eb; text-decoration: underline;">Ajouter un nouveau statut</a></p>
        </div>
      </c:when>
      <c:otherwise>
        <div class="table-wrap">
          <table>
            <thead>
              <tr>
                <th>ID Demande</th>
                <th>Statut</th>
                <th>Date & Heure</th>
                <th>Durée travaillée</th>
                <th>Couleur</th>
                <th>Observation</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <c:forEach items="${demandesStatus}" var="status">
                <tr>
                  <td><span class="badge badge-blue">${status.getId_demande()}</span></td>
                  <td>
                    <c:set var="statusCode" value="" />
                    <c:forEach items="${statuses}" var="st">
                      <c:if test="${st.value == status.getId_status()}">
                        <span class="badge badge-green">${st.key}</span>
                      </c:if>
                    </c:forEach>
                  </td>
                  <td>${status.getDate_status()}</td>
                  <td>
                    <c:choose>
                      <c:when test="${status.getDuree_travail_minutes() != null}">
                        ${status.getDuree_travail_minutes()} min
                      </c:when>
                      <c:otherwise>
                        —
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>
                    <c:choose>
                      <c:when test="${status.getCouleur() != null}">
                        <span class="badge badge-green">${status.getCouleur()}</span>
                      </c:when>
                      <c:otherwise>
                        —
                      </c:otherwise>
                    </c:choose>
                  </td>
                  <td>${status.getObservation() != null && !status.getObservation().isEmpty() ? status.getObservation() : '—'}</td>
                  <td>
                    <div class="row-actions">
                      <a class="btn btn-primary" href="${pageContext.request.contextPath}/demande_status/modifier/${status.getId_demande()}/${status.getId_status()}">✏️ Modifier</a>
                      <a class="btn btn-danger" onclick="if (confirm('Êtes-vous sûr de vouloir supprimer ce statut ?')) { window.location='${pageContext.request.contextPath}/demande_status/supprimer/${status.getId_demande()}/${status.getId_status()}'; }">🗣️ Supprimer</a>
                    </div>
                  </td>
                </tr>
              </c:forEach>
            </tbody>
          </table>
        </div>
      </c:otherwise>
    </c:choose>

  </div>

</div>

</body>
</html>
