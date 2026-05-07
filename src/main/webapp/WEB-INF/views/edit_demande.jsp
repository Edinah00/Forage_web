<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier demande</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f4f7fb; margin: 0; padding: 32px; color: #1f2937; }
        .card { max-width: 760px; margin: 0 auto; background: #fff; border-radius: 16px; padding: 24px; box-shadow: 0 12px 30px rgba(15,23,42,.08); }
        .field { margin-bottom: 14px; display: flex; flex-direction: column; gap: 6px; }
        input, select { border: 1px solid #dbe3ef; border-radius: 10px; padding: 10px 12px; }
        .actions { margin-top: 18px; display: flex; gap: 10px; }
        .btn { border: 0; border-radius: 10px; padding: 10px 14px; text-decoration: none; cursor: pointer; }
        .primary { background: #2563eb; color: #fff; }
        .secondary { background: #e5eefc; color: #2563eb; }
    </style>
</head>
<body>
<div class="card">
    <h2>Modifier la demande</h2>
    <form:form action="${pageContext.request.contextPath}/demande/modifier" method="post" modelAttribute="demande">
        <form:input path="id_demande" type="hidden"/>

        <div class="field">
            <label>Référence</label>
            <form:input path="ref_demande"/>
        </div>
        <div class="field">
            <label>Client</label>
            <form:input path="id_client"/>
        </div>
        <div class="field">
            <label>Lieu</label>
            <form:input path="lieu_demande"/>
        </div>
        <div class="field">
            <label>Commune</label>
            <form:input path="id_commune"/>
        </div>
        <div class="field">
            <label>Date</label>
            <form:input path="date_demande" type="date"/>
        </div>

        <div class="actions">
            <input class="btn primary" type="submit" value="Enregistrer"/>
            <a class="btn secondary" href="${pageContext.request.contextPath}/formulaire">Annuler</a>
        </div>
    </form:form>
</div>
</body>
</html>
