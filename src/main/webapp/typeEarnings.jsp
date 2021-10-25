<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*"%>
<%
try{ 
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keyboardpartauction",
	           "root", "dPQmsdPwjddl660507");
	Statement st = con.createStatement();   
	ResultSet rs;
	String ProductType = request.getParameter("ptype");
	String Query;
	if(ProductType.equals("cases")){
		Query = "SELECT SUM(highestBid) FROM auction, cases, listed WHERE auction.ended = 1 AND auction.auctionID = listed.auctionID AND listed.productID = cases.productID";
	}
	else if(ProductType.equals("keycaps")){
		Query = "SELECT SUM(highestBid) FROM auction, keycaps, listed WHERE auction.ended = 1 AND auction.auctionID = listed.auctionID AND listed.productID = keycaps.productID";
	}
	else if(ProductType.equals("prebuilt")){
		Query = "SELECT SUM(highestBid) FROM auction, prebuilt, listed WHERE auction.ended = 1 AND auction.auctionID = listed.auctionID AND listed.productID = prebuilt.productID";
	}
	else if(ProductType.equals("pcb")){
		Query = "SELECT SUM(highestBid) FROM auction, pcb, listed WHERE auction.ended = 1 AND auction.auctionID = listed.auctionID AND listed.productID = pcb.productID";
	}
	else if(ProductType.equals("switch")){
		Query = "SELECT SUM(highestBid) FROM auction, switch, listed WHERE auction.ended = 1 AND auction.auctionID = listed.auctionID AND listed.productID = switch.productID";
	}
	else throw new Exception();
	rs = st.executeQuery(Query);
	
	while(rs.next()){
		out.print("Total Earnings for Product Type " + ProductType + ": $" + rs.getFloat(1));
	}
	%><br><%
	out.print("<a href='salesReport.jsp'>Back to Sales Report Menu</a>");

	con.close();
}
catch(Exception e){
	out.print("An error occurred. <a href='salesReport.jsp'>Back to Sales Report Menu</a>");
}
    
%>