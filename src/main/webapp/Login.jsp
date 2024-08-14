<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Group 33</title>
</head>
<body style="font-family: Arial, sans-serif;">

    <h2 style="text-align: center; color: #333;">Please input your login:</h2>
    
    <form method="post" action="LoginCheck.jsp" style="text-align: center;">
        <table style="margin: 0px auto;">
            <tr>
                <td style="padding: 10px;"><input type="text" name="username" value="" maxlength="30" required style="width: 200px; padding: 5px; border-radius: 5px; border: 1px solid #ccc;"/></td>
            </tr>
            <tr>
                <td style="padding: 10px;"><input type="password" name="password" value="" maxlength="30" required style="width: 200px; padding: 5px; border-radius: 5px; border: 1px solid #ccc;"/></td>
            </tr>
            <tr>
                <td style="padding: 10px;"><input type="submit" value="Log in" style="width: 200px; padding: 10px; border-radius: 5px; border: none; background-color: #007bff; color: #fff; cursor: pointer;"/></td>
            </tr>
            <tr>
                <td><p style="text-align: center; margin-top: 10px; color: #333;">Don't have an account? <a href="Register.jsp" style="color: #007bff; text-decoration: none;">Create one</a></p></td>
            </tr>
            <tr>
                <td style="padding: 10px;">Admin or Customer Rep? <a href="AdminRepLogin.jsp" style="color: #007bff; text-decoration: none;">Click here!</a></td>
            </tr>
            <% if (request.getParameter("registerRet") != null) { %>
                <tr>
                    <td><p style="text-align: center; color: blue; padding: 10px;"><%=request.getParameter("registerRet")%></p></td>
                </tr>
            <% } else if (request.getParameter("loginRet") != null) { %>
                <tr>
                    <td><p style="text-align: center; color: red; padding: 10px;"><%=request.getParameter("loginRet")%></p></td>
                </tr>
            <% } %>
        </table>
    </form>
</body>

</html>