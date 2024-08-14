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
<body style="font-family: Arial, sans-serif; text-align: center;">
    <a href="Questions.jsp" style="text-decoration: none; color: #007bff; font-size: 16px; margin-bottom: 20px; display: inline-block;">&larr; Back to Q&amp;A</a>
    <% 
    ApplicationDB db = new ApplicationDB();    
    Connection con = db.getConnection();
    String q_id = request.getParameter("q_id");
    
    String ask_query = "SELECT asker FROM asks WHERE q_id=?";
    PreparedStatement ps = con.prepareStatement(ask_query);
    ps.setString(1, q_id);
    ResultSet rs = ps.executeQuery();
    rs.next();
    String asker = rs.getString(1);
    
    String q_text_query = "SELECT q_text FROM question WHERE q_id=?";
    ps = con.prepareStatement(q_text_query);
    ps.setString(1, q_id);
    rs = ps.executeQuery();
    rs.next();
    String q_text = rs.getString(1);
    %>
    <h2 style="color: #007bff; font-size: 24px; margin-top: 20px;"><%= asker %> asks:</h2>
    <p style="font-size: 18px; margin-bottom: 20px;"><%= q_text %></p>
    <%
    ps = con.prepareStatement(
            "SELECT resolver, resolve_text FROM resolves WHERE q_id=?"
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
    <h4 style="color: red; margin-top: 20px;">This issue has not yet been resolved!</h4>
    <% } else { %>
    <h4 style="color: green; margin-top: 20px;">Resolved by Customer Rep Id #<%= resolver_id %>:</h4>
    <p style="font-size: 18px; margin-bottom: 20px;"><%= resolve_text %></p>
    <% } %>
</body>

</html>