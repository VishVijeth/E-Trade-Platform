<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import= "java.sql.*"%>
<%@ page import = "java.io.*,java.util.*, javax.servlet.*,java.text.SimpleDateFormat,java.util.Date" %>
<html>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	java.util.Date dNow = new java.util.Date();
    ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
	Statement stmt2 = con.createStatement();
        //Get the productID
      
    ResultSet rs1 = stmt.executeQuery("SELECT * FROM auction where ended = 0");
        while(rs1.next()){
            int ogre = rs1.getInt(9);
            if(ogre == 0){
            	int auc = rs1.getInt(1);
            	float minprice = rs1.getFloat(6);
          	  String ss = "SELECT * from sells WHERE auctionID= " + auc;
          	  int productID = 0;
                  ResultSet rs2 = stmt2.executeQuery("SELECT * FROM listed WHERE auctionID =" + Integer.toString(auc));
                      
                  if(rs2.next()){
                      productID = rs2.getInt(2);
                  }
                  
                PreparedStatement pss = con.prepareStatement(ss);
        		ResultSet ress = pss.executeQuery();
        		String sellerName = "";
        		if(ress.next()){
        			sellerName = ress.getString(2);
        		}
              String resDate = rs1.getString(2);
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
              if (numDate1 > numDate){
                	String stt = "UPDATE auction SET ended = 1 WHERE auctionID=" + Integer.toString(auc);
                	PreparedStatement pps = con.prepareStatement(stt);
                	pps.executeUpdate();
                	Float high = rs1.getFloat(5);
  					if (high >= minprice){
                		String s = "SELECT * from bids WHERE auctionID= " + Integer.toString(auc) + " AND bidPrice =" + Float.toString(high);
                		PreparedStatement ps = con.prepareStatement(s);
                		ResultSet res = ps.executeQuery(s);
                		String winnerName = "";
                		if(res.next()){
                			winnerName = res.getString(2);
                		}
                		String msg = "You Won!";
                		String msg2 = "You have succesfully won auction: " + Integer.toString(auc) + " for $" + Float.toString(high);
                		String ins = "INSERT INTO alert(`userID`, `auctionID`, `alertType`, `alertMessage`, `productID`) VALUES (?, ?, ?, ?, ?)";
                		PreparedStatement winner = con.prepareStatement(ins);
                		winner.setString(1,winnerName);
                		winner.setInt(2,auc);
                		winner.setString(3,msg);
                		winner.setString(4,msg2);
                		winner.setInt(5,0);
                		winner.executeUpdate();
                		String msg3 = "Your auction sold!";
                		String msg4 = "You have successfully sold your acution: " + Integer.toString(auc) + " for $" + Float.toString(high);
                		String ins2 = "INSERT INTO alert(`userID`, `auctionID`, `alertType`, `alertMessage`, `productID`) VALUES (?, ?, ?, ?, ?)";
  						PreparedStatement sold = con.prepareStatement(ins2);
  						sold.setString(1,sellerName);
                		sold.setInt(2,auc);
                		sold.setString(3,msg3);
                		sold.setString(4,msg4);
                		sold.setInt(5,productID);
                		sold.executeUpdate();
                		
                		String ins3 = "INSERT INTO winbids(sellerID, winnerID, aucID, winningPrice) VALUES (?,?,?,?)";
                		PreparedStatement winbids = con.prepareStatement(ins3);
                		winbids.setString(1,sellerName);
                		winbids.setString(2,winnerName);
                		winbids.setInt(3,auc);
                		winbids.setFloat(4,high);
                		winbids.executeUpdate();
                		
  					}else{
  						String msg3 = "Your auction failed to sell";
                		String msg4 = "You have unsuccessfully sold your acution: " + Integer.toString(auc) + " for $" + Float.toString(minprice);
                		String ins2 = "INSERT INTO alert(userID, auction ID, alertType, alertMessage, productID) VALUES (?, ?, ?, ?, 0)";
  						PreparedStatement sold = con.prepareStatement(ins2);
  						sold.setString(1,sellerName);
                		sold.setInt(2,auc);
                		sold.setString(3,msg3);
                		sold.setString(4,msg4);
                		sold.executeUpdate();
                	}
                }
            }
            
        }
        response.sendRedirect("MainAuctionBrowse.jsp");
%>
</html>