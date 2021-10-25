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
    out.println("<a href = 'newRepForm.jsp'>Create Representative Account");
    %>
    <br>
    <%
    out.println("<a href = 'salesReport.jsp'>View Sales Reports");
}
%>