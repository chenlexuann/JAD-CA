<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Author: Chen Lexuan
Class: DIT/FT/2A/02
Date: 8/6/2023
Description: ST0510/JAD Assignment 1 -->
<%@ page import="java.util.*"%>
<%@ page import="model.*"%>

<!DOCTYPE html>
<html>
<head>
<%@ include file="header.jsp" %>
<title>Book Details</title>
<%@ include file="navbar.jsp" %>
<script>
	$(document)
			.ready(
					function() {
						if (request.getParameter("redirect").equals("false")) {

						}
<%
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
						<em>Quantity: </em><span id="bookQuantity"><%=book.getBookQuantity()%></span>
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
	<%@ include file="footer.jsp" %>
</body>
</html>