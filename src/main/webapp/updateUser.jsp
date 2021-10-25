<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*"%>
<%
try{
	Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/keyboardpartauction",
            "root", "dPQmsdPwjddl660507");
	
	String UserID = (String) session.getAttribute("editUser");
	String NewPassword = request.getParameter("NewPassword");
	String NewCCN = request.getParameter("NewCCN");
	String NewEmail = request.getParameter("NewEmail");
	String NewFN = request.getParameter("NewFN");
	String NewLN = request.getParameter("NewLN");
	String NewHome = request.getParameter("NewHome");
	String NewCell = request.getParameter("NewCell");
	String NewStreet = request.getParameter("NewStreet");
	String NewCity = request.getParameter("NewCity");
	String NewState = request.getParameter("NewState");
	String NewZIP = request.getParameter("NewZIP");
	
	
	if(!NewPassword.equals("")){
		Statement st = con.createStatement();
		String Insert = "UPDATE account SET password='" + NewPassword + "' WHERE userID='" + UserID + "'";
	    PreparedStatement ps = con.prepareStatement(Insert);
	    ps.executeUpdate();
	}
	if(!NewCCN.equals("")){
		Statement st = con.createStatement();
		String Insert = "UPDATE account SET creditCard='" + NewCCN + "' WHERE userID='" + UserID + "'";
	    PreparedStatement ps = con.prepareStatement(Insert);
	    ps.executeUpdate();
	}
	if(!NewEmail.equals("")){
		Statement st = con.createStatement();
		String Insert = "UPDATE account SET email='" + NewEmail + "' WHERE userID='" + UserID + "'";
	    PreparedStatement ps = con.prepareStatement(Insert);
	    ps.executeUpdate();
	}
	if(!NewFN.equals("")){
		Statement st = con.createStatement();
		String Insert = "UPDATE account SET name_first='" + NewFN + "' WHERE userID='" + UserID + "'";
	    PreparedStatement ps = con.prepareStatement(Insert);
	    ps.executeUpdate();
	}
	if(!NewLN.equals("")){
		Statement st = con.createStatement();
		String Insert = "UPDATE account SET name_last='" + NewLN + "' WHERE userID='" + UserID + "'";
	    PreparedStatement ps = con.prepareStatement(Insert);
	    ps.executeUpdate();
	}
	if(!NewHome.equals("")){
		Statement st = con.createStatement();
		String Insert = "UPDATE account SET phone_home='" + NewHome + "' WHERE userID='" + UserID + "'";
	    PreparedStatement ps = con.prepareStatement(Insert);
	    ps.executeUpdate();
	}
	if(!NewCell.equals("")){
		Statement st = con.createStatement();
		String Insert = "UPDATE account SET phone_cell='" + NewCell + "' WHERE userID='" + UserID + "'";
	    PreparedStatement ps = con.prepareStatement(Insert);
	    ps.executeUpdate();
	}
	if(!NewStreet.equals("")){
		Statement st = con.createStatement();
		String Insert = "UPDATE account SET address_street='" + NewStreet + "' WHERE userID='" + UserID + "'";
	    PreparedStatement ps = con.prepareStatement(Insert);
	    ps.executeUpdate();
	}
	if(!NewCity.equals("")){
		Statement st = con.createStatement();
		String Insert = "UPDATE account SET address_city='" + NewCity + "' WHERE userID='" + UserID + "'";
	    PreparedStatement ps = con.prepareStatement(Insert);
	    ps.executeUpdate();
	}
	if(!NewState.equals("")){
		Statement st = con.createStatement();
		String Insert = "UPDATE account SET address_state='" + NewState + "' WHERE userID='" + UserID + "'";
	    PreparedStatement ps = con.prepareStatement(Insert);
	    ps.executeUpdate();
	}
	if(!NewZIP.equals("")){
		Statement st = con.createStatement();
		String Insert = "UPDATE account SET address_zip='" + NewZIP + "' WHERE userID='" + UserID + "'";
	    PreparedStatement ps = con.prepareStatement(Insert);
	    ps.executeUpdate();
	}
	out.print("Info successfully updated. <a href = 'editUserAcct.jsp'>Return");
	con.close();
}
catch(Exception e){
	out.print("An error occurred.");
}
%>