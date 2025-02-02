<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		
		String old_user = request.getParameter("old_user");
		String examined_user = old_user;
		String new_user = request.getParameter("new_user");
		String new_pass = request.getParameter("new_pass");
		String deleteOperation = request.getParameter("delete");
		
		if (deleteOperation != null && deleteOperation.equals("true")) {
			PreparedStatement ps = con.prepareStatement(
					"DELETE FROM users WHERE username=(?)"
			);
			ps.setString(1, old_user);
			ps.executeUpdate();
			response.sendRedirect("CustomerRepHome.jsp");
		} else {
			if (new_pass != null && !new_pass.isBlank()) {
				PreparedStatement ps = con.prepareStatement(
						"UPDATE users SET password=(?) WHERE username=(?)"
				);
				ps.setString(1, new_pass);
				ps.setString(2, old_user);
				ps.executeUpdate();
			}
			
			if (new_user != null && !new_user.isBlank()) {
				PreparedStatement ps = con.prepareStatement(
						"UPDATE users SET username=(?) WHERE username=(?)"
				);
				ps.setString(1, new_user);
				ps.setString(2, old_user);
				examined_user = new_user;
				ps.executeUpdate();
			}
		%>
	<jsp:forward page="RepUser.jsp">
	<jsp:param name="username" value="<%=examined_user%>"/> 
	</jsp:forward>
	<% } %>
</body>
</html>