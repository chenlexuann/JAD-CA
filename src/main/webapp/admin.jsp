<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<!-- //Chen Lexuan
//DIT/FT/1B/02
//p2212562 -->
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<script
	src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
	integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<Title>Admin</Title>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script>
	$(document).ready(function() {
		document.getElementById("form1").reset();
		document.getElementById("form2").reset();
<%String message = request.getParameter("statusCode");%>
	if (message != null && message.equals("invalidLogin")) {
			loggedIn();
		} else {
			loggedOut();
		}
		$('#AddActor').show();
		$('#AddCustomer').hide();

		$("#Logout").click(function() {
			window.localStorage.clear();
			window.location.assign("http://localhost:3001/login.html");
		});

	});
</script>
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
						<form action='<%=request.getContextPath()%>/logoutUserServlet'
							class=logoutForm>
							<button type="submit" class="btn btn-danger mr-2" id="btnLogin">Logout</button>
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
	
	<div class="form-group row justify-content-center mt-5">
		<button type="button" class="btn btn-outline-info btn-lg mr-2"
			id="add-actor">Add Actor</button>
		<button type="button" class="btn btn-outline-info btn-lg"
			id="add-customer">Add Customer</button>
	</div>


	<div class="container" id="AddActor">
		<h1>Add Actor</h1>
		<form id="form1">
			<div class="form-group row">
				<div class="col-md-6">
					<label for="firstName">First Name:</label> <input type="text"
						class="form-control" id="firstName" placeholder="Enter First Name">
				</div>
				<div class="col-md-6">
					<label for="lastName">Last Name:</label> <input type="text"
						class="form-control" id="lastName" placeholder="Enter Last Name">
				</div>
			</div>
		</form>
		<div class="form-group row justify-content-end">
			<button type="submit" class="btn btn-primary" id="addAct">Confirm</button>
		</div>
		<h1>Delete Actor</h1>
		<label for="basic-url" class="form-label">Actors:</label>
		<div class="input-group mb-3">
			<select class="custom-select form-control" id="actors">
				<option value="0" selected>None Selected</option>
			</select>
		</div>
		<div class="form-group row justify-content-end">
			<button type="submit" class="btn btn-danger" id="delAct">Delete</button>
		</div>
	</div>

	<div class="container" id="AddCustomer">
		<div>
			<h1>Add Customer</h1>
			<form id="form2">
				<div class="form-group row">
					<div class="col-md-6">
						<label for="first-name">First Name</label> <input type="text"
							class="form-control" id="first-name"
							placeholder="Enter First Name">
					</div>
					<div class="col-md-6">
						<label for="last-name">Last Name</label> <input type="text"
							class="form-control" id="last-name" placeholder="Enter Last Name">
					</div>
					<div class="col-12 mt-2">
						<label for="basic-url" class="form-label">Store</label>
						<div class="input-group mb-3">
							<select class="custom-select form-control" id="store">
							</select>
						</div>
					</div>
				</div>
				<div class="form-group">
					<label for="email">Email address</label> <input type="email"
						class="form-control" id="email" aria-describedby="emailHelp"
						placeholder="Enter email"> <small id="emailHelp"
						class="form-text text-muted">We'll never share your email
						with anyone else.</small>
				</div>
			</form>
		</div>
		<div class="mt-5">
			<form id="address">
				<div class="row">
					<div class="form-group col-6">
						<label for="address-line1">Address Line 1:</label> <input
							type="text" class="form-control" id="addressLine1"
							placeholder="Enter Address Line 1">
					</div>
					<div class="form-group col-6">
						<label for="address-line2">Address Line 2: (optional)</label> <input
							type="text" class="form-control" id="addressLine2"
							placeholder="Enter Address Line 2">
					</div>
				</div>
				<div class="form-group">
					<label for="basic-url" class="form-label">City:</label>
					<div class="input-group mb-3">
						<select class="custom-select form-control" id="city">
						</select>
					</div>
				</div>
				<div class="form-group">
					<label for="district">District:</label> <input type="text"
						class="form-control" id="district" placeholder="Enter district">
				</div>
				<div class="form-group">
					<label for="postal-code">Postal code:</label> <input type="text"
						class="form-control" id="postalCode"
						placeholder="Enter postal code">
				</div>
				<div class="form-group">
					<label for="phone">Phone number:</label> <input type="text"
						class="form-control" id="phoneNum"
						placeholder="Enter phone number">
				</div>

			</form>
			<div class="form-group row justify-content-end">
				<button type="submit" class="btn btn-primary" id="addCust">Confirm</button>
			</div>
		</div>
	</div>
<script src="./JS/functions.js"></script>
</body>
</html>