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
<title>Update Account</title>
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

	String first_name = request.getParameter("first_name");
	String oldFirstName = request.getParameter("oldFirstName");
	String last_name = request.getParameter("last_name");
	String oldLastName = request.getParameter("oldLastName");
	String email = request.getParameter("email");
	String oldEmail = request.getParameter("oldEmail");
	String password = request.getParameter("password");
	String oldPassword = request.getParameter("oldPassword");

	out.print("<div align='center'><h2>Update Account</h2>");
	if (first_name.equals(oldFirstName) && last_name.equals(oldLastName) && email.equals(oldEmail)
			&& password.equals(oldPassword)) {
		out.print("No changes made<br>");
	} else {
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
			String sqlStr = "UPDATE members SET first_name=?, last_name=?, email=?, password=? WHERE email=?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, first_name);
			pstmt.setString(2, last_name);
			pstmt.setString(3, email);
			pstmt.setString(4, password);
			pstmt.setString(5, email);

			int nRowsAffected = pstmt.executeUpdate();

			// Step 6: Process Result
			if (nRowsAffected > 0) {
		out.print("Successfully updated!<br>");
			}

			// Step 7: Close connection
			conn.close();

		} catch (Exception e) {
			out.print("Error :" + e);
		}
	}
	%>

	<br>
	<a href='viewAccount.jsp'><button>Back</button></a>
	</div>
	<br>
	<%@include file="footer.html"%>
</body>
</html>