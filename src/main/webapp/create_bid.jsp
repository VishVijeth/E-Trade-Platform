<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
 <%
   String auctionID = request.getParameter("setupbid");
    String address = "AuctionInfoPage.jsp?auctionID=" + auctionID;
	
   try{
       
    String userID = (String) session.getAttribute("user");
    
    // Manual Bidding
 
    
        // Add a new Bid Instance
        ApplicationDB db = new ApplicationDB();	
        Connection con = db.getConnection();
        Statement stmt = con.createStatement();
			
        int enter = 0;
        
        String insert1 = "INSERT INTO bids(auctionID, userID, bidPrice) VALUES(?, ?, ?)";

        float bidPrice = Float.parseFloat(request.getParameter("bidPrice"));
        bidPrice = (float) Math.round(bidPrice * 100) / 100;

        PreparedStatement ps1 = con.prepareStatement(insert1);

        ps1.setInt(1, Integer.parseInt(auctionID));
        ps1.setString(2, userID);
        ps1.setFloat(3, bidPrice);
        
        //Get the productID
        int productID = 0;
        ResultSet rs = stmt.executeQuery("SELECT * FROM listed WHERE auctionID =" + auctionID);
        
        if(rs.next()){
        	productID = rs.getInt(2);
        }
			
        //Get the highest bid
        float highestBid = 0;
        float bidIncrement = 0;
        ResultSet rs1 = stmt.executeQuery("SELECT * FROM auction WHERE auctionID =" + auctionID);

        if(rs1.next()){
        	bidIncrement = rs1.getFloat(4);
            highestBid = rs1.getFloat(5);
        }

        // Check if this bid is higher than the current highest Bid
        if(bidPrice > highestBid){
        	
        	enter = 1;
        	// Add the Bid instance
        	ps1.executeUpdate();
        	
            // Update the highestBid in the "auction" table
            String insert2 = "UPDATE auction SET highestBid = " + Float.toString(bidPrice) + " WHERE auctionID = " + auctionID;
            PreparedStatement ps2 = con.prepareStatement(insert2);
            ps2.executeUpdate();

            // Repeatedly add alerts to the "alerts" table
            ResultSet rs2 = stmt.executeQuery("SELECT DISTINCT userID FROM bids WHERE auctionID = " + auctionID);

            while(rs2.next()){
                String temp_userID = rs2.getString(1);

                // If the user is the current bidder skip
                if(temp_userID.equals(userID)){
                    continue;
                }

                String alertType = "Outbidded";
                String alertMessage = "" + Float.toString(bidPrice) + " is now the leading price!";

                String insert3 = "INSERT INTO alert(userID, auctionID, alertType, alertMessage, productID) VALUES(?, ?, ?, ?, ?)";
                PreparedStatement ps3 = con.prepareStatement(insert3);

                ps3.setString(1, temp_userID);
                ps3.setInt(2, Integer.parseInt(auctionID));
                ps3.setString(3, alertType);
                ps3.setString(4, alertMessage);
                ps3.setInt(5, productID);
                
                ps3.executeUpdate();
            }
        }
        else{
        	 con.close();
        	 out.print("The current highest bid is " + Float.toString(highestBid) + ". You must enter atleast " + Float.toString(highestBid + bidIncrement) + " for your request to process.");
        	 out.print("<a href = 'MainAuctionBrowse.jsp'> Back to Home Page</a>");
        }
        
        if(enter == 1){
            con.close();
		    out.print("Your have succesfully created your bid !");
            out.print("<a href = 'MainAuctionBrowse.jsp'> Back to Home Page</a>");
        }
   
   }
    
    catch (Exception ex) {%>
		<a href='<%= address %>'>Your Bid could not be created.Try again</a>
	<%}
	%>
    
    
</body>
</html>