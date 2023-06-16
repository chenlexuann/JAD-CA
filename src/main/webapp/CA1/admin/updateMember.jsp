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
<title>Update Member</title>
</head>
<body>
	<%@page import="java.sql.*"%>
	<%@include file="header.html"%>
	<%
	String dm_userID = (String) session.getAttribute("sessUserID");
	String dm_userRole = (String) session.getAttribute("sessUserRole");
	String dm_loginStatus = (String) session.getAttribute("loginStatus");

	if (dm_userID == null || !dm_loginStatus.equals("success")) {
		response.sendRedirect("login.jsp?errCode=sessionTimeOut");
	}

	String id = request.getParameter("id");
	String first_name = request.getParameter("first_name");
	String oldFirstName = request.getParameter("oldFirstName");
	String last_name = request.getParameter("last_name");
	String oldLastName = request.getParameter("oldLastName");
	String email = request.getParameter("email");
	String oldEmail = request.getParameter("oldEmail");
	String password = request.getParameter("password");
	String oldPassword = request.getParameter("oldPassword");

	out.print("<div align='center'><h2>Update Member</h2>");
	if (email.equals(oldEmail) && password.equals(oldPassword) && first_name.equals(oldFirstName)
			&& last_name.equals(oldLastName)) {
		out.print("No changes made");
	} else {
		try {
			// Step1: Load JDBC Driver
			// Class.forName("com.mysql.cj.jdbc.Driver");

			// Step 2: Define Connection URL
			String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=root&serverTimezone=UTC";

			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Step 4: Create Statement object
			// Statement stmt = conn.createStatement();

			// Step 5: Execute SQL Command
			String sqlStr = "UPDATE members SET first_name=?, last_name=?, email=?, password=? WHERE member_id=?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, first_name);
			pstmt.setString(2, last_name);
			pstmt.setString(3, email);
			pstmt.setString(4, password);
			pstmt.setString(5, id);

			int nRowsAffected = pstmt.executeUpdate();

			String simpleProc = "{call getMember(?)}";
			CallableStatement cs = conn.prepareCall(simpleProc);
			cs.setString(1, id);
			ResultSet rs = cs.executeQuery();

			// Step 6: Process Result
			if (nRowsAffected > 0) {
		out.print("Successfully updated!");
			} else {
		out.print("Unsuccessful.");
			}

			while (rs.next()) {
		out.print("<br><br>id: " + rs.getString("member_id") + "<br>");
		out.print("first name: " + rs.getString("first_name") + "<br>");
		out.print("last name: " + rs.getString("last_name") + "<br>");
		out.print("email: " + rs.getString("email") + "<br>");
		out.print("password: " + rs.getString("password"));
			}

			// Step 7: Close connection
			conn.close();

		} catch (SQLIntegrityConstraintViolationException e) {
			out.print("Sorry, this email is already in use.");
		} catch (Exception e) {
			out.print("Error :" + e);
		}
	}
	%>

	<br>
	<br>
	<a href='manageMembers.jsp'><button>Back</button></a>
	</div>
	<br>
	<%@include file="footer.html"%>
</body>
</html>