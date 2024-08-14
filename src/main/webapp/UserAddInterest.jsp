<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Add Interest</title>
</head>
<body>
	<% 
    	//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String username = (String) session.getAttribute("username");
		if (username == null) {
			response.sendRedirect("Login.jsp");
		}
		
		String interest = request.getParameter("interest");
		
	    PreparedStatement ps = con.prepareStatement("INSERT INTO interests(username, interest) VALUES(?, ?)");
	    ps.setString(1, username);
	    ps.setString(2, interest);
	    ps.executeUpdate();
	    response.sendRedirect("Interests.jsp");		
    %>
    
    
</body>
</html>