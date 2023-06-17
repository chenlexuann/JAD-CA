<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="books.Book"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>Cart</title>
<script>
	$(document)
			.ready(
					function() {
<%String role = session.getAttribute("sessUserRole") + "";
String message = request.getParameter("statusCode");
double price = 0.0;
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
.center-text {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 50vh;
	font-size: 24px;
	font-weight: bold;
}

.tiny-image {
	width: 50px; /* Set the width of the image */
	height: auto; /* Maintain the aspect ratio */
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
				<li class="nav-item"><a class="nav-link mx-2"
					href="<%=request.getContextPath()%>/getCartServlet"> <i
						class="fas fa-shopping-cart"></i> Cart
				</a></li>
			</ul>
		</div>
	</nav>
	<%
	if (role != null && (role.equals("memberUser") || role.equals("adminUser"))) {
		// Retrieve cart details from session and display the list of books
		ArrayList<Book> booksInCart = (ArrayList<Book>) session.getAttribute("booksInCart");

		if (booksInCart == null || booksInCart.isEmpty()) {
	%>
	<div class="center-text">No books in the cart.</div>
	<%
	} else {
	%><div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-10">
				<table class="table">
					<tr>
						<th>Cover</th>
						<th>Title</th>
						<th>Author</th>
						<th>Price</th>
						<th>Quantity</th>
						<th>Publisher</th>
						<th>Published</th>
					</tr>
					</thead>
					<tbody>
						<%
						int loopCounter = 1;
						for (Book book : booksInCart) {
							price += book.getPrice();
						%>
						<tr>
							<td><img src="<%=book.getImageUrl()%>" class="tiny-image"
								alt="Book Image"></td>
							<td><%=book.getTitle()%></td>
							<td><%=book.getAuthorName()%></td>
							<td><%=book.getPrice()%></td>
							<td><%=book.getQuantity()%></td>
							<td><%=book.getPublisherName()%></td>
							<td><%=book.getPublicationDate()%></td>
							<td>
								<form action="<%=request.getContextPath()%>/removeBookServlet"
									method="POST">
									<input type="hidden" name="WhichBook" value="<%=loopCounter%>">
									<button type="submit">Remove</button>
								</form>
							</td>
						</tr>
						<%
						loopCounter++;
						}
						%>
					</tbody>
				</table>
				<div class="text-right">
					<h5>Total Price:</h5>
					<%
					out.print(String.format("%.2f", price));
					%>
				</div>
			</div>
		</div>
	</div>
	<%
	}
	} else {
	%>
	<script>
		alert("Please log in to continue.");
		window.location.href = "login.jsp";
	</script>
	<%
	}
	%>

</body>
</html>