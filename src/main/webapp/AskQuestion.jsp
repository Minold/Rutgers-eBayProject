<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ask a Question</title>
</head>
<body>
    <% 
        
        ApplicationDB db = new ApplicationDB();  
        Connection con = db.getConnection();
        String username = (String) session.getAttribute("username");
        if (username == null) {
            response.sendRedirect("Login.jsp");
        }      
    %>

    <div style="text-align: center;">
        <h1 style="color: #007bff; font-family: Arial, sans-serif;">Customer Rep. Help</h1>
        <form method="post" action="VerifyQuestion.jsp">
            <table align="center" style="width: 50%; margin: 0 auto;">
                <tr>  
                    <td>
                        <label for="question">Fill out the form below, and we will get back to you!</label><br>
                        <textarea id="question" name="question" rows="6" cols="50" style="padding: 8px; margin-top: 5px; border: 1px solid #ccc; border-radius: 5px; width: 100%;"
                                  onfocus="if (this.value == 'Ask us anything! Type here') { this.value = ''; }"
                                  onblur="if (this.value == '') { this.value = 'Ask us anything! Type here'; }">Ask us anything! Type here</textarea>
                    </td>
                </tr>
                <tr>
                    <td>
                        <input type="submit" value="Post" style="width: 100%; padding: 10px; margin-top: 10px; background-color: #007bff; color: #fff; border: none; border-radius: 5px; cursor: pointer;">
                    </td>
                </tr>
                <tr>
                    <td>
                        <a href="Account.jsp" style="text-decoration: none; color: #007bff; font-weight: bold;">Back</a>
                    </td>
                </tr>                   
                <% if (request.getParameter("msg") != null) { %>
                <tr>
                    <td>
                        <p style="text-align: center; color: red;"><%=request.getParameter("msg")%></p>
                    </td>
                </tr>
                <% } %>
            </table>
        </form>
    </div>
    <script>
        function func(){
            var idElement = document.getElementById("subcategory");
            var selectedValue = idElement.options[idElement.selectedIndex].text;   
            if(selectedValue=="Cars"){document.getElementById("Subattr").innerHTML = "Color: ";}
            else if(selectedValue=="Figurines"){document.getElementById("Subattr").innerHTML = "Tag: ";}
            else{document.getElementById("Subattr").innerHTML = "Pieces: ";}
        }
    </script>
</body>


</html>