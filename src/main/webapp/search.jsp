<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Search Results</title>
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
		String subcat = request.getParameter("subcat");
		String searchVal = request.getParameter("search");
	%>

    <div style="text-align: center">
    	<h1>Search Results: <%=subcat%></h1>
    	<table align="center">
    		<tr>  
    			<td><a href="home.jsp">Home</a></td>
        		<td>|</td>
				<td><a href="Account.jsp">Account</a></td>
				<td>|</td>
				<td><a href="Logout.jsp">Logout</a></td>
   			</tr>
    	</table>
<div class="container" style="margin-top: 20px; text-align: center;">
    <form class="form-inline" method="post" action="search.jsp?subcat=Tops" style="display: inline-block;">
        <input type="text" name="search" class="form-control" placeholder="Search goes here..." style="width: 300px; padding: 10px; border-radius: 5px; border: 1px solid #007bff;">
        <button type="submit" name="save" class="btn btn-primary" style="padding: 10px 20px; border-radius: 5px; border: none; background-color: #007bff; color: #fff; cursor: pointer;">Search</button>
    </form>
  
    <br>
  
    <form class="form-inline" method="post" action="Tops.jsp?" style="display: inline-block;">
        <select name="sortby" id="sortby" class="form-control" style="padding: 10px; border-radius: 5px; border: 1px solid #007bff;">
            <option value="None">Sort by...</option>
            <option value="Name">Name</option>
            <option value="lowToHigh">Price (Ascending)</option>
            <option value="highToLow">Price (Descending)</option>
            <option value="Tag">Color</option>
            <option value="Open">Status: Open</option>
            <option value="Closed">Status: Closed</option>
        </select>    
        <button type="submit" name="sortBy" class="btn btn-primary" style="padding: 10px 20px; border-radius: 5px; border: none; background-color: #007bff; color: #fff; cursor: pointer;">Go</button>
    </form>
</div>


    	
    	 <% 
			Statement stmt = con.createStatement();
    	 	String sortParam = request.getParameter("sortby");
    	 	ResultSet resultset = null;
    	 	if(sortParam == null){
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='"+subcat+"' AND itemname LIKE '%"+searchVal+"%';");
    	 	}else if(sortParam.equals("Name")){
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='"+subcat+"' AND itemname LIKE '%"+searchVal+"%' ORDER BY itemname;");
    	 	}else if(sortParam.equals("lowToHigh")){
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='"+subcat+"' AND itemname LIKE '%"+searchVal+"%' ORDER BY price;");
    	 	}else if(sortParam.equals("highToLow")){
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='"+subcat+"' AND itemname LIKE '%"+searchVal+"%' ORDER BY price DESC;");
    	 	}else if(sortParam.equals("Tag")){
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='"+subcat+"' AND itemname LIKE '%"+searchVal+"%' ORDER BY subattribute;");
    	 	}else if(sortParam.equals("Open")){
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='"+subcat+"' AND closed='0' AND itemname LIKE '%"+searchVal+"%' ORDER BY itemname;");
    	 	}else if(sortParam.equals("Closed")){
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='"+subcat+"' AND closed='1' AND itemname LIKE '%"+searchVal+"%' ORDER BY itemname;");
    	 	}else{
    	 		resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='"+subcat+"' AND itemname LIKE '%"+searchVal+"%';");
    	 	}
             
       	 %>
    	<br><br>
    	<form method="post" action="examinelisting.jsp">
    	<table align="center" border="1" style="border-collapse: collapse; width: 80%; margin: 0 auto;">
    <thead>
        <tr>
            <th style="padding: 10px;">&nbsp;</th>
            <th style="padding: 10px;">Name</th>
            <th style="padding: 10px;">Tag</th>
            <th style="padding: 10px;">Price</th>
            <th style="padding: 10px;">Status</th>
        </tr>
    </thead>
    <tbody>
        <% while(resultset.next()) { 
            String status = resultset.getString(8);
        %>
        <tr>
            <td style="padding: 10px;">
                <form method="post" action="examinelisting.jsp">
                    <button type="submit" name="lid" value="<%= resultset.getString(1) %>" style="padding: 5px 10px; border-radius: 5px; border: none; background-color: #007bff; color: #fff; cursor: pointer;">View</button>
                </form>
            </td>
            <td style="padding: 10px;"><%=resultset.getString(2)%></td>
            <td style="padding: 10px;"><%=resultset.getString(4)%></td>
            <td style="padding: 10px;"><%=resultset.getString(5)%></td>
            <td style="padding: 10px; background-color: <%= status.equals("0") ? "#28a745" : "#dc3545" %>;"><%= status.equals("0") ? "Open" : "CLOSED" %></td>
        </tr>
        <% } %>
    </tbody>
</table>

    	</form>
    </div>
</body>
</html>