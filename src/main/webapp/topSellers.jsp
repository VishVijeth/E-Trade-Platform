<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*"%>
<%
///try{ 
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keyboardpartauction",
	           "root", "dPQmsdPwjddl660507");
	Statement st = con.createStatement();   
	ResultSet rs;
	String Query = "SELECT SUM(auction.highestBid) as earnings, winbids.sellerID FROM auction, winbids WHERE auction.ended = 1 AND auction.auctionID = winbids.aucID GROUP BY winbids.sellerID ORDER BY earnings DESC";
	rs = st.executeQuery(Query);
	
	int i = 3;
	while(i-- > 0 && rs.next()){
		out.print("Total Earnings for User " + rs.getString(2) + ": $" + rs.getFloat(1));
		%><br><%
	}
	%><br><%
	out.print("<a href='salesReport.jsp'>Back to Sales Report Menu</a>");

	con.close();
//}
//catch(Exception e){
//	out.print("An error occurred. <a href='salesReport.jsp'>Back to Sales Report Menu</a>");
//}
    
%>