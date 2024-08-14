<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Viewing Question</title>
</head>
<body style="font-family: Arial, sans-serif; text-align: center; margin: 20px;">

    <%-- Java code to fetch question details --%>
    <%
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String rep_id = (String) session.getAttribute("employeeid");
        if (rep_id == null) {
            response.sendRedirect("Login.jsp");
        }
        String q_id = request.getParameter("q_id");

        String ask_query = "SELECT asker FROM asks WHERE q_id=(?)";
        PreparedStatement ps = con.prepareStatement(ask_query);
        ps.setString(1, q_id);
        ResultSet rs = ps.executeQuery();
        rs.next();
        String asker = rs.getString(1);

        String q_text_query = "SELECT q_text FROM question WHERE q_id=(?)";
        ps = con.prepareStatement(q_text_query);
        ps.setString(1, q_id);
        rs = ps.executeQuery();
        rs.next();
        String q_text = rs.getString(1);
    %>

    <%-- Back button to Rep Home --%>
    <a href="CustomerRepHome.jsp" style="text-decoration: none; color: #007bff; font-size: 16px;"> Back to Home</a>

    <%-- Question details --%>
    <h2 style="font-size: 20px; margin: 20px 0;"><%= asker %> asks:</h2>
    <p style="margin-bottom: 20px;"><%= q_text %></p>
    <hr>

    <%-- Check if question is resolved or not --%>
    <%
        ps = con.prepareStatement(
                "SELECT resolver, resolve_text FROM resolves WHERE q_id=(?)"
        );
        ps.setString(1, q_id);
        String resolver_id = null;
        String resolve_text = null;
        rs = ps.executeQuery();
        if (rs.next()) {
            resolver_id = rs.getString(1);
            resolve_text = rs.getString(2);
        }
        if (resolver_id == null) {
    %>
    <%-- Form to resolve the issue --%>
    <h4 style="margin-bottom: 10px;">Resolve this issue:</h4>
    <form action="ResolveCusQuestion.jsp" style="margin-bottom: 20px;">
        <textarea name="resolve_text" style="width: 500px; height: 150px; margin-bottom: 10px;"></textarea>
        <br>
        <button type="submit" style="padding: 8px 16px; border: none; background-color: #007bff; color: #fff; border-radius: 5px; cursor: pointer;">Resolve!</button>
        <input type="hidden" name="rep_id" value="<%= rep_id %>" />
        <input type="hidden" name="q_id" value="<%= q_id %>" />
    </form>
    <% } else { %>
    <%-- Display resolved details --%>
    <h4 style="margin-bottom: 10px;">Resolved by Customer Rep Id #<%= resolver_id %>:</h4>
    <p style="margin-bottom: 20px;"><%= resolve_text %></p>
    <% } %>

</body>
</html>