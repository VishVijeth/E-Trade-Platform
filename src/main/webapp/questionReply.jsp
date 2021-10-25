<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*"%>
<%
	String TicketID = request.getParameter("TicketID");
	String Reply = request.getParameter("Reply");
	Reply = Reply.replace("'", "\\'");

    Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keyboardpartauction",
            "root", "dPQmsdPwjddl660507");
    Statement st = con.createStatement();
    String Rep = (String) session.getAttribute("user");
    
    try{
    	String Insert = "UPDATE Ticket SET reply='" + Reply + "', rep='" + Rep + "' WHERE ticketID='" + TicketID + "'";
    	PreparedStatement ps = con.prepareStatement(Insert);
    	ps.executeUpdate();
    	response.sendRedirect("questionMenu.jsp");
    }
    catch(Exception e){
    	out.print("An error occurred. <a href='questionMenu.jsp'>Back to Customer Questions</a>");
    }
    
    con.close();
    
%>