<!-- Author: Angie Toh Anqi
Class: DIT/FT/2A/02
Date: 8/6/2023
Description: ST0510/JAD Assignment 1 -->

<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Genre Form</title>
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

	<div align='center'>
		<h2>Create Genre Form</h2>
		<form action='createGenre.jsp' method='POST'>
			Genre: <input type='text' name='genre' style='margin-bottom: 10px;'><br>
			<br> <input type='submit' name='btnSubmit' value='Submit'>
			<input type='reset' name='btnReset' value='Reset'>
		</form>

		<%-- <%
		try {
			String title = "";

			// Step1: Load JDBC Driver
			// Class.forName("com.mysql.cj.jdbc.Driver");

			// Step 2: Define Connection URL
			String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=T0513022G&serverTimezone=UTC";

			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Step 4: Create Statement object
			Statement stmt = conn.createStatement();

			// Step 5: Execute SQL Command
			String sqlStr = "SELECT * FROM books";
			ResultSet rs = stmt.executeQuery(sqlStr);
			out.print(
			"<div align='center'><h2>Create Genre Form</h2><form action='createGenre.jsp' method='POST'>Genre: <input type='text' name='genre' style='margin-bottom: 10px;'><br><br>Select Books:<br>");

			// Step 6: Process Result
			while (rs.next()) {
				title = rs.getString("title");
				out.print("<input type='checkbox' name='titles' value='" + title + "'>" + title + "<br>");
			}
			out.print(
			"<br><input type='submit' name='btnSubmit'value='Submit'> <input type='reset' name='btnReset' value='Reset'></form>");

			// Step 7: Close connection
			conn.close();

		} catch (Exception e) {
			out.print("Error :" + e);
		}
		%> --%>

		<br>
		<button onclick="window.location.href='manageBooks.jsp'">Cancel</button>
	</div>
	<br>
	<%@include file="footer.html"%>
</body>
</html>