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
<title>Create Book</title>
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
	String genre = request.getParameter("genre");
	String author = request.getParameter("author");
	String publisher = request.getParameter("publisher");
	String title = request.getParameter("title");
	String price = request.getParameter("price");
	String quantity = request.getParameter("quantity");
	String description = request.getParameter("description");
	String publication_date = request.getParameter("publication_date");
	String ISBN = request.getParameter("ISBN");
	String rating = request.getParameter("rating");

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
		String sqlStr = "INSERT INTO books (genre_id, author_id, publisher_id, title, price, quantity, description, publication_date, ISBN, rating) SELECT (SELECT genre_id FROM genres WHERE genre_name=? LIMIT 1),(SELECT author_id FROM authors WHERE author_name=? LIMIT 1), (SELECT publisher_id FROM publishers WHERE publisher_name=? LIMIT 1),?,?,?,?,?,?,?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, genre);
		pstmt.setString(2, author);
		pstmt.setString(3, publisher);
		pstmt.setString(4, title);
		pstmt.setString(5, price);
		pstmt.setString(6, quantity);
		pstmt.setString(7, description);
		pstmt.setString(8, publication_date);
		pstmt.setString(9, ISBN);
		pstmt.setString(10, rating);

		int nRowsAffected = pstmt.executeUpdate();

		// Step 6: Process Result
		out.print("<div align='center'><h2>Create Book</h2>");
		if (nRowsAffected > 0) {
			out.print("Successfully created!");
		} else {
			out.print("Unsuccessful.");
		}

		// Step 7: Close connection
		conn.close();

	} catch (SQLException e) {
		out.print("Sorry, incorrect data.");
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