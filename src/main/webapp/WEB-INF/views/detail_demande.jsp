<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Détail demande</title>
    <style>
        body { font-family: Arial, Helvetica, sans-serif; background: #f4f7fb; margin: 0; padding: 32px; color: #1f2937; }
        .card { max-width: 780px; margin: 0 auto; background: #fff; border-radius: 16px; padding: 24px; box-shadow: 0 12px 30px rgba(15,23,42,.08); }
        .row { display: grid; grid-template-columns: 180px 1fr; gap: 12px; padding: 10px 0; border-bottom: 1px solid #e5e7eb; }
        .label { font-weight: 700; color: #334155; }
        .back { display: inline-block; margin-top: 18px; color: #2563eb; text-decoration: none; }
    </style>
</head>
<body>
<div class="card">
    <h2>Détail de la demande</h2>
    <c:if test="${not empty demande}">
        <div class="row"><div class="label">ID</div><div>${demande.id_demande}</div></div>
        <div class="row"><div class="label">Référence</div><div>${demande.ref_demande}</div></div>
        <div class="row"><div class="label">Client</div><div>${demande.id_client}</div></div>
        <div class="row"><div class="label">Lieu</div><div>${demande.lieu_demande}</div></div>
        <div class="row"><div class="label">Commune</div><div>${demande.id_commune}</div></div>
        <div class="row"><div class="label">Date</div><div>${demande.date_demande}</div></div>
    </c:if>
    <a class="back" href="${pageContext.request.contextPath}/formulaire">Retour</a>
</div>
</body>
</html>
