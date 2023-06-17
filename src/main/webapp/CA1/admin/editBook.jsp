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
<title>Edit Book</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
</head>
<body>
	<%@page import="java.sql.*"%>
	<%@page import="java.util.*"%>
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
		Statement stmt1 = conn.createStatement();
		Statement stmt2 = conn.createStatement();
		Statement stmt3 = conn.createStatement();

		// Step 5: Execute SQL Command
		String sqlStr = "SELECT g.genre_name, a.author_name, p.publisher_name, b.* FROM books b	JOIN genres g ON b.genre_id = g.genre_id JOIN authors a ON b.author_id = a.author_id JOIN publishers p ON b.publisher_id = p.publisher_id WHERE book_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();

		// Create SQL statement that retrieves all genres for genres array
		String sqlStrGenre = "SELECT * FROM genres;";
		ResultSet rsGenre = stmt1.executeQuery(sqlStrGenre);

		// Create SQL statement that retrieves all authors for authors array
		String sqlStrAuthor = "SELECT * FROM authors;";
		ResultSet rsAuthor = stmt2.executeQuery(sqlStrAuthor);

		// Create SQL statement that retrieves all publishers for publishers array
		String sqlStrPublisher = "SELECT * FROM publishers;";
		ResultSet rsPublisher = stmt3.executeQuery(sqlStrPublisher);

		// Step 6: Process Result
		List<String> genres = new ArrayList<>();
		List<String> authors = new ArrayList<>();
		List<String> publishers = new ArrayList<>();

		if (rs.next()) {
			genre = rs.getString("genre_name");
			author = rs.getString("author_name");
			publisher = rs.getString("publisher_name");
			title = rs.getString("title");
			price = rs.getString("price");
			quantity = rs.getString("quantity");
			description = rs.getString("description");
			publication_date = rs.getString("publication_date");
			ISBN = rs.getString("ISBN");
			rating = rs.getString("rating");
		}

		String oldGenre = genre;
		String oldAuthor = author;
		String oldPublisher = publisher;
		String oldTitle = title;
		String oldPrice = price;
		String oldQuantity = quantity;
		String oldDescription = description;
		String oldPublicationDate = publication_date;
		String oldISBN = ISBN;
		String oldRating = rating;

		while (rsGenre.next()) {
			genre = rsGenre.getString("genre_name");
			genres.add(genre);
		}

		while (rsAuthor.next()) {
			author = rsAuthor.getString("author_name");
			authors.add(author);
		}

		while (rsPublisher.next()) {
			publisher = rsPublisher.getString("publisher_name");
			publishers.add(publisher);
		}
	%>

	<div align="center">
		<h2>Edit Book</h2>
		<form action="updateBook.jsp" method="POST">
			<table border="1" style="border-collapse: collapse;">
				<tr>
					<td style="padding: 5px;">id:</td>
					<td style="padding: 5px;"><input type="text" name="id"
						value="<%=id%>" readonly="readonly" style="padding: 3px;"></td>
				</tr>
				<tr>
					<td style="padding: 5px;">genre:</td>
					<td style="padding: 5px;"><select name="genre">
							<option value="<%=oldGenre%>" selected><%=oldGenre%></option>
							<%
							for (int i = 0; i < genres.size(); i++) {
								String genreStr = genres.get(i);
							%>
							<option value="<%=genreStr%>"><%=genreStr%></option>
							<%
							}
							%>
					</select><input type="hidden" name="oldGenre" value="<%=oldGenre%>">
					</td>
				</tr>
				<tr>
					<td style="padding: 5px;">author:</td>
					<td style="padding: 5px;"><select name="author">
							<option value="<%=oldAuthor%>" selected><%=oldAuthor%></option>
							<%
							for (int i = 0; i < authors.size(); i++) {
								String authorStr = authors.get(i);
							%>
							<option value="<%=authorStr%>"><%=authorStr%></option>
							<%
							}
							%>
					</select><input type="hidden" name="oldAuthor" value="<%=oldAuthor%>">
					</td>
				</tr>
				<tr>
					<td style="padding: 5px;">publisher:</td>
					<td style="padding: 5px;"><select name="publisher">
							<option value="<%=oldPublisher%>" selected><%=oldPublisher%></option>
							<%
							for (int i = 0; i < publishers.size(); i++) {
								String publisherStr = publishers.get(i);
							%>
							<option value="<%=publisherStr%>"><%=publisherStr%></option>
							<%
							}
							%>
					</select><input type="hidden" name="oldPublisher" value="<%=oldPublisher%>">
					</td>
				</tr>
				<tr>
					<td style="padding: 5px;">title:</td>
					<td style="padding: 5px;"><input type="text" name="title"
						value="<%=title%>" style="padding: 3px;"> <input
						type="hidden" name="oldTitle" value="<%=oldTitle%>"></td>
				</tr>
				<tr>
					<td style="padding: 5px;">price:</td>
					<td style="padding: 5px;"><input type="text" name="price"
						value="<%=price%>" style="padding: 3px;"> <input
						type="hidden" name="oldPrice" value="<%=oldPrice%>"></td>
				</tr>
				<tr>
					<td style="padding: 5px;">quantity:</td>
					<td style="padding: 5px;"><input type="text" name="quantity"
						value="<%=quantity%>" style="padding: 3px;"> <input
						type="hidden" name="oldQuantity" value="<%=oldQuantity%>"></td>
				</tr>
				<tr>
					<td style="padding: 5px;">description:</td>
					<td style="padding: 5px;"><input type="text"
						name="description" value="<%=description%>" style="padding: 3px;">
						<input type="hidden" name="oldDescription"
						value="<%=oldDescription%>"></td>
				</tr>
				<tr>
					<td style="padding: 5px;">publication date:</td>
					<td style="padding: 5px;"><input type="text"
						name="publication_date" value="<%=publication_date%>"
						style="padding: 3px;"> <input type="hidden"
						name="oldPublicationDate" value="<%=oldPublicationDate%>"></td>
				</tr>
				<tr>
					<td style="padding: 5px;">ISBN:</td>
					<td style="padding: 5px;"><input type="text" name="ISBN"
						value="<%=ISBN%>" style="padding: 3px;"> <input
						type="hidden" name="oldISBN" value="<%=oldISBN%>"></td>
				</tr>
				<tr>
					<td style="padding: 5px;">rating:</td>
					<td style="padding: 5px;"><select name="rating">
							<option value="<%=oldRating%>" selected><%=oldRating%></option>
							<option value="G">G</option>
							<option value="PG">PG</option>
							<option value="PG-13">PG-13</option>
							<option value="R">R</option>
							<option value="NC-17">NC-17</option>
					</select> <input type="hidden" name="oldRating" value="<%=oldRating%>"></td>
				</tr>
				<tr>
					<td colspan="2" align="center" style="padding: 5px;"><input
						type="submit" value="Update"></td>
				</tr>
			</table>
		</form>
		<br> <a href='manageBooks.jsp'><button>Back</button></a> <br>
	</div>

	<%
	// Step 7: Close connection
	conn.close();

	} catch (Exception e) {
	out.print("Error :" + e);
	}
	%>
	<%@include file="footer.html"%>
</body>
</html>