<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
Edit User Information:
 <br>
  Enter the User ID you wish to edit:
  <br>
  <form method="get" action="editUserDetails.jsp">
   	 <table>
   	 <tr>    
   	 <td>User ID:</td><td><input type="text" name="UserID"></td>
   	 </tr>
   	 </table>
   	 <input type="submit" value="Submit">
   	 </form>
  <br>
  <%out.print("<a href = 'repHome.jsp'>Back to Representative Home</a>");%>