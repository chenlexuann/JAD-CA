<!-- Author: Angie Toh Anqi
Class: DIT/FT/2A/02
Date: 8/6/2023
Description: ST0510/JAD Assignment 1 -->

<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Members</title>
</head>
<body>
	<%@include file="header.html"%>
	<%
	String dm_userID = (String) session.getAttribute("sessUserID");
	String dm_userRole = (String) session.getAttribute("sessUserRole");
	String dm_loginStatus = (String) session.getAttribute("loginStatus");

	if (dm_userID == null || !dm_loginStatus.equals("success")) {
		response.sendRedirect("login.jsp?errCode=sessionTimeOut");
	}
	%>
	<div align="center">
		<h2 align="center">Manage Members</h2>
		<button onclick="window.location.href='createMemberForm.jsp'">Create
			new Member</button>
		<br> <br>

		<%
		String msg = "";
		try {
			int id;
			String first_name = "";
			String last_name = "";
			String email = "";
			String password = "";

			// Step1: Load JDBC Driver
			// Class.forName("com.mysql.cj.jdbc.Driver");

			// Step 2: Define Connection URL
			String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=T0513022G&serverTimezone=UTC";

			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Step 4: Create Statement object
			Statement stmt = conn.createStatement();

			// Step 5: Execute SQL Command
			String sqlStr = "SELECT * FROM members";
			ResultSet rs = stmt.executeQuery(sqlStr);

			// Step 6: Process Result

			out.print("<table border='1' align='center' style='border-collapse: collapse; text-align: center;'>");
			out.print(
			"<tr><th style='padding: 5px;'>id</th><th style='padding: 5px;'>first name</th><th style='padding: 5px;'>last name</th><th style='padding: 5px;'>email</th><th style='padding: 5px;'>password</th><th colspan='2' style='padding: 5px;'>action</th></tr>");

			while (rs.next()) {
				id = rs.getInt("member_id");
				first_name = rs.getString("first_name");
				last_name = rs.getString("last_name");
				email = rs.getString("email");
				password = rs.getString("password");

				out.print("<tr><td style='padding: 5px;'>" + id + "</td><td style='padding: 5px;'>" + first_name
				+ "</td><td style='padding: 5px;'>" + last_name + "</td><td style='padding: 5px;'>" + email
				+ "</td><td style='padding: 5px;'>" + password + "</td>");
				out.print("<td style='padding: 5px;'><a href='editMember.jsp?id=" + id + "&first_name=" + first_name
				+ "&last_name=" + last_name + "&email=" + email + "&password=" + password
				+ "'><button>edit</button></a></td><td style='padding: 5px;'><button style='background-color: red; color: white;' onclick='confirmDelete()'>delete</button></a></td></tr>");

				msg = "deleteMember.jsp?id=" + id;
			}
			out.print("</table>");

			// Step 7: Close connection
			conn.close();

		} catch (Exception e) {
			out.print("Error :" + e);
		}
		%>

		<br>
		<button onclick="window.location.href='menu.jsp'">Back to
			Menu</button>
	</div>
	<br>
	<br>
	<%@include file="footer.html"%>
</body>
<script>
	function confirmDelete() {
		if(confirm("Are you sure you want to delete this member?")){ // if user clicks "OK"
			var msg = "<%=msg%>"; // due to separation between server side and client side code
			window.location.href = msg;
		} else {
			// do nothing
		}
	}
</script>
</html>