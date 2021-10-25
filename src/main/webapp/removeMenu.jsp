<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<br>
 Remove Auction:
 <br>
  Enter the Auction ID of the auction you wish to remove:
  <br>
  <form method="post" action="removeAuction.jsp">
   	 <table>
   	 <tr>    
   	 <td>AuctionID:</td><td><input type="text" name="AuctionID"></td>
   	 </tr>
   	 </table>
   	 <input type="submit" value="Remove">
   	 </form>
  <br>
  Remove Bid:
  <br>
   Enter the Auction ID, User ID, and exact Bid Amount of the bid you wish to remove:
   <br>
   <form method="post" action="removeBid.jsp">
   	 <table>
   	 <tr>    
   	 <td>AuctionID:</td><td><input type="text" name="AuctionID"></td>
   	 </tr>
   	 <tr>    
   	 <td>UserID:</td><td><input type="text" name="UserID"></td>
   	 </tr>
   	 <tr>    
   	 <td>Bid Amount:</td><td><input type="text" name="BidAmount"></td>
   	 </tr>
   	 </table>
   	 <input type="submit" value="Remove">
   	 </form>
  <br>
  <br>
    <%out.println("<a href='repHome.jsp'>Return to Homepage</a>");%>