/*Author: Angie Toh Anqi
Class: DIT/FT/2A/02
Date: 26/7/2023
Description: ST0510/JAD Assignment 1*/

package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class deleteMemberServlet
 */
@WebServlet("/deleteMemberServlet")
public class deleteMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public deleteMemberServlet() {
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

		HttpSession session = request.getSession();
		String dm_userRole = (String) session.getAttribute("sessUserRole");
		String email = request.getParameter("email");

		try {
			// Step1: Load JDBC Driver
			// Class.forName("com.mysql.cj.jdbc.Driver");

			// Step 2: Define Connection URL
			String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=root&serverTimezone=UTC";

			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Step 4: Create Statement object
			// Statement stmt = conn.createStatement();

			// Step 5: Execute SQL Command
			String sqlStr = "";
			PreparedStatement pstmt;

			/*if (dm_userRole == "adminUser") {
				sqlStr = "DELETE FROM members WHERE member_id=?";
				pstmt = conn.prepareStatement(sqlStr);
				pstmt.setString(1, id);
			} else {*/
				sqlStr = "DELETE FROM members WHERE email=?";
				pstmt = conn.prepareStatement(sqlStr);
				pstmt.setString(1, email);
			// }

			int nRowsAffected = pstmt.executeUpdate();

			// Step 6: Process Result
			if (nRowsAffected > 0) {
				if (dm_userRole == "adminUser") {
					response.sendRedirect("CA1/admin/manageMembers.jsp?statusCode=success");
				} else {
					response.sendRedirect("login.jsp?statusCode=success");
				}
			} else {
				if (dm_userRole == "adminUser") {
					response.sendRedirect("CA1/admin/manageMembers.jsp?statusCode=unsuccessful");
				} else {
					response.sendRedirect("CA1/member/viewAccount.jsp?statusCode=unsuccessful");
				}
			}

			// Step 7: Close connection
			conn.close();

		} catch (Exception e) {
			System.out.print("Error :" + e);
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
