<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Questions and Answers!</title>
<style>
.center {
	margin-left: auto;
	margin-right: auto;
}

table, th, td {
  	border: 1px solid;
  	border-collapse: collapse;
  	padding: 8px;
}
</style>
</head>
<body style="font-family: Arial, sans-serif;">

    <a href="home.jsp" style="display: block; text-align: center; margin-bottom: 20px; text-decoration: none; color: #007bff; font-size: 16px;"> Back to Homepage</a>

    
    <div style="text-align: center;">
        <h1 style="color: #007bff; font-family: 'Arial', sans-serif; font-size: 32px; text-align: center; margin-bottom: 30px; text-shadow: 2px 2px 4px rgba(0,0,0,0.1);">Questions Asked by Users</h1>

        
        <% 
            ApplicationDB db = new ApplicationDB();    
            Connection con = db.getConnection();
            Statement stmt = con.createStatement();
        %>
        
        <form method="post" action="Questions.jsp" style="margin-bottom: 20px;">
            <input type="text" name="search" class="form-control" placeholder="Search by keyword" style="padding: 5px;">
            <button type="submit" name="save" class="btn btn-primary" style="padding: 5px 10px; background-color: #007bff; color: #fff; border: none; border-radius: 5px; cursor: pointer;">Search</button>
        </form>
        
        <%
            String keyword = request.getParameter("search");
            ResultSet resultset;
            
            if (keyword == null || keyword.isBlank()) {
                resultset = stmt.executeQuery("SELECT q_id, q_text FROM question");
            } else {
                PreparedStatement ps = con.prepareStatement("SELECT q_id, q_text FROM question WHERE q_text LIKE '%" + keyword + "%'");
                resultset = ps.executeQuery();
            }
        %>
        
        <hr>
        
        <%
            if (keyword != null && !keyword.isBlank()) {
        %>
        <h3>Showing results for: <%= keyword %></h3>
        <%
            }
        %>
        
        <form action="UserExamineQuestion.jsp">
            <table style="margin: 0 auto;">
                <tr>
                    <th></th>
                    <th>Question</th>
                </tr>
                <% while (resultset.next()) { %>
                <tr>
                    <td><button name="q_id" type="submit" value="<%= resultset.getString(1) %>" style="padding: 5px 10px; background-color: #007bff; color: #fff; border: none; border-radius: 5px; cursor: pointer;">>></button></td>
                    <td style="max-width: 300px; overflow: hidden; text-overflow: ellipsis; white-space: nowrap; padding: 5px;"><%= resultset.getString(2) %></td>
                </tr>
                <% } %>
            </table>
        </form>
    </div>
</body>

</html>