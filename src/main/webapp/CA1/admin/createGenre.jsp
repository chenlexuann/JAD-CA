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
<title>Create Genre</title>
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

	String genre = request.getParameter("genre");
	String[] titles = request.getParameterValues("titles");

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
		String sqlStr = "INSERT INTO genres (genre_name) VALUES (?)";
		PreparedStatement pstmt1 = conn.prepareStatement(sqlStr);
		pstmt1.setString(1, genre);

		int nRowsAffected1 = pstmt1.executeUpdate();

		if (titles != null) {
			String sqlStrTitles = "UPDATE books SET genre_id = (SELECT genre_id FROM genres WHERE genre_name = ?) WHERE title = ?";
			int count = 1;
			while (count < titles.length) {
		sqlStrTitles += " OR title = ?";
		count++;
			}

			PreparedStatement pstmt2 = conn.prepareStatement(sqlStrTitles);
			pstmt2.setString(1, genre);
			for (int i = 0; i < count; i++) {
		pstmt2.setString((i + 2), titles[i]);
			}
			int nRowsAffected2 = pstmt2.executeUpdate();
		}

		// Step 6: Process Result
		out.print("<div align='center'><h2>Create Genre</h2>");
		if (nRowsAffected1 > 0) {
			out.print("Successfully created!");
		} else {
			out.print("Unsuccessful.");
		}

		// Step 7: Close connection
		conn.close();

	} catch (SQLIntegrityConstraintViolationException e) {
		out.print("Sorry, this genre already exists.");
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