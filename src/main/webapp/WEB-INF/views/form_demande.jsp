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
            min-height: 100vh;
        }

        .page {
            width: 100%;
            max-width: none;
            margin: 0;
            padding: 8px;
        }

        .layout {
            display: grid;
            grid-template-columns: 240px 1fr;
            gap: 12px;
            align-items: start;
        }

        .sidebar {
            position: sticky;
            top: 8px;
            min-height: calc(100vh - 16px);
            padding: 18px 14px;
            border-radius: 16px;
            background: linear-gradient(180deg, #0f172a 0%, #1e293b 100%);
            color: #e2e8f0;
            box-shadow: 0 12px 28px rgba(15, 23, 42, 0.14);
        }

        .brand {
            margin-bottom: 18px;
            padding-bottom: 14px;
            border-bottom: 1px solid rgba(226, 232, 240, 0.12);
        }

        .brand h1 {
            margin: 0 0 8px;
            font-size: 1.5rem;
            color: #fff;
        }

        .brand p {
            margin: 0;
            color: #94a3b8;
            font-size: 0.92rem;
            line-height: 1.5;
        }

        .nav-title {
            margin: 0 0 12px;
            font-size: 0.8rem;
            text-transform: uppercase;
            letter-spacing: 0.12em;
            color: #94a3b8;
        }

        .nav {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .nav a {
            display: block;
            padding: 12px 14px;
            border-radius: 14px;
            color: #e2e8f0;
            text-decoration: none;
            background: rgba(148, 163, 184, 0.08);
            transition: background 0.15s ease, transform 0.15s ease;
        }

        .nav a:hover {
            background: rgba(37, 99, 235, 0.25);
            transform: translateX(2px);
        }

        .sidebar-card {
            margin-top: 22px;
            padding: 16px;
            border-radius: 16px;
            background: rgba(255, 255, 255, 0.05);
            border: 1px solid rgba(255, 255, 255, 0.08);
        }

        .sidebar-card strong {
            display: block;
            margin-bottom: 6px;
            color: #fff;
        }

        .sidebar-card span {
            color: #cbd5e1;
            font-size: 0.92rem;
            line-height: 1.5;
        }

        .content {
            display: flex;
            flex-direction: column;
            gap: 12px;
        }

        .grid {
            display: grid;
            grid-template-columns: 1fr;
            gap: 12px;
        }

        .card {
            background: var(--card);
            border: 1px solid var(--border);
            border-radius: 14px;
            box-shadow: 0 10px 28px rgba(15, 23, 42, 0.06);
            padding: 18px;
        }

        .card h2 {
            margin: 0 0 18px;
            font-size: 1.25rem;
        }

        .message {
            margin-bottom: 12px;
            padding: 12px 14px;
            border-radius: 12px;
            background: #ecfdf5;
            color: var(--success);
            border: 1px solid #bbf7d0;
        }

        .form-grid {
            display: grid;
            grid-template-columns: repeat(2, minmax(0, 1fr));
            gap: 12px;
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
            margin-top: 14px;
            display: flex;
            justify-content: flex-end;
        }

        .btn {
            border: 0;
            border-radius: 10px;
            padding: 10px 14px;
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
            padding: 11px 10px;
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
            padding: 18px 12px;
        }

        @media (max-width: 720px) {
            .layout {
                grid-template-columns: 1fr;
            }

            .sidebar {
                position: relative;
                min-height: auto;
            }

            .form-grid {
                grid-template-columns: 1fr;
            }

            .card {
                padding: 14px;
            }
        }
    </style>
</head>
<body>
<div class="page">
    <div class="layout">
        <aside class="sidebar">
            <div class="brand">
                <h1>Forage Web</h1>
                <p>Gestion des demandes, clients et communes depuis une interface simple.</p>
            </div>

            <p class="nav-title">Navigation</p>
            <nav class="nav">
                <a href="${pageContext.request.contextPath}/formulaire">Ajouter une demande</a>
                <a href="${pageContext.request.contextPath}/demandes">Liste des demandes</a>
                <a href="${pageContext.request.contextPath}/formulaire">Accueil</a>
            </nav>

            <div class="sidebar-card">
                <strong>Astuce</strong>
                <span>Les sélections client et commune viennent directement de la base de données.</span>
            </div>
        </aside>

        <main class="content">
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
                                        <form:option value="${client.idClient}">${client.nomClient}</form:option>
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
                                        <form:option value="${commune.idCommune}">${commune.nomCommune}</form:option>
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
        </main>
    </div>
</div>

</body>
</html>
