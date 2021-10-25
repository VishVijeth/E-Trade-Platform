<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
if ((session.getAttribute("user") == null)) {
    out.println("You are logged out");
    out.println("<a href='main.jsp'>Try Again</a>");
} else {
    out.println("Welcome, " + session.getAttribute("user") + "!");
    %>
    <br>
    <%
    out.println("<a href='logout.jsp'>Log Out</a>");
    %>
    <br>
    <br>
    <%
    out.println("<a href='removeMenu.jsp'>Remove Auctions/Bids</a>");
    %>
    <br>
    <%
    out.println("<a href='questionMenu.jsp'>View Support Questions");
    %>
    <br>
    <%
    out.println("<a href='editUserAcct.jsp'>Edit Account Details");
}
%>