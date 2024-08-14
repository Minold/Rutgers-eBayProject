<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Bottoms</title>
</head>
<body style="font-family: Arial, sans-serif;">

    <% 
        
        ApplicationDB db = new ApplicationDB();    
        Connection con = db.getConnection();
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("Login.jsp");
        }
    %>

    <div style="text-align: center;">
        <h1 style="color: blue;">Subcategory: Bottoms</h1>
        <table align="center">
            <tr>  
                <td><a href="home.jsp" style="text-decoration: none; color: #333;">Home</a></td>
                <td>|</td>
                <td><a href="Account.jsp" style="text-decoration: none; color: #333;">Account</a></td>
                <td>|</td>
                <td><a href="Logout.jsp" style="text-decoration: none; color: #333;">Logout</a></td>
            </tr>
        </table>
        
        <div class="container" style="margin-top: 20px;">
            <form class="form-inline" method="post" action="search.jsp?subcat=Bottoms">
                <input type="text" name="search" class="form-control" placeholder="Search goes here..." style="width: 300px; padding: 5px; border-radius: 5px; border: 1px solid #ccc;">
                <button type="submit" name="save" class="btn btn-primary" style="padding: 5px 10px; border-radius: 5px; border: none; background-color: #007bff; color: #fff; cursor: pointer;">Search</button>
            </form>
          
            <br>
          
            <form class="form-inline" method="post" action="Bottoms.jsp">
                <select name="sortby" id="sortby" style="padding: 5px; border-radius: 5px; border: 1px solid #ccc;">
                    <option value="None">sort by...</option>
                    <option value="Name">Name</option>
                    <option value="lowToHigh">Price (Ascending)</option>
                    <option value="highToLow">Price (Descending)</option>
                    <option value="Tag">Color</option>
                    <option value="Open">Status: Open</option>
                    <option value="Closed">Status: Closed</option>
                </select>    
                <button type="submit" name="sortBy" style="padding: 5px 10px; border-radius: 5px; border: none; background-color: #007bff; color: #fff; cursor: pointer;">Go</button>
            </form>
        </div>
                
        <% 
            Statement stmt = con.createStatement();
            String sortParam = request.getParameter("sortby");
            ResultSet resultset = null;
            if(sortParam == null){
                resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='Bottoms';");
            }else if(sortParam.equals("Name")){
                resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='Bottoms' ORDER BY itemname;");
            }else if(sortParam.equals("lowToHigh")){
                resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='Bottoms' ORDER BY price;");
            }else if(sortParam.equals("highToLow")){
                resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='Bottoms' ORDER BY price DESC;");
            }else if(sortParam.equals("Tag")){
                resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='Bottoms' ORDER BY subattribute;");
            }else if(sortParam.equals("Open")){
                resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='Bottoms' AND closed='0' ORDER BY itemname;");
            }else if(sortParam.equals("Closed")){
                resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='Bottoms' AND closed='1' ORDER BY itemname;");
            }else{
                resultset = stmt.executeQuery("SELECT * from listings WHERE subcategory='Bottoms';");
            }
        %>
        
        <br><br>
        
        <form method="post" action="examinelisting.jsp">
            <table align="center" border="1">
                <tr>
                    <th></th>
                    <th>Name</th>
                    <th>Color</th>
                    <th>Price</th>
                    <th>Status</th>
                </tr>
                <% while(resultset.next()){ 
                    String status = resultset.getString(8);
                %>
                <tr>
                    <td> <button name="lid" type="submit" value="<%= resultset.getString(1) %>" style="padding: 5px 10px; border-radius: 5px; border: none; background-color: #007bff; color: #fff; cursor: pointer;">>></button></td>
                    <td><%=resultset.getString(2)%></td>
                    <td><%= resultset.getString(4) %></td>
                    <td><%= resultset.getString(5) %></td>
                    <%if(status.equals("0")){ %>
                        <td bgcolor="blue">Open</td>
                    <% }else{ %>
                        <td bgcolor="red">CLOSED</td>
                    <% } %>
                </tr>
                <% } %>
            </table>
        </form>
    </div>
</body>

</html>