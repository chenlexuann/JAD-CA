<!-- Author: Angie Toh Anqi
Class: DIT/FT/2A/02
Date: 8/6/2023
Description: ST0510/JAD Assignment 1 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>View Account</title>
</head>
<body>
	<%@page import="java.sql.*"%>
	<%@include file="header.html"%>
	<%
	String dm_userID = (String) session.getAttribute("sessUserID");
	String dm_userRole = (String) session.getAttribute("sessUserRole");
	String dm_loginStatus = (String) session.getAttribute("loginStatus");

	if (dm_userID == null || !dm_loginStatus.equals("success")) {
		response.sendRedirect("login.jsp?errCode=sessionTimeOut");
	}

	out.print("<div align='center'><h2>View Account</h2>");
	out.print("Welcome " + dm_userID + "!<br>");
	out.print("Your user role is: " + dm_userRole + "<br><br>");

	String first_name = "";
	String last_name = "";
	String email = "";
	String password = "";

	try {
		// Step1: Load JDBC Driver
		// Class.forName("com.mysql.cj.jdbc.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=T0513022G&serverTimezone=UTC";

		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);

		// Step 4: Create Statement object
		// Statement stmt = conn.createStatement();

		// Step 5: Execute SQL Command
		String sqlStr = "SELECT * FROM members WHERE email=?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, dm_userID);
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Result
		if (rs.next()) {
			first_name = rs.getString("first_name");
			last_name = rs.getString("last_name");
			email = rs.getString("email");
			password = rs.getString("password");
		}

		// Step 7: Close connection
		conn.close();

	} catch (Exception e) {
		out.print("Error :" + e);
	}
	%>

	<div align="center">
		<form action="editAccount.jsp" method="POST">
			<table border="1" style="border-collapse: collapse;">
				<tr>
					<td style="padding: 5px;">first name:</td>
					<td style="padding: 5px;"><input type="text" name="first_name"
						value="<%=first_name%>" readonly="readonly" style="padding: 3px;"></td>
				</tr>
				<tr>
					<td style="padding: 5px;">last name:</td>
					<td style="padding: 5px;"><input type="text" name="last_name"
						value="<%=last_name%>" readonly="readonly" style="padding: 3px;"></td>
				</tr>
				<tr>
					<td style="padding: 5px;">email:</td>
					<td style="padding: 5px;"><input type="text" name="email"
						value="<%=email%>" readonly="readonly" style="padding: 3px;"></td>
				</tr>
				<tr>
					<td style="padding: 5px;">password:</td>
					<td style="padding: 5px;"><input type="text" name="password"
						value="<%=password%>" readonly="readonly" style="padding: 3px;"></td>
				</tr>
				<tr>
					<td colspan="2" align="center" style="padding: 5px;"><input
						type="submit" value="Edit" /></td>
				</tr>
			</table>
		</form>
		<br> <a href='login.jsp'><button>Log Out</button></a>
		<button style='background-color: red; color: white;'
			onclick='confirmDelete()'>Delete Account</button>
		</a>
	</div>
	<br>

	<%@include file="footer.html"%>
</body>
<script>
	function confirmDelete() {
		if(confirm("Are you sure you want to delete your account?")){ // if user clicks "OK"
			var email = "<%=email%>"; // due to separation between server side and client side code
			window.location.href = "deleteAccount.jsp?email=" + email;
		} else {
			// do nothing
		}
	}
</script>
</html>