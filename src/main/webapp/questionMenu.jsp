<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Question Menu</title>
</head>
<body>
	Customer Questions
	<br>
	Search by Keyword:
	<br>
	<form method="get" action="questionSearch.jsp">
   	 <table>
   	 <tr>    
   	 <td>Keyword:</td><td><input type="text" name="SearchKey"></td>
   	 </tr>
   	 </table>
   	 <input type="submit" value="Search">
   	 </form>
  	<br>
	<br>
	<%
	try {
		//Get the database connection
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keyboardpartauction",
            "root", "dPQmsdPwjddl660507");

		//Create a SQL statement
		Statement st = con.createStatement();

		ResultSet rs;
		rs = st.executeQuery("SELECT * FROM ticket");
		while (rs.next()){
			//Retrieve attributes from current row
			out.print("Ticket ID: " + rs.getInt(1) + ", posted by User " + rs.getString(4));
			%><br>
				<b><%
			//Title
			
			out.print(rs.getString(2));
			%>	</b>
			<br><%
			//Question info
			out.print(rs.getString(3));
			%><br><%
			//Test if response exists, then print
			if(rs.getString(5) != null){
				out.print("Response from representative " + rs.getString(5) + ":");
				%><br><%
				out.print(rs.getString(6));
				%><br><%
				%><br><%
			}
			else {
				out.print("> No representative response yet.");
				%><br><%
				%><br><%
			}
		}
		%>
		Respond to a Question:
		    <br>
		   	 <form method="post" action="questionReply.jsp">
		   	 <table>
		   	 <tr>    
		   	 <td>Ticket ID:</td><td><input type="text" name="TicketID"></td>
		   	 </tr>
		   	 <tr>
		   	 <td>Your Reply:</td><td><input type="text" name="Reply"></td>
		   	 </tr>
		   	 </table>
		   	 <input type="submit" value="Post Reply">
		   	 </form>
		    <br>
		<%		
		//Close the connection. Don't forget to do it, otherwise you're keeping the resources of the server allocated.
		con.close();
		out.print("<a href = 'repHome.jsp'>Back to Representative Home</a>");
		
	} catch (Exception ex) {
		out.print("Question DB connection failed. <a href='repHome.jsp'>Back to Representative Home</a>");
	}
%>
</body>
</html>