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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<meta charset="UTF-8">
<title>Cart</title>
<%@ include file="header.jsp"%>
<script>
	
<%double price = 0.0;%>
	
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