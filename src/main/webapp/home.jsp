<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="books.Book"%>

<!DOCTYPE html>
<html>
<head>
<!-- Bootstrap CSS -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<title>home</title>
<script>
	function reply_click(clicked_id) {
		session.setAttribute('book_id', clicked_id);
		window.location.assign("bookDetails.jsp");
	}

	$(document)
			.ready(
					function() {
						if (request.getParameter("redirect").equals("false")) {

						}
<%String role = session.getAttribute("sessUserRole") + "";
String message = request.getParameter("statusCode");
boolean admin = false;
boolean loggedIn = false;
if (role != null && role.equals("adminUser")) {
	admin = true;
}
if (role != null && role.equals("memberUser") || role.equals("adminUser")) {
	loggedIn = true;
}%>
	})
</script>
<style>
.center-image {
	display: flex;
	justify-content: center;
	align-items: center;
}

.center-image img {
	max-width: 100%;
	max-height: 30vh;
	object-fit: contain;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="home.jsp"> <img
			src="./img/kittyLogo.png" width="auto" height="50" alt="kitty books">
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
						<%
						if (loggedIn) {
						%>
						<form action='<%=request.getContextPath()%>/logoutUserServlet'
							class=logoutForm id="Logout">
							<button type="submit" class="btn btn-danger mr-2">Logout</button>
						</form>
						<%
						} else {
						%>
						<a href="login.jsp" class="btn btn-primary mr-2" id="Login">Log
							In</a>
						<%
						}
						%>
					</div>
				</li>
				<li class="nav-item"><a class="nav-link active mx-2"
					aria-current="page" href="home.jsp">Home</a></li>
				<%
				if (admin) {
				%>
				<li class="nav-item"><a class="nav-link mx-2"
					aria-current="page" href="admin.jsp" id="Admin">Admin</a></li>
				<%
				}
				%>
			</ul>
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link mx-2" href="cart.jsp">
						<i class="fas fa-shopping-cart"></i> Cart
				</a></li>
			</ul>
		</div>
	</nav>
	<div class="container mt-4">
		<div class="center-image">
			<img src="./img/kittyLogo.png" alt="Kitty books">
		</div>
		<form action="<%=request.getContextPath()%>/searchBooksServlet"
			method="GET">
			<div class="row">
				<div class="col-6">
					<label for="PriceInput" class="form-label">Max Price</label>
					<div class="input-group mb-3">
						<input type="text" class="form-control" id="PriceInput"
							name="maxPrice" placeholder="Type here">
					</div>
				</div>
				<div class="col-6">
					<label for="category" class="form-label">Category</label>
					<div class="input-group mb-3">
						<select class="custom-select form-control" id="genre" name="genre">
							<option value="0" selected>None Selected</option>
							<%
							List<String> genres = (List<String>) session.getAttribute("genres");
							List<Integer> genre_id = (List<Integer>) session.getAttribute("genre_ID");
							if (genre_id != null && genres != null) {
								for (int i = 0; i < genres.size(); i++) {
									String genre = genres.get(i);
									int genreId = genre_id.get(i);
							%>
							<option value="<%=genreId%>"><%=genre%></option>
							<%
							}
							}
							%>
						</select>
					</div>
				</div>
			</div>
			<div class="row mt-4">
				<div class="col-12">
					<input type="text" class="form-control"
						placeholder="Search for Title" name="searchTitle" id="TitleInput">
				</div>
			</div>
			<div class="d-flex justify-content-end my-2">
				<button type="submit" class="btn btn-primary">Search</button>
			</div>
		</form>

	</div>
	<div>
		<div class="container">
			<div class="row justify-content-center" id="books">
				<%
				List<Book> books = (List<Book>) request.getAttribute("books");

				if (books != null) {
					for (Book book : books) {
				%>
				<div class="col-lg-6 col-md-12" id="<%=book.getBookId()%>"
					onClick="window.location.href = 'bookDetailsServlet?bookId=<%=book.getBookId()%>'">
					<div class="card border-primary mb-3">
						<div class="card-header">
							<h3><%=book.getTitle()%></h3>
						</div>
						<div class="card-body">
							<div class="row">
								<div class="col-md-6">
									<h5>
										Price:
										<%=book.getPrice()%></h5>
								</div>
								<div class="col-md-6">
									<h5>
										Quantity:
										<%=book.getQuantity()%></h5>
								</div>
							</div>
							<!-- Display other book details as needed -->
						</div>
					</div>
				</div>
				<%
				}
				}
				%>
			</div>
		</div>
	</div>
</body>
<!-- Bootstrap JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

</body>
</html>