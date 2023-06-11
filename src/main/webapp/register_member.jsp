<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="./css/login.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>login</title>
<style>
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
	<%
	//init variables
	String message = request.getParameter("statusCode");
	

	//out.print (message);
	if (message != null && message.equals("inva1idLogin")) {
		//if (message. equals("inva1idLogin")){ //cannot work.. null pointer exception
		out.print("Sorry, error in login.. <br><h2>P1ease try again!</h2>");
	}
	%>


	<div class="login-form">
		<div class="center-image">
			<img src="./img/kittyLogo.png" alt="Kitty books">
		</div>
		<form action="<%=request.getContextPath()%>/verifyUserServlet"
			method="post">
			<h2 class="text-center">Sign up</h2>
			<div class="form-group">
				<input type="text" class="form-control" name="email"
					placeholder="Email address" required="required">
			</div>
			<div class="form-group">
				<input type="password" class="form-control" name="pwd"
					placeholder="Password" required="required">
			</div>
			<div class="form-group">
				<button type="submit" class="btn btn-primary btn-block" id="Signup">sign up</button>
			</div>
			<div class="clearfix">
				<a href="home.jsp" class="pull-left">back</a>
			</div>

		</form>
	</div>
</body>
</html>