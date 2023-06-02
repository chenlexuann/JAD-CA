<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
	$(document).ready(function() { //This is to prevent any jQuery code from running before the document is finished loading (is ready). alternative: $(document).ready(function()
<%String message = request.getParameter("statusCode");%>
	loginVerify();
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
						if (message != null && message.equals("validLogin")) {
						%>
						<a href="login.jsp" class="btn btn-danger mr-2" id="Logout">Log
							Out</a>
						<form action='<%=request.getContextPath()%>/logoutUserServlet'
							class=logoutForm>
							<button type="submit" class="btn btn-secondary mr-2"
								id="btnLogin">Logout</button>
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
				<li class="nav-item"><a class="nav-link mx-2"
					aria-current="page" href="admin.jsp" id="Admin">Admin</a></li>
				<li class="nav-item"><a class="nav-link mx-2"
					aria-current="page" href="AddDVD.html" id="AddDVD">DVD</a></li>
			</ul>
		</div>
	</nav>
	<div class="container mt-4">
		<div class="center-image">
			<img src="./img/kittyLogo.png" alt="Kitty books">
		</div>
		<div class="row">
			<div class="col-6">
				<label for="basic-url" class="form-label">Max Price</label>
				<div class="input-group mb-3">
					<input type="text" class="form-control" id="PriceInput"
						aria-describedby="basic-addon3" placeholder="Type here">
				</div>
			</div>
			<div class="col-6">
				<label for="basic-url" class="form-label">Category</label>
				<div class="input-group mb-3">
					<select class="custom-select form-control" id="category">
						<option value="0" selected>None Selected</option>
					</select>
				</div>
			</div>
		</div>
		<div class="d-flex justify-content-end my-2">
			<a href="#"><button class="btn btn-primary" id="Search">Search</button></a>
		</div>
		<div class="row mt-4">
			<div class="col-12">
				<input type="text" class="form-control"
					placeholder="Search for Title" id="TitleInput">
			</div>
		</div>
		<div class="d-flex justify-content-end my-2">
			<a href="#"><button class="btn btn-primary" id="SearchTitle">Search</button></a>
		</div>
	</div>
	<div>
		<div class="container">
			<div class="row justify-content-center" id="Movies"></div>
		</div>
	</div>
</body>
<!-- Bootstrap JS -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.0/js/bootstrap.bundle.min.js"></script>

<script src="./JS/functions.js"></script>
</body>
</html>