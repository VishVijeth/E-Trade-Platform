 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
<script type="text/javascript">
    $(function () {
        $("#ptype").change(function () {
            if ($(this).val() == "cases") {
				
				$("#d_material").show();
				$("#d_color").show();

				$("#d_profile").hide();
				$("#d_layout").hide();
				$("#d_type").hide();
				$("#d_viaSupport").hide();
				$("#d_actuationForce").hide();
            } 
			else if($(this).val() == "keycaps"){
				$("#d_profile").show();
				$("#d_material").show();

				$("#d_color").hide();
				$("#d_layout").hide();
				$("#d_type").hide();
				$("#d_viaSupport").hide();
				$("#d_actuationForce").hide();
			}
			else if($(this).val() == "prebuilt"){
				$("#d_layout").show();

				$("#d_color").hide();
				$("#d_profile").hide();
				$("#d_material").hide();
				$("#d_type").hide();
				$("#d_viaSupport").hide();
				$("#d_actuationForce").hide();
			}
			else if($(this).val() == "pcb"){
				$("#d_type").show();
				$("#d_layout").show();
                $("#d_viaSupport").show();

				$("#d_color").hide();
				$("#d_profile").hide();
				$("#d_material").hide();
				$("#d_actuationForce").hide();
            }
			else if($(this).val() == "switch"){
				$("#d_type").show();
				$("#d_actuationForce").show();

				$("#d_layout").hide();
                $("#d_viaSupport").hide();
				$("#d_color").hide();
				$("#d_profile").hide();
				$("#d_material").hide();
            }
			else{
				$("#d_layout").hide();
				$("#d_material").hide();
				$("#d_color").hide();
				$("#d_type").hide();
				$("#d_profile").hide();
				$("#d_viaSupport").hide();
				$("#d_actuationForce").hide();
			}
        });
    });
</script>

<html>
    <head>
   	 	<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
   	 	<title>Auction Page</title>
    </head>
    
    <body> 
		<br>  						   
   	 	Create a new Product:
        <br>
        <hr>
        Keyboard Part Information:
        <br>
        <form method="post" action="create_product.jsp">
        
        <table>
        <tr>
		<td>Name:&nbsp;</td><td><input type="text" name="name" required></td>
		</tr>

		<tr>
		<td>Quantity:&nbsp;</td><td><input type="number" name="quantity" required></td>
		</tr>

		<tr>
		<td>Brand:&nbsp;</td><td><input type="text" name="brand" required></td>
		</tr>

		<tr>
		<td>Condition:&nbsp;</td><td><input type="text" name="condition" required></td>
		</tr>
		<tr>
		<td>Picture Link:&nbsp;</td><td><input type="text" name="piclink" required></td>
		</tr>
        
        </table>
		<hr>
		
		<label for="ptype">Choose a keyboard Part:&nbsp;</label>
		<select name="ptype" id="ptype">	
			<option value="none"selected disabled hidden>Select an Option</option>
			<option value="keycaps">Keycaps</option>
			<option value="cases">Cases</option>
			<option value="prebuilt">Prebuilt</option>
			<option value="pcb">PCB</option>
			<option value="switch">Switch</option>
		</select>
		<br>

		<table>

		<%-- Keycaps --%>
		<tr id = "d_profile">
		<td>Profile:&nbsp;</td><td><input type="text" name="profile"></td>
		</tr>

		<tr id = "d_material">
		<td>Material:&nbsp;</td><td><input type="text" name="material"></td>
		</tr>

		<%-- Cases --%>
		<tr id = "d_color">
		<td>Color:&nbsp;</td><td><input type="text" name="color"></td>
		</tr>

		<%-- PCB --%>
		<tr id = "d_type">
		<td>Type:&nbsp;</td><td><input type="text" name="type"></td>
		</tr>

		<tr id = "d_layout">
		<td>Layout:&nbsp;</td><td><input type="number" name="layout"></td>
		</tr>

		<tr id = "d_viaSupport">
		<td>Via Support:&nbsp;</td><td><input type="number" name="viaSupport"></td>
		</tr>

		<%-- Prebuilt (Just Layout) --%> 

		<%-- Switch --%>
		<tr id = "d_actuationForce">
		<td>Actuation Force:&nbsp;</td><td><input type="number" name="actuationForce"></td>
		</tr>

		</table>

        <br>
   	 	<input type="submit" value="Create Product !">
   	 	</form>
    <br>
    <a href='MainAuctionBrowse.jsp'>Back</a>
</body>
</html>