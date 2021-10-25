<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sales Menu</title>
</head>
<body>
Generate Sales Report for:
<br>
<a href='totalEarnings.jsp'>Total Earnings</a>
<br>
<br>
<a href='topSellers.jsp'>Top Sellers</a>
<br>
<br>
<a href='topBuyers.jsp'>Top Buyers</a>
<br>
<br>
Specific User:
<br>
<form method="get" action="userEarnings.jsp">
   	 <table>
   	 <tr>    
   	 <td>User ID:</td><td><input type="text" name="UserID"></td>
   	 </tr>
   	 </table>
   	 <input type="submit" value="Submit">
   	 </form>
	<br>
<br>
Specific Item:
<br>
<form method="get" action="itemEarnings.jsp">
   	 <table>
   	 <tr>    
   	 <td>Product ID:</td><td><input type="text" name="ProductID"></td>
   	 </tr>
   	 </table>
   	 <input type="submit" value="Submit">
   	 </form>
	<br>
<br>
Item Type:
<br>
<form method="post" action="typeEarnings.jsp">
		<hr>
<label for="ptype">Choose a Product:&nbsp;</label>
        <select name="ptype" id="ptype">    
            <option value="none"selected disabled hidden>Select an Option</option>
            <option value="cases">Cases</option>
            <option value="keycaps">Keycaps</option>
            <option value="prebuilt">Prebuilt</option>
            <option value="pcb">PCB</option>
            <option value="switch">Switch</option>
        </select>
        <br>
        <input type="submit" value="Submit">
</form>
<br>
<br>
<a href = 'adminHome.jsp'>Back to Admin Home</a>
</body>
</html>