 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
Alerts Page:
<hr>
<%
try{
    
    String userID = (String) session.getAttribute("user");

    ApplicationDB db = new ApplicationDB();    
    Connection con = db.getConnection();
    Statement stmt = con.createStatement();

    ResultSet rs;
    rs = stmt.executeQuery("select * from alert where userID = '" + userID + "'" + "order by(auctionID) desc" );

    int prev_id = 0;
    int curr_id = 0;

    while(rs.next()){
        
        curr_id = rs.getInt(2);

        if(curr_id == prev_id){
            out.print(rs.getString(4) + "\n");
            %>
            <br>
            <%
        }
        else{
            %>
            <br>
            <%
            out.print("\n AuctionID: " + Integer.toString(curr_id));           
            %>
            <br>
            <%
            out.print(rs.getString(4) + "\n");
            %>
            <br>
            <% 
        }
        prev_id = curr_id;
    }
    
    con.close();
    %>
    <br>
    <%
    out.print("<a href = 'UserInfoPage.jsp'> Back to Home Page</a>");
}
    
catch(Exception ex) {
    out.print("Your Alerts could not be displayed. <a href='UserInfoPage.jsp'>Try again</a>");
}
%>