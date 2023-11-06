<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
		<!-- Author: Chen Lexuan
Class: DIT/FT/2A/02
Date: 8/6/2023
Description: ST0510/JAD Assignment 1 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Register Member</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<style>
body {
	display: flex;
	align-items: center;
	justify-content: center;
}

.registration-form {
	max-width: 400px;
	padding: 20px;
	border: 1px solid #ccc;
	border-radius: 4px;
	background-color: #fff;
}

.center-image {
	display: flex;
	justify-content: center;
	align-items: center;
}

.center-image img {
	max-width: 100%;
	max-height: 80vh;
	object-fit: contain;
}
</style>
</head>
<body>
	<div class="registration-form">
		<div class="center-image">
			<img src="./img/kittyLogo.png" alt="Kitty books">
		</div>
		<h2 class="text-center">Register Member</h2>
		<form action="<%=request.getContextPath()%>/createUserServlet"
			method="post">
			<div class="form-group">
				<label for="firstName">First Name:</label> <input type="text"
					class="form-control" id="firstName" name="firstName" required>
			</div>
			<div class="form-group">
				<label for="lastName">Last Name:</label> <input type="text"
					class="form-control" id="lastName" name="lastName" required>
			</div>
			<div class="form-group">
				<label for="email">Email:</label> <input type="email"
					class="form-control" id="email" name="email" required>
			</div>
			<div class="form-group">
				<label for="password">Password:</label> <input type="password"
					class="form-control" id="password" name="password" required>
			</div>
			<button type="submit" class="btn btn-primary btn-block">Register</button>
			<br />
			<div class="clearfix">
				<a href="<%=request.getContextPath()%>/logoutUserServlet"
					class="pull-right">Cancel</a>
			</div>
		</form>
	</div>
</body>
<script>
	
<%//init variables
String message = request.getParameter("statusCode");

//out.print (message);
if (message != null && message.equals("success")) {%>
	alert("Success!");
	windows.location.href = "login.jsp";
<%} else if (message != null && message.equals("duplicateEmail")) {%>
	alert("Email already exist!");
<%}%>
	
</script>
</html>
