<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Registration</title>
</head>
<body>
	<%
		try {
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			Statement stmt = con.createStatement();
			String username = request.getParameter("username");
			String password = request.getParameter("password");
			String insert = "INSERT INTO users(username, password) " 
							+ "VALUES(?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, username);
			ps.setString(2, password);
			ps.executeUpdate();

	%>
	<jsp:forward page="Login.jsp">
	<jsp:param name="registerRet" value="Account successfully created."/> 
	</jsp:forward>
	<% 
		} catch (SQLException e) {
			String code = e.getSQLState();
			if (code.equals("23000")) {
				%>
				<jsp:forward page="Register.jsp">
				<jsp:param name="msg" value="This username is already exists."/> 
				</jsp:forward>
				<%
			} else {
				%>
				<jsp:forward page="Register.jsp">
				<jsp:param name="msg" value="Error creating account. Please try again."/> 
				</jsp:forward>
				<%
			}
		} catch (Exception e) {
			out.print("Unknown exception.");
			%>
			<jsp:forward page="Register.jsp">
			<jsp:param name="msg" value="Error creating account. Please try again."/> 
			</jsp:forward>
			<%
		}
	%>
</body>
</html>