<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des devis</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f7fb; margin: 0; padding: 32px; color: #1f2937; }
        .card { max-width: 1200px; margin: 0 auto; background: #fff; border-radius: 16px; padding: 24px; box-shadow: 0 12px 30px rgba(15,23,42,.08); }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px 10px; border-bottom: 1px solid #e5e7eb; text-align: left; }
        th { background: #eef4ff; }
        a { color: #2563eb; text-decoration: none; }
        .badge { display:inline-block; padding:4px 10px; border-radius:999px; background:#dbeafe; color:#1d4ed8; font-size:12px; font-weight:700; }
    </style>
</head>
<body>
<div class="card">
    <h2>Liste des devis</h2>
    <p><a href="${pageContext.request.contextPath}/devis/nouveau">+ Nouveau devis</a></p>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Demande</th>
            <th>Type</th>
            <th>Date</th>
            <th>Observation</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="devis" items="${devisList}">
            <tr>
                <td>${devis.idDevis}</td>
                <td><span class="badge">${devis.idDemande}</span></td>
                <td>${devis.idTypeDevis}</td>
                <td>${devis.dateDevis}</td>
                <td>${devis.observation}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/devis/${devis.idDevis}">Voir</a>
                    |
                    <a href="${pageContext.request.contextPath}/devis/supprimer/${devis.idDevis}">Supprimer</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>
</body>
</html>
