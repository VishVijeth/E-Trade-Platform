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
	           "root", "newCr0uton<>");
	Statement st = con.createStatement();   
	ResultSet rs;
	rs = st.executeQuery("SELECT SUM(highestBid) FROM auction WHERE auction.ended = 1");
	
	while(rs.next()){
		out.print("Total Earnings: $" + rs.getFloat(1));
	}
	%><br><%
	out.print("<a href='salesReport.jsp'>Back to Sales Report Menu</a>");

	con.close();
}
catch(Exception e){
	out.print("An error occurred. <a href='salesReport.jsp'>Back to Sales Report Menu</a>");
}
    
%>