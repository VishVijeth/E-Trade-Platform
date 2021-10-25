<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*"%>
<%
	try{
		//Get the database connection
		Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keyboardpartauction",
            "root", "dPQmsdPwjddl660507");

		String UserID = request.getParameter("UserID");
		
		session.setAttribute("editUser", UserID);
		//Create a SQL statement
		Statement st = con.createStatement();
		ResultSet rs;
		rs = st.executeQuery("SELECT * FROM account WHERE userID='" + UserID + "'");
		
		if(rs.next()){
			out.print("Username:" + rs.getString(1));
			%><br><%
			out.print("Password:" + rs.getString(3));
			%><br><%
			out.print("Credit Card Number:" + rs.getString(4));
			%><br><%
			out.print("Email: " + rs.getString(5));
			%><br><%
			out.print("First Name: " + rs.getString(6));
			%><br><%
			out.print("Last Name: " + rs.getString(7));
			%><br><%
			out.print("Home Phone: " + rs.getString(8));
			%><br><%
			out.print("Cell Phone: " + rs.getString(9));
			%><br><%
			out.print("Street: " + rs.getString(10));
			%><br><%
			out.print("City: " + rs.getString(11));
			%><br><%
			out.print("State: " + rs.getString(12));
			%><br><%
			out.print("ZIP: " + rs.getString(13));
			%><br><%
			%>
			<br>
			Update Info:
	   	 <form method="post" action="updateUser.jsp">
	   	 <table>
	   	 <tr>
	   	 <td>Password:</td><td><input type="text" name="NewPassword"></td>
	   	 </tr>
	   	 <tr>
	   	 <td>Credit Card Number:</td><td><input type="text" name="NewCCN"></td>
	   	 </tr>
	   	 <tr>
	   	 <td>Email:</td><td><input type="text" name="NewEmail"></td>
	   	 </tr>
	   	 <tr>
	   	 <td>First Name:</td><td><input type="text" name="NewFN"></td>
	   	 </tr>
	   	 <tr>
	   	 <td>Last Name:</td><td><input type="text" name="NewLN"></td>
	   	 </tr>
	   	 <tr>
	   	 <td>Home Phone:</td><td><input type="text" name="NewHome"></td>
	   	 </tr>
	   	 <tr>
	   	 <td>Cell Phone:</td><td><input type="text" name="NewCell"></td>
	   	 </tr>
	   	 <tr>
	   	 <td>Street:</td><td><input type="text" name="NewStreet"></td>
	   	 </tr>
	   	 <tr>
	   	 <td>City:</td><td><input type="text" name="NewCity"></td>
	   	 </tr>
	   	 <tr>
	   	 <td>State:</td><td><input type="text" name="NewState"></td>
	   	 </tr>
	   	 <tr>
	   	 <td>ZIP:</td><td><input type="text" name="NewZIP"></td>
	   	 </tr>
	   	 </table>
	   	 <input type="submit" value="Submit">
	   	 </form>
	    	<br>
	    	<%
		}
		con.close();
	}
	catch(Exception e){
		out.print("Specified user was not found. <a href='editUserAcct.jsp'>Try Again</a>");
	}
%>