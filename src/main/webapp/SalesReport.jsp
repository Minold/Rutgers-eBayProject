<%@ page import="java.sql.Timestamp, java.text.SimpleDateFormat" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*, java.io.*, java.util.*, java.sql.*, javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
    <title>Viewing Sales Report</title>
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
<body style="font-family: Arial, sans-serif; margin: 0; padding: 0; background-color: #f7f7f7; text-align: center;">
    <a href="AdminHome.jsp" style="display: block; margin-top: 20px; text-decoration: none; color: #333;">&lt;= Exit Sales Report</a>
    <% 
        ApplicationDB db = new ApplicationDB();
        Connection con = null;
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            con = db.getConnection();
            String start = request.getParameter("date1");
            String end = request.getParameter("date2");
            SimpleDateFormat fmt = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            SimpleDateFormat printer = new SimpleDateFormat("EEE, d MMM yyyy HH:mm:ss");

            Timestamp date1 = new Timestamp(fmt.parse(start).getTime());
            Timestamp date2 = new Timestamp(fmt.parse(end).getTime());

            String query = "SELECT SUM(price) FROM listings l WHERE dt >= ? AND dt <= ? AND closed=1 AND l.l_id IN (SELECT g.l_id FROM generates g)";
            ps = con.prepareStatement(query);
            ps.setTimestamp(1, date1);
            ps.setTimestamp(2, date2);
            rs = ps.executeQuery();
            String total_earnings = "0.00";
            if (rs.next()) {
                total_earnings = rs.getString(1) != null ? rs.getString(1) : "0.00";
            }
    %>
    <div style="text-align:center">
        <h1>Viewing Sale Report</h1>
        <h3>From: <%= printer.format(date1) %></h3>
        <h3>To: <%= printer.format(date2) %></h3>
        <hr>
        <h3>Total Earnings: $<%= total_earnings %></h3>
    <% 
            query = "SELECT l.itemname, l.subcategory, SUM(l.price), COUNT(*) FROM listings l WHERE dt >= ? AND dt <= ? AND closed=1 AND l.l_id IN (SELECT g.l_id FROM generates g) GROUP BY l.itemname, l.subcategory ORDER BY SUM(l.price) DESC";
            ps = con.prepareStatement(query);
            ps.setTimestamp(1, date1);
            ps.setTimestamp(2, date2);
            rs = ps.executeQuery();
    %>
        <h4>Best Selling Items</h4>
        <table style="margin: 20px auto; width: 80%; background-color: #fff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
            <tr>
                <th>Item</th>
                <th>Category</th>
                <th>Earnings</th>
                <th>Number Sold</th>
            </tr>
            <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getString(1) %></td>
                <td><%= rs.getString(2) %></td>
                <td>$<%= rs.getString(3) %></td>
                <td><%= rs.getString(4) %></td>
            </tr>
            <% } %>
        </table>
        <% 
            query = "SELECT l.subcategory, SUM(l.price) AS earnings, COUNT(*) AS count FROM listings l WHERE dt >= ? AND dt <= ? AND closed=1 AND l.l_id IN (SELECT g.l_id FROM generates g) GROUP BY l.subcategory ORDER BY earnings DESC";
            ps = con.prepareStatement(query);
            ps.setTimestamp(1, date1);
            ps.setTimestamp(2, date2);
            rs = ps.executeQuery();
        %>
        <h4>Best Selling Categories</h4>
        <table style="margin: 20px auto; width: 80%; background-color: #fff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
            <tr>
                <th>Category</th>
                <th>Earnings</th>
                <th>Number Items Sold</th>
            </tr>
            <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getString(1) %></td>
                <td>$<%= rs.getString(2) %></td>
                <td><%= rs.getString(3) %></td>
            </tr>
            <% } %>
        </table>
        <% 
            query = "SELECT p.username, SUM(l.price) AS total_spent, COUNT(*) AS items_bought FROM listings l INNER JOIN bidson bd ON l.l_id = bd.l_id INNER JOIN bids b ON bd.b_id = b.b_id INNER JOIN places p ON p.b_id = b.b_id WHERE l.closed=1 AND l.price=b.price AND dt >= ? AND dt <= ? AND l.l_id IN (SELECT g.l_id FROM generates g) GROUP BY p.username ORDER BY total_spent DESC";
            ps = con.prepareStatement(query);
            ps.setTimestamp(1, date1);
            ps.setTimestamp(2, date2);
            rs = ps.executeQuery();
        %>
        <h4>Biggest Spenders</h4>
        <table style="margin: 20px auto; width: 80%; background-color: #fff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
            <tr>
                <th>Username</th>
                <th>Total Spent</th>
                <th>Number Items Bought</th>
            </tr>
            <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getString(1) %></td>
                <td>$<%= rs.getString(2) %></td>
                <td><%= rs.getString(3) %></td>
            </tr>
            <% } %>
        </table>
        <% 
            query = "SELECT p.username, SUM(l.price) AS total_earnings, COUNT(*) AS items_sold FROM listings l INNER JOIN posts p ON p.l_id = l.l_id WHERE l.closed=1 AND dt >= ? AND dt <= ? AND l.l_id IN (SELECT g.l_id FROM generates g) GROUP BY p.username ORDER BY total_earnings DESC";
            ps = con.prepareStatement(query);
            ps.setTimestamp(1, date1);
            ps.setTimestamp(2, date2);
            rs = ps.executeQuery();
        %>
        <h4>Biggest Earners</h4>
        <table style="margin: 20px auto; width: 80%; background-color: #fff; border-radius: 8px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">
            <tr>
                <th>Username</th>
                <th>Total Earnings</th>
                <th>Number Items Sold</th>
            </tr>
            <% while (rs.next()) { %>
            <tr>
                <td><%= rs.getString(1) %></td>
                <td>$<%= rs.getString(2) %></td>
                <td><%= rs.getString(3) %></td>
            </tr>
            <% } %>
        </table>
        <% 
        } catch (Exception e) {
            e.printStackTrace();
            out.println("<h3>Error encountered: " + e.getMessage() + "</h3>");
        } finally {
            if (rs != null) try { rs.close(); } catch (SQLException ex) {}
            if (ps != null) try { ps.close(); } catch (SQLException ex) {}
            if (con != null) try { con.close(); } catch (SQLException ex) {}
        }
    %>
    </div>
</body>
</html>

