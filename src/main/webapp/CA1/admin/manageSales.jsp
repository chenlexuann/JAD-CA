<!-- Author: Angie Toh Anqi
Class: DIT/FT/2A/02
Date: 2/8/2023
Description: ST0510/JAD Assignment 2 -->

<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Manage Sales</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
	integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
	crossorigin="anonymous">
<script>
	
<%String role = session.getAttribute("sessUserRole") + "";
String message = request.getParameter("statusCode");
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
		<h2 align="center">Manage Sales</h2>
		<br> <select id="dateFilter">
			<option value="thisWeek">This Week</option>
			<option value="thisMonth">This Month</option>
			<option value="thisYear">This Year</option>
			<option value="allTime" selected>All Time</option>
		</select> <select id="dateSort">
			<option value="newest">Newest to Oldest</option>
			<option value="oldest">Oldest to Newest</option>
			<option value="none" selected>None</option>
		</select> <br> <br>
		
		<table id="salesTable" border='1' align='center'
			style='border-collapse: collapse; text-align: center;'>
			<tbody>
				<tr>
					<th style='padding: 5px;'>order id</th>
					<th style='padding: 5px;'>member email</th>
					<th style='padding: 5px;'>titles</th>
					<th style='padding: 5px;'>quantities</th>
					<th style='padding: 5px;'>total price</th>
					<th style='padding: 5px;'>order date</th>
				</tr>

				<%@ page import="java.text.DecimalFormat"%>
				<%
				try {
					int id;
					String email = "";
					String titles = "";
					String quantities = "";
					double total_price;
					String order_date = "";

					// Step1: Load JDBC Driver
					Class.forName("com.mysql.cj.jdbc.Driver");

					// Step 2: Define Connection URL
					String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=root&serverTimezone=UTC";

					// Step 3: Establish connection to URL
					Connection conn = DriverManager.getConnection(connURL);

					// Step 4: Create Statement object
					Statement stmt = conn.createStatement();

					// Step 5: Execute SQL Command
					String sqlStr = "SELECT o.order_id, m.email AS member_email, o.order_date, GROUP_CONCAT(CONCAT(b.title, ',') SEPARATOR '') AS titles, GROUP_CONCAT(CONCAT(oi.quantity, ',') SEPARATOR '') AS quantities, SUM(oi.unit_price * oi.quantity) AS total_price "
					+ "FROM orders o " + "JOIN order_items oi ON o.order_id = oi.order_id "
					+ "JOIN books b ON oi.book_id = b.book_id " + "JOIN members m ON o.member_id = m.member_id "
					+ "GROUP BY o.order_id";
					ResultSet rs = stmt.executeQuery(sqlStr);

					// Step 6: Process Result
					while (rs.next()) {
						id = rs.getInt("order_id");
						email = rs.getString("member_email");
						titles = rs.getString("titles");
						quantities = rs.getString("quantities");
						total_price = rs.getDouble("total_price");
						order_date = rs.getString("order_date");

						// format total price to two decimal points
						DecimalFormat df = new DecimalFormat("#.##");
						String formattedTotalPrice = df.format(total_price);
				%>
				<tr>
					<td style='padding: 5px;'><%=id%></td>
					<td style='padding: 5px;'><%=email%></td>
					<td style='padding: 5px;'><%=titles.replace(",", "<br>")%></td>
					<td style='padding: 5px;'><%=quantities.replace(",", "<br>")%></td>
					<td style='padding: 5px;'>$<%=formattedTotalPrice%></td>
					<td style='padding: 5px;'><%=order_date%></td>
				</tr>
				<%
				}

				// Step 7: Close connection
				conn.close();

				} catch (Exception e) {
				out.print("Error :" + e);
				}
				%>
			</tbody>
		</table>
		<br>
		<button onclick="window.location.href='menu.jsp'">Back to
			Menu</button>
	</div>
	<br>
	<br>
</body>
<script>
	$(document).ready(
			function() {
				// Initial table data
				var originalTableContent = $('#salesTable').html();
				var sortedTableContent = $('#salesTable').html(); // Copy of original content for sorting

				// Handle dropdown change event
				$('#dateFilter').change(function() {
					var selectedValue = $(this).val();

					if (selectedValue === 'thisWeek') {
						filterTableByDateRange(getStartOfWeek(), new Date());
					} else if (selectedValue === 'thisMonth') {
						filterTableByDateRange(getStartOfMonth(), new Date());
					} else if (selectedValue === 'thisYear') {
						filterTableByDateRange(getStartOfYear(), new Date());
					} else if (selectedValue === 'allTime') {
						resetTableContent();
					}
				});

				// Function to reset table content
				function resetTableContent() {
					$('#salesTable').html(originalTableContent);
				}

				// Function to get the start of the week
				function getStartOfWeek() {
					var today = new Date();
					var startOfWeek = new Date(today.getFullYear(), today
							.getMonth(), today.getDate() - today.getDay() + 1);
					return startOfWeek;
				}

				// Function to get the start of the month
				function getStartOfMonth() {
					var today = new Date();
					var startOfMonth = new Date(today.getFullYear(), today
							.getMonth(), 1);
					return startOfMonth;
				}

				// Function to get the start of the year
				function getStartOfYear() {
					var today = new Date();
					var startOfYear = new Date(today.getFullYear(), 0, 1);
					return startOfYear;
				}

				// Function to filter the table data by date range
				function filterTableByDateRange(startDate, endDate) {
					$('#salesTable tr:not(:first-child)').each(
							function() {
								var orderDateStr = $(this)
										.find('td:last-child').text();
								var orderDate = new Date(orderDateStr);

								if (orderDate >= startDate
										&& orderDate <= endDate) {
									$(this).show();
								} else {
									$(this).hide();
								}
							});
				}

				$('#dateSort').change(function() {
					var selectedSort = $(this).val();

					if (selectedSort === 'newest') {
						sortTableByRecency('desc');
					} else if (selectedSort === 'oldest') {
						sortTableByRecency('asc');
					} else if (selectedSort === 'none') {
						resetTableContent();
					}
				});

				// Function to sort the table data by recency
				function sortTableByRecency(order) {
					var sortedRows = $('#salesTable tr:not(:first-child)')
							.toArray().sort(
									function(a, b) {
										var dateA = new Date($(a).find(
												'td:last-child').text());
										var dateB = new Date($(b).find(
												'td:last-child').text());

										if (order === 'desc') {
											return dateB - dateA;
										} else {
											return dateA - dateB;
										}
									});

					$('#salesTable tbody').empty();
					$('#salesTable tbody').append(sortedRows);
				}
			});
</script>
</html>