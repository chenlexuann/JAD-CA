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
<title>View Account</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<script>
<%String role = session.getAttribute("sessUserRole") + "";
String message = request.getParameter("statusCode");
if (message != null && message.equals("success")){
	%>
	alert("Success!");
	<%
}
if (message != null && message.equals("unsuccessful")){
	%>
	alert("Something went wrong!");
	<%
}
if (message != null && message.equals("noChanges")){
	%>
	alert("No changes made.");
	<%
}

boolean member = false;
if (role != null && role.equals("memberUser")) {
	member = true;
}%></script>
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
			<ul class="navbar-nav ml-auto">
				<li class="nav-item"><a class="nav-link mx-2"
					href="../../cart.jsp"> <i class="fas fa-shopping-cart"></i>
						Cart
				</a></li>
			</ul>
		</div>
	</nav>
	<%@page import="java.sql.*"%>
	<%
	String dm_userID = (String) session.getAttribute("sessUserID");
	String dm_userRole = (String) session.getAttribute("sessUserRole");
	String dm_loginStatus = (String) session.getAttribute("loginStatus");

	if (dm_userID == null || !dm_loginStatus.equals("success")) {
		response.sendRedirect("../../login.jsp?errCode=sessionTimeOut");
	}

	out.print("<div align='center'><h2>View Account</h2>");
	out.print("Welcome " + dm_userID + "!<br>");
	out.print("Your user role is: " + dm_userRole + "<br><br>");

	int id = 0;
	String first_name = "";
	String last_name = "";
	String email = "";
	String password = "";
	String address = "";
	String postalCode = "";

	try {
		// Step1: Load JDBC Driver
		Class.forName("com.mysql.cj.jdbc.Driver");

		// Step 2: Define Connection URL
		String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=root&serverTimezone=UTC";

		// Step 3: Establish connection to URL
		Connection conn = DriverManager.getConnection(connURL);

		// Step 4: Create Statement object
		// Statement stmt = conn.createStatement();

		// Step 5: Execute SQL Command
		String sqlStr = "SELECT * FROM members WHERE email=?";
		PreparedStatement pstmt = conn.prepareStatement(sqlStr);
		pstmt.setString(1, dm_userID);
		ResultSet rs = pstmt.executeQuery();
		
		// Step 6: Process Result
		if (rs.next()) {
			id = rs.getInt("member_id");
			first_name = rs.getString("first_name");
			last_name = rs.getString("last_name");
			email = rs.getString("email");
			password = rs.getString("password");
			address = rs.getString("address");
			postalCode = rs.getString("postalCode");
		}

		// Step 7: Close connection
		conn.close();

	} catch (Exception e) {
		out.print("Error :" + e);
	}
	%>

	<div align="center">
		<form action="editAccount.jsp" method="POST">
			<table border="1" style="border-collapse: collapse;">
				<tr>
					<td style="padding: 5px;">first name:</td>
					<td style="padding: 5px;"><span><%=first_name%></span>
					<input type="hidden" name="id" value="<%=id%>"></td>
				</tr>
				<tr>
					<td style="padding: 5px;">last name:</td>
					<td style="padding: 5px;"><span><%=last_name%></span></td>
				</tr>
				<tr>
					<td style="padding: 5px;">email:</td>
					<td style="padding: 5px;"><span><%=email%></span></td>
				</tr>
				<tr>
					<td style="padding: 5px;">password:</td>
					<td style="padding: 5px;"><span><%=password%></span></td>
				</tr>
				<tr>
					<td style="padding: 5px;">address:</td>
					<td style="padding: 5px;"><span><%=address%></span></td>
				</tr>
								<tr>
					<td style="padding: 5px;">postalCode:</td>
					<td style="padding: 5px;"><span><%=postalCode%></span></td>
				</tr>
				<tr>
					<td colspan="2" align="center" style="padding: 5px;"><input
						type="submit" value="Edit" /></td>
				</tr>
			</table>
		</form>
		<br>
		<button style='background-color: red; color: white;'
			onclick='confirmDelete("<%=email%>")'>Delete Account</button>
	</div>
	<br>
</body>
<script>
	function confirmDelete(email) {
		if(confirm("Are you sure you want to delete your account?")){ // if user clicks "OK"
			var url = "<%=request.getContextPath()%>/deleteMemberServlet?email=" + email; 
			window.location.href = url;
		} else {
			// do nothing
		}
	}
</script>
</html>