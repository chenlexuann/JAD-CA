<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ page import="java.util.*"%>
<%@ page import="model.*"%>
<%@ page import="dbaccess.*"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ include file="header.jsp"%>
<title>home</title>
<%@ include file="navbar.jsp"%>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="./css/checkout.css" rel="stylesheet" />
<style>
.tiny-image {
	width: 20px; /* Set the width of the image */
	height: auto; /* Maintain the aspect ratio */
}
</style>
<script>
	
<%String memberID = session.getAttribute("sessMemberID") + "";
List<Order> Orderhistory = null;
try {
	if (memberID != null) {
		OrdersDAO oDAO = new OrdersDAO();
		Orderhistory = oDAO.getOrderHistory(memberID);
	}
} catch (Exception e) {
	response.sendRedirect("home.jsp?statusCode=sessionTimeOut");
}%>
	
</script>
</head>
<body>
	<div class="container">
		<h4>
			Order History <span class="price" style="color: black"></span>
		</h4>
		<div style="display: flex; justify-content: center;">
			<table id="salesTable" border='1'
				style='border-collapse: collapse; text-align: center;'>
				<thead>
					<tr>
						<th style='padding: 5px;'>order id</th>
						<th style='padding: 5px;'>titles</th>
						<th style='padding: 5px;'>quantities</th>
						<th style='padding: 5px;'>total price</th>
						<th style='padding: 5px;'>order date</th>
					</tr>
				</thead>
				<tbody>
					<%
					if (Orderhistory != null) {
						for (Order o : Orderhistory) {
					%>
					<tr>
						<td style='padding: 5px;'><%=o.getOrder_id()%></td>
						<td style='padding: 5px;'><%=o.getTitle().replace(",", "<br>")%></td>
						<td style='padding: 5px;'><%=o.getQuantities().replace(",", "<br>")%></td>
						<td style='padding: 5px;'>$<%=o.getPrice()%></td>
						<td style='padding: 5px;'><%=o.getOrder_date()%></td>
					</tr>
					<%
					}
					%>
				</tbody>
				<%
				}
				%>
			</table>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>
