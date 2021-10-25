<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Question Form</title>
</head>
<body>
Have a question for a Customer Representative? Ask here!
<br>
<form method="post" action="submitQuestion.jsp">
   	 <table>
   	 <tr>    
   	 <td>Title:</td><td><input type="text" name="Title"></td>
   	 </tr>
   	 <tr>    
   	 <td>Body:</td><td><input type="text" name="Body"></td>
   	 </tr>
   	 </table>
   	 <input type="submit" value="Submit">
   	 </form>
	<br>
<br>
<a href='UserInfoPage.jsp'>Return</a>
</body>
</html>