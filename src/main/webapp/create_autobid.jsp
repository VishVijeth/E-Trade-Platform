<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="java.sql.*"%>
	<%
	
		//Get the database connection
				Class.forName("com.mysql.jdbc.Driver");
				 ApplicationDB db = new ApplicationDB();	
    	 		Connection con = db.getConnection();
				//Get parameters from the HTML form at the index.jsp
				String auccid = request.getParameter("setupbid");
				String newID = (String) session.getAttribute("user");
				float initialbidprice = Float.parseFloat(request.getParameter("bidPrice"));
	            float newAutobid = Float.parseFloat(request.getParameter("autoBid"));
	            newAutobid = (float) Math.round(newAutobid * 100) / 100;
				float roundOff = (float) Math.round(newAutobid * 100) / 100;
				float highestprice = 0;
				float alertprice = 0;
				float startingbid = 0;
				float bidIncrement = 0;
				boolean alertSeller = false;
				boolean issue = false;
				boolean newWinner = false;
				String oldID = "";
				float oldMaximum = 0;
				boolean alreadyAlerted = false;
				int ended = 0;
				Statement stmt = con.createStatement();
				int auccint = Integer.parseInt(auccid);
				int noone = 0;
				ResultSet results = stmt.executeQuery("SELECT * FROM auction WHERE `auctionID`=" + auccid);
				//get items
				if(results.next()) { 
					highestprice = results.getFloat(5);
					alertprice = results.getFloat(8);
					startingbid = results.getFloat(7);
					bidIncrement = results.getFloat(4);
					ended = results.getInt(9);
				}
				ResultSet prevBids = stmt.executeQuery("SELECT * FROM sells where `auctionID` =" + auccid);
				String seller = "";
				if(prevBids.next()){
					seller = prevBids.getString(2);
				}
				if (highestprice > alertprice){
					alreadyAlerted = true;
				}
				Statement stmt2 = con.createStatement();
					if (!(highestprice == 0) && issue == false){
						ResultSet person = stmt2.executeQuery("SELECT * FROM bids WHERE auctionID = " + auccid + " AND bidPrice= " + highestprice);
						if(person.next()){
							oldID = person.getString(2);
							oldMaximum = person.getFloat(4);
						}else noone = 1;
						}
					
					if(noone == 1){
						if(initialbidprice > startingbid) highestprice = initialbidprice;
						else if (startingbid < roundOff) highestprice = roundOff;
						String stt = "UPDATE auction SET highestBid = " + Float.toString(highestprice) + " WHERE `auctionID`= " + auccid;
						stmt.executeUpdate(stt);
						
						String insert = "INSERT INTO bids(auctionID, userID, bidPrice, autoBidMax) VALUES (?, ?, ?, ?)";
						PreparedStatement pss = con.prepareStatement(insert);
						pss.setInt(1,auccint);
						pss.setString(2,newID);
						pss.setFloat(3,highestprice);
						pss.setFloat(4,roundOff);
						pss.executeUpdate();
						
						
						if (!alreadyAlerted && highestprice >= alertprice) {
							String msg = "Someone has bid over your reserve!" + Float.toString(highestprice);
							String msg2 = "A user has bid: " + Float.toString(highestprice) + " which is higher than your reserve/minimum price!";
							String in = "INSERT INTO alert(`userID`, `auctionID`, `alertType`, `alertMessage`, `productID`) VALUES (?, ?, ?, ?, 0)";
							PreparedStatement psss = con.prepareStatement(in);
							psss.setString(1,seller);
							psss.setInt(2,auccint);
							psss.setString(3,msg);
							psss.setString(4,msg2);
						}
					}
					
					else {
						int oldNew = 0;
						int ranonce = 0;
						while ((issue == false && (highestprice + bidIncrement < roundOff) && oldNew == 0) || (issue == false && (highestprice + bidIncrement < oldMaximum) && oldNew == 1)){
						ranonce = 1;
						//new buyer has priority
						if(oldNew == 0){
							oldNew++;
							if(highestprice + bidIncrement > initialbidprice) 
								highestprice += bidIncrement;
							else highestprice = initialbidprice;
							String stt = "UPDATE auction SET highestBid =" + Float.toString(highestprice) + "WHERE auctionID=" + auccid;
							PreparedStatement pres = con.prepareStatement(stt);
							pres.executeUpdate();
							
							
							String insert = "INSERT INTO bids(auctionID, userID, bidPrice, autoBidMax) VALUES (?, ?, ?, ?)";
							PreparedStatement pss = con.prepareStatement(insert);
							pss.setInt(1,auccint);
							pss.setString(2,newID);
							pss.setFloat(3,highestprice);
							pss.setFloat(4,roundOff);
							pss.executeUpdate();
							Statement stmtfix = con.createStatement();
							ResultSet notifyMe = stmtfix.executeQuery("SELECT DISTINCT userID FROM bids WHERE `auctionID` =" + auccid);
							String id = "";
			            	while(notifyMe.next()){
	                        	id = notifyMe.getString(1);
	                        	if (!id.equals(newID)){
	                        		String msg = "Someone has bid on an item!" + Float.toString(highestprice);
				            		String msg2 = "A user has bid: " + Float.toString(highestprice) + " which is now the leading price!";
				            		String in = "INSERT INTO alert(`userID`, `auctionID`, `alertType`, `alertMessage`, `productID`) VALUES (?, ?, ?, ?, 0)";
				            		PreparedStatement psss = con.prepareStatement(in);
				            		psss.setString(1,id);
				            		psss.setInt(2,auccint);
				            		psss.setString(3,msg);
				            		psss.setString(4,msg2);
	                        		psss.executeUpdate();
	                        	}
	                        }
			            }
								
						
						
						else{
						//oldBuyer takes the lead
							oldNew--;
							highestprice = highestprice + bidIncrement;
							
							String stt = "UPDATE auction SET highestBid =" + Float.toString(highestprice) + "WHERE auctionID=" + auccid;
							PreparedStatement pres = con.prepareStatement(stt);
							pres.executeUpdate();
							
							String insert = "INSERT INTO bids(auctionID,userID,bidPrice,autoBidMax) VALUES (?, ?, ?, ?)";
							PreparedStatement pss = con.prepareStatement(insert);
							pss.setInt(1,auccint);
							pss.setString(2,oldID);
							pss.setFloat(3,highestprice);
							pss.setFloat(4,oldMaximum);
							pss.executeUpdate();
	                   		Statement stmtfix = con.createStatement();
							ResultSet notifyMe = stmtfix.executeQuery("SELECT DISTINCT userid FROM bids WHERE auctionID =" + auccid);
							String id = "";
			            	while(notifyMe.next()){
	                        	id = notifyMe.getString(1);
	                        	if (!id.equals(newID)){
	                        		String msg = "Someone has bid on an item!" + Float.toString(highestprice);
				           			String msg2 = "A user has bid: " + Float.toString(highestprice) + " which is now the leading price!";
				            		String in = "INSERT INTO alert(`userID`, `auctionID`, `alertType`, `alertMessage`, `productID`) VALUES (?, ?, ?, ?, 0)";
				            		PreparedStatement psss = con.prepareStatement(in);
				            		psss.setString(1,id);
				            		psss.setInt(2,auccint);
				            		psss.setString(3,msg);
				            		psss.setString(4,msg2);
	                        		psss.executeUpdate();
	                        	}
			            	}
						}
				}//ends the large while loop
						
						
						
				if (!alreadyAlerted && highestprice >= alertprice) alertSeller = true;
				String message = "Outbid!"+ Float.toString(highestprice);
				String message2;
				if (oldNew == 0) {
					message2 = oldID + " has placed a bid of: " + Float.toString(highestprice) + " on auction: " + auccid + " which is higher than your upper limit!";
				}
				else message2 = newID + " has placed a bid of: " + Float.toString(highestprice) + " on auction: " + auccid + " which is higher than your upper limit!";
				if (!seller.equals(newID) && issue == false){
				String insertt = "INSERT INTO alert(`userID`, `auctionID`, `alertType`, `alertMessage`, `productID`) VALUES (?, ?, ?, ?, 0)";
				PreparedStatement psss = con.prepareStatement(insertt);
				if (oldNew==0){
					psss.setString(1,newID);
				}else psss.setString(1,oldID);
				psss.setInt(2,auccint);
				psss.setString(3,message);
				psss.setString(4,message2);
				}
				if(alertSeller == true){
					String msg = "Someone has bid over your reserve!" + Float.toString(highestprice);
					String msg2 = "A user has bid: " + Float.toString(highestprice) + " which is higher than your reserve/minimum price!";
					String in = "INSERT INTO alert(`userID`, `auctionID`, `alertType`, `alertMessage`, `productID`) VALUES (?, ?, ?, ?,0)";
					PreparedStatement psss = con.prepareStatement(in);
					psss.setString(1,seller);
					psss.setInt(2,auccint);
					psss.setString(3,msg);
					psss.setString(4,msg2);
				}
				con.close();
				out.print("Bid placed! Check your alerts to see if you have been outbid automatically!");
				response.sendRedirect("MainAuctionBrowse.jsp");
			}
		%>