
<!-- Author: Chen Lexuan
Class: DIT/FT/2A/02
Date: 6/8/2023
Description: ST0510/JAD Assignment -->
<%
boolean loggedIn = false;
boolean admin = false;
boolean member = false;
String role = session.getAttribute("sessUserRole") + "";
String message = request.getParameter("statusCode");
if (role != null && role.equals("adminUser")) {
	admin = true;
}
if (role != null && role.equals("memberUser") || role.equals("adminUser")) {
	loggedIn = true;
}
if (role != null && role.equals("memberUser")) {
	member = true;
}
if (message != null && message.equals("emptyCart")) {
%><script>
	alert("Empty cart");
</script>
<%
}
if (message != null && message.equals("invalidLogin")) {
%>
<script>
	alert("Wrong email or password!");
</script>
<%
}

if (message != null && message.equals("sessionTimeOut")) {
%>
<script>
	alert("Session timed out. Please log in again!");
</script>
<%
}

if (message != null && message.equals("err")) {
%>
<script>
	alert("Error!");
</script>
<%
}
%>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
	<a class="navbar-brand" href="home.jsp"> <img
		src="./img/kittyLogo.png" width="auto" height="50" alt="kitty books">
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
					<%
					if (loggedIn) {
					%>
					<form action='<%=request.getContextPath()%>/logoutUserServlet'
						class=logoutForm id="Logout">
						<button type="submit" class="btn btn-danger mr-2">Logout</button>
					</form>
					<%
					} else {
					%>
					<a href="login.jsp" class="btn btn-primary mr-2" id="Login">Log
						In</a>
					<%
					}
					%>
				</div>
			</li>
			<li class="nav-item"><a class="nav-link active mx-2"
				aria-current="page" href="home.jsp">Home</a></li>
			<%
			if (admin) {
			%>
			<li class="nav-item"><a class="nav-link mx-2"
				aria-current="page" href="CA1/admin/menu.jsp" id="Admin">Admin</a></li>
			<%
			} else if (member) {
			String firstName = (String) session.getAttribute("sessUserName");
			%>
			<li class="nav-item"><a class="nav-link mx-2"
				aria-current="page" href="CA1/member/viewAccount.jsp" id="UserEdit">
					<%=firstName%>
			</a></li>
			<li class="nav-item"><a class="nav-link mx-2"
				aria-current="page" href="viewOrderHistory.jsp" id="OrderHistory">
					Orders </a></li>
			<%
			}
			if (loggedIn && member) {
			%>
		</ul>
		<ul class="navbar-nav ml-auto">
			<li class="nav-item"><a class="nav-link mx-2"
				href="<%=request.getContextPath()%>/getCartServlet"> <i
					class="fas fa-shopping-cart"></i> Cart
			</a></li>
		</ul>
		<%
		}
		%>
	</div>
</nav>