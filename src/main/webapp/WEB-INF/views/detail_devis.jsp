<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détail devis</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f7fb; margin: 0; padding: 32px; color: #1f2937; }
        .card { max-width: 1200px; margin: 0 auto; background: #fff; border-radius: 16px; padding: 24px; box-shadow: 0 12px 30px rgba(15,23,42,.08); }
        .row { display: grid; grid-template-columns: 180px 1fr; gap: 12px; padding: 10px 0; border-bottom: 1px solid #e5e7eb; }
        .label { font-weight: 700; color: #334155; }
        table { width: 100%; border-collapse: collapse; margin-top: 18px; }
        th, td { padding: 12px 10px; border-bottom: 1px solid #e5e7eb; text-align: left; }
        th { background: #eef4ff; }
        a { color: #2563eb; text-decoration: none; }
        .actions { margin-top: 18px; }
    </style>
</head>
<body>
<div class="card">
    <h2>Détail du devis</h2>
    <c:if test="${not empty devis}">
        <div class="row"><div class="label">ID devis</div><div>${devis.idDevis}</div></div>
        <div class="row"><div class="label">ID demande</div><div>${devis.idDemande}</div></div>
        <div class="row"><div class="label">Type devis</div><div>${devis.idTypeDevis}</div></div>
        <div class="row"><div class="label">Date</div><div>${devis.dateDevis}</div></div>
        <div class="row"><div class="label">Observation</div><div>${devis.observation}</div></div>
    </c:if>

    <h3>Details devis</h3>
    <table>
        <thead>
        <tr>
            <th>ID</th>
            <th>Libellé</th>
            <th>Unité</th>
            <th>Quantité</th>
            <th>Prix unitaire</th>
            <th>Montant</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="detail" items="${detailsDevis}">
            <tr>
                <td>${detail.id_detail}</td>
                <td>${detail.libelle}</td>
                <td>${detail.unite}</td>
                <td>${detail.quantite}</td>
                <td>${detail.prix_unitaire}</td>
                <td>${detail.montantCalcule}</td>
                <td>${detail.description}</td>
                <td>
                    <a href="${pageContext.request.contextPath}/devis/detail/supprimer/${detail.id_detail}">Supprimer</a>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <div class="actions">
        <a href="${pageContext.request.contextPath}/devis/liste">Retour à la liste</a>
    </div>
</div>
</body>
</html>
