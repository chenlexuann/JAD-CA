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
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

/**
 * Servlet implementation class updateBookServlet
 */
@WebServlet("/updateBookServlet")
public class updateBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public updateBookServlet() {
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

		String id = request.getParameter("id");
		String genre = request.getParameter("genre");
		String oldGenre = request.getParameter("oldGenre");
		String author = request.getParameter("author");
		String oldAuthor = request.getParameter("oldAuthor");
		String publisher = request.getParameter("publisher");
		String oldPublisher = request.getParameter("oldPublisher");
		String title = request.getParameter("title");
		String oldTitle = request.getParameter("oldTitle");
		String price = request.getParameter("price");
		String oldPrice = request.getParameter("oldPrice");
		String quantity = request.getParameter("quantity");
		String oldQuantity = request.getParameter("oldQuantity");
		String description = request.getParameter("description");
		String oldDescription = request.getParameter("oldDescription");
		String publication_date = request.getParameter("publication_date");
		String oldPublicationDate = request.getParameter("oldPublicationDate");
		String ISBN = request.getParameter("ISBN");
		String oldISBN = request.getParameter("oldISBN");
		String image_url = request.getParameter("image_url");
		String oldImageURL = request.getParameter("oldImageURL");
		String rating = request.getParameter("rating");
		String oldRating = request.getParameter("oldRating");

		/*
		 * Part imagePart = request.getPart("imageFile"); String imageFileName = null;
		 * 
		 * if (imagePart != null) { String imageName = System.currentTimeMillis() + "_"
		 * + imagePart.getSubmittedFileName(); String imagePath =
		 * "C:\\Users\\Angie Toh\\Downloads\\JAD images" + imageName;
		 * imagePart.write(imagePath); imageFileName = imageName; }
		 */

		if (genre.equals(oldGenre) && author.equals(oldAuthor) && publisher.equals(oldPublisher)
				&& title.equals(oldTitle) && price.equals(oldPrice) && quantity.equals(oldQuantity)
				&& description.equals(oldDescription) && publication_date.equals(oldPublicationDate)
				&& ISBN.equals(oldISBN) && image_url.equals(oldImageURL) && rating.equals(oldRating)) {
			response.sendRedirect("CA1/admin/manageBooks.jsp?statusCode=noChanges");
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
				String sqlStr = "UPDATE books AS b SET genre_id = (SELECT genre_id FROM genres WHERE genre_name = ? LIMIT 1), author_id = (SELECT author_id FROM authors WHERE author_name = ? LIMIT 1), publisher_id = (SELECT publisher_id FROM publishers WHERE publisher_name = ? LIMIT 1), title = ?, price = ?, quantity = ?, description = ?, publication_date = ?, ISBN = ?, image_url = ?, rating = ? WHERE book_id = ?;";
				// String sqlStr = "UPDATE books AS b SET genre_id = ?, author_id = ?, publisher_id = ?, title = ?, price = ?, quantity = ?, description = ?, publication_date = ?, ISBN = ?, rating = ?, image_url = ? WHERE book_id = ?";
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
				pstmt.setString(10, image_url);
				pstmt.setString(11, rating);
				// pstmt.setString(11, imageFileName); // Set the image file name
				pstmt.setString(12, id);

				int nRowsAffected = pstmt.executeUpdate();

				String simpleProc = "{call getBook(?)}";
				CallableStatement cs = conn.prepareCall(simpleProc);
				cs.setString(1, id);
				ResultSet rs = cs.executeQuery();

				// Step 6: Process Result
				if (nRowsAffected > 0) {
					response.sendRedirect("CA1/admin/manageBooks.jsp?statusCode=success");
				} else {
					response.sendRedirect("CA1/admin/manageBooks.jsp?statusCode=unsuccessful");
				}

				/*
				 * while (rs.next()) { out.print("<br><br>id: " + rs.getString("book_id") +
				 * "<br>"); out.print("genre: " + rs.getString("genre_name") + "<br>");
				 * out.print("author: " + rs.getString("author_name") + "<br>");
				 * out.print("publisher: " + rs.getString("publisher_name") + "<br>");
				 * out.print("title: " + rs.getString("title") + "<br>"); out.print("price: " +
				 * rs.getString("price") + "<br>"); out.print("quantity: " +
				 * rs.getString("quantity") + "<br>"); out.print("description: " +
				 * rs.getString("description") + "<br>"); out.print("publication_date: " +
				 * rs.getString("publication_date") + "<br>"); out.print("ISBN: " +
				 * rs.getString("ISBN") + "<br>"); out.print("rating: " +
				 * rs.getString("rating")); }
				 */

				// Step 7: Close connection
				conn.close();

			} catch (SQLException e) {
				response.sendRedirect("CA1/admin/manageBooks.jsp?statusCode=incorrectFormat");
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
