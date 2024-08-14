<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
	<style>
	.center {
	    margin-left: auto;
	    margin-right: auto;
	}
	
	table, th, td {
	      border: 1px solid;
	      border-collapse: collapse;
	      padding: 0px;
	}
	
	</style>
	<meta charset="utf-8">
	<title>Your Interests</title>
</head>
<body style="text-align: center;">

    <% 
        //Get the database connection
        ApplicationDB db = new ApplicationDB();    
        Connection con = db.getConnection();
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("Login.jsp");
        }
        PreparedStatement ps = con.prepareStatement(
                "SELECT interest " +
                "FROM interests " +
                "WHERE username=(?)");
        ps.setString(1, username);
        ResultSet rs = ps.executeQuery();  
    %>
    
    <div>
        <h1 style="color: #007bff;">Your Interests</h1>
        <a href="Account.jsp" style="text-decoration: none; padding: 8px 16px; background-color: #007bff; color: #fff; border: none; border-radius: 5px; cursor: pointer; transition: background-color 0.3s;">Back</a>

        <hr>
        <form method="post" action="UserAddInterest.jsp" style="margin-top: 20px;">
            <input type="text" name="interest" style="padding: 8px; width: 60%; border: 1px solid #ccc; border-radius: 5px; margin-right: 10px;" placeholder="Enter your interest">
            <input type="submit" value="Add Interest" style="padding: 8px 16px; background-color: #007bff; color: #fff; border: none; border-radius: 5px; cursor: pointer;">
        </form>
        <br>
        <table style="margin: 20px auto; border-collapse: collapse; width: 80%;">
            <tr>
                <th>Your Interests</th>
            </tr>
            <% while (rs.next()) { %>
                <tr> 
                    <td style="padding: 8px; border: 1px solid #ccc;"><%= rs.getString(1) %></td>
                </tr>
            <% } %>
        </table>
    </div>

</body>

</html>