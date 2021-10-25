<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Create Representative Account</title>
</head>
<body>
	<%
	try {
		//Get the database connection
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keyboardpartauction",
            "root", "dPQmsdPwjddl660507");

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the index.jsp
		String newUser = request.getParameter("Username");
		String newPW = request.getParameter("Password");


		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO Account(userID, password, accType) VALUES (?, ?, 1)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, newUser);
		ps.setString(2, newPW);
		
		ps.executeUpdate();
		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("A representative user account insert succeeded!");
		out.print("<a href = 'adminHome.jsp'>Back to Admin Home</a>");
		
	} catch (Exception ex) {
		out.print("An account with entered username exists already. <a href='newRepForm.jsp'>Try again</a>");
	}
%>
</body>
</html>