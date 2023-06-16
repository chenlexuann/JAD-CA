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
<title>Create Book Form</title>
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
		<h2>Create Book Form</h2>
		<form action="createBook.jsp">
			genre: <select name="genre" style="margin-bottom: 10px;">
				<option value="Fantasy">Fantasy</option>
				<option value="Science Fiction">Science Fiction</option>
				<option value="Mystery">Mystery</option>
			</select><br> author: <select name="author" style="margin-bottom: 10px;">
				<option value="Isaac Asimov">Isaac Asimov</option>
				<option value="Agatha Christie">Agatha Christie</option>
				<option value="Stephen King">Stephen King</option>
				<option value="Gillan Flynn">Gillan Flynn</option>
			</select><br> publisher: <select name="publisher"
				style="margin-bottom: 10px;">
				<option value="Penguin Random House">Penguin Random House</option>
				<option value="Simon & Schuster">Simon & Schuster</option>
				<option value="Macmillan Publishers">Macmillan Publishers</option>
				<option value="Hachette Book Group">Hachette Book Group</option>
			</select><br> Title: <input type="text" name="title"
				style="margin-bottom: 10px;"><br> Price: <input
				type="text" name="price" style="margin-bottom: 10px;"><br>
			Quantity: <input type="text" name="quantity"
				style="margin-bottom: 10px;"><br>Description: <input
				type="text" name="description" style="margin-bottom: 10px;"><br>
			Publication Date: <input type="text" name="publication_date"
				style="margin-bottom: 10px;"><br> ISBN: <input
				type="text" name="ISBN" style="margin-bottom: 10px;"><br>
			Rating: <select name="rating" style="margin-bottom: 10px;">
				<option value="G">G</option>
				<option value="PG">PG</option>
				<option value="PG-13">PG-13</option>
				<option value="R">R</option>
				<option value="NC-17">NC-17</option>
			</select><br> <br> <input type="submit" name="btnSubmit"
				value="Submit"> <input type="reset" name="btnReset"
				value="Reset">
		</form>
		<br>
		<button onclick="window.location.href='manageBooks.jsp'">Cancel</button>
	</div>
	<br>
	<%@include file="footer.html"%></body>
</html>