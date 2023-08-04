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
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link href="./css/login.css" rel="stylesheet" />
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<title>login/signup</title>
<style>
@import
	url("https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap")
	;

@import
	url("https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.2/css/all.min.css")
	;

* {
	margin: 0px;
	padding: 0px;
	box-sizing: border-box;
}

body {
	font-family: "Poppins", sans-serif;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	background-color: #ddd;
	font-size: 14px;
}

.container {
	width: 760px;
	max-width: 100vw;
	height: 480px;
	position: relative;
	overflow-x: hidden;
}

.container .forms-container {
	position: relative;
	width: 50%;
	text-align: center;
}

.container .forms-container .form-control {
	position: absolute;
	width: 100%;
	display: flex;
	justify-content: center;
	flex-direction: column;
	height: 480px;
	transition: all 0.5s ease-in;
}

.container .forms-container .form-control h2 {
	font-size: 2rem;
}

.container .forms-container .form-control form {
	display: flex;
	flex-direction: column;
	margin: 0px 30px;
}

.container .forms-container .form-control form input {
	margin: 10px 0px;
	border: none;
	padding: 15px;
	background-color: #efefef;
	border-radius: 5px;
}

.container .forms-container .form-control form button {
	border: none;
	padding: 20px;
	margin-top: 5px;
	background-color: #059669;
	border-radius: 5px;
	color: #fff;
	cursor: pointer;
}

.container .forms-container .form-control form button:focus {
	outline: none;
}

.container .forms-container .form-control span {
	margin: 10px 0px;
}

.container .forms-container .form-control .socials {
	margin: 20px 5px;
	color: #fff;
	border-radius: 50%;
}

.container .forms-container .form-control.signup-form {
	opacity: 0;
	z-index: 1;
	left: 200%;
}

.container .forms-container .form-control.signin-form {
	opacity: 1;
	z-index: 2;
	left: 0%;
}

.container .intros-container {
	position: relative;
	left: 50%;
	width: 50%;
	text-align: center;
}

.container .intros-container .intro-control {
	position: absolute;
	width: 100%;
	display: flex;
	justify-content: center;
	flex-direction: column;
	height: 480px;
	color: #fff;
	background: linear-gradient(170deg, #34d399, #059669);
	transition: all 0.5s ease-in;
}

.container .intros-container .intro-control .intro-control__inner {
	margin: 0px 30px;
}

.container .intros-container .intro-control button {
	border: none;
	padding: 15px 30px;
	background-color: #10b981;
	border-radius: 50px;
	color: #fff;
	margin: 10px 0px;
	cursor: pointer;
}

.container .intros-container .intro-control button:focus, .container .intros-container .intro-control button:hover
	{
	outline: none;
	background-color: #059669;
}

.container .intros-container .intro-control h3, .container .intros-container .intro-control p
	{
	margin: 10px 0px;
}

.container .intros-container .intro-control.signin-intro {
	opacity: 1;
	z-index: 2;
}

.container .intros-container .intro-control.signup-intro {
	opacity: 0;
	z-index: 1;
}

.change .forms-container .form-control.signup-form {
	opacity: 1;
	z-index: 2;
	transform: translateX(-100%);
}

.change .forms-container .form-control.signup-form button {
	background-color: #2563eb !important;
}

.change .forms-container .form-control.signin-form {
	opacity: 0;
	z-index: 1;
	transform: translateX(-100%);
}

.change .intros-container .intro-control {
	transform: translateX(-100%);
	background: linear-gradient(170deg, #3b82f6, #2563eb);
}

.change .intros-container .intro-control #signin-btn {
	background-color: #2563eb;
}

.change .intros-container .intro-control.signin-intro {
	opacity: 0;
	z-index: 1;
}

.change .intros-container .intro-control.signup-intro {
	opacity: 1;
	z-index: 2;
}

@media screen and (max-width: 480px) {
	.container {
		height: 100vh;
		display: flex;
		flex-direction: column;
	}
	.container .forms-container {
		order: 2;
		width: 100%;
		height: 50vh;
	}
	.container .forms-container .form-control {
		position: absolute;
		height: 50vh;
	}
	.container .forms-container .form-control.signup-form {
		left: 0%;
		margin-top: 70px;
	}
	.container .intros-container {
		order: 1;
		width: 100%;
		left: 0%;
		height: 40vh;
	}
	.container .intros-container .intro-control {
		position: absolute;
		height: 40vh;
	}
	.change .forms-container .form-control.signup-form {
		transform: translateX(0%);
	}
	.change .forms-container .form-control.signin-form {
		transform: translateX(0%);
	}
	.change .intros-container .intro-control {
		transform: translateX(0%);
	}
}
</style>
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

<%
//init variables
String message = request.getParameter("statusCode");

//out.print (message);
if (message != null && message.equals("invalidLogin")) {
%>
<script>
alert("Wrong email or password!");
</script>
<%
}

if (message != null && message.equals("sessionTimeOut")) {
%>
<script>
alert("Session timed out. Please log in again!");
</script>
<%
}
%>
</head>
<body>
	<div class="container">
		<div class="forms-container">
			<div class="form-control signup-form">
				<form action="<%=request.getContextPath()%>/createUserServlet"
					method="post">
					<h2>Sign up</h2>
					<input type="text" id="firstName" name="firstName"
						placeholder="First Name" required /> <input type="text"
						id="lastName" name="lastName" placeholder="Last name" required />
					<input type="email" id="email" name="email" placeholder="Email"
						required /> <input type="password" id="password" name="password"
						placeholder="Password" required />
					<button>Sign up</button>
				</form>
				<div class="socials">
					<a href="<%=request.getContextPath()%>/logoutUserServlet">use
						as guest</a>
				</div>
			</div>
			<div class="form-control signin-form">
				<form action="<%=request.getContextPath()%>/verifyUserServlet">
					<h2>Log in</h2>
					<input type="text" placeholder="Username" required name="email" />
					<input type="password" placeholder="Password" required name="pwd" />
					<button type="submit" id="Login">Log in</button>
				</form>
				<div class="socials">
					<a href="home.jsp">use as guest</a>
				</div>
			</div>
		</div>
		<div class="intros-container">
			<div class="intro-control signin-intro">
				<div class="intro-control__inner">
					<h2>Welcome back!</h2>
					<p>
						Welcome back! We are so happy to have you at <strong>kitty
							books</strong>. It's great to see you again. We hope you had a safe and
						enjoyable time away.
					</p>
					<button id="signup-btn">No account yet? Sign up.</button>
				</div>
			</div>
			<div class="intro-control signup-intro">
				<div class="intro-control__inner">
					<h2>Come join us!</h2>
					<p>
						We are so excited to have you at <strong>kitty books</strong>. If
						you haven't already, create an account to get access to exclusive
						offers, rewards, and discounts.
					</p>
					<button id="signin-btn">Already have an account? Log in.</button>
				</div>
			</div>
		</div>
	</div>
	<script>
    const signupBtn = document.getElementById("signup-btn");
    const signinBtn = document.getElementById("signin-btn");
    const mainContainer = document.querySelector(".container");

    signupBtn.addEventListener("click", () => {
      mainContainer.classList.toggle("change");
    });
    signinBtn.addEventListener("click", () => {
      mainContainer.classList.toggle("change");
    });
	
<%//init variables

//out.print (message);
if (message != null && message.equals("success")) {%>
	alert("Success!");
	windows.location.href = "login.jsp";
<%} else if (message != null && message.equals("duplicateEmail")) {%>
	alert("Email already exist!");
<%}%>
	
</script>
</body>
</html>