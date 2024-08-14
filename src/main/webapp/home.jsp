<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Home</title>
</head>
<body>

	<% 
    	//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		String username = (String) session.getAttribute("username");
		if (username == null) {
			response.sendRedirect("Login.jsp");
		}
			
    %>

    <div style="text-align: center;">
  <h1 style="color: #007bff; font-family: Arial, sans-serif; font-size: 36px; text-align: center; padding: 20px; background-color: #f8f9fa; border: 2px solid #007bff; border-radius: 10px; box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);">Group 33's BuyMe: Clothing</h1>

<div style="text-align: center; font-family: Arial, sans-serif;">
    <h2 style="margin-bottom: 20px; font-size: 24px; color: #333;">Explore Our Collection</h2>
    <a href="Tops.jsp" style="text-decoration: none; color: #fff; background-color: #007bff; padding: 12px 24px; border-radius: 5px; display: inline-block; margin-right: 20px; transition: background-color 0.3s; font-size: 18px;">Tops</a>
    <a href="Bottoms.jsp" style="text-decoration: none; color: #fff; background-color: #007bff; padding: 12px 24px; border-radius: 5px; display: inline-block; margin-right: 20px; transition: background-color 0.3s; font-size: 18px;">Bottoms</a>
    <a href="Others.jsp" style="text-decoration: none; color: #fff; background-color: #007bff; padding: 12px 24px; border-radius: 5px; display: inline-block; transition: background-color 0.3s; font-size: 18px;">Others</a>
</div>

<hr style="margin: 40px auto; border: none; border-top: 2px dashed #ccc; width: 80%;">

<div style="text-align: center; font-family: Arial, sans-serif;">
    <h2 style="margin-bottom: 20px; font-size: 24px; color: #333;">Your Activities</h2>
    <a href="Questions.jsp" style="text-decoration: none; color: #333; background-color: #f8f9fa; border: 2px solid #333; padding: 10px 20px; border-radius: 5px; display: inline-block; margin-right: 20px; transition: background-color 0.3s; font-size: 18px;">View Questions</a>
    <a href="Account.jsp" style="text-decoration: none; color: #333; background-color: #f8f9fa; border: 2px solid #333; padding: 10px 20px; border-radius: 5px; display: inline-block; margin-right: 20px; transition: background-color 0.3s; font-size: 18px;">Account</a>
    <a href="Logout.jsp" style="text-decoration: none; color: #333; background-color: #f8f9fa; border: 2px solid #333; padding: 10px 20px; border-radius: 5px; display: inline-block; transition: background-color 0.3s; font-size: 18px;">Logout</a>
</div>


    	<% 
    		//table that shows which listings the user no longer has the highest bid in
    		PreparedStatement ps = con.prepareStatement(
    			"SELECT l.itemname, l.price, MAX(b.price) AS user_max_bid " +
				"FROM places p " +
    			"INNER JOIN bidson bo ON bo.b_id = p.b_id " + 
				"INNER JOIN bids b ON b.b_id = p.b_id " +
				"INNER JOIN listings l ON bo.l_id = l.l_id " + 
				"WHERE p.username =(?) AND l.closed=0 " +
				"GROUP BY l.l_id " +
				"HAVING user_max_bid < l.price");
    		ps.setString(1, username);
    		ResultSet lostBids = ps.executeQuery();
    		
    		//table that shows which automatic bids are no longer valid
    		ps = con.prepareStatement(
    			"SELECT l.itemname, l.price, ab.b_limit " +
    			"FROM auto_bids ab " +
    			"INNER JOIN listings l ON ab.l_id = l.l_id " +
    			"WHERE ab.u_id =(?) AND l.closed=0 " +
    			"HAVING l.price > ab.b_limit");
    		ps.setString(1, username);
    		ResultSet lostAutoBids = ps.executeQuery();	
    		
    		//table that shows a user's won auctions
    		ps = con.prepareStatement(
    			"SELECT DISTINCT l.itemname, l.price " +
  				"FROM listings l " +
  				"INNER JOIN bidson bd ON l.l_id = bd.l_id " +
  				"INNER JOIN bids b ON bd.b_id = b.b_id " + 
  				"INNER JOIN places p ON p.b_id = b.b_id " +
  				"WHERE l.closed=1 AND l.price=b.price AND l.l_id IN (SELECT g.l_id FROM generates g) AND p.username=(?)");
    		ps.setString(1, username);
    		ResultSet wonAuctions = ps.executeQuery();
    		
    		//table that shows listings of a user's interests up for auction
    		ps = con.prepareStatement(
        		"SELECT l.itemname " +
    			"FROM listings l " +
        		"INNER JOIN interests i ON l.itemname LIKE CONCAT('%', i.interest, '%') " + 
    			"WHERE i.username =(?) AND l.closed=0");
        	ps.setString(1, username);
        	ResultSet interests = ps.executeQuery();
       	 %>

    	<table align="center" border="5" style="width: 200px; max-width:200px; margin-top: 20px;">
    		<tr><td><b>Alerts</b></td></tr>
   			<% while(lostBids.next()) { %>
            	<tr>
            		<td>
            			<span style="color:red">Alert! </span>Your bid on '<%= lostBids.getString(1) %>' is no longer the highest bid!
            			<p style="padding: 0">Your bid: $<%= lostBids.getString(3) %><br>Max bid: $<%= lostBids.getString(2) %></p>
            		</td>
           	</tr>
            <% } %>
            <% while(lostAutoBids.next()) { %>
            	<tr>
            		<td>
            			<span style="color:red">Alert! </span>Your auto bid limit on '<%= lostAutoBids.getString(1) %>' is below the current bid price.
            			<p style="padding: 0">Your limit: $<%= lostAutoBids.getString(3) %><br>Max bid: $<%= lostAutoBids.getString(2) %></p>
            		</td>
           	</tr>
            <% } %>
            <% while(wonAuctions.next()) { %>
            	<tr>
            		<td>
            			<span style="color:green">Congrats!</span> You won the auction '<%=wonAuctions.getString(1)%>'
            				with your bid of $<%=wonAuctions.getString(2)%>
            		</td>
           		</tr>
            <% } %>
            <% while(interests.next()) { %>
            	<tr>
            		<td>
            			<span style="color:blue">Availability Alert! </span>Your interest '<%=interests.getString(1)%>' is up for auction!
            		</td>
           	</tr>
            <% } %>
    	</table>
    </div>
</body>
</html>