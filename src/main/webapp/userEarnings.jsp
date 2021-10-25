<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*"%>
<%
//try{ 
	Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keyboardpartauction",
	           "root", "dPQmsdPwjddl660507");
	Statement st = con.createStatement();   
	ResultSet rs;
	String User = request.getParameter("UserID");
	String Query = "SELECT SUM(highestBid) FROM auction, sells WHERE auction.ended = 1 AND auction.auctionID = sells.auctionID AND sells.userID = '" + User + "'";
	rs = st.executeQuery(Query);
	
	while(rs.next()){
		out.print("Total Earnings for user " + User + ": $" + rs.getFloat(1));
	}
	%><br><%
	out.print("<a href='salesReport.jsp'>Back to Sales Report Menu</a>");

	con.close();
//}
//catch(Exception e){
//	out.print("An error occurred. <a href='salesReport.jsp'>Back to Sales Report Menu</a>");
//}
    
%>