<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
if ((session.getAttribute("user") == null)) {
    out.println("you arent logged in");
} else {
    String a = session.getAttribute("user");
    out.println("Welcome, " + session.getAttribute("user") + "!");
    out.println("<a href='logout.jsp'>Click here to Log Out</a>");
    out.println("<a href='MainAuctionBrowse.jsp'>Click here to browse auctions</a>");
}
%>

