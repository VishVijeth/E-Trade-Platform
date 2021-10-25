<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Remove Auction</title>
</head>
<body>
	<%
	try {
		//Get the database connection
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keyboardpartauction",
            "root","dPQmsdPwjddl660507");

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form
		String aucID = request.getParameter("AuctionID");

		//Make a delete statement for the auction table:
		String insert = "DELETE FROM auction WHERE auctionID='" + aucID + "'";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		ps.executeUpdate();
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("Auction successfully deleted.");
		out.print("<a href = 'repHome.jsp'>Back to Representative Home</a>");
		
	} catch (Exception ex) {
		out.print("Auction removal failed. <a href='removeMenu.jsp'>Try again</a>");
	}
%>
</body>
</html>