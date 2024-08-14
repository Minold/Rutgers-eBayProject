<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Rep Homepage</title>
</head>
<body>
	<%
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			
			String id = request.getParameter("id");
			String password = request.getParameter("password");
			
			if (id.equals("0")) {
				%>
				<jsp:forward page="AdminHome.jsp">
				<jsp:param name="CreateRet" value="You can not use ID 0"/>
				</jsp:forward>
				<%
			}
			String insert = "INSERT INTO customer_rep VALUES(?, ?)";
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, id);
			ps.setString(2, password);
			ps.executeUpdate();
			
			insert = "INSERT INTO admin_creates VALUES(0, ?)";
			ps = con.prepareStatement(insert);
			ps.setString(1, id);
			ps.executeUpdate();
			%>
			<jsp:forward page="AdminHome.jsp">
			<jsp:param name="CreateRet" value="Rep Successfully created!"/>
			<jsp:param name="CreateRetCode" value="0"/>
			</jsp:forward>
			<%
		} catch (SQLException e) {
			String code = e.getSQLState();
			if (code.equals("23000")) {
				%>
				<jsp:forward page="AdminHome.jsp">
				<jsp:param name="CreateRet" value="Say Hi!"/> 
				<jsp:param name="CreateRetCode" value="1"/>
				</jsp:forward>
				<%
			} else {
				%>
				<jsp:forward page="AdminHome.jsp">
				<jsp:param name="CreateRet" value="Error creating Rep. Please try again."/>
				<jsp:param name="CreateRetCode" value="1"/>
				</jsp:forward>
				<%
			}
		}
	%>
</body>
</html>