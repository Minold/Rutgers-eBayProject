<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Account Activity</title>
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
        <h1 style="color: #007bff; font-family: Arial, sans-serif;">Account Activity</h1>
        <h4>View Activities of You or Other Users!</h4>
        <table align="center" style="margin-top: 20px;">
            <tr>  
                <td><a href="home.jsp" style="text-decoration: none; color: #007bff; font-weight: bold;">Home</a></td>
                <td>|</td>
                <td><a href="Account.jsp" style="text-decoration: none; color: #007bff; font-weight: bold;">Account</a></td>
            </tr>
        </table>
        
        <div class="container" style="margin-top: 20px;">
            <form class="form-inline" method="post" action="Activity.jsp">
                <input type="text" name="usersearch" class="form-control" placeholder="type here..." style="padding: 8px 12px; border: 1px solid #007bff; border-radius: 5px; font-size: 16px;">

                <button type="submit" name="save" class="btn btn-primary" style="margin-left: 10px; background-color: #007bff; border-color: #007bff; color: #ffffff; border-radius: 5px; padding: 8px 20px; font-size: 16px;">
    Search Another User
</button>

            </form>
        </div>
        
        <%
            String usersearch = request.getParameter("usersearch");     
            if(usersearch!=null){
        %>
        <h4 style="text-align: center; font-family: Arial, sans-serif; color: #333; margin-top: 20px; padding: 10px; background-color: #f2f2f2; border-radius: 5px;">User: <%=usersearch%></h4>

        <%
            } else {
                usersearch = username;
        %>
       <h4 style="text-align: center; font-family: Arial, sans-serif; color: #333; margin-top: 20px; padding: 10px; background-color: #f2f2f2; border-radius: 5px;">User: <%=usersearch%></h4>

        <%
            }
        
            Statement stmt1 = con.createStatement();
            ResultSet bidhist = stmt1.executeQuery("SELECT l_id, b.b_id, price, username, dtime from bids b "+
                "LEFT JOIN bidson bo on bo.b_id = b.b_id LEFT JOIN places p on p.b_id = bo.b_id " +
                "WHERE username= '" +usersearch+"';");
        %>
        
        <br><br>
        <h4 style="text-align: center; font-family: Arial, sans-serif; color: #333; padding: 10px; background-color: #f2f2f2; border-radius: 5px;">Your Bids</h4>

        <form method="post" action="examinelisting.jsp">
            <table align="center" border="1" cellspacing="0" cellpadding="8" style="margin-top: 10px; border-collapse: collapse; width: 80%; border: 2px solid #007bff;">
    <thead>
        <tr style="background-color: #007bff; color: #fff;">
            <th style="padding: 10px;">View</th>
            <th style="padding: 10px;">Price</th>
            <!-- th style="padding: 10px;">Date/Time</th> -->
        </tr>
    </thead>
    <tbody>
        <% while(bidhist.next()){ %>
        <tr style="background-color: #f2f2f2;">
            <td style="padding: 10px;"><button name="lid" type="submit" value="<%= bidhist.getString(1) %>" style="padding: 5px 10px; border: none; background-color: #007bff; color: #fff; cursor: pointer;">View</button></td>
            <td style="padding: 10px;"><%= bidhist.getString(3) %></td>
          <%--   <td style="padding: 10px;"><%= bidhist.getString(4) %></td> --%>
        </tr>
        <% } %>
    </tbody>
</table>

        </form>
        
        <br>
        <%
            Statement stmt2 = con.createStatement();
            ResultSet listhist = stmt2.executeQuery("SELECT l.l_id, l.itemname from listings l "+
                "LEFT JOIN posts p on p.l_id = l.l_id " +
                "WHERE username= '" +usersearch+"';");
        %>
        
        <h4 style="text-align: center; font-family: Arial, sans-serif; color: #333; padding: 10px; background-color: #f2f2f2; border-radius: 5px;">Your Listings</h4>

        <form method="post" action="examinelisting.jsp">
            <table align="center" border="1" cellspacing="0" cellpadding="8" style="margin-top: 10px; border-collapse: collapse; width: 80%; border: 2px solid #007bff;">
    <thead>
        <tr style="background-color: #007bff; color: #fff;">
            <th style="padding: 10px;">View</th>
            <th style="padding: 10px;">Item Name</th>
        </tr>
    </thead>
    <tbody>
        <% while(listhist.next()){ %>
        <tr style="background-color: #f2f2f2;">
            <td style="padding: 10px;"><button name="lid" type="submit" value="<%= listhist.getString(1) %>" style="padding: 5px 10px; border: none; background-color: #007bff; color: #fff; cursor: pointer;">View</button></td>
            <td style="padding: 10px;"><%=listhist.getString(2)%></td>
        </tr>
        <% } %>
    </tbody>
</table>

        </form>
    </div>
</body>

</html>