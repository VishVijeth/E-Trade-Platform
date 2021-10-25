<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.util.Date,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*,java.text.SimpleDateFormat"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>



	<%
ApplicationDB db = new ApplicationDB();	
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keyboardpartauction",
        "root", "dPQmsdPwjddl660507");
Statement st = con.createStatement();

String auction = request.getParameter("auctionID");
out.println("auction ID " + auction);
%>
	<p>&nbsp;</p>

	<% try {
	    
		String str = "select * from bids where auctionID = " + auction;
		ResultSet result2 = st.executeQuery(str);%>
		
	<table>
		<tr>
			<td>Bid User ID</td>
			<td>Bid Price</td>
		</tr>
		<%
		result2.beforeFirst();
			while (result2.next()) {  %>
		<tr>
			<td><%= result2.getString("userID") %></td>
			<td><%= result2.getString("bidPrice") %></td>
		</tr>
	
	 
	<%} %>
	</table>
	<!--  put code here for bidding -->
	
	
	  <br><b> Manual Bid:</b>
      
       <br>

       <form method="post" action="create_bid.jsp">
       <table>

    <tr>  
       <td> Bid Price:</td><td><input type="number" name="bidPrice"></td>
    </tr>

    
       </table>

    <br>
       <button name="setupbid" value=<%=auction%>>Set up Bid!</button>
       </form>
    <br>
	<table>
	
	       <br>
      <b> Auto Bid:</b>
       <br>

       <form method="post" action="create_autobid.jsp">
       <table>

    <tr>  
       <td> Bid Price:</td><td><input type="number" name="bidPrice"></td>
    </tr>
    
    <tr>  
       <td> Auto Bid Max:</td><td><input type="number" name="autoBid"></td>
    </tr>

       </table>

    <br>
       <button name="setupbid" value=<%=auction%>>Set up AutoBid!</button>
       </form>
    <br>
	
	</table>
	
	
	
	
	<!-- end code here for bidding -->
	

		<% 

	//We need a query where we select all the avail auctions that are same item type
		Date date = new Date(); 
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String strDate = formatter.format(date);  
        String year1 = strDate.substring(0,4);
        String month1 = strDate.substring(5,7);
        String yearmonth = year1+month1;
        int yrmonth = Integer.parseInt(yearmonth) - 1;
        yearmonth = String.valueOf(yrmonth);
        
        year1 = yearmonth.substring(0,4);
        month1 = yearmonth.substring(4,6);
        String BidPrice = "select highestBid from auction where auctionID = " + auction;
		
        ResultSet bidPriceSet = st.executeQuery(BidPrice);
        bidPriceSet.next();
		String BidPrice2 = bidPriceSet.getString("highestBid");
	
		String dateCheck =  "select * from auction where bidStartTime like '"+year1+"-"+month1+"%' AND highestBid > " + BidPrice2;

		ResultSet itemResult2 = st.executeQuery(dateCheck);
		%>
	
	<p><b>Here are similar auctions available from the last month: </b></p>
		<table>
		<tr>
			<td>Product ID</td>
			<td>Product Name</td>
			<td>Auction ID</td>
			<td>Current Bid</td>
			<td>Seller</td>
		</tr>
		<%
			
			while (itemResult2.next()) { %>
		<tr>

			<td><a href='ItemDetails.jsp?productID=<%=itemResult2.getString("productID")%> '>
			<%= itemResult2.getString("productID") %></a></td>
			
			<td><%= itemResult2.getString("name") %></td>
			
			<td><a href='AuctionInfoPage.jsp?auctionID=<%=itemResult2.getString("auctionID")%> '>
			<%= itemResult2.getString("auctionID") %></a></td>

			<td><%= itemResult2.getString("highestBid") %></td>		
			
			<td><%= itemResult2.getString("userID") %></td>				
		</tr>
	</table> 
	
		<%
		} db.closeConnection(con); }
		
		
			catch (Exception e) {
			out.print(e);
		}%>


	<p>
		<a href='MainAuctionBrowse.jsp'>Click here to go back to main page</a>
	</p>

</body>
</html>