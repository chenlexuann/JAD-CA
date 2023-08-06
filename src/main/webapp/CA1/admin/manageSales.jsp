<!-- Author: Angie Toh Anqi
Class: DIT/FT/2A/02
Date: 2/8/2023
Description: ST0510/JAD Assignment 2 -->

<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.text.DecimalFormat"%>

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
		<br>
		<div>
			<input type="text" id="emailSearch"
				placeholder="Search by Member Email"> <input type="text"
				id="titleSearch" placeholder="Search by Title">
			<button id="searchButton">Search</button>
		</div><br>
		<select id="dateFilter">
			<option value="thisWeek">This Week</option>
			<option value="thisMonth">This Month</option>
			<option value="thisYear">This Year</option>
			<option value="allTime" selected>All Time</option>
		</select> <select id="dateSort">
			<option value="newest">Newest to Oldest</option>
			<option value="oldest">Oldest to Newest</option>
			<option value="none" selected>None</option>
		</select> <select id="priceSort">
			<option value="mostExpensive">Most to Least Expensive</option>
			<option value="leastExpensive">Least to Most Expensive</option>
			<option value="none" selected>None</option>
		</select><br> <br>
	</div>

	<div style="display: flex; justify-content: center;">
		<div style="width: 30%; margin-right: 10px;">
			<h3 align='center'>Top 10 Customers</h3>
			<table id="topCustomersTable" border='1' align='center'
				style='border-collapse: collapse; text-align: center;'>
				<tbody>
					<tr>
						<th style='padding: 5px;'></th>
						<th style='padding: 5px;'>member email</th>
						<th style='padding: 5px;'>total spending</th>
					</tr>

					<%
					try {
						int ranking = 1;
						String topEmail = "";
						double total_spending;

						// Step1: Load JDBC Driver
						Class.forName("com.mysql.cj.jdbc.Driver");

						// Step 2: Define Connection URL
						String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=root&serverTimezone=UTC";

						// Step 3: Establish connection to URL
						Connection conn = DriverManager.getConnection(connURL);

						// Step 4: Create Statement object
						Statement stmt1 = conn.createStatement();

						// Step 5: Execute SQL Command
						String sqlStr1 = "SELECT m.email, SUM(oi.unit_price * oi.quantity) AS total_spending " + "FROM members m "
						+ "JOIN orders o ON m.member_id = o.member_id " + "JOIN order_items oi ON o.order_id = oi.order_id "
						+ "GROUP BY m.email " + "ORDER BY total_spending DESC " + "LIMIT 10";
						ResultSet rs1 = stmt1.executeQuery(sqlStr1);

						// Step 6: Process Result
						while (rs1.next()) {
							topEmail = rs1.getString("email");
							total_spending = rs1.getDouble("total_spending");

							// format total spending to two decimal points
							DecimalFormat df = new DecimalFormat("#.##");
							String formattedTotalSpending = df.format(total_spending);
					%>
					<tr>
						<td style='padding: 5px;'><%=ranking%></td>
						<td style='padding: 5px;'><%=topEmail%></td>
						<td style='padding: 5px;'>$<%=formattedTotalSpending%></td>
					</tr>
					<%
					ranking++;
					}

					/* // Step 7: Close connection
					conn.close();

					} catch (Exception e) {
					out.print("Error :" + e);
					} */
					%>
				</tbody>
			</table>
		</div>

		<div style="width: 65%;">
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

					<%
					int id;
					String salesEmail = "";
					String titles = "";
					String quantities = "";
					double total_price;
					String order_date = "";

					// Step 4: Create Statement object
					Statement stmt2 = conn.createStatement();

					// Step 5: Execute SQL Command
					String sqlStr2 = "SELECT o.order_id, m.email AS member_email, o.order_date, GROUP_CONCAT(CONCAT(b.title, ',') SEPARATOR '') AS titles, GROUP_CONCAT(CONCAT(oi.quantity, ',') SEPARATOR '') AS quantities, SUM(oi.unit_price * oi.quantity) AS total_price "
							+ "FROM orders o " + "JOIN order_items oi ON o.order_id = oi.order_id "
							+ "JOIN books b ON oi.book_id = b.book_id " + "JOIN members m ON o.member_id = m.member_id "
							+ "GROUP BY o.order_id";
					ResultSet rs2 = stmt2.executeQuery(sqlStr2);

					// Step 6: Process Result
					while (rs2.next()) {
						id = rs2.getInt("order_id");
						salesEmail = rs2.getString("member_email");
						titles = rs2.getString("titles");
						quantities = rs2.getString("quantities");
						total_price = rs2.getDouble("total_price");
						order_date = rs2.getString("order_date");

						// format total price to two decimal points
						DecimalFormat df = new DecimalFormat("#.##");
						String formattedTotalPrice = df.format(total_price);
					%>
					<tr>
						<td style='padding: 5px;'><%=id%></td>
						<td style='padding: 5px;'><%=salesEmail%></td>
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
		</div>
	</div>
	<br>
	<br>
	<div align="center">
		<button onclick="window.location.href='menu.jsp'">Back to
			Menu</button>
	</div>
</body>
<script>
	$(document).ready(
			function() {
				var originalTableContent = $('#salesTable').html();
				var sortedTableContent = $('#salesTable').html(); // Copy of original content for sorting

				// handle dropdown change event
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

				function resetTableContent() {
					$('#salesTable').html(originalTableContent);
				}

				function getStartOfWeek() {
					var today = new Date();
					var startOfWeek = new Date(today.getFullYear(), today
							.getMonth(), today.getDate() - today.getDay() + 1);
					return startOfWeek;
				}

				function getStartOfMonth() {
					var today = new Date();
					var startOfMonth = new Date(today.getFullYear(), today
							.getMonth(), 1);
					return startOfMonth;
				}

				function getStartOfYear() {
					var today = new Date();
					var startOfYear = new Date(today.getFullYear(), 0, 1);
					return startOfYear;
				}

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

				$('#priceSort').change(function() {
					var selectedSort = $(this).val();

					if (selectedSort === 'mostExpensive') {
						sortTableByPrice('desc');
					} else if (selectedSort === 'leastExpensive') {
						sortTableByPrice('asc');
					} else if (selectedSort === 'none') {
						resetTableContent();
					}
				});

				function sortTableByPrice(order) {
					var sortedRows = $('#salesTable tr:not(:first-child)')
							.toArray().sort(
									function(a, b) {
										var priceA = parseFloat($(a).find(
												'td:nth-child(5)').text()
												.replace('$', ''));
										var priceB = parseFloat($(b).find(
												'td:nth-child(5)').text()
												.replace('$', ''));

										if (order === 'desc') {
											return priceB - priceA;
										} else {
											return priceA - priceB;
										}
									});

					$('#salesTable tbody').empty();
					$('#salesTable tbody').append(sortedRows);
				}
				
				$('#searchButton').click(function () {
			        var email = $('#emailSearch').val().toLowerCase();
			        var title = $('#titleSearch').val().toLowerCase();

			        $('#salesTable tr:not(:first-child)').each(function () {
			            var row = $(this);
			            var salesEmail = row.find('td:nth-child(2)').text().toLowerCase();
			            var rowTitles = row.find('td:nth-child(3)').text().toLowerCase();

			            if (salesEmail.includes(email) && rowTitles.includes(title)) {
			                row.show();
			            } else {
			                row.hide();
			            }
			        });
			    });
			});
</script>
</html>