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
	
<%DecimalFormat dcf = new DecimalFormat("#.##");
request.setAttribute("dcf", dcf);
ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
List<Cart> cartProduct = null;
User user = new User();
String Address = "";
String Postal = "";
double total = 0.0;
String memberID = session.getAttribute("sessMemberID") + "";
try {
	if (memberID != null) {
		UserDAO uDAO = new UserDAO();
		user = uDAO.getUserDetails(memberID);
		request.setAttribute("user", user);
	}
	if (cart_list != null) {
		CartDAO cDAO = new CartDAO();
		cartProduct = cDAO.getCartProducts(cart_list);
		total = cDAO.getTotalCartPrice(cart_list);
		request.setAttribute("total", total);
		request.setAttribute("cart_list", cart_list);
	} else {
		response.sendRedirect("home.jsp?statusCode=emptyCart");
	}
	if (user == null) {
		response.sendRedirect("home.jsp?statusCode=sessionTimeOut");
	}
	if (user.getAddress() != null) {
		Address = user.getAddress();
	}

	if (user.getPostalCode() != null) {
		Postal = user.getPostalCode();
	}
} catch (Exception e) {
	response.sendRedirect("home.jsp?statusCode=sessionTimeOut");
}%>
	
</script>
</head>
<body>
	<div class="row">
		<div class="col-75">
			<div class="container">
				<form
					action="<%=request.getContextPath()%>/checkoutServlet?total=<%=total%>"
					method="post">
					<div class="row">
						<div class="col-50">
							<h3>Billing Address</h3>
							<hr>
							<div class="row">
								<div class="col-50">
									<label for="fname"><i class="fa fa-user"></i> First
										Name</label> <input type="text" id="fname" name="firstname"
										placeholder="John M. Doe" value="<%=user.getFirstName()%>"
										required>
								</div>
								<div class="col-50">
									<label for="fname"><i class="fa fa-user"></i> Last Name</label>
									<input type="text" id="lname" name="lastname"
										placeholder="John M. Doe" value="<%=user.getLastName()%>"
										required>
								</div>
							</div>
							<label for="email"><i class="fa fa-envelope"></i> Email</label> <input
								type="text" id="email" name="email" value="<%=user.getEmail()%>"
								readonly>
							<div class="row">
								<div class="col-50">
									<label for="adr"><i class="fa fa-address-card-o"></i>
										Address</label> <input type="text" id="adr" name="address"
										placeholder="123 sunshine road" value="<%=Address%>" required>
								</div>
								<div class="col-50">
									<label for="zip">PostalCode</label> <input type="text"
										id="postal" name="postal" placeholder="123456"
										value="<%=Postal%>" required>
								</div>
							</div>
						</div>

					</div>
					<label> <input type="checkbox" checked="checked"
						name="sameadr"> Shipping address same as billing
					</label> <input type="submit" value="checkout" class="btn1">
				</form>
			</div>
		</div>
		<div class="col-25">
			<div class="container">
				<h4>
					Cart <span class="price" style="color: black"><i
						class="fa fa-shopping-cart"></i> </span>
				</h4>
				<%
				if (cart_list != null) {
					for (Cart c : cartProduct) {
				%>
				<p>
					<img src="<%=c.getImageUrl()%>" class="tiny-image" alt="Book Image">&nbsp;&nbsp;<a
						href="<%=request.getContextPath()%>/bookDetailsServlet?bookId=<%=c.getBookId()%>"><%=c.getTitle()%></a>&nbsp;&nbsp;<span
						class="Quantity"><%=c.getCartQuantity()%></span> <span
						class="price"><%=((DecimalFormat) request.getAttribute("dcf")).format(c.getPrice())%></span>
				</p>
				<hr>
				<%
				}
				}
				%>
				<p>
					Total (w/o GST): <span class="price" style="color: black"><b>$
							${(total>0)?dcf.format(total):0}</b></span>
				</p>
			</div>
		</div>
	</div>

	<%@ include file="footer.jsp"%>
</body>
</html>
