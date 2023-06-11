package servlets;

import java.io.*;
import java.sql.*;
import javax.servlet.RequestDispatcher;
import java.util.ArrayList;
import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class getBooksServlet
 */
@WebServlet("/getBooksServlet")
public class getBooksServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public getBooksServlet() {
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
		List<String> genres = new ArrayList<>();
		List<Integer> genre_ID = new ArrayList<>();
		try {
			// Step1: Load JDBC Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Step 2: Define Connection URL
			String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=root&serverTimezone=UTC";

			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Step 4: Create Statement object
			Statement stmt = conn.createStatement();

			// Step 5: Execute SQL Command
			String sqlStr = "SELECT * FROM bookstore.genres;";
			ResultSet rs = stmt.executeQuery(sqlStr);

			// Step 6: Process Result
			while (rs.next()) {
				String genre_name = rs.getString("genre_name");
				int genre_id = rs.getInt("genre_id");
				genres.add(genre_name);
				genre_ID.add(genre_id);
			}

			// Set the categories as request attributes
			// Set the genres as session attributes
			session.setAttribute("genres", genres);
			session.setAttribute("genre_ID", genre_ID);

			// Close the connection
			conn.close();
		} catch (Exception e) {
			PrintWriter out = response.getWriter();
			out.println("Error: " + e);
			out.close();
		}

		// Forward the request to the JSP page
		response.sendRedirect("home.jsp?redirect=false");
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
