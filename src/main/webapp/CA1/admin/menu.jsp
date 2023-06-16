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
<title>Menu</title>
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

	out.print("<div align='center'><h2>Menu</h2>");
	out.print("Welcome " + dm_userID + "!<br>");
	out.print("Your user role is: " + dm_userRole + "<br><br>");
	%>

	<button onclick="window.location.href='manageBooks.jsp'">Manage
		Books</button>
	<button onclick="window.location.href='manageMembers.jsp'">Manage
		Members</button>
	</div>
	<br>
	<%@include file="footer.html"%>
</body>
</html>