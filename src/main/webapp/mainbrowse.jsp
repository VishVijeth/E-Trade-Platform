 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
    <head>
   	 <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
   	 <title>Main Page</title>
    </head>
    
    <body>   						   
   	 <br>
   	 Login:
   	 <br>
   	 <form method="get" action="login.jsp">
   	 <table>
   	 <tr>    
   	 <td>Username:</td><td><input type="text" name="Username"></td>
   	 </tr>
   	 <tr>
   	 <td>Password:</td><td><input type="text" name="Password"></td>
   	 </tr>
   	 </table>
   	 <input type="submit" value="Check Me">
   	 </form>
    <br>
   	 Create new Account:
    <br>
   	 <form method="post" action="create.jsp">
   	 <table>
   	 <tr>    
   	 <td>Username:</td><td><input type="text" name="Username"></td>
   	 </tr>
   	 <tr>
   	 <td>Password</td><td><input type="text" name="Password"></td>
   	 </tr>
   	 </table>
   	 <input type="submit" value="Create Me">
   	 </form>
    <br>
</body>
</html>
 