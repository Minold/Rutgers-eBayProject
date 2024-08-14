<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>




<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Listing</title>
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

    <div style="text-align: center; max-width: 600px; margin: 0 auto;">
        <h1 style="color: #007bff; font-family: Arial, sans-serif;">Create A Listing</h1>
        <form method="post" action="VerifyListing.jsp">
            <table align="center" style="width: 100%;">
                <tr>  
                    <td style="padding: 10px;">
                        <label for="itemname">Item Name:</label><br>
                        <input type="text" name="itemname" value="" maxlength="30" required style="width: 100%; box-sizing: border-box; padding: 8px; margin-top: 5px; border: 1px solid #ccc; border-radius: 5px;">
                    </td>
                </tr>
                <tr>  
                    <td style="padding: 10px;">
                        <label for="subcategory">Subcategory:</label><br>
                        <select name="subcategory" id="subcategory" onchange="func()" style="width: 100%; box-sizing: border-box; padding: 8px; margin-top: 5px; border: 1px solid #ccc; border-radius: 5px;">
                            <option value="NONE">-SELECT AN OPTION-</option>
                            <option value="Tops">Tops</option>
                            <option value="Bottoms">Bottoms</option>
                            <option value="Others">Others</option>
                        </select>
                    </td>
                </tr>
                <tr>  
                    <td style="padding: 10px;">
                        <label for="subattribute" id="Subattr">Subattribute:</label><br>
                        <input type="text" name="subattribute" value="" maxlength="30" required style="width: 100%; box-sizing: border-box; padding: 8px; margin-top: 5px; border: 1px solid #ccc; border-radius: 5px;">
                    </td>
                </tr>
                <tr>  
                    <td style="padding: 10px;">
                        <label for="price">Starting Price:</label><br>
                        <input type="number" required name="price" min="0" value="0" step=".01" style="width: 100%; box-sizing: border-box; padding: 8px; margin-top: 5px; border: 1px solid #ccc; border-radius: 5px;">
                    </td>
                </tr>
                <tr>  
                    <td style="padding: 10px;">
                        <label for="minsale">Minimum Sale Price (Hidden):</label><br>
                        <input type="number" required name="minsale" min="0.01" value="0" step=".01" style="width: 100%; box-sizing: border-box; padding: 8px; margin-top: 5px; border: 1px solid #ccc; border-radius: 5px;">
                    </td>
                </tr>
                <tr>  
                    <td style="padding: 10px;">
                        <label for="dt">Closing Date/Time:</label><br>
                        <input type="datetime-local" required name="dt" style="width: 100%; box-sizing: border-box; padding: 8px; margin-top: 5px; border: 1px solid #ccc; border-radius: 5px;">
                    </td>
                </tr>
                <tr>
                    <td style="padding: 10px;">
                        <input type="submit" value="Create" style="width: 100%; box-sizing: border-box; padding: 10px; margin-top: 10px; background-color: #007bff; color: #fff; border: none; border-radius: 5px; cursor: pointer;">
                    </td>
                </tr>
                <tr>
                    <td style="padding: 10px;">
                        <a href="Account.jsp" style="text-decoration: none; color: #007bff; font-weight: bold;">Back</a>
                    </td>
                </tr>
                <% if (request.getParameter("msg") != null) { %>
                <tr>
                    <td style="padding: 10px;">
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
            if(selectedValue=="Bottoms"){document.getElementById("Subattr").innerHTML = "Color: ";}
            else if(selectedValue=="Tops"){document.getElementById("Subattr").innerHTML = "Color: ";}
            else{document.getElementById("Subattr").innerHTML = "Color: ";}
        }
    </script>
</body>

</html>