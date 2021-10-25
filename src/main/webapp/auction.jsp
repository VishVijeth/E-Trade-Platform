<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%String productID = request.getParameter("productID"); %>
<html>

    <head>
            <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
            <title>Auction Page</title>
    </head>
    
    <body> 
        <br>                             
            Create a new Auction:
        <br>
            <form method="post" action="create_auction.jsp?=productID"+>
        <hr>
        
            <table>
     <tr>    
            <td>Starting Price:</td><td><input type="number" name="startingPrice" required></td>
            </tr>
            
            <tr>    
            <td>Starting Bid Time:&nbsp;</td><td><input type="datetime-local" name="bidStartTime" required></td>
            </tr>

        <tr>    
            <td>Closing Bid Time:</td><td><input type="datetime-local" name="bidEndTime" required></td>
            </tr>
        
        <tr>    
            <td>Minimum Bid Increment:</td><td><input type="number" name="bidIncrement" required></td>
            </tr>

        <tr>
            <td>Minimum/Reserve Price:</td><td><input type="number" name="minPrice" ></td>
            </tr>

            </table>

        <br>
            <button name="setupauction" value=<%=productID%>>Set up Bid!</button>
            </form>
    <br>
</body>
</html>