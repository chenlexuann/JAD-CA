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
 * Servlet implementation class createGenreServlet
 */
@WebServlet("/createGenreServlet")
public class createGenreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public createGenreServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		// response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String genre = request.getParameter("genre");
		String[] titles = request.getParameterValues("titles");

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
			String sqlStr = "INSERT INTO genres (genre_name) VALUES (?)";
			PreparedStatement pstmt1 = conn.prepareStatement(sqlStr);
			pstmt1.setString(1, genre);

			int nRowsAffected1 = pstmt1.executeUpdate();

			if (titles != null) {
				String sqlStrTitles = "UPDATE books SET genre_id = (SELECT genre_id FROM genres WHERE genre_name = ?) WHERE title = ?";
				int count = 1;
				while (count < titles.length) {
			sqlStrTitles += " OR title = ?";
			count++;
				}

				PreparedStatement pstmt2 = conn.prepareStatement(sqlStrTitles);
				pstmt2.setString(1, genre);
				for (int i = 0; i < count; i++) {
			pstmt2.setString((i + 2), titles[i]);
				}
				int nRowsAffected2 = pstmt2.executeUpdate();
			}

			// Step 6: Process Result
			if (nRowsAffected1 > 0) {
				response.sendRedirect("CA1/admin/manageBooks.jsp?statusCode=success");
			} else {
				response.sendRedirect("CA1/admin/manageBooks.jsp?statusCode=unsuccessful");
			}

			// Step 7: Close connection
			conn.close();

		} catch (SQLIntegrityConstraintViolationException e) {
			response.sendRedirect("CA1/admin/manageBooks.jsp?statusCode=duplicateGenre");
		} catch (Exception e) {
			System.out.print("Error :" + e);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
