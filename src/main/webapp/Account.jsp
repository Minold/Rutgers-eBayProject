<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Your Account</title>
</head>
<body style="font-family: Arial, sans-serif;">

    <% 
        // Get the database connection
        ApplicationDB db = new ApplicationDB();    
        Connection con = db.getConnection();
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("Login.jsp");
        }
    %>

    <div style="text-align: center;">
        <h1 style="color: blue;">Account </h1>
        <h3>User: <%=username%></h3>
       <div style="text-align: center;">
    <table style="margin: 0 auto;">
        <tr>  
            <td><a href="home.jsp" style="text-decoration: none; color: #333;"><button style="width: 150px; padding: 12px 24px; background-color: #007bff; color: #fff; border: none; border-radius: 5px; cursor: pointer;">Home</button></a></td>
            <td><a href="Logout.jsp" style="text-decoration: none; color: #333;"><button style="width: 150px; padding: 12px 24px; background-color: #007bff; color: #fff; border: none; border-radius: 5px; cursor: pointer;">Logout</button></a></td>
        </tr>
        <tr>
            <td colspan="2" style="padding-top: 10px;">
                <hr style="border: none; border-top: 2px dashed #ccc;">
            </td>
        </tr>
        <tr>
            <td colspan="2"><br><a href="Listing.jsp" style="text-decoration: none;"><button style="width: 300px; padding: 12px 24px; background-color: #007bff; color: #fff; border: none; border-radius: 5px; cursor: pointer;">Create Listing</button></a></td>
        </tr>
        <tr>
            <td colspan="2"><br><a href="AskQuestion.jsp" style="text-decoration: none;"><button style="width: 300px; padding: 12px 24px; background-color: #007bff; color: #fff; border: none; border-radius: 5px; cursor: pointer;">Ask a Question</button></a></td>
        </tr>
        <tr>
            <td colspan="2"><br><a href="Activity.jsp" style="text-decoration: none;"><button style="width: 300px; padding: 12px 24px; background-color: #007bff; color: #fff; border: none; border-radius: 5px; cursor: pointer;">Account Activity</button></a></td>
        </tr>    
        <tr>
            <td colspan="2"><br><a href="Interests.jsp" style="text-decoration: none;"><button style="width: 300px; padding: 12px 24px; background-color: #007bff; color: #fff; border: none; border-radius: 5px; cursor: pointer;">Interests</button></a></td>
        </tr>    
    </table>
</div>


        <table style="margin: 20px auto;">
            <% if (request.getParameter("msg") != null) { %>
                <tr>
                    <td><p style="color: red;"><%=request.getParameter("msg")%></p></td>
                </tr>
            <% } %>
            
            <% if (request.getParameter("createListingRet") != null) { %>
                <tr>
                    <td><p style="color: blue;"><%=request.getParameter("createListingRet")%></p></td>
                </tr>
            <% } %>
            
            <% if (request.getParameter("askQuestionRet") != null) { %>
                <tr>
                    <td><p style="color: blue;"><%=request.getParameter("askQuestionRet")%></p></td>
                </tr>
            <% } %>
        </table>
    </div>
</body>

</html>