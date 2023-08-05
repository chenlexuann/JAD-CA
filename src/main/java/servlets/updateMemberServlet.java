/*Author: Angie Toh Anqi
Class: DIT/FT/2A/02
Date: 26/7/2023
Description: ST0510/JAD Assignment 1*/

package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class updateMemberServlet
 */
@WebServlet("/updateMemberServlet")
public class updateMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public updateMemberServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		String dm_userRole = (String) session.getAttribute("sessUserRole");

		String id = request.getParameter("id");
		String first_name = request.getParameter("first_name");
		String oldFirstName = request.getParameter("oldFirstName");
		String last_name = request.getParameter("last_name");
		String oldLastName = request.getParameter("oldLastName");
		String email = request.getParameter("email");
		String oldEmail = request.getParameter("oldEmail");
		String password = request.getParameter("password");
		String oldPassword = request.getParameter("oldPassword");
		String address = request.getParameter("address");
		String oldAddress = request.getParameter("oldAddress");
		String postalCode = request.getParameter("postalCode");
		String oldPostalCode = request.getParameter("oldPostalCode");

		if (first_name.equals(oldFirstName) && last_name.equals(oldLastName) && email.equals(oldEmail)
				&& password.equals(oldPassword) && address.equals(oldAddress) && postalCode.equals(oldPostalCode)) {
			if (dm_userRole == "adminUser") {
				response.sendRedirect("CA1/admin/manageMembers.jsp?statusCode=noChanges");
			} else {
				response.sendRedirect("CA1/member/viewAccount.jsp?statusCode=noChanges");
			}
		} else {
			try {
				// Step1: Load JDBC Driver
				Class.forName("com.mysql.cj.jdbc.Driver");

				// Step 2: Define Connection URL
				String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=root&serverTimezone=UTC";

				// Step 3: Establish connection to URL
				Connection conn = DriverManager.getConnection(connURL);

				// Step 4: Create Statement object
				// Statement stmt = conn.createStatement();

				// Step 5: Execute SQL Command
				String sqlStr = "UPDATE members SET first_name=?, last_name=?, email=?, password=?, address=?, postalCode=? WHERE member_id=?";
				PreparedStatement pstmt = conn.prepareStatement(sqlStr);
				pstmt.setString(1, first_name);
				pstmt.setString(2, last_name);
				pstmt.setString(3, email);
				pstmt.setString(4, password);
				pstmt.setString(5, address);
				pstmt.setString(6, postalCode);
				pstmt.setString(7, id);

				int nRowsAffected = pstmt.executeUpdate();

				String simpleProc = "{call getMember(?)}";
				CallableStatement cs = conn.prepareCall(simpleProc);
				cs.setString(1, id);
				ResultSet rs = cs.executeQuery();

				// Step 6: Process Result
				if (nRowsAffected > 0) {
					if (dm_userRole == "adminUser") {
						response.sendRedirect("CA1/admin/manageMembers.jsp?statusCode=success");
					} else {
						response.sendRedirect("CA1/member/viewAccount.jsp?statusCode=success");
					}
				} else {
					if (dm_userRole == "adminUser") {
						response.sendRedirect("CA1/admin/manageMembers.jsp?statusCode=unsuccessful");
					} else {
						response.sendRedirect("CA1/member/viewAccount.jsp?statusCode=unsuccessful");
					}
				}

				while (rs.next()) {
					out.print("<br><br>id: " + rs.getString("member_id") + "<br>");
					out.print("first name: " + rs.getString("first_name") + "<br>");
					out.print("last name: " + rs.getString("last_name") + "<br>");
					out.print("email: " + rs.getString("email") + "<br>");
					out.print("password: " + rs.getString("password") + "<br>");
					out.print("address: " + rs.getString("address") + "<br>");
					out.print("postal code: " + rs.getString("postalCode"));
				}

				// Step 7: Close connection
				conn.close();

			} catch (SQLIntegrityConstraintViolationException e) {
				response.sendRedirect("CA1/admin/manageMembers.jsp?statusCode=duplicateEmail");
			} catch (Exception e) {
				System.out.print("Error :" + e);
			}
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
