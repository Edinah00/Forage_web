<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<html>
<body>

<%-- ✅ modelAttribute doit correspondre à model.addAttribute("demande") --%>
<form:form action="${pageContext.request.contextPath}/Ajout_demande" method="post" modelAttribute="demande">

    <form:input path="ref_demande" type="hidden" value="25" />

    <label>Demandeur :</label>
    <form:select path="id_client">
        <form:option value="1">Demandeur 1</form:option>
        <form:option value="2">Demandeur 2</form:option>
    </form:select>
   
    <form:input path="lieu_demande" placeholder="Lieu"/>
    <form:input path="id_commune"  placeholder="ID Commune"/>
    <form:input path="date_demande" type="date"/>

    <input type="submit" value="Ajouter la demande"/>

</form:form>
</body>
</html>
