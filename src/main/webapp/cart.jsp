<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- Author: Chen Lexuan
Class: DIT/FT/2A/02
Date: 8/6/2023
Description: ST0510/JAD Assignment 1 -->
<%@ page import="java.util.*"%>
<%@ page import="model.*"%>
<%@ page import="dbaccess.*"%>
<%@ page import="java.text.DecimalFormat"%>
<!DOCTYPE html>
<html>
<head>
<%@ include file="header.jsp"%>
<meta charset="UTF-8">
<title>Cart</title>
<%@ include file="navbar.jsp"%>
<script>
	
<%DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
try {
	if (cart_list != null) {
		CartDAO cDAO = new CartDAO();
		cartProduct = cDAO.getCartProducts(cart_list);
		double total = cDAO.getTotalCartPrice(cart_list);
		request.setAttribute("total", total);
		request.setAttribute("cart_list", cart_list);
	}
} catch (Exception e) {
	e.printStackTrace(); // For logging the exception
	response.sendRedirect("home.jsp?statusCode=err");

}%>
	
</script>
<style>
.center-text {
	display: flex;
	justify-content: center;
	align-items: center;
	height: 50vh;
	font-size: 24px;
	font-weight: bold;
}

.tiny-image {
	width: 50px; /* Set the width of the image */
	height: auto; /* Maintain the aspect ratio */
}
</style>
</head>
<body>
	<div class="container">
		<div class="row justify-content-center">
			<div class="col-lg-10">
				<table class="table">
					<thead>
						<tr>
							<th>Cover</th>
							<th>Title</th>
							<th>Author</th>
							<th>Quantity Left</th>
							<th>Total Price</th>
							<th>Order Quantity</th>
							<th>Action</th>
						</tr>
					</thead>
					<tbody>
						<%
						if (cart_list != null) {
							for (Cart c : cartProduct) {
						%>
						<tr>
							<td><img src="<%=c.getImageUrl()%>" class="tiny-image"
								alt="Book Image"></td>
							<td><%=c.getTitle()%></td>
							<td><%=c.getAuthorName()%></td>
							<td><%=c.getBookQuantity()%></td>
							<td><%=((DecimalFormat) request.getAttribute("dcf")).format(c.getPrice())%></td>
							<td>
								<form action="order-now" method="post" class="form-inline">
									<input type="hidden" name="id" value="<%=c.getBookId()%>"
										class="form-input">
									<div class="form-group d-flex justify-content-between">
										<a class="btn bnt-sm btn-incre"
											href="quantity-inc-dec?action=inc&id=<%=c.getBookId()%>&quantityMax=<%=c.getBookQuantity()%>"><i
											class="fas fa-plus-square"></i></a> <input type="text"
											name="quantity" class="form-control"
											value="<%=c.getCartQuantity()%>" readonly> <a
											class="btn btn-sm btn-decre"
											href="quantity-inc-dec?action=dec&id=<%=c.getBookId()%>&quantityMax=<%=c.getBookQuantity()%>"><i
											class="fas fa-minus-square"></i></a>
									</div>
								</form>
							</td>
							<td><a
								href="<%=request.getContextPath()%>/removeBookServlet?id=<%=c.getBookId()%>"
								class="btn btn-sm btn-danger">Remove</a></td>
						</tr>
						<%
						}
						}
						%>
					</tbody>
				</table>
				<div class="text-right">
					<h5>Total Price (w/o GST): $ ${(total>0)?dcf.format(total):0}
					</h5>
					<a class="mx-3 btn btn-primary" href="checkout.jsp">Check Out</a>
				</div>
			</div>
		</div>
	</div>
	<%@ include file="footer.jsp"%>
</body>
</html>