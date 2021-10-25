<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>

<%@ page import="java.io.*,java.util.*,java.sql.*,java.util.Date"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
    <%
    try{
        ApplicationDB db = new ApplicationDB();	
	    Connection con = db.getConnection();
	    Statement stmt = con.createStatement();

        int enter = 1;
        
        // Generate New Product ID
        int productID = 0;

        ResultSet rs1;
        rs1 = stmt.executeQuery("select MAX(productID) from keyboardpart");

        if(rs1.next()){
            productID = rs1.getInt(1) + 1;
        }

        // Insert into KeyboardPart
        String name = request.getParameter("name");
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        String brand = request.getParameter("brand");
        String cond = request.getParameter("condition");
        String piclink = request.getParameter("piclink");

        String insert1 = "INSERT INTO keyboardpart(productID, name, quantity, brand, `condition`, piclink) VALUES (?, ?, ?, ?, ?, ?)";
        PreparedStatement ps1 = con.prepareStatement(insert1);

        ps1.setInt(1, productID);
        ps1.setString(2, name);
        ps1.setInt(3, quantity);
        ps1.setString(4, brand);
        ps1.setString(5, cond);
        ps1.setString(6, piclink);
		
        String productType = request.getParameter("ptype");
        
        // Prepare Inserts for the other product Type
        if(productType == null){
            con.close();
            enter = 0;
            out.print("Your Auction could not be created because you didn't choose a Keyboard Part. <a href='auction.jsp'>Try again</a>");
        }
        else if(productType.equals("cases")){
            String material = request.getParameter("material");
            String color = request.getParameter("color");

            String insert2 = "INSERT INTO cases(productID, material, color) VALUES(?, ?, ?)";
            PreparedStatement ps2 = con.prepareStatement(insert2);

            ps2.setInt(1, productID);
            ps2.setString(2, material);
            ps2.setString(3, color);
            ps2.executeUpdate();
        }
        else if(productType.equals("keycaps")){
            String profile = request.getParameter("profile");
            String material = request.getParameter("material");

            String insert2 = "INSERT INTO keycaps(productID, profile, material) VALUES(?, ?, ?)";
            PreparedStatement ps2 = con.prepareStatement(insert2);

            ps2.setInt(1, productID);
            ps2.setString(2, profile);
            ps2.setString(3, material);
            ps2.executeUpdate();
        }
        else if(productType.equals("prebuilt")){
            int layout = Integer.parseInt(request.getParameter("layout"));

            String insert2 = "INSERT INTO prebuilt(productID, layout) VALUES(?, ?)";
            PreparedStatement ps2 = con.prepareStatement(insert2);

            ps2.setInt(1, productID);
            ps2.setInt(2, layout);
            ps2.executeUpdate();
        }
        else if(productType.equals("pcb")){
            String type = request.getParameter("type");
            int layout = Integer.parseInt(request.getParameter("layout")); 
            int viaSupport = Integer.parseInt(request.getParameter("viaSupport"));

            String insert2 = "INSERT INTO pcb(productID, type, layout, viaSupport) VALUES(?, ?, ?, ?)";
            PreparedStatement ps2 =con.prepareStatement(insert2);

            ps2.setInt(1, productID);
            ps2.setString(2, type);
            ps2.setInt(3, layout);
            ps2.setInt(4, viaSupport);
            ps2.executeUpdate();
        }
        else if(productType.equals("switch")){
            String type = request.getParameter("type");
            int actuationForce = Integer.parseInt(request.getParameter("actuationForce"));

            String insert2 = "INSERT INTO switch(productID, type, actuationForce) VALUES(?, ?, ?)";
            PreparedStatement ps2 =con.prepareStatement(insert2);

            ps2.setInt(1, productID);
            ps2.setString(2, type);
            ps2.setInt(3, actuationForce);
            ps2.executeUpdate();
        }

        if(enter == 1){
            ps1.executeUpdate();
            con.close();
		    out.print("Your Product has been succesfully created!");
            out.print("<a href = 'MainAuctionBrowse.jsp'> Back to Home Page</a>");
        }
		
	} 
    catch (Exception ex) {
		out.print("Your Product could not be created. <a href='product.jsp'>Try again</a>");
	}
    %>
</body>
</html>