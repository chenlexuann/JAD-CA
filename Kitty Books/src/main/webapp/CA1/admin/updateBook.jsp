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
<title>Update Book</title>
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
	String oldGenre = request.getParameter("oldGenre");
	String author = request.getParameter("author");
	String oldAuthor = request.getParameter("oldAuthor");
	String publisher = request.getParameter("publisher");
	String oldPublisher = request.getParameter("oldPublisher");
	String title = request.getParameter("title");
	String oldTitle = request.getParameter("oldTitle");
	String price = request.getParameter("price");
	String oldPrice = request.getParameter("oldPrice");
	String quantity = request.getParameter("quantity");
	String oldQuantity = request.getParameter("oldQuantity");
	String description = request.getParameter("description");
	String oldDescription = request.getParameter("oldDescription");
	String publication_date = request.getParameter("publication_date");
	String oldPublicationDate = request.getParameter("oldPublicationDate");
	String ISBN = request.getParameter("ISBN");
	String oldISBN = request.getParameter("oldISBN");
	String rating = request.getParameter("rating");
	String oldRating = request.getParameter("oldRating");

	out.print("<div align='center'><h2>Update Book</h2>");
	if (genre.equals(oldGenre) && author.equals(oldAuthor) && publisher.equals(oldPublisher) && title.equals(oldTitle)
			&& price.equals(oldPrice) && quantity.equals(oldQuantity) && description.equals(oldDescription)
			&& publication_date.equals(oldPublicationDate) && ISBN.equals(oldISBN) && rating.equals(oldRating)) {
		out.print("No changes made");
	} else {
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
			String sqlStr = "UPDATE books AS b SET genre_id = (SELECT genre_id FROM genres WHERE genre_name = ? LIMIT 1), author_id = (SELECT author_id FROM authors WHERE author_name = ? LIMIT 1), publisher_id = (SELECT publisher_id FROM publishers WHERE publisher_name = ? LIMIT 1), title = ?, price = ?, quantity = ?, description = ?, publication_date = ?, ISBN = ?, rating = ? WHERE book_id = ?;";
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
			pstmt.setString(11, id);

			int nRowsAffected = pstmt.executeUpdate();

			String simpleProc = "{call getBook(?)}";
			CallableStatement cs = conn.prepareCall(simpleProc);
			cs.setString(1, id);
			ResultSet rs = cs.executeQuery();

			// Step 6: Process Result
			if (nRowsAffected > 0) {
		out.print("Successfully updated!");
			} else {
		out.print("Unsuccessful.");
			}

			while (rs.next()) {
		out.print("<br><br>id: " + rs.getString("book_id") + "<br>");
		out.print("genre: " + rs.getString("genre_name") + "<br>");
		out.print("author: " + rs.getString("author_name") + "<br>");
		out.print("publisher: " + rs.getString("publisher_name") + "<br>");
		out.print("title: " + rs.getString("title") + "<br>");
		out.print("price: " + rs.getString("price") + "<br>");
		out.print("quantity: " + rs.getString("quantity") + "<br>");
		out.print("description: " + rs.getString("description") + "<br>");
		out.print("publication_date: " + rs.getString("publication_date") + "<br>");
		out.print("ISBN: " + rs.getString("ISBN") + "<br>");
		out.print("rating: " + rs.getString("rating"));
			}

			// Step 7: Close connection
			conn.close();

		} catch (SQLException e) {
			out.print("Sorry, incorrect data type.");
		} catch (Exception e) {
			out.print("Error :" + e);
		}
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