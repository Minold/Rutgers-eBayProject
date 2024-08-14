<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Admin Homepage</title>
</head>
<body style="font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f7f7f7;">

    <% 
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();
        Statement stmt = con.createStatement();
        String admin_id = (String) session.getAttribute("employeeid");
        if (admin_id == null) {
            response.sendRedirect("Login.jsp");
        }
        ResultSet resultset = stmt.executeQuery("SELECT id, password FROM customer_rep");
    %>

    <h1 style="text-align: center; color: #333;">Welcome back, Admin.</h1>
    <h2 style="text-align: center; color: #333;">Your Customer Representatives</h2>
    <table style="margin: 20px auto; border-collapse: collapse; width: 80%; background-color: #fff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
        <tr>
            <th style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd; background-color: #f2f2f2;">Customer_Rep ID</th>
            <th style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd; background-color: #f2f2f2;">Password</th>
        </tr>
        <% if (!resultset.next()) { %>
            <tr>
                <td colspan="2" style="padding: 12px; text-align: center;">No Customer Reps found!</td>
            </tr>
        <% } else { %>
            <% resultset.beforeFirst(); %>
            <% while (resultset.next()) { %>
                <tr>
                    <td style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd;"><%= resultset.getString(1) %></td>
                    <td style="padding: 12px; text-align: left; border-bottom: 1px solid #ddd;"><%= resultset.getString(2) %></td>
                </tr>
            <% } %>
        <% } %>
    </table>

    <h3 style="text-align: center; color: #333;">Add a Customer Representative to the Team!</h3>
    <form method="post" action="MakeCP.jsp" style="margin: 20px auto; text-align: center;">
        <table style="width: 80%; margin: 0 auto;">
            <tr>
                <td style="padding: 10px; text-align: left;"><label for="id">New Rep ID (Numeric Values Only!):</label> <input type="text" name="id" value="" maxlength="3" required style="padding: 10px; border: 1px solid #ccc; border-radius: 5px; width: 100%; box-sizing: border-box;"></td>
            </tr>
            <tr>
                <td style="padding: 10px; text-align: left;"><label for="password">Rep Password:</label> <input type="text" name="password" value="" maxlength="30" required style="padding: 10px; border: 1px solid #ccc; border-radius: 5px; width: 100%; box-sizing: border-box;"></td>
            </tr>
            <tr>
                <td style="padding: 10px; text-align: left;"><input type="submit" value="Create!" style="padding: 10px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; width: 100%;"></td>
            </tr>
            <% if (request.getParameter("CreateRet") != null) { %>
                <tr>
                    <td style="padding: 10px;"><p style="text-align: center; color: <%= request.getParameter("CreateRetCode").equals("0") ? "blue" : "red" %>;"><%= request.getParameter("CreateRet") %></p></td>
                </tr>
            <% } %>
        </table>
    </form>

    <hr>

    <h2 style="text-align: center; color: #333;">Create Sales Reports</h2>
    <h4 style="text-align: center; color: #333;">Generate a Sales Report</h4>
    <form action="SalesReport.jsp" style="margin: 20px auto; text-align: center;">
        <table style="width: 80%; margin: 0 auto;">
            <tr>
                <th style="padding: 12px; text-align: left;"><label for="date1">From (Start Date)</label></th>
                <th style="padding: 12px; text-align: left;"><label for="date2">To (End Date)</label></th>
            </tr>
            <tr>
                <td style="padding: 12px; text-align: left;"><input type="datetime-local" required name="date1" style="padding: 10px; border: 1px solid #ccc; border-radius: 5px; width: 100%; box-sizing: border-box;"></td>
                <td style="padding: 12px; text-align: left;"><input type="datetime-local" required name="date2" style="padding: 10px; border: 1px solid #ccc; border-radius: 5px; width: 100%; box-sizing: border-box;"></td>
            </tr>
        </table>
        <input type="submit" value="Generate" style="padding: 10px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer; width: 80%; margin: 20px auto;">
    </form>

    <a href="Logout.jsp" style="display: block; text-align: center; margin-top: 20px; color: #333; text-decoration: none;">Logout</a>

</body>
</html>