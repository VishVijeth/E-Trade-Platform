<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*"%>
<%
	String Title = request.getParameter("Title");
	String Body = request.getParameter("Body");
	Title = Title.replace("'", "\\'");
	Body = Body.replace("'", "\\'");

    Class.forName("com.mysql.jdbc.Driver");
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keyboardpartauction",
            "root", "dPQmsdPwjddl660507");
    Statement st = con.createStatement();
    String User = (String) session.getAttribute("user");
    ResultSet rs;
    
    
    try{
    	rs = st.executeQuery("select MAX(ticketID) from ticket");
    	rs.next();
    	String Insert = "INSERT INTO ticket(ticketID, ticketTitle, ticketInfo, user) VALUES (?, ?, ?, ?)";
    	PreparedStatement ps = con.prepareStatement(Insert);
    	ps.setInt(1, rs.getInt(1)+1);
		ps.setString(2, Title);
		ps.setString(3, Body);
		ps.setString(4, User);
    	ps.executeUpdate();
    	response.sendRedirect("askQuestion.jsp");
    }
    catch(Exception e){
    	out.print("An error occurred. <a href='askQuestion.jsp'>Back to Questions</a>");
    }
    
    con.close();
    
%>