<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des demandes</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f7fb; margin: 0; padding: 32px; color: #1f2937; }
        .card { max-width: 1100px; margin: 0 auto; background: #fff; border-radius: 16px; padding: 24px; box-shadow: 0 12px 30px rgba(15,23,42,.08); }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px 10px; border-bottom: 1px solid #e5e7eb; text-align: left; }
        th { background: #eef4ff; }
        a { color: #2563eb; text-decoration: none; }
    </style>
</head>
<body>
<div class="card">
    <h2>Liste des demandes</h2>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Référence</th>
            <th>Client</th>
            <th>Lieu</th>
            <th>Commune</th>
            <th>Date</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="demande" items="${demandes}">
            <tr>
                <td>${demande.id_demande}</td>
                <td>${demande.ref_demande}</td>
                <td>${demande.id_client}</td>
                <td>${demande.lieu_demande}</td>
                <td>${demande.id_commune}</td>
                <td>${demande.date_demande}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/demande/${demande.id_demande}">Voir</a>
                    |
                    <a href="${pageContext.request.contextPath}/demande/modifier/${demande.id_demande}">Modifier</a>
                    |
                    <a href="${pageContext.request.contextPath}/demande/supprimer/${demande.id_demande}">Supprimer</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
    <p><a href="${pageContext.request.contextPath}/formulaire">Retour au formulaire</a></p>
</div>
</body>
</html>
