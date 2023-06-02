function loginVerify() {
	var message = request.getParameter("statusCode");
	if (message != null && message.equals("invalidLogin")) {
		$("#Logout").hide();
		$("#Login").show();
		$("#Admin").hide();
		$("#AddDVD").hide();
	} else {
		$("#Login").hide();
		$("#Logout").show();
		$("#Admin").show();
		$("#AddDVD").show();
	}
}