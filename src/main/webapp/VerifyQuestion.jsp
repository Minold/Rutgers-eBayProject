<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Verify Question</title>
</head>
<body>
	<%
		try {
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			Statement stmt = con.createStatement();
			
			String username = (String) session.getAttribute("username");
			if (username == null) {
				response.sendRedirect("Login.jsp");
			}
			String question = request.getParameter("question"); 
			
			
			String insert = "INSERT INTO question(q_text) " 
					+ "VALUES(?)";
			
			PreparedStatement ps = con.prepareStatement(insert);
			ps.setString(1, question);
			ps.executeUpdate();
			
			
			insert = "INSERT INTO asks(asker, q_id) " 
					+ "VALUES(?, (SELECT MAX(q_id) FROM question))";
			
			ps = con.prepareStatement(insert);
			ps.setString(1, username);
			ps.executeUpdate();
			
			%>
			<jsp:forward page="Account.jsp">
			<jsp:param name="askQuestionRet" value="Question posted!"/> 
			</jsp:forward>
			<% 
		} catch (SQLException e) {
			String code = e.getSQLState();
			if (code.equals("23000")) {
				%>
				<jsp:forward page="AskQuestion.jsp">
				<jsp:param name="msg" value="ERROR"/> 
				</jsp:forward>
				<%
			} else {
				%>
				<jsp:forward page="AskQuestion.jsp">
				<jsp:param name="msg" value="ERROR"/> 
				</jsp:forward>
				<%
			}
		} catch (Exception e) {
			out.print("Unknown exception.");
			%>
			<jsp:forward page="AskQuestion.jsp">
			<jsp:param name="msg" value="ERROR"/> 
			</jsp:forward>
			<%
		}
	%>
</body>
</html>