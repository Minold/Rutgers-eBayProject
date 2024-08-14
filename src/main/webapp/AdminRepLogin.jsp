<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin and Rep Home</title>
</head>
<body style="font-family: Arial, sans-serif;">

    <h2 style="text-align: center; color: #333;">Admin & Customer Rep Login!:</h2>
    
    <form method="post" action="EmployeeLoginCheck.jsp" style="text-align: center;">
        <table style="margin: 0px auto;">
            <tr>
                <td style="padding: 10px;"><input type="text" name="employee_id" value="" maxlength="30" required style="width: 200px; padding: 5px; border-radius: 5px; border: 1px solid #ccc;"/></td>
            </tr>
            <tr>
                <td style="padding: 10px;"><input type="password" name="password" value="" maxlength="30" required style="width: 200px; padding: 5px; border-radius: 5px; border: 1px solid #ccc;"/></td>
            </tr>
            <tr>
                <td style="padding: 10px;"><input type="submit" value="Log in" style="width: 200px; padding: 10px; border-radius: 5px; border: none; background-color: #007bff; color: #fff; cursor: pointer;"/></td>
            </tr>
            <% if (request.getParameter("registerRet") != null) { %>
                <tr>
                    <td><p style="text-align: center; color: blue; padding: 10px;"><%=request.getParameter("registerRet")%></p></td>
                </tr>
            <% } else if (request.getParameter("loginRet") != null) { %>
                <tr>
                    <td><p style="text-align: center; color: red; padding: 10px;"><%=request.getParameter("loginRet")%></p></td>
                </tr>
            <% } %>
        </table>
    </form>
    <p style="text-align:center; color: #333; margin-top: 20px;">Not an employee? <a href="Login.jsp" style="color: #007bff; text-decoration: none;">Login Here!</a></p>
</body>

</html>