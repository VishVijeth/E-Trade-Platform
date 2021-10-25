<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*"%>
<%
    String userid = request.getParameter("Username");   
    String pwd = request.getParameter("Password");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keyboardpartauction",
            "root", "dPQmsdPwjddl660507");
    Statement st = con.createStatement();
    ResultSet rs;
    rs = st.executeQuery("select * from Account where userID='" + userid + "' and password='" + pwd + "'");
    if (rs.next()) {
        session.setAttribute("user", userid);
        session.setAttribute("accType", rs.getInt(2));
        Integer type = (Integer) session.getAttribute("accType");
        if(type == 2){
        	response.sendRedirect("adminHome.jsp");
        }
        else if(type == 1){
        	response.sendRedirect("repHome.jsp");
        }
        else
        	response.sendRedirect("MainAuctionBrowse.jsp");
        /*     out.println("Welcome, " + userid + "! You are ");
        out.println("<a href='logout.jsp'>Click here to Log Out</a>");*/
        
    } else {
        out.println("Invalid password or username! <a href='main.jsp'>Try again</a>");
    }
%>