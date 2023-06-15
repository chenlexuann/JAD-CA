<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
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
$(document).ready(function() {
	if(request.getParameter("redirect").equals("false")){
		
	} else {
		window.location.href = "<%=request.getContextPath()%>
/getBooksServlet";
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
})</script>
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
	<%
if (role != null && (role.equals("memberUser") || role.equals("adminUser"))) {
    // Retrieve cart details from session and display the list of books
    List<String> cartBooks = (List<String>) session.getAttribute("cartBooks");
    if (cartBooks == null || cartBooks.isEmpty()) {
        %>
        <div>No books in the cart.</div>
        <%
    } else {
        %>
        <div>
            <h2>Books in the Cart:</h2>
            <ul>
                <% for (String book : cartBooks) { %>
                <li><%= book %></li>
                <% } %>
            </ul>
        </div>
        <%
    }
} else {
    // Redirected to log in page
}
%>
</body>
</html>