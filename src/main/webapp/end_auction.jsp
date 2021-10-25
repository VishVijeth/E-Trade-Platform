<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import= "java.sql.*"%>
<%@ page import = "java.io.*,java.util.*, java.text.SimpleDateFormat, java.util.Date, javax.servlet.*" %>
<html>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%

//try{
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	Statement stmt1 = con.createStatement();
	Statement stmt2 = con.createStatement();
	Statement stmt3 = con.createStatement();

    String userID = (String) session.getAttribute("user");

    ResultSet rs = stmt.executeQuery("SELECT * FROM auction where ended = 0");

    while(rs.next()){
        
        int auctionID = rs.getInt(1);
        float highestBid = rs.getFloat(5);
        float minPrice = rs.getFloat(6);
        String resDate = rs.getString(2);
		
        //Get the productID
        int productID = 0;
        ResultSet rs1 = stmt1.executeQuery("SELECT * FROM listed WHERE auctionID =" + Integer.toString(auctionID));
            
        if(rs1.next()){
            productID = rs1.getInt(2);
        }

        String year = resDate.substring(0,4);
        String month = resDate.substring(5,7);
        String day = resDate.substring(8,10);
        String hour = resDate.substring(11,13);
        String min = resDate.substring(14,16);
        float numDate = Float.parseFloat(year + month + day + hour + min);

        Date date = new Date(); 
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
        String strDate = formatter.format(date);  
        String year1 = strDate.substring(0,4);
        String month1 = strDate.substring(5,7);
        String day1 = strDate.substring(8,10);
        String hour1 = strDate.substring(11,13);
        String min1 = strDate.substring(14,16);
        float numDate1 = Float.parseFloat(year1 + month1 + day1 + hour1 + min1);

     
        // If the auction has ended
        if(numDate1 > numDate){ 

            // Update that the auction has ended
            String insert = "UPDATE auction SET ended = 1 WHERE auctionID = " + Integer.toString(auctionID);
            PreparedStatement ps = con.prepareStatement(insert);
            ps.executeUpdate();
            ResultSet rsS = stmt3.executeQuery("SELECT userID FROM sells WHERE auctionID = " + Integer.toString(auctionID));
            String sellerID = "";
            if(rsS.next()){
            	sellerID = rsS.getString(1);
            }
            // If someone won the auction
            if(highestBid >= minPrice){
                
                // Alert the seller that a sale has been made
                String alertType = "Sale!";
                String alertMessage = "Your item was sold for " + Float.toString(highestBid);

                String insert2 = "INSERT INTO alert(userID, auctionID, alertType, alertMessage, productID) VALUES(?, ?, ?, ?, ?)";
                PreparedStatement ps2 = con.prepareStatement(insert2);

                ps2.setString(1, sellerID);
                ps2.setInt(2, auctionID);
                ps2.setString(3, alertType);
                ps2.setString(4, alertMessage);
                ps2.setInt(5, productID);
                ps2.executeUpdate();
        

                // Alert everyone involved that auction has ended and someone has won
            	 ResultSet rs2 = stmt2.executeQuery("SELECT DISTINCT userID, MAX(bidPrice) FROM bids WHERE auctionID = " + Integer.toString(auctionID) + " GROUP BY userID");
            	 
            	 while(rs2.next()){
                     
                    String curr_userID = rs2.getString(1);
					float curr_bidPrice = rs2.getFloat(2); 
                    // Alert the Winner 
                    if(curr_bidPrice == highestBid){

                        String alertType1 = "Winner";
                        String alertMessage1 = "Congratulations you have won this auction !";

                        String insert3 = "INSERT INTO alert(userID, auctionID, alertType, alertMessage, productID) VALUES(?, ?, ?, ?, ?)";
                        PreparedStatement ps3 = con.prepareStatement(insert3);

                        ps3.setString(1, curr_userID);
                        ps3.setInt(2, auctionID);
                        ps3.setString(3, alertType1);
                        ps3.setString(4, alertMessage1);
                        ps3.setInt(5, productID);
                        ps3.executeUpdate();

                        // Insert into winds bids for easy access later
                        String insert4 = "INSERT INTO winbids(sellerID, winnerID, aucID, winningPrice) VALUES (?,?,?,?)";
                		PreparedStatement ps4 = con.prepareStatement(insert4);
                		ps4.setString(1, sellerID);
                		ps4.setString(2, curr_userID);
                		ps4.setInt(3, auctionID);
                		ps4.setFloat(4, highestBid);
                		ps4.executeUpdate();
                    }
                    // Alert the losers
                    else{
                        String alertType1 = "Loser";
                        String alertMessage1 = "Someone else has won this auction with a price of" + Float.toString(highestBid);

                        String insert3 = "INSERT INTO alert(userID, auctionID, alertType, alertMessage, productID) VALUES(?, ?, ?, ?, ?)";
                        PreparedStatement ps3 = con.prepareStatement(insert3);

                        ps3.setString(1, curr_userID);
                        ps3.setInt(2, auctionID);
                        ps3.setString(3, alertType1);
                        ps3.setString(4, alertMessage1);
                        ps3.setInt(5, productID);
                        ps3.executeUpdate();

                    }
            		 
            	 }
	
            }
            // If no one won the auction
            else{
                
                // Alert the seller that the sale has not been made
                String alertType = "No Sale!";
                String alertMessage = "Your item was not sold since no bid exceeded your Reserve price of " + Float.toString(minPrice);

                String insert2 = "INSERT INTO alert(userID, auctionID, alertType, alertMessage, productID) VALUES(?, ?, ?, ?, ?)";
                PreparedStatement ps2 = con.prepareStatement(insert2);

                ps2.setString(1, sellerID);
                ps2.setInt(2, auctionID);
                ps2.setString(3, alertType);
                ps2.setString(4, alertMessage);
                ps2.setInt(5, productID);
                ps2.executeUpdate();

                // Alert everyone involved that sale has not been made
                ResultSet rs2 = stmt.executeQuery("SELECT DISTINCT userID FROM bids WHERE auctionID = " + Integer.toString(auctionID));

                while(rs2.next()){

                    String curr_userID = rs2.getString(1);

                    String alertType1 = "No Sale";
                    String alertMessage1 = "This Auction has closed and has failed to sell its item due to the Reserve price";

                    String insert3 = "INSERT INTO alert(userID, auctionID, alertType, alertMessage, productID) VALUES(?, ?, ?, ?, ?)";
                    PreparedStatement ps3 = con.prepareStatement(insert3);

                    ps3.setString(1, curr_userID);
                    ps3.setInt(2, auctionID);
                    ps3.setString(3, alertType1);
                    ps3.setString(4, alertMessage1);
                    ps3.setInt(5, productID);
                    ps3.executeUpdate();

                }
            }
        }
    }
    con.close();
    response.sendRedirect("MainAuctionBrowse.jsp");
//}
    /*catch (Exception ex){
        out.print("Auction could not be updated. <a href='success.jsp'>Go Back!</a>");
    }*/

%>
</html>