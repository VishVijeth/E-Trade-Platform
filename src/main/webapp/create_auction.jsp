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
    String productID = request.getParameter("setupauction");
    
    try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
        
        // Preparing 1st Insert into "auction"
        int auctionID = 0;

        ResultSet rs;
        rs = stmt.executeQuery("select MAX(auctionID) from auction");

        if(rs.next()){
            auctionID = rs.getInt(1) + 1;
        }
        
        String bidEndTime = request.getParameter("bidEndTime");
        String bidStartTime = request.getParameter("bidStartTime");
        String minPrice = request.getParameter("minPrice");
        
        float minInsert = 0;
        
        if(minPrice == null){
        	minInsert = -1;
        }
        else{
        	minInsert = Float.parseFloat(minPrice);
        }
        
        float bidIncrement = Float.parseFloat(request.getParameter("bidIncrement"));
        float highestBid = 0;
        float startingBid = Float.parseFloat(request.getParameter("startingPrice"));
        
        String insert1 = "INSERT INTO auction(auctionID, bidEndTime, bidStartTime, bidIncrement, highestBid, minPrice, startingBid, ended) VALUES (?, ?, ?, ?, ?, ?, ?, 0)";

        PreparedStatement ps1 = con.prepareStatement(insert1);

        ps1.setInt(1, auctionID);
        ps1.setString(2, bidEndTime);
        ps1.setString(3, bidStartTime);
        ps1.setFloat(4, bidIncrement);
        ps1.setFloat(5, highestBid);
        ps1.setFloat(6, minInsert);
        ps1.setFloat(7, startingBid);

        // Preparing 2nd Insert into "listed"
        int productID1 = Integer.parseInt(productID);

        String insert2 = "INSERT INTO listed(auctionID, productID) VALUES(?, ?)";

        PreparedStatement ps2 = con.prepareStatement(insert2);

        ps2.setInt(1, auctionID);
        ps2.setInt(2, productID1);
 
        // 3rd insert into "sells"
        String userID = (String) session.getAttribute("user");
        String insert3 = "INSERT INTO sells(auctionID, userID) VALUES(?, ?)";

        PreparedStatement ps3 = con.prepareStatement(insert3);
        ps3.setInt(1, auctionID);
        ps3.setString(2, userID);

        
        String updateAlert = "update alert set auctionID =" +auctionID +" where productID =" + productID+ " AND auctionID = 99999";
        PreparedStatement ps4 = con.prepareStatement(updateAlert);
        ps4.executeUpdate();
        
        ps1.executeUpdate();
        ps2.executeUpdate();
        ps3.executeUpdate();
        con.close();
		out.print("Your auction has been succesfully created!");
        out.print("<a href = 'MainAuctionBrowse.jsp'> Back to Home Page</a>");
	
	} 
    catch (Exception ex) {
		out.print("Your Auction could not be created. <a href='auction.jsp'>Try again</a>");
	}
%>
</body>
</html>