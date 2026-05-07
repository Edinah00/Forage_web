<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <meta charset="UTF-8">
    <title>Gestion des demandes</title>
    <style>
        :root {
            --bg: #f4f7fb;
            --card: #ffffff;
            --text: #1f2937;
            --muted: #6b7280;
            --primary: #2563eb;
            --primary-dark: #1d4ed8;
            --border: #dbe3ef;
            --table-head: #eef4ff;
            --success: #16a34a;
            --danger: #dc2626;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, Helvetica, sans-serif;
            background: linear-gradient(180deg, #eff6ff 0%, var(--bg) 35%, #edf2f7 100%);
            color: var(--text);
        }

        .page {
            max-width: 1100px;
            margin: 0 auto;
            padding: 32px 20px 48px;
        }

        .hero {
            margin-bottom: 24px;
        }

        .hero h1 {
            margin: 0 0 8px;
            font-size: 2rem;
        }

        .hero p {
            margin: 0;
            color: var(--muted);
        }

        .grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 24px;
        }

        .card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 18px;
            box-shadow: 0 14px 40px rgba(15, 23, 42, 0.08);
            padding: 24px;
        }

        .card h2 {
            margin: 0 0 18px;
            font-size: 1.25rem;
        }

        .message {
            margin-bottom: 16px;
            padding: 12px 14px;
            border-radius: 12px;
            background: #ecfdf5;
            color: var(--success);
            border: 1px solid #bbf7d0;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 16px;
        }

        .field {
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .field label {
            font-size: 0.92rem;
            font-weight: 700;
            color: #334155;
        }

        .field input,
        .field select {
            width: 100%;
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 12px 14px;
            font-size: 0.98rem;
            background: #fff;
            outline: none;
        }

        .field input:focus,
        .field select:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(37, 99, 235, 0.12);
        }

        .field.full {
            grid-column: 1 / -1;
        }

        .actions {
            margin-top: 18px;
            display: flex;
            justify-content: flex-end;
        }

        .btn {
            border: 0;
            border-radius: 12px;
            padding: 12px 18px;
            font-size: 0.98rem;
            font-weight: 700;
            cursor: pointer;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            transition: transform 0.15s ease, background 0.15s ease, box-shadow 0.15s ease;
        }

        .btn-primary {
            background: var(--primary);
            color: #fff;
            box-shadow: 0 10px 20px rgba(37, 99, 235, 0.18);
        }

        .btn-primary:hover {
            background: var(--primary-dark);
            transform: translateY(-1px);
        }

        .btn-ghost {
            background: #eff6ff;
            color: var(--primary);
        }

        .table-wrap {
            overflow-x: auto;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 820px;
        }

        th, td {
            padding: 14px 12px;
            border-bottom: 1px solid var(--border);
            text-align: left;
            vertical-align: top;
        }

        th {
            background: var(--table-head);
            color: #1e3a8a;
            font-size: 0.92rem;
        }

        tbody tr:hover {
            background: #f8fbff;
        }

        .badge {
            display: inline-block;
            padding: 5px 10px;
            border-radius: 999px;
            background: #eff6ff;
            color: #1d4ed8;
            font-size: 0.85rem;
            font-weight: 700;
        }

        .row-actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }

        .link-danger {
            color: var(--danger);
        }

        .empty-state {
            text-align: center;
            color: var(--muted);
            padding: 26px 12px;
        }

        @media (max-width: 720px) {
            .form-grid {
                grid-template-columns: 1fr;
            }

            .card {
                padding: 18px;
            }
        }
    </style>
</head>
<body>
<div class="page">
    <div class="hero">
        <h1>Gestion des demandes</h1>
        <p>Ajoutez une nouvelle demande puis consultez la liste juste en dessous.</p>
    </div>

    <div class="grid">
        <div class="card">
            <h2>Ajouter une demande</h2>

            <c:if test="${not empty message}">
                <div class="message">${message}</div>
            </c:if>

            <form:form action="${pageContext.request.contextPath}/Ajout_demande" method="post" modelAttribute="demande">
                <form:input path="ref_demande" type="hidden" value="25" />

                <div class="form-grid">
                    <div class="field">
                        <label>Demandeur</label>
                        <form:select path="id_client">
                            <form:option value="">-- Choisir un client --</form:option>
                            <c:forEach var="client" items="${clients}">
                                <form:option value="${client.id_client}">${client.nom_client}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>

                    <div class="field">
                        <label>Date</label>
                        <form:input path="date_demande" type="date"/>
                    </div>

                    <div class="field">
                        <label>Lieu</label>
                        <form:input path="lieu_demande" placeholder="Ex: Antananarivo"/>
                    </div>

                    <div class="field">
                        <label>Commune</label>
                        <form:select path="id_commune">
                            <form:option value="">-- Choisir une commune --</form:option>
                            <c:forEach var="commune" items="${communes}">
                                <form:option value="${commune.id_commune}">${commune.nom_commune}</form:option>
                            </c:forEach>
                        </form:select>
                    </div>
                </div>

                <div class="actions">
                    <input class="btn btn-primary" type="submit" value="Ajouter la demande"/>
                </div>
            </form:form>
        </div>

        <div class="card">
            <h2>Liste des demandes</h2>

            <div class="table-wrap">
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
                    <c:choose>
                        <c:when test="${not empty demandes}">
                            <c:forEach var="demande" items="${demandes}">
                                <tr>
                                    <td><span class="badge">${demande.id_demande}</span></td>
                                    <td>${demande.ref_demande}</td>
                                    <td>${demande.id_client}</td>
                                    <td>${demande.lieu_demande}</td>
                                    <td>${demande.id_commune}</td>
                                    <td>${demande.date_demande}</td>
                                    <td>
                                        <div class="row-actions">
                                            <a class="btn btn-ghost" href="${pageContext.request.contextPath}/demande/${demande.id_demande}">Voir</a>
                                            <a class="btn btn-ghost" href="${pageContext.request.contextPath}/demande/modifier/${demande.id_demande}">Modifier</a>
                                            <a class="btn btn-ghost link-danger"
                                               href="${pageContext.request.contextPath}/demande/supprimer/${demande.id_demande}"
                                               onclick="return confirm('Supprimer cette demande ?');">Supprimer</a>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td class="empty-state" colspan="7">Aucune demande enregistrée pour le moment.</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

</body>
</html>
