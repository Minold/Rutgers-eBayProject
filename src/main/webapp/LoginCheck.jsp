<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Verify Login</title>
</head>
<body>
	<%
		try {
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			Statement stmt = con.createStatement();
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			
			String lookup = "SELECT username, password FROM users WHERE " 
						+ "username=(?) AND password=(?)";
			PreparedStatement ps = con.prepareStatement(lookup);
			ps.setString(1, username);
			ps.setString(2, password);
			ResultSet result = ps.executeQuery();

			if (result.next()) {
				session.setAttribute("username", username);
				%>
				<jsp:forward page="home.jsp">
				<jsp:param name="user" value="<%=username%>"/> 
				</jsp:forward>
				<% 
			} else {
				%>
				<jsp:forward page="Login.jsp">
				<jsp:param name="loginRet" value="Incorrect username or password."/> 
				</jsp:forward>
				<%
			}

		} catch (Exception e) {
			%>
			<jsp:forward page="Login.jsp">
			<jsp:param name="loginRet" value="Error logging in. Please try again."/> 
			</jsp:forward>
			<%
		}
	%>
</body>
</html>