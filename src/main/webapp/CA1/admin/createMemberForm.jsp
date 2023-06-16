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
	<%@include file="header.html"%>
	<%
	String dm_userID = (String) session.getAttribute("sessUserID");
	String dm_userRole = (String) session.getAttribute("sessUserRole");
	String dm_loginStatus = (String) session.getAttribute("loginStatus");

	if (dm_userID == null || !dm_loginStatus.equals("success")) {
		response.sendRedirect("login.jsp?errCode=sessionTimeOut");
	}
	%>

	<div align="center">
		<h2>Create Member Form</h2>
		<form action="createMember.jsp" method="POST">
			First Name: <input type="text" name="first_name"
				style="margin-bottom: 10px;"><br> Last Name: <input
				type="text" name="last_name" style="margin-bottom: 10px;"><br>
			Email: <input type="text" name="email" style="margin-bottom: 10px;"><br>
			Password: <input type="text" name="password"
				style="margin-bottom: 10px;"><br> <br> <input
				type="submit" name="btnSubmit" value="Submit"> <input
				type="reset" name="btnReset" value="Reset">
		</form>
		<br>
		<button onclick="window.location.href='manageMembers.jsp'">Cancel</button>
	</div>
	<br>
	<%@include file="footer.html"%>
</body>
</html>