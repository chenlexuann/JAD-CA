/*Author: Angie Toh Anqi
Class: DIT/FT/2A/02
Date: 26/7/2023
Description: ST0510/JAD Assignment 1*/

package servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class createBookServlet
 */
@WebServlet("/createBookServlet")
public class createBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public createBookServlet() {
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

		String id = request.getParameter("id");
		String genre = request.getParameter("genre");
		String author = request.getParameter("author");
		String publisher = request.getParameter("publisher");
		String title = request.getParameter("title");
		String price = request.getParameter("price");
		String quantity = request.getParameter("quantity");
		String description = request.getParameter("description");
		String publication_date = request.getParameter("publication_date");
		String ISBN = request.getParameter("ISBN");
		String rating = request.getParameter("rating");

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
			String sqlStr = "INSERT INTO books (genre_id, author_id, publisher_id, title, price, quantity, description, publication_date, ISBN, rating) SELECT (SELECT genre_id FROM genres WHERE genre_name=? LIMIT 1),(SELECT author_id FROM authors WHERE author_name=? LIMIT 1), (SELECT publisher_id FROM publishers WHERE publisher_name=? LIMIT 1),?,?,?,?,?,?,?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, genre);
			pstmt.setString(2, author);
			pstmt.setString(3, publisher);
			pstmt.setString(4, title);
			pstmt.setString(5, price);
			pstmt.setString(6, quantity);
			pstmt.setString(7, description);
			pstmt.setString(8, publication_date);
			pstmt.setString(9, ISBN);
			pstmt.setString(10, rating);

			int nRowsAffected = pstmt.executeUpdate();

			// Step 6: Process Result
			if (nRowsAffected > 0) {
				response.sendRedirect("CA1/admin/manageBooks.jsp?statusCode=success");
			} else {
				response.sendRedirect("CA1/admin/manageBooks.jsp?statusCode=unsuccessful");
			}

			// Step 7: Close connection
			conn.close();

		} catch (SQLException e) {
			response.sendRedirect("CA1/admin/manageBooks.jsp?statusCode=duplicateBook");
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
