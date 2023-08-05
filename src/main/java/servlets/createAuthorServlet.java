/*Author: Angie Toh Anqi
Class: DIT/FT/2A/02
Date: 26/7/2023
Description: ST0510/JAD Assignment 1*/

package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLIntegrityConstraintViolationException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class createAuthorServlet
 */
@WebServlet("/createAuthorServlet")
public class createAuthorServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public createAuthorServlet() {
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

		String author = request.getParameter("author");

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
			String sqlStr = "INSERT INTO authors (author_name) VALUES (?)";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, author);

			int nRowsAffected = pstmt.executeUpdate();

			// Step 6: Process Result
			if (nRowsAffected > 0) {
				response.sendRedirect("CA1/admin/manageBooks.jsp?statusCode=success");
			} else {
				response.sendRedirect("CA1/admin/manageBooks.jsp?statusCode=unsuccessful");
			}

			// Step 7: Close connection
			conn.close();

		} catch (SQLIntegrityConstraintViolationException e) {
			response.sendRedirect("CA1/admin/manageBooks.jsp?statusCode=duplicateAuthor");
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
