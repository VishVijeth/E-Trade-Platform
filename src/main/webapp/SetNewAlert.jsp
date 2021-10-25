<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
ApplicationDB db = new ApplicationDB();	
Class.forName("com.mysql.jdbc.Driver");
Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keyboardpartauction",
        "root", "dPQmsdPwjddl660507");
Statement st = con.createStatement();

String userID = (String) session.getAttribute("user");
String prodid = request.getParameter("ProductID");
String newAdr = "ItemDetails.jsp?productID=" + prodid;

String checkExistingAlert = "select * from alert where userID = '"+userID+"' AND productID = "+prodid+" AND auctionID = 99999;";
ResultSet rst = st.executeQuery(checkExistingAlert);
rst.beforeFirst();
if (rst.next()){ %>
    <p>
	<a href='<%=newAdr%>'>You already have an existing alert. Click here to go back to item page</a>
</p>
<% }
else{
    String setNewAlert =  "insert into alert (alertType, alertmessage, productID, userID, auctionID) values ('Interested', 'Item you are interested in is available: "+prodid+"', " + prodid + ",'" + userID +"', 99999)";

    st.executeUpdate(setNewAlert);
    %>
    <p>
		<a href='<%=newAdr%>'>Alert Successfully set, Click here to go back to item page!</a>
	</p>
	<% 
}
db.closeConnection(con); 
%>


</body>
</html>