<!-- Author: Angie Toh Anqi
Class: DIT/FT/2A/02
Date: 8/6/2023
Description: ST0510/JAD Assignment 1 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Member Form</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="../../home.jsp"> <img
			src="../../img/kittyLogo.png" width="auto" height="50"
			alt="kitty books">
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
						<form action='<%=request.getContextPath()%>/logoutUserServlet'
							class=logoutForm id="Logout">
							<button type="submit" class="btn btn-danger mr-2">Logout</button>
						</form>
					</div>
				</li>
				<li class="nav-item"><a class="nav-link active mx-2"
					aria-current="page" href="../../home.jsp">Home</a></li>
			</ul>
		</div>
	</nav>
	<%
	String dm_userID = (String) session.getAttribute("sessUserID");
	String dm_userRole = (String) session.getAttribute("sessUserRole");
	String dm_loginStatus = (String) session.getAttribute("loginStatus");

	if (dm_userID == null || !dm_loginStatus.equals("success")) {
		response.sendRedirect("../../login.jsp?errCode=sessionTimeOut");
	}
	%>

	<div align="center">
		<h2>Create Member</h2>
		<form action="<%=request.getContextPath()%>/createUserServlet"
			method="POST">
			First Name: <input type="text" name="firstName"
				style="margin-bottom: 10px;"><br> Last Name: <input
				type="text" name="lastName" style="margin-bottom: 10px;"><br>
			Email: <input type="text" name="email" style="margin-bottom: 10px;"><br>
			Password: <input type="text" name="password"
				style="margin-bottom: 10px;"><br>
				Address: <input type="text" name="address"
				style="margin-bottom: 10px;"><br>
				Postal Code: <input type="text" name="postalCode"
				style="margin-bottom: 10px;"><br>
				 <br> <input
				type="submit" name="btnSubmit" value="Submit"> <input
				type="reset" name="btnReset" value="Reset">
		</form>
		<br>
		<button onclick="window.location.href='manageMembers.jsp'">Cancel</button>
	</div>
	<br>
</body>
</html>