<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- Author: Chen Lexuan
Class: DIT/FT/2A/02
Date: 8/6/2023
Description: ST0510/JAD Assignment 1 -->
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
<title>Book Details</title>
<script>
	$(document)
			.ready(
					function() {
						if (request.getParameter("redirect").equals("false")) {

						}
<%String role = session.getAttribute("sessUserRole") + "";
String message = request.getParameter("statusCode");
boolean admin = false;
boolean loggedIn = false;
boolean member = false;
if (role != null && role.equals("adminUser")) {
	admin = true;
}
if (role != null && role.equals("memberUser") || role.equals("adminUser")) {
	loggedIn = true;
}
if (role != null && role.equals("memberUser")) {
	member = true;
}
Book book = (Book) request.getAttribute("bookDetail");%>
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
.img-fluid.book-cover {
        max-height: 70%; 
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
					aria-current="page" href="CA1/admin/menu.jsp" id="Admin">Admin</a></li>
				<%
				} else if (member) {
				String firstName = (String) session.getAttribute("sessUserName");
				%>
				<li class="nav-item"><a class="nav-link mx-2"
					aria-current="page" href="CA1/member/viewAccount.jsp" id="UserEdit">
						<%=firstName%>
				</a></li>
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
	<div class="m-5">
		<div class="row">
			<div class="col-md-4">
				<img src="<%=book.getImageUrl()%>" class="img-fluid book-cover"
					id="bookCover" />
			</div>
			<div class="col-md-8">
				<h1 class="text-start" id="bookTitle"><%=book.getTitle()%></h1>
				<div class="text-start">
					<h3>
						<em>Price: </em><span id="bookPrice"><%=book.getPrice()%></span>
					</h3>
					<h3>
						<em>Quantity: </em><span id="bookQuantity"><%=book.getQuantity()%></span>
					</h3>
				</div>

				<div class="book-details my-3">
					<p class="text-justify" id="bookDescription"><%=book.getDescription()%></p>
					<div class="row">
						<div class="col-md-6">
							<p>
								<strong>ISBN: </strong><span id="bookISBN"><%=book.getISBN()%></span>
							</p>
							<p>
								<strong>Author: </strong><span id="bookAuthorName"><%=book.getAuthorName()%></span>
							</p>
							<p>
								<strong>Publisher: </strong><span id="bookPublisherName"><%=book.getPublisherName()%></span>
							</p>
						</div>
						<div class="col-md-6">
							<p>
								<strong>Publication Date: </strong><span
									id="bookPublicationDate"><%=book.getPublicationDate()%></span>
							</p>
							<p>
								<strong>Genre: </strong><span id="bookGenreName"><%=book.getGenreName()%></span>
							</p>
							<p>
								<strong>Rating: </strong><span id="bookRating"><%=book.getRating()%></span>
							</p>
						</div>
					</div>
				</div>
				<div class="text-end">
					<%
					if (loggedIn) {
					%><form action="<%=request.getContextPath()%>/add2Cart"
						method="post">
						<input type="hidden" name="bookId" value="<%=book.getBookId()%>">
						<button type="submit" class="btn btn-primary" id="addToCartButton">Add
							to Cart</button>
					</form>
					<%
					} else {
					%>
					<button onclick="window.location.href = 'login.jsp'"
						class="btn btn-primary" id="addToCartButton">Log in to
						add to cart</button>
					<%
					}
					%>

				</div>
			</div>
		</div>
	</div>
</body>
<!-- Bootstrap JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>
</html>