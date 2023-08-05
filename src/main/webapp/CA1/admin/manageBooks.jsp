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
<title>Manage Books</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<script>
<%String role = session.getAttribute("sessUserRole") + "";
String message = request.getParameter("statusCode");
if (message != null && message.equals("success")) {%>
	alert("Success!");
	<%}
if (message != null && message.equals("unsuccessful")) {%>
	alert("Something went wrong!");
	<%}
if (message != null && message.equals("duplicateBook")) {%>
	alert("This book already exists.");
	<%}
if (message != null && message.equals("duplicateGenre")) {%>
	alert("This genre already exists.");
	<%}
if (message != null && message.equals("duplicateAuthor")) {%>
	alert("This author already exists.");
	<%}
if (message != null && message.equals("duplicatePublisher")) {%>
	alert("This publisher already exists.");
	<%}
if (message != null && message.equals("incorrectFormat")) {%>
	alert("Sorry, incorrect format. Please try again.");
	<%}

boolean admin = false;
if (role != null && role.equals("adminUser")) {
	admin = true;
}%></script>
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
				<%
				if (admin) {
				%>
				<li class="nav-item"><a class="nav-link mx-2"
					aria-current="page" href="menu.jsp" id="Admin">Admin</a></li>
				<%
				}
				%>
			</ul>
		</div>
	</nav>
	<%
	String dm_userID = (String) session.getAttribute("sessUserID");
	String dm_userRole = (String) session.getAttribute("sessUserRole");
	String dm_loginStatus = (String) session.getAttribute("loginStatus");

	if (dm_userID == null || !dm_loginStatus.equals("success")) {
		response.sendRedirect("../../login.jsp?errCode=sessionTimeOut");
	}
	%>

	<div align="center">
		<h2 align="center">Manage Books</h2>
		<button onclick="window.location.href='createBookForm.jsp'">Create
			new Book</button>
		<button onclick="window.location.href='createGenreForm.jsp'">Create
			new Genre</button>
		<button onclick="window.location.href='createAuthorForm.jsp'">Add
			new Author</button>
		<button onclick="window.location.href='createPublisherForm.jsp'">Add
			new Publisher</button>
		<br> <br> <select id="sortPopularity">
			<option value="bestSelling">Best Selling</option>
			<option value="leastSelling">Least Selling</option>
			<option value="none" selected>None</option>
		</select> <select id="filterStock">
			<option value="lowStock">Low Stock</option>
			<option value="oos">Out of Stock</option>
			<option value="none" selected>None</option>
		</select> <br> <br>

		<%
		try {
			int id, quantity;
			String genre = "";
			String author = "";
			String publisher = "";
			String title = "";
			double price;
			String description = "";
			String publication_date = "";
			String ISBN = "";
			String rating = "";

			// Step1: Load JDBC Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Step 2: Define Connection URL
			String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=root&serverTimezone=UTC";

			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Step 4: Create Statement object
			Statement stmt = conn.createStatement();

			// Step 5: Execute SQL Command
			/* String selectedSort = request.getParameter("sort");
			String sqlStr = "";
			if ("bestSelling".equals(selectedSort)) {
				sqlStr = "SELECT g.genre_name, a.author_name, p.publisher_name, b.* FROM books b JOIN genres g ON b.genre_id = g.genre_id JOIN authors a ON b.author_id = a.author_id JOIN publishers p ON b.publisher_id = p.publisher_id ORDER BY quantity DESC";
			} else if ("leastSelling".equals(selectedSort)) {
				sqlStr = "SELECT g.genre_name, a.author_name, p.publisher_name, b.* FROM books b JOIN genres g ON b.genre_id = g.genre_id JOIN authors a ON b.author_id = a.author_id JOIN publishers p ON b.publisher_id = p.publisher_id ORDER BY quantity ASC";
			} else {
				sqlStr = "SELECT g.genre_name, a.author_name, p.publisher_name, b.* FROM books b JOIN genres g ON b.genre_id = g.genre_id JOIN authors a ON b.author_id = a.author_id JOIN publishers p ON b.publisher_id = p.publisher_id ORDER BY b.book_id";
			} */
			String sqlStr = "SELECT g.genre_name, a.author_name, p.publisher_name, b.* FROM books b JOIN genres g ON b.genre_id = g.genre_id JOIN authors a ON b.author_id = a.author_id JOIN publishers p ON b.publisher_id = p.publisher_id ORDER BY b.book_id";
			ResultSet rs = stmt.executeQuery(sqlStr);

			// Step 6: Process Result
			out.print("<table border='1' align='center' style='border-collapse: collapse; text-align: center;'>");
			out.print(
			"<tr><th style='padding: 5px;'>id</th><th style='padding: 5px;'>genre</th><th style='padding: 5px;'>author</th><th style='padding: 5px;'>publisher</th><th style='padding: 5px;'>title</th><th style='padding: 5px;'>price</th><th style='padding: 5px;'>quantity</th><th style='padding: 5px;'>publication date</th><th style='padding: 5px;'>ISBN</th><th style='padding: 5px;'>rating</th><th colspan='2' style='padding: 5px;'>action</th></tr>");

			while (rs.next()) {
				id = rs.getInt("book_id");
				genre = rs.getString("genre_name");
				author = rs.getString("author_name");
				publisher = rs.getString("publisher_name");
				title = rs.getString("title");
				price = rs.getDouble("price");
				quantity = rs.getInt("quantity");
				description = rs.getString("description");
				publication_date = rs.getString("publication_date");
				ISBN = rs.getString("ISBN");
				rating = rs.getString("rating");

				out.print("<tr><td style='padding: 5px;'>" + id + "</td><td style='padding: 5px;'>" + genre
				+ "</td><td style='padding: 5px;'>" + author + "</td><td style='padding: 5px;'>" + publisher
				+ "</td><td style='padding: 5px;'>" + title + "</td><td style='padding: 5px;'>$" + price);
				if (quantity <= 10) {
			out.print("</td><td style='padding: 5px; background-color: red;'>" + quantity);
				} else {
			out.print("</td><td style='padding: 5px;'>" + quantity);
				}
				out.print("</td><td style='padding: 5px;'>" + publication_date + "</td><td style='padding: 5px;'>" + ISBN
				+ "</td><td style='padding: 5px;'>" + rating + "</td>");

				out.print("<td style='padding: 5px;'><a href='editBook.jsp?id=" + id + "&title=" + title + "&price=" + price
				+ "&quantity=" + quantity + "&description=" + description + "&publication_date=" + publication_date
				+ "&ISBN=" + ISBN + "&rating=" + rating
				+ "'><button>edit</button></a></td><td style='padding: 5px;'><button style='background-color: red; color: white;' onclick='confirmDelete("
				+ id + ")'>delete</button></a></td></tr>");
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
</body>
<script>
	function confirmDelete(id) {
		if(confirm("Are you sure you want to delete this book?\nid:" + id)){ // if user clicks "OK"
			var url = "<%=request.getContextPath()%>
	/deleteBookServlet?id="
					+ id;
			window.location.href = url;
		} else {
			// do nothing
		}
	}

	/* document.addEventListener("DOMContentLoaded", function() {
		var sortPopularity = document.getElementById("sortPopularity");

		sortDropdown.addEventListener("change", function() {
			var selectedValue = sortPopularity.value;

			// Redirect to the same page with the selected sort parameter
			window.location.href = updateQueryStringParameter(
					window.location.href, "sort", selectedValue);
		});
	});

	function updateQueryStringParameter(uri, key, value) {
		var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
		var separator = uri.indexOf("?") !== -1 ? "&" : "?";

		if (uri.match(re)) {
			return uri.replace(re, "$1" + key + "=" + value + "$2");
		} else {
			return uri + separator + key + "=" + value;
		}
	} */
</script>
</html>