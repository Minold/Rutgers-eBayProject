<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Create Account</title>
</head>
<body style="font-family: Arial, sans-serif;">

    <h2 style="text-align: center; color: #333;">Register Your Account With Us!:</h2>
    
    <form method="post" action="RegisterAccount.jsp" style="text-align: center;">
        <table style="margin: 0px auto;">
            <tr>
                <td style="padding: 10px;"><input type="text" name="username" value="" maxlength="30" required style="width: 200px; padding: 5px; border-radius: 5px; border: 1px solid #ccc;"/></td>
            </tr>
            <tr>
                <td style="padding: 10px;"><input type="password" name="password" value="" maxlength="30" required style="width: 200px; padding: 5px; border-radius: 5px; border: 1px solid #ccc;"/></td>
            </tr>
            <tr>
                <td style="padding: 10px;"><input type="submit" value="Create Account" style="width: 200px; padding: 10px; border-radius: 5px; border: none; background-color: #007bff; color: #fff; cursor: pointer;"/></td>
            </tr>
            <tr>
                <td><p style="text-align: center; margin-top: 10px; color: #333;">Already have an account? <a href="Login.jsp" style="color: #007bff; text-decoration: none;">Sign In</a></p></td>
            </tr>
            <% if (request.getParameter("msg") != null) { %>
                <tr>
                    <td><p style="text-align: center; color: red; padding: 10px;"><%=request.getParameter("msg")%></p></td>
                </tr>
            <% } %>
        </table>
    </form>
</body>

</html>