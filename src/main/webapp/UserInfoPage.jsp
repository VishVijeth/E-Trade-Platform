<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>


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
String userID = (String) session.getAttribute("user");
out.println("Hello user " + userID + "!"); 
%>

<p><a href='alerts_display.jsp'>Click here to go to your Alert page</a></p>

<p><a href='askQuestion.jsp'>Click here to go to Customer Question page</a></p>

<h3><span style="color: #339966;"><strong>Your Bids:</strong></span></h3>

		<% try {

			String str = "SELECT auctionID, bidPrice FROM bids where userID = '" + userID + "'";
			//Run the query against the database.
			ResultSet result3 = st.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
		<table>
		<tr>    
			<td>Auction ID</td>
			<td>Bid Price</td>
		</tr>
		<% if (result3.next() == false){ %>
		<tr>    
			<td><%= "--" %></td>
			<td><%= "--" %></td> 
		</tr>
		<%}else{ 
		result3.beforeFirst();%>
			<%while (result3.next()) { %>
				<tr>    
					<td><%= result3.getString("auctionID")%></td>
					<td><%= result3.getString("bidPrice")%></td>
				</tr>
				
			<%} //db.closeConnection(con); } 
			}%>
		</table>

		<% } catch (Exception e) {
			out.print(e);
		}%>
	

<h3><span style="color: #339966;"><strong>Your Auctions:</strong></span></h3>

		<% try {

			String str = "SELECT auction.auctionID, bidEndTime, highestBid FROM auction, sells where auction.auctionID = sells.auctionID AND userID = '" + userID + "'";
			//Run the query against the database.
			ResultSet result4 = st.executeQuery(str);
		%>
			
		<!--  Make an HTML table to show the results in: -->
		<table>
		<tr>    
			<td>Auction ID</td>
			<td>Bid End Time</td>
			<td>Highest Bid</td>
		</tr>
		<% if (result4.next() == false){ %>
		<tr>    
			<td><%= "--" %></td>
			<td><%= "--" %></td> 
			<td><%= "--" %></td> 
		</tr>
		<%}else{ %>
		<% result4.previous();%>
			<%while (result4.next()) { %>
				<tr>    
					<td><%= result4.getString("auction.auctionID")%></td>
					<td><%= result4.getString("bidEndTime")%></td>
					<td><%= result4.getString("highestBid")%></td>
				</tr>
				
			<%} //db.closeConnection(con); 
			}%>
		</table>

		<% } catch (Exception e) {
			out.print(e);
		}%>
	


<h3><span style="color: #339966;"><strong>Your Purchases:</strong></span></h3>


        <% try {

            String str = "SELECT aucID, winningPrice FROM winbids where winnerID = '" + userID + "'";
            //Run the query against the database.
            ResultSet result5 = st.executeQuery(str);
        %>
            
        <!--  Make an HTML table to show the results in: -->
        <table>
        <tr>    
            <td>Auction ID</td>
            <td>Bid Price</td>
        </tr>
        <% if (result5.next() == false){ %>
        <tr>    
            <td><%= "--" %></td>
            <td><%= "--" %></td> 
        </tr>
        <%}else{ %>
        <% result5.previous();%>
            <%while (result5.next()) { %>
                <tr>    
                    <td><%= result5.getString("aucID")%></td>
                    <td><%= result5.getString("winningPrice")%></td>
                </tr>
                
            <%} db.closeConnection(con); }%>
        </table>

        <% } catch (Exception e) {
            out.print(e);
        }%>
	

<p><a href='MainAuctionBrowse.jsp'>Click here to go back to main page</a></p>

</body>
</html>