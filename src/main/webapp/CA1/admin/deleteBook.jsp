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
<title>Delete Book</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
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

	String id = request.getParameter("id");

	try {
		// Step1: Load JDBC Driver
		// Class.forName("com.mysql.cj.jdbc.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=root&serverTimezone=UTC";

		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);

		// Step 4: Create Statement object
		// Statement stmt = conn.createStatement();

		// Step 5: Execute SQL Command
		String sqlStr = "DELETE FROM books WHERE book_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, id);

		int nRowsAffected = pstmt.executeUpdate();

		// Step 6: Process Result
		out.print("<div align='center'><h2>Delete Book</h2>");
		if (nRowsAffected > 0) {
			out.print("Successfully deleted!");
		} else {
			out.print("Unsuccessful.");
		}

		// Step 7: Close connection
		conn.close();

	} catch (Exception e) {
		out.print("Error :" + e);
	}
	%>

	<br>
	<br>
	<a href='manageBooks.jsp'><button>Back</button></a>
	</div>
	<br>
	<%@include file="footer.html"%>
</body>
</html>