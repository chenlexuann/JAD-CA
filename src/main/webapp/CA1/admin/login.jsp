<!-- Author: Angie Toh Anqi
Class: DIT/FT/2A/02
Date: 8/6/2023
Description: ST0510/JAD Assignment 1 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Admin Login</title>
</head>
<body>
	<%@include file="header.html"%>
	<%
	String message = request.getParameter("errCode");

	out.print("<div align='center'><h2>Admin Login</h2>");

	if (message != null && message.equals("invalidLogin")) {
		out.print("Sorry, error in login... Please try again!<br><br>");
	}

	if (message != null && message.equals("sessionTimeOut")) {
		out.print("Sorry, session timed out... Please log in again!<br><br>");
	}
	%>

	<form action="<%=request.getContextPath()%>/VerifyAdminServlet"
		method="POST">
		Email: <input type="text" name="loginid" style="margin-bottom: 10px;"><br>
		Password: <input type="password" name="password" style="margin-bottom: 10px;"> <br> <br>
		<input type="submit" name="btnSubmit" value="Login"> <input
			type="reset" name="btnReset" value="Reset">
	</form>
	<br>
	</div>

	<%@include file="footer.html"%>
</body>
</html>