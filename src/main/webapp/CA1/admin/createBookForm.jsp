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
<title>Create Book Form</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="../../home.jsp"> <img
			src="../../img/kittyLogo.png" width="auto" height="50"
			alt="kitty books">
		</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarNavDropdown">
			<ul class="navbar-nav">
				<li class="nav-item">
					<div class="mx-2">
						<form action='<%=request.getContextPath()%>/logoutUserServlet'
							class=logoutForm id="Logout">
							<button type="submit" class="btn btn-danger mr-2">Logout</button>
						</form>
					</div>
				</li>
				<li class="nav-item"><a class="nav-link active mx-2"
					aria-current="page" href="../../home.jsp">Home</a></li>
			</ul>
		</div>
	</nav>
	<%@page import="java.sql.*"%>
	<%@page import="java.util.*"%>
	<%
	String dm_userID = (String) session.getAttribute("sessUserID");
	String dm_userRole = (String) session.getAttribute("sessUserRole");
	String dm_loginStatus = (String) session.getAttribute("loginStatus");

	if (dm_userID == null || !dm_loginStatus.equals("success")) {
		response.sendRedirect("../../login.jsp?errCode=sessionTimeOut");
	}

	try {
		// Step1: Load JDBC Driver
		Class.forName("com.mysql.cj.jdbc.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=root&serverTimezone=UTC";

		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);

		// Step 4: Create Statement object
		Statement stmt1 = conn.createStatement();
		Statement stmt2 = conn.createStatement();
		Statement stmt3 = conn.createStatement(); // -----------------------------

		// Step 5: Execute SQL Command
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
		String genre = "";
		String author = "";
		String publisher = "";
		List<String> genres = new ArrayList<>();
		List<String> authors = new ArrayList<>();
		List<String> publishers = new ArrayList<>();

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
		<h2>Create Book</h2>
		<form action="<%=request.getContextPath()%>/createBookServlet">
			Genre: <select name="genre" style="margin-bottom: 10px;">
				<%
				for (int i = 0; i < genres.size(); i++) {
					String genreStr = genres.get(i);
				%>
				<option value="<%=genreStr%>"><%=genreStr%></option>
				<%
				}
				%>
			</select><br> Author: <select name="author" style="margin-bottom: 10px;">
				<%
				for (int i = 0; i < authors.size(); i++) {
					String authorStr = authors.get(i);
				%>
				<option value="<%=authorStr%>"><%=authorStr%></option>
				<%
				}
				%>
			</select><br> Publisher: <select name="publisher"
				style="margin-bottom: 10px;">
				<%
				for (int i = 0; i < publishers.size(); i++) {
					String publisherStr = publishers.get(i);
				%>
				<option value="<%=publisherStr%>"><%=publisherStr%></option>
				<%
				}
				%>
			</select><br> Title: <input type="text" name="title"
				style="margin-bottom: 10px;"><br> Price: <input
				type="text" name="price" style="margin-bottom: 10px;"><br>
			Quantity: <input type="text" name="quantity"
				style="margin-bottom: 10px;"><br>Description: <input
				type="text" name="description" style="margin-bottom: 10px;"><br>
			Publication Date (yyyy-mm-dd): <input type="text"
				name="publication_date" style="margin-bottom: 10px;"><br>
			ISBN: <input type="text" name="ISBN" style="margin-bottom: 10px;"><br>
			Image URL: <input type="text" name="image_url" style="margin-bottom: 10px;"><br>
			Rating: <select name="rating" style="margin-bottom: 10px;">
				<option value="G">G</option>
				<option value="PG">PG</option>
				<option value="PG-13">PG-13</option>
				<option value="R">R</option>
				<option value="NC-17">NC-17</option>
			</select><br> <br> <input type="submit" name="btnSubmit"
				value="Submit"> <input type="reset" name="btnReset"
				value="Reset">
		</form>
		<br>
		<button onclick="window.location.href='manageBooks.jsp'">Cancel</button>
	</div>

	<%
	// Step 7: Close connection
	conn.close();

	} catch (Exception e) {
	out.print("Error :" + e);
	}
	%>

	<br>
</body>
</html>