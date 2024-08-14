<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Listing Editor</title>
</head>
<body style="font-family: Arial, sans-serif; text-align: center; margin: 20px;">

    
    <%
        ApplicationDB db = new ApplicationDB();
        Connection con = db.getConnection();

        String rep_id = (String) session.getAttribute("employeeid"); //asker
        if (rep_id == null) {
            response.sendRedirect("Login.jsp");
        }
        String lid = request.getParameter("lid");
        Statement stmt = con.createStatement();
        ResultSet resultset = stmt.executeQuery("SELECT * from listings WHERE l_id='" + lid + "';");
        
        String name = null;
        String subcat = null; 
        String subattr = null; 
        String price = null; 
        String minsale = null; 
        String cdt = null; 
        Double p = null;
        Double m = null; 
        Double minbid = null; 

        Statement stmt2 = con.createStatement();
        ResultSet fetchposter = stmt2.executeQuery("SELECT username from posts WHERE l_id=" + lid + ";");
        String postedby = null; 
        %>

    <%
    while (resultset.next()) {
        
        name = resultset.getString(2);
        subcat = resultset.getString(3);
        subattr = resultset.getString(4);
        price = resultset.getString(5);
        minsale = resultset.getString(6);
        cdt = resultset.getString(7);

        p = Double.parseDouble(price);
        p = Math.round(p * 100.0) / 100.0;
        minbid = p + .01;
        minbid = Math.round(minbid * 100.0) / 100.0;
    } 

    while (fetchposter.next()) {
        
        postedby = fetchposter.getString(1);
    } 
    %>

    <div style="text-align: center; margin-bottom: 20px;">
        <a href="CustomerRepHome.jsp" style="text-decoration: none; color: #007bff; font-size: 16px;">Exit Listing</a>
        <h1 style="margin: 20px 0;"><%= name %></h1>

        <table align="center" style="margin-bottom: 20px;">
            <tr>
                <td><input type="hidden" name="lid" value="<%= lid %>" /></td>
            </tr>
            <tr>
                <td><input type="hidden" name="price" value="<%= price %>" /></td>
            </tr>
            <tr>
                <td>Current Price: $<%= price %></td>
            </tr>
        </table>
    </div>

    <hr>

<div style="text-align: center; margin-bottom: 20px;">
    <h3 style="margin-bottom: 10px; text-decoration: underline; font-family: Arial, sans-serif; color: #333;">Details:</h3>
    <div style="margin-bottom: 10px;">
        <p style="margin: 5px 0; font-family: Arial, sans-serif; color: #666;"><span style="font-weight: bold; color: #444;">Seller:</span> <%= postedby %></p>
        <p style="margin: 5px 0; font-family: Arial, sans-serif; color: #666;"><span style="font-weight: bold; color: #444;">Closing Date/Time:</span> <%= cdt %></p>
        <p style="margin: 5px 0; font-family: Arial, sans-serif; color: #666;"><span style="font-weight: bold; color: #444;">Subcategory:</span> <%= subcat %></p>
        <p style="margin: 5px 0; font-family: Arial, sans-serif; color: #666;"><span style="font-weight: bold; color: #444;">Subattribute:</span> <%= subattr %></p>
        <p style="margin: 5px 0; font-family: Arial, sans-serif; color: #666;"><span style="font-weight: bold; color: #444;">Min. Sale Price:</span> $<%= minsale %></p>
    </div>
</div>

    <hr>

    <div style="text-align: center;">
        <h3 style="margin-bottom: 10px;">Bid History</h3>
        <% Statement stmt3 = con.createStatement(); ResultSet bidhist = stmt3.executeQuery("SELECT b.b_id, price, username, dtime from bids b "+ "LEFT JOIN bidson bo on bo.b_id = b.b_id LEFT JOIN places p on p.b_id = bo.b_id " + "WHERE l_id= " +lid+";"); %>
        <form action="EditListing.jsp" style="margin-bottom: 20px;">
             <table align="center" style="margin: 0 auto; border-collapse: collapse; width: 80%;">
            <tr style="background-color: #f8f9fa;">
                <th style="padding: 10px;">BidID</th>
                <th style="padding: 10px;">Price</th>
                <th style="padding: 10px;">Bidder</th>
                <th style="padding: 10px;">Date/Time</th>
                <th style="padding: 10px;">Action</th>
            </tr>
            <% while (bidhist.next()) { %>
                <tr style="background-color: #ffffff;">
                    <td style="padding: 10px;"><%= bidhist.getString(1) %></td>
                    <td style="padding: 10px;">$<%= bidhist.getString(2) %></td>
                    <td style="padding: 10px;"><%= bidhist.getString(3) %></td>
                    <td style="padding: 10px;"><%= bidhist.getString(4) %></td>
                    <td style="padding: 10px;"><button name="bid" type="submit" value="<%= bidhist.getString(1) %>" style="padding: 5px 10px; background-color: #dc3545; color: #fff; border: none; border-radius: 5px; cursor: pointer;">Remove Bid</button></td>
                </tr>
            <% } %>
        </table>
            <input type="hidden" name="operation" value="removeBid" />
            <input type="hidden" name="lid" value="<%= lid %>" />
        </form>

        <hr>

        <form action="EditListing.jsp" style="margin-bottom: 20px;">
            <button name="lid" type="submit" value="<%= lid %>" style="padding: 8px 16px; background-color: #dc3545; color: #fff; border: none; border-radius: 5px; cursor: pointer;">Remove Listing!</button>
            <input type="hidden" name="operation" value="removeListing" />
        </form>
        <p style="font-size: 14px; color: #dc3545;">WARNING: Removal of a listing cannot be undone!</p>
    </div>

</body>

</html>