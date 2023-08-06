<!-- Author: Angie Toh Anqi
Class: DIT/FT/2A/02
Date: 8/6/2023
Description: ST0510/JAD Assignment 1 -->

<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Members</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<script>
<%String role = session.getAttribute("sessUserRole") + "";
String message = request.getParameter("statusCode");
if (message != null && message.equals("success")) {%>
	alert("Success!");
	<%}
if (message != null && message.equals("unsuccessful")) {%>
	alert("Something went wrong!");
	<%}
if (message != null && message.equals("duplicateEmail")) {%>
	alert("This email is already in use.");
	<%}
if (message != null && message.equals("noChanges")) {%>
	alert("No changes made.");
	<%}

boolean admin = false;
if (role != null && role.equals("adminUser")) {
	admin = true;
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
				<%
				if (admin) {
				%>
				<li class="nav-item"><a class="nav-link mx-2"
					aria-current="page" href="menu.jsp" id="Admin">Admin</a></li>
				<%
				}
				%>
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
		<h2 align="center">Manage Members</h2>
		<br>
		<div>
			<input type="text" id="emailSearch"
				placeholder="Search by Member Email"> <input type="text"
				id="addressSearch" placeholder="Search by Address">
			<button id="searchButton">Search</button>
		</div>
		<br> <select id="sortPostalCode" onchange="updateSort()">
			<option name="sort" value="none"
				<%if ("none".equals(request.getParameter("sort")))
	out.print("selected");%>>None</option>
			<option name="sort" value="ascending"
				<%if ("ascending".equals(request.getParameter("sort")))
	out.print("selected");%>>Ascending
				Postal Code</option>
			<option name="sort" value="descending"
				<%if ("descending".equals(request.getParameter("sort")))
	out.print("selected");%>>Descending
				Postal Code</option>
		</select><br> <br>
		<button onclick="window.location.href='createMemberForm.jsp'">Create
			new Member</button>
		<br> <br>

		<%
		String msg = "";
		try {
			int id;
			String first_name = "";
			String last_name = "";
			String email = "";
			String password = "";
			String address = "";
			String postalCode = "";

			// Step1: Load JDBC Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Step 2: Define Connection URL
			String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=root&serverTimezone=UTC";

			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Step 4: Create Statement object
			Statement stmt = conn.createStatement();

			// Step 5: Execute SQL Command
			String selectedSort = request.getParameter("sort");
			String sqlStr = "SELECT * FROM members";
			String orderByClause = "";

			if ("ascending".equals(selectedSort)) {
				orderByClause = " ORDER BY postalCode ASC";
			} else if ("descending".equals(selectedSort)) {
				orderByClause = " ORDER BY postalCode DESC";
			}

			sqlStr += orderByClause;
			ResultSet rs = stmt.executeQuery(sqlStr);

			// Step 6: Process Result

			out.print(
			"<table id='membersTable' border='1' align='center' style='border-collapse: collapse; text-align: center;'><tbody>");
			out.print(
			"<tr><th style='padding: 5px;'>id</th><th style='padding: 5px;'>first name</th><th style='padding: 5px;'>last name</th><th style='padding: 5px;'>email</th><th style='padding: 5px;'>password</th><th style='padding: 5px;'>address</th><th style='padding: 5px;'>postal code</th><th colspan='2' style='padding: 5px;'>action</th></tr>");

			while (rs.next()) {
				id = rs.getInt("member_id");
				first_name = rs.getString("first_name");
				last_name = rs.getString("last_name");
				email = rs.getString("email");
				password = rs.getString("password");
				address = rs.getString("address");
				postalCode = rs.getString("postalCode");

				out.print("<tr><td style='padding: 5px;'>" + id + "</td><td style='padding: 5px;'>" + first_name
				+ "</td><td style='padding: 5px;'>" + last_name + "</td><td style='padding: 5px;'>" + email
				+ "</td><td style='padding: 5px;'>" + password + "</td><td style='padding: 5px;'>" + address
				+ "</td><td style='padding: 5px;'>" + postalCode + "</td>");
				out.print("<td style='padding: 5px;'><a href='editMember.jsp?id=" + id + "&first_name=" + first_name
				+ "&last_name=" + last_name + "&email=" + email + "&password=" + password + "&address=" + address
				+ "&postalCode=" + postalCode
				+ "'><button>edit</button></a></td><td style='padding: 5px;'><button style='background-color: red; color: white;' onclick='confirmDelete(\""
				+ email + "\")'>delete</button></a></td></tr>");
			}
			out.print("</tbody></table>");

			// Step 7: Close connection
			conn.close();

		} catch (Exception e) {
			out.print("Error :" + e);
		}
		%>

		<br>
		<button onclick="window.location.href='menu.jsp'">Back to
			Menu</button>
	</div>
	<br>
	<br>
</body>
<script>
	function confirmDelete(email) {
		if(confirm("Are you sure you want to delete this member?\nemail:" + email)){ // if user clicks "OK"
			var url = "<%=request.getContextPath()%>/deleteMemberServlet?email=" + email;
			window.location.href = url;
		} else {
			// do nothing
		}
	}

	function updateSort() {
		var selectedSort = document.getElementById("sortPostalCode").value;
		var currentURL = window.location.href;

		// update URL query parameters "sort" with selected options
		var updatedURL = updateQueryStringParameter(currentURL, "sort",
				selectedSort);

		// redirect to updated URL
		window.location.href = updatedURL;
	}

	function updateQueryStringParameter(uri, key, value) {
		var re = new RegExp("([?&])" + key + "=.*?(&|$)", "i");
		var separator = uri.indexOf("?") !== -1 ? "&" : "?";

		if (uri.match(re)) {
			return uri.replace(re, "$1" + key + "=" + value + "$2");
		} else {
			return uri + separator + key + "=" + value;
		}
	}

	$('#searchButton').click(
			function() {
				var email = $('#emailSearch').val().toLowerCase();
				var address = $('#addressSearch').val().toLowerCase();

				$('#membersTable tr:not(:first-child)').each(
						function() {
							var row = $(this);
							var membersEmail = row.find('td:nth-child(4)')
									.text().toLowerCase();
							var rowAddress = row.find('td:nth-child(6)').text()
									.toLowerCase();

							if (membersEmail.includes(email)
									&& rowAddress.includes(address)) {
								row.show();
							} else {
								row.hide();
							}
						});
			});
</script>
</html>