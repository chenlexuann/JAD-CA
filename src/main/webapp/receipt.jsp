<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
	<!-- Author: Chen Lexuan
Class: DIT/FT/2A/02
Date: 6/8/2023
Description: ST0510/JAD Assignment -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<%@ page import="java.util.*"%>
<%@ page import="model.*"%>
<title>Payment Receipt</title>
<style type="text/css">
table {
	border: 0;
}

table td {
	padding: 5px;
}
</style>
</head>
<body>
	<div align="center">
		<h1>Payment Done. Thank you for purchasing our products</h1>
		<br />
		<h2>Receipt Details:</h2>
		<table>
			<tr>
				<td><b>Merchant:</b></td>
				<td>Kitty Books Ptd Ltd.</td>
			</tr>
			<tr>
				<td><b>Payer:</b></td>
				<td>${payer.firstName}${payer.lastName}</td>
			</tr>
			<tr>
				<td><b>Description:</b></td>
				<td>${transaction.description}</td>
			</tr>
			<tr>
				<td><b>Subtotal:</b></td>
				<td>${transaction.amount.details.subtotal} SGD</td>
			</tr>
			<tr>
				<td><b>Tax:</b></td>
				<td>${transaction.amount.details.tax} SGD</td>
			</tr>
			<tr>
				<td><b>Total:</b></td>
				<td>${transaction.amount.total} SGD</td>
			</tr>
		</table>
		<form action="home.jsp">
			<table>
				<tr>
					<td colspan="2" align="center"><input type="submit"
						value="back to home page" /></td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>