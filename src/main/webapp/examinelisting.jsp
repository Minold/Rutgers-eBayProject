<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="com.cs336.pkg.*" %>

<head>
<style>
.center {
	margin-left: auto;
	margin-right: auto;
}
</style>
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
			String lid = request.getParameter("lid");
			Statement stmt = con.createStatement();
            ResultSet resultset = stmt.executeQuery("SELECT * from listings WHERE l_id='"+lid+"';") ;
        	

       	   	String name = null;
            String subcat = null;
            String subattr = null;
            String price = null;
            String minsale = null;
            String cdt = null;
            String status = null;
            Double p = null; 
            Double m = null; 
            Double minbid = null; 
            Double minprice = null;

            Statement stmt2 = con.createStatement();
          	ResultSet fetchposter = stmt2.executeQuery("SELECT username from posts WHERE l_id="+lid+";");
            String postedby = null; 

            while(resultset.next()){
	            
	            name = resultset.getString(2);
	            subcat = resultset.getString(3);
	            subattr = resultset.getString(4);
	            price = resultset.getString(5);
	            minsale = resultset.getString(6);
	            cdt = resultset.getString(7);
	            status = resultset.getString(8);

	            p = Double.parseDouble(price);
	            p = Math.round(p * 100.0)/100.0;
				minbid = p+.01;
				minbid = Math.round(minbid * 100.0)/100.0;

				minprice = Double.parseDouble(minsale);
				minprice = Math.round(minprice * 100.0)/100.0;
           }

           while(fetchposter.next()){
  	        	
  	            postedby = fetchposter.getString(1);
  	       }
          %>

       <div style="text-align: center; margin-bottom: 20px;">
    <a href="home.jsp">Home</a>
    <h1 style="font-family: Arial, sans-serif; color: #333;"><%=name%></h1>
    <% if (status.equals("0")) { %>
        <p style="font-size: 18px; color: #666;"><b>Current Price: $<%=price%></b></p>
    <% } %>

   
    <% if (!postedby.equals(username)) { %>
        <form method="post" action="VerifyBid.jsp" style="margin-top: 20px;">
            <table align="center">
                <tr>
                    <td><input type="hidden" name="lid" value="<%=lid%>" /></td>
                </tr>
                <tr>
                    <td><input type="hidden" name="price" value="<%=price%>" /></td>
                </tr>

                <% if(status.equals("0")){ %><!--listing is open -->
                    
                    <tr>
                        <td style="padding-bottom: 10px;">Bid: <input type="number" required name="bid" min="0" value="<%=minbid%>" step=".01" style="width: 100%; padding: 5px; border: 1px solid #ccc; border-radius: 5px;"></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Make Bid" style="width: 100%; padding: 10px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer;"></td>
                    </tr>
                <% } %>
            </table>
        </form>
        <form method="post" action="AutoBidCheck.jsp">
            <table align="center" style="margin-top: 20px;">
                <tr>
                    <td><input type="hidden" name="lid" value="<%=lid%>" /></td>
                </tr>
                <tr>
                    <td><input type="hidden" name="price" value="<%=price%>" /></td>
                </tr>

                <% if(status.equals("0")){ %><!--listing is open -->
                    <!-- Automatic bids -->
                    <tr>
                        <td style="text-align: center; padding-top: 10px;"> or </td>
                    </tr>
                    <tr>
                        <td>Bid Limit: <input type="number" required name="bid_limit" min="0" step=".01" style="width: 100%; padding: 5px; border: 1px solid #ccc; border-radius: 5px;"></td>
                    </tr>
                    <tr>
                        <td>Increment: <input type="number" required name="increment" min="0" step=".01" style="width: 100%; padding: 5px; border: 1px solid #ccc; border-radius: 5px;"></td>
                    </tr>
                    <tr>
                        <td><input type="submit" value="Set Automatic Bid" style="width: 100%; padding: 10px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer;"></td>
                    </tr>
                <% } %>
            </table>
        </form>
    <% } %>
    

    <% if (p >= minprice && status.equals("1") ) { %>
        <table class="center" style="margin-top: 20px; border-collapse: collapse; width: 100%;">
            <tr>
                <td style="padding: 10px; background-color: #4CAF50; color: white; font-size: 20px;">ITEM SOLD!</td>
            </tr>
            <tr>
                <td style="padding: 10px;">Sale Price: $<%=price%></td>
            </tr>
        </table>
    <% } else if (status.equals("1")) { %>
        <table class="center" style="margin-top: 20px; border-collapse: collapse; width: 100%;">
            <tr>
                <td style="padding: 10px; background-color: #f44336; color: white; font-size: 20px;">Auction Closed: No Winner ;(</td>
            </tr>
            <tr>
                <td style="padding: 10px;">Final Price: $<%=price%></td>
            </tr>
            <tr>
                <td style="padding: 10px;">Desired Minimum: $<%=minprice%></td>
            </tr>
        </table>
    <% } %>
    <% if (request.getParameter("msg") != null) { %>
        <table style="margin-top: 20px;">
            <tr>
                <td style="text-align: center; color: red;"><%=request.getParameter("msg")%></td>
            </tr>
        </table>
    <% } %>

    <% if (request.getParameter("makeBidRet") != null) { %>
        <table style="margin-top: 20px;">
            <tr>
                <td><p style="text-align: center; color: blue;"><%=request.getParameter("makeBidRet")%></p></td>
            </tr>
        </table>
    <% } %>
</div>

<hr>
<h3 style="text-align: center; font-family: Arial, sans-serif; color: #333;"><u>Details:</u></h3>
<p style="text-align: center; font-size: 18px; color: #666;"><b>Seller: </b><%=postedby%></p>
<p style="text-align: center; font-size: 18px; color: #666;"><b>Closing Date/Time: </b><%=cdt%></p>
<p style="text-align: center; font-size: 18px; color: #666;"><b>Subcategory: </b><%=subcat%></p>
<p style="text-align: center; font-size: 18px; color: #666;"><b>Subattribute: </b><%=subattr%></p>
<hr>

<div style="text-align: center;">
    <h3 style="font-family: Arial, sans-serif; color: #333;">Bid History</h3>
    <% Statement stmt3 = con.createStatement();
    ResultSet bidhist = stmt3.executeQuery("SELECT b.b_id, price, username, dtime from bids b "+
            "LEFT JOIN bidson bo on bo.b_id = b.b_id LEFT JOIN places p on p.b_id = bo.b_id " +
            "WHERE l_id= " +lid+";");
    %>
    <table align="center" BORDER="1" style="margin-bottom: 20px; border-collapse: collapse; width: 100%;">
        <tr>
            <th style="padding: 10px; background-color: #f2f2f2;">Price</th>
            <th style="padding: 10px; background-color: #f2f2f2;">Bidder</th>
            <th style="padding: 10px; background-color: #f2f2f2;">Date/Time</th>
        </tr>
        <% while(bidhist.next()){ %>
        <tr>
            <td style="padding: 10px;"><%=bidhist.getString(2)%></td>
            <td style="padding: 10px;"><%=bidhist.getString(3)%></td>
            <td style="padding: 10px;"><%=bidhist.getString(4)%></td>
        </tr>
        <% } %>
    </table>
    <hr>

    <h3 style="font-family: Arial, sans-serif; color: #333;">Similar Items</h3>
    <% Statement stmt4 = con.createStatement();
    ResultSet similar = stmt4.executeQuery("SELECT * from listings WHERE l_id != "+lid+" AND (itemname LIKE '%"+name+"%' OR subattribute LIKE '%"+subattr+"%');");
    %>
    <form method="post" action="examinelisting.jsp">
        <table align="center" BORDER="1" style="margin-top: 20px; border-collapse: collapse; width: 100%;">
            <tr>
                <th style="padding: 10px; background-color: #f2f2f2;">View</th>
                <th style="padding: 10px; background-color: #f2f2f2;">Item Name</th>
                <th style="padding: 10px; background-color: #f2f2f2;">Subcategory</th>
                <th style="padding: 10px; background-color: #f2f2f2;">Attribute</th>
            </tr>
            <% while(similar.next()){ %>
            <tr>
                <td style="padding: 10px;"><button name="lid" type="submit" value="<%= similar.getString(1) %>" style="padding: 5px 10px; background-color: #4CAF50; color: white; border: none; border-radius: 5px; cursor: pointer;">>></button></td>
                <td style="padding: 10px;"><%=similar.getString(2)%></td>
                <td style="padding: 10px;"><%=similar.getString(3)%></td>
                <td style="padding: 10px;"><%=similar.getString(4)%></td>
            </tr>
            <% } %>
        </table>
    </form>
</div>


</body>

</html>