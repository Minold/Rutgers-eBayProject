<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Customer Represenative Home</title>
<style>
table, th, td {
  	border: 1px solid;
  	border-collapse: collapse;
}
</style>
</head>
<body style="font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f7f7f7; text-align: center;">

<%
    ApplicationDB db = new ApplicationDB();   
    Connection con = db.getConnection();
    String rep_id = (String) session.getAttribute("employeeid");
    if (rep_id == null) {
        response.sendRedirect("Login.jsp");
    }
%>
<h1>Welcome back!</h1>
<h2 style="color: #333;">Questions</h2>
<%
    Statement stmt = con.createStatement();
    ResultSet resultset = stmt.executeQuery("SELECT q_id, q_text FROM question");
%>
<form action="ExamineQuestion.jsp" style="margin-bottom: 20px;">
<table border="1" cellpadding="8" cellspacing="0" style="margin: 0 auto; width: 80%; background-color: #fff; border-collapse: collapse; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
<tr style="background-color: #f2f2f2;">
    <th></th>
    <th>Question</th>
</tr>
<%
    if (!resultset.next()) {
%>
<tr>
    <td colspan="2">No one has asked a question yet!</td>
</tr>
<%
    } else {
        resultset.beforeFirst();
        while (resultset.next()) { 
%>
    <tr>
        <td><button name="q_id" type="submit" value="<%= resultset.getString(1) %>" style="border: none; background-color: #007bff; color: #fff; padding: 6px 12px; border-radius: 4px; cursor: pointer;">View</button></td>
        <td style="max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><%= resultset.getString(2) %></td>
    </tr>
<%  
        } // end while
    } // end if
%>
</table>
</form>
<hr>
<h2 style="color: #333;">Bids and Auctions</h2>
<%
    resultset = stmt.executeQuery("SELECT l_id, itemname, subcategory, price FROM listings");
%>
<form action="RepEditListing.jsp" style="margin-bottom: 20px;">
<table border="1" cellpadding="8" cellspacing="0" style="margin: 0 auto; width: 80%; background-color: #fff; border-collapse: collapse; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
<tr style="background-color: #f2f2f2;">
    <th></th>
    <th>Item</th>
    <th>Subcategory</th>
    <th>Price</th>
</tr>
<%
    if (!resultset.next()) {
%>
<tr>
    <td colspan="4">No one has posted a listing yet!</td>
</tr>
<%
    } else {
        resultset.beforeFirst();
        while (resultset.next()) { 
%>
    <tr>
        <td><button name="lid" type="submit" value="<%= resultset.getString(1) %>" style="border: none; background-color: #007bff; color: #fff; padding: 6px 12px; border-radius: 4px; cursor: pointer;">View</button></td>
        <td style="max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><%= resultset.getString(2) %></td>
        <td style="max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><%= resultset.getString(3) %></td>
        <td style="max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><%= resultset.getString(4) %></td>
    </tr>
<%  
        } 
    } 
%>
</table>
</form>
<hr>
<h2 style="color: #333;">User Account Access</h2>
<%
    resultset = stmt.executeQuery("SELECT username FROM users");
%>
<form action="RepUser.jsp" style="margin-bottom: 20px;">
<table border="1" cellpadding="8" cellspacing="0" style="margin: 0 auto; width: 80%; background-color: #fff; border-collapse: collapse; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
<tr style="background-color: #f2f2f2;">
    <th></th>
    <th>Username</th>
</tr>
<%
    if (!resultset.next()) {
%>
<tr>
    <td colspan="2">No one has registered yet!</td>
</tr>
<%
    } else {
        resultset.beforeFirst();
        while (resultset.next()) { 
%>
    <tr>
        <td><button name="username" type="submit" value="<%= resultset.getString(1) %>" style="border: none; background-color: #007bff; color: #fff; padding: 6px 12px; border-radius: 4px; cursor: pointer;">View</button></td>
        <td style="max-width: 300px; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><%= resultset.getString(1) %></td>
    </tr>
<%  
        } 
    } 
%>
</table>
</form>
<hr>
<a href="Logout.jsp" style="text-decoration: none; color: #007bff;">Logout</a>

</body>
</html>