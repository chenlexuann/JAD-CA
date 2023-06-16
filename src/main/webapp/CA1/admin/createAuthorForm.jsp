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
<title>Create Author Form</title>
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
		<h2>Create Author Form</h2>
		<form action="createAuthor.jsp" method="POST">
			Author: <input type="text" name="author" style="margin-bottom: 10px;"><br>
			<br> <input type="submit" name="btnSubmit" value="Submit">
			<input type="reset" name="btnReset" value="Reset">
		</form>
		<br>
		<button onclick="window.location.href='manageBooks.jsp'">Cancel</button>
	</div>
	<br>
	<%@include file="footer.html"%>
</body>
</html>