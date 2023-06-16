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
		// Statement stmt = conn.createStatement();

		// Step 5: Execute SQL Command
		String sqlStr = "SELECT g.genre_name, a.author_name, p.publisher_name, b.* FROM books b	JOIN genres g ON b.genre_id = g.genre_id JOIN authors a ON b.author_id = a.author_id JOIN publishers p ON b.publisher_id = p.publisher_id WHERE book_id=?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, id);
		ResultSet rs = pstmt.executeQuery();

		// Step 6: Process Result
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

		/* List<String> genres = new ArrayList<>();
		String genre_name;

		while (rs.next()) {
			genre_name = rs.getString("genre_name");
			genres.add(genre_name);
		} */

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

				<%-- <select name="genreTest">
					<option value="0" selected>None Selected</option>
					<%
					/* List<String> genres = (List<String>) session.getAttribute("genres");
					List<Integer> genre_id = (List<Integer>) session.getAttribute("genre_ID"); */
					for (int i = 0; i < genres.size(); i++) {
						String genreStr = genres.get(i);
					%>
					<option value="<%=genreStr%>"><%=genreStr%></option>
					<%
					}
					%>
				</select> --%>

				<tr>
					<td style="padding: 5px;">genre:</td>
					<td style="padding: 5px;"><select name="genre">
							<option value="Fantasy">Fantasy</option>
							<option value="Science Fiction">Science Fiction</option>
							<option value="Mystery">Mystery</option>
					</select> <input type="hidden" name="oldGenre" value="<%=oldGenre%>">
					</td>
				</tr>
				<tr>
					<td style="padding: 5px;">author:</td>
					<td style="padding: 5px;"><select name="author">
							<option value="Isaac Asimov">Isaac Asimov</option>
							<option value="Agatha Christie">Agatha Christie</option>
							<option value="Stephen King">Stephen King</option>
							<option value="Gillan Flynn">Gillan Flynn</option>
					</select> <input type="hidden" name="oldAuthor" value="<%=oldAuthor%>">
					</td>
				</tr>
				<tr>
					<td style="padding: 5px;">publisher:</td>
					<td style="padding: 5px;"><select name="publisher">
							<option value="Penguin Random House">Penguin Random
								House</option>
							<option value="Simon & Schuster">Simon & Schuster</option>
							<option value="Macmillan Publishers">Macmillan
								Publishers</option>
							<option value="Hachette Book Group">Hachette Book Group</option>
					</select> <input type="hidden" name="oldPublisher" value="<%=oldPublisher%>">
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
					<td style="padding: 5px;">publication_date:</td>
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
		<br>
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