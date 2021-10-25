<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Item Detail</title>
</head>
<body>

	<%
ApplicationDB db = new ApplicationDB();	
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keyboardpartauction",
        "root", "dPQmsdPwjddl660507");
Statement st = con.createStatement();

String productID = request.getParameter("productID");
out.println("Product ID " + productID);
%>
	<p>&nbsp;</p>

	<% try {
	    
			String checkCase = "  select * from cases where productID = " + productID;
			String checkPCB = "  select * from pcb where productID = " + productID;
			String checkPrebuilt = "  select * from prebuilt where productID = " + productID;
			String checkKeycaps = "  select * from keycaps where productID = " + productID;
			String checkSwitches = "  select * from switch where productID = " + productID;
			String type = "";
			
			ResultSet result1 = st.executeQuery(checkCase);
			if (result1.next() == true){ 
			    type = " cases ";
			}
			ResultSet result2 = st.executeQuery(checkPCB);
			if (result2.next() == true){
			    type = " pcb ";
			}
			ResultSet result3 = st.executeQuery(checkPrebuilt);
			if (result3.next() == true){
			    type = " prebuilt ";
			}
			ResultSet result4 = st.executeQuery(checkKeycaps);
			if (result4.next() == true){
			    type = " keycaps ";
			}
			ResultSet result5 = st.executeQuery(checkSwitches); 
			if (result5.next() == true){
			    type = " switch ";
			}
			
			
		String str = "select * from" + type + "p inner join keyboardpart k on k.productID = p.productID AND k.productID = " + productID;
		ResultSet result = st.executeQuery(str);
		result.first();
		String imagelink = result.getString("piclink");%>

	<img src=<%=imagelink%> alt="image" width="400" height="400">


	<p>
		<a href='auction.jsp?productID=<%=productID%> '>Click here to create an auction for this item!</a>
	</p>
	

	<p>
		<strong>Name: </strong>
		<%= result.getString("name") %></p>
	<p>
		<strong>Brand: </strong>
		<%= result.getString("brand") %></p>
	<p>
		<strong>Condition: </strong><%= result.getString("condition") %></p>
	<% if(type.equals(" cases ")){%>
		<p> <strong>Material: </strong><%= result.getString("material") %></p>
		<p> <strong>Color: </strong><%= result.getString("color") %></p>
	<%}else if(type.equals(" pcb ")){%>
	    <p> <strong>Type: </strong><%= result.getString("type") %></p>
		<p> <strong>Layout: </strong><%= result.getString("layout") %></p>
		<p> <strong>Via Support: </strong><%= result.getString("viaSupport") %></p>
	<%}else if(type.equals(" prebuilt ")){%>
	   <p> <strong>Layout: </strong><%= result.getString("layout") %></p>
	<%}else if(type.equals(" keycaps ")){%>
	    <p> <strong>Material: </strong><%= result.getString("material") %></p>
		<p> <strong>Profile: </strong><%= result.getString("profile") %></p>
	<%}else {%>
	    <p> <strong>Type: </strong><%= result.getString("type") %></p>
		<p> <strong>Actuation Force: </strong><%= result.getString("actuationForce") %></p>    
	<%}%>
	<p>
		<strong>Existing Auctions: </strong>
	</p>

	<% 
		String itemAuctions =  "select a.auctionID, bidEndTime, bidStartTime, bidIncrement, highestBid, minPrice, startingBid "+
		"from listed l inner join auction a on a.auctionID = l.auctionID AND l.productID = '" + productID +"'";
		ResultSet itemResult = st.executeQuery(itemAuctions);%>

	<% if (itemResult.next() == false){ %>
	

	<form action="SetNewAlert.jsp" method="post">
<p><button name="ProductID" value=<%=productID %>>
There is no Existing Auctions on this Item, Click here to set an alert!</button></p>
	</form>
	
	
	
	<% }else{ %>
	<table>
		<tr>
			<td>Auction ID</td>
			<td>Bid End Time</td>
			<td>Bid Start Time</td>
			<td>Bid Increment</td>
			<td>Highest Bid</td>
			<td>Minimum Price</td>
			<td>Starting Bid</td>
		</tr>
		<%
			itemResult.beforeFirst();
			while (itemResult.next()) { %>
		<tr>
			<td><a href='AuctionInfoPage.jsp?auctionID=<%=itemResult.getString("auctionID")%> '><%= itemResult.getString("auctionID") %></a></td>
			<td><%= itemResult.getString("bidEndTime") %></td>
			<td><%= itemResult.getString("bidStartTime") %></td>
			<td><%= itemResult.getString("bidIncrement") %></td>
			<td><%= itemResult.getString("highestBid") %></td>
			<td><%= itemResult.getString("minPrice") %></td>
			<td><%= itemResult.getString("startingBid") %></td>
		</tr>
	
	<% } }%>
	</table>
	<% } catch (Exception e) {
			out.print(e);
		}
		
			db.closeConnection(con);%>


	<p>
		<a href='MainAuctionBrowse.jsp'>Click here to go back to main page</a>
	</p>
	

</body>
</html>