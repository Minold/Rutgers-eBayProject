<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>EditList</title>
</head>
<body>
<%
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	
	String operation = request.getParameter("operation");
	String lid = request.getParameter("lid");
	if (operation.equals("removeListing")) {
		PreparedStatement ps = con.prepareStatement("DELETE FROM listings WHERE l_id=(?)");
		ps.setString(1, lid);
		ps.executeUpdate();
		response.sendRedirect("CustomerRepHome.jsp");
	} else if (operation.equals("removeBid")) {
		String bid = request.getParameter("bid");
		PreparedStatement ps = con.prepareStatement("DELETE FROM bids WHERE b_id=(?)");
		ps.setString(1, bid);
		ps.executeUpdate();
		ps = con.prepareStatement(
				"SELECT MAX(b.price) " +
				"FROM listings l " +
				"INNER JOIN bidson bd ON bd.l_id = l.l_id " +
				"INNER JOIN bids b ON b.b_id = bd.b_id " +
				"WHERE l.l_id=(?)"
		);
		ps.setString(1, lid);
		ResultSet rs = ps.executeQuery();
		String new_price = null;
		if (rs.next()) {
			new_price = rs.getString(1);
		}
		if (new_price == null) {
			ps = con.prepareStatement(
					"UPDATE listings SET price=0.01 WHERE l_id=(?)"
			);
			ps.setString(1, lid);
		} else {
			ps = con.prepareStatement(
					"UPDATE listings SET price=(?) WHERE l_id=(?)"
			);
			ps.setString(1, new_price);
			ps.setString(2, lid);
		}
		ps.executeUpdate();
	%>
		<jsp:forward page="RepEditListing.jsp">
		<jsp:param name="lid" value="<%= lid %>"/> 
		</jsp:forward>
	<%
	}
	%>
</body>
</html>