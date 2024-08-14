<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Examining User</title>
</head>
<body>
	<%
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String user = request.getParameter("username");
		PreparedStatement ps = con.prepareStatement(
			"SELECT password FROM users WHERE username=(?)"
		);
		ps.setString(1, user);
		ResultSet rs = ps.executeQuery();
		rs.next();
	%>
	 <div style="text-align: center; margin-top: 50px;">
        <p><a href="CustomerRepHome.jsp" style="text-decoration: none; color: #007bff;"> Quit User Examination</a></p>
        <h1 style="margin-bottom: 20px;">Examining: <%= user %></h1>
        <form action="EditUserInfo.jsp" method="post" style="margin-bottom: 20px;">
            <p style="margin-bottom: 10px;">Current Username: <%= user %></p>
            <p style="margin-bottom: 10px;">Current Password: <%= rs.getString(1) %></p>
            <div style="margin-bottom: 20px;">
                <label for="new_user">New Username:</label>
                <input type="text" id="new_user" name="new_user" value="" maxlength="30" style="margin-left: 10px;">
            </div>
            <div style="margin-bottom: 20px;">
                <label for="new_pass">New Password:</label>
                <input type="text" id="new_pass" name="new_pass" value="" maxlength="30" style="margin-left: 14px;">
            </div>
            <button type="submit" style="padding: 8px 20px; background-color: #007bff; color: #fff; border: none; border-radius: 5px; cursor: pointer;">Confirm Edits</button>
            <hr style="margin-top: 20px; margin-bottom: 20px; border-color: #ccc;">
            <button type="submit" name="delete" value="true" style="padding: 8px 20px; background-color: #dc3545; color: #fff; border: none; border-radius: 5px; cursor: pointer;">DELETE USER</button>
            <input type="hidden" name="old_user" value="<%= user %>"/>
        </form>
    </div>
</body>
</html>