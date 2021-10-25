<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">

<h1>
	<span style="color: #cc99ff;"><strong>BuyMe</strong></span>
</h1>
</head>
<body>
<p><strong>Go to my <a href='UserInfoPage.jsp'>User Page</a></strong> OR <strong><a href='logout.jsp'>Log out</a></strong></p>

	<p>
		<a href='update.jsp'>Click here to update auctions</a>
	</p>
	
		<p>
		<a href='product.jsp'>Click here to create an item!</a>
	</p>
	
<form action="FilterAndSort.jsp" method="post">
<p><strong><span style="color: #ff6600;">Filter By:</span></strong></p>
<input type="checkbox" id="itemtype1" name="filterCase" value="1">
<label for="itemtype1"> Case</label>

<input type="checkbox" id="itemtype2" name="filterKeycaps" value="1">
<label for="itemtype2"> Keycaps</label>

<input type="checkbox" id="itemtype3" name="filterPCB" value="1">
<label for="itemtype3"> PCB</label>

<input type="checkbox" id="itemtype4" name="filterSwitches" value="1">
<label for="itemtype4"> Switches</label>

<input type="checkbox" id="itemtype5" name="filterPrebuilt" value="1">
<label for="itemtype5"> Prebuilt</label>

<p><strong><span style="color: #0000ff;">Sort By:</span></strong></p>
<input type="radio" id="itemtype5" name="filterPrebuilt" value="1">
<label for="itemtype5"> Item Type</label>

<input type="radio" id="itemtype6" name="filterPrebuilt" value="1">
<label for="itemtype6"> Highest Bid Price</label>

<input type="radio" id="itemtype7" name="filterPrebuilt" value="1">
<label for="itemtype7"> Lowest Bid Price</label>

<input type="radio" id="itemtype8" name="filterPrebuilt" value="1">
<label for="itemtype8"> Seller ID</label>

<input type="radio" id="itemtype9" name="filterPrebuilt" value="1">
<label for="itemtype9"> Auction ID</label>

<input type="radio" id="itemtype10" name="filterPrebuilt" value="1">
<label for="itemtype10"> Product ID</label>
<p><input type="submit" value="submit"></p>

</form>


<% 
	try {
	
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			
			
			//Get the selected radio button from the index.jsp
			String str = "select k.productID, k.name, k.quantity, k.brand, k.condition, x.auctionID, x.userID, x.highestBid from keyboardpart as k 	left join (select l.productID, l.auctionID, s.userID, a.highestBid  from listed l, auction a, sells s, keyboardpart k where a.auctionID = l.auctionID AND l.productID = k.productID AND s.auctionID = a.auctionID) as x on k.productID = x.productID;";
			//Run the query against the database.
			ResultSet results = stmt.executeQuery(str);
		%>


	<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>
			<td>Product ID</td>
			<td>Product Name</td>
			<td>Auction ID</td>
			<td>Current Bid</td>
			<td>Seller</td>
		</tr>
		<%
			//parse out the results
			
			while (results.next()) { %>
		<tr>
			<!--  Clicking on Auction ID redirects user to auction details page -->
			<td><a href='ItemDetails.jsp?productID=<%=results.getString("productID")%> '><%= results.getString("productID") %></a></td>
			<td><%= results.getString("name") %></td>
			
			<td><% if (results.getString("auctionID") == null){ %>
			<%= "--" %>
			<% }else{ %>
			<a href='AuctionInfoPage.jsp?auctionID=<%=results.getString("auctionID")%> '><%= results.getString("auctionID") %></a></td>

			<% } %>	
			
			<td><% if (results.getString("highestBid") == null){ %>
			<%= "--" %>
			<% }else{ %>
			<%= results.getString("highestBid") %>
			<% } %>
			</td>		
			
			<td><% if (results.getString("userID") == null){ %>
			<%= "--" %>
			<% }else{ %>
			<%= results.getString("userID") %>
			<% } %>
			</td>				
		</tr>
		<% }
			//close the connection.
			db.closeConnection(con);
			%>
	</table>

	<%} catch (Exception e) {
			out.print(e);
		}%>
		


</body>
</html>