package servlets;

import javax.servlet.http.Cookie;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import books.Book;

/**
 * Servlet implementation class getCartServlet
 */
@WebServlet("/getCartServlet")
public class getCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public getCartServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		ArrayList<Integer> cart = (ArrayList<Integer>) session.getAttribute("cart");

		if (cart != null && !cart.isEmpty()) {
			try {
				// Step 1: Establish the database connection
				Class.forName("com.mysql.cj.jdbc.Driver");
				String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=root&serverTimezone=UTC";
				Connection conn = DriverManager.getConnection(connURL);

				// Step 2: Prepare the SQL statement
				String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description "
						+ "FROM bookstore.books " + "JOIN authors ON authors.author_id = books.author_id "
						+ "JOIN genres ON genres.genre_id = books.genre_id "
						+ "JOIN publishers ON publishers.publisher_id = books.publisher_id " + "WHERE book_id = ?";

				ArrayList<Book> booksInCart = new ArrayList<Book>();

				// Step 3: Retrieve book details for each book in the cart
				for (Integer bookId : cart) {
					PreparedStatement statement = conn.prepareStatement(sqlStr);
					statement.setInt(1, bookId);
					ResultSet rs = statement.executeQuery();

					if (rs.next()) {
						int id = rs.getInt("book_id");
						String title = rs.getString("title");
						double price = rs.getDouble("price");
						int quantity = rs.getInt("quantity");
						String isbn = rs.getString("ISBN");
						String imageUrl = rs.getString("image_url");
						String authorName = rs.getString("author_name");
						String genreName = rs.getString("genre_name");
						String publisherName = rs.getString("publisher_name");
						Date publicationDate = rs.getDate("publication_date");
						String rating = rs.getString("rating");
						String description = rs.getString("description");

						booksInCart.add(new Book(id, title, price, quantity, isbn, imageUrl, authorName, genreName,
								publisherName, publicationDate, rating, description));
					}

					rs.close();
					statement.close();
				}

				// Step 4: Store the books in cart details in the session
				session.setAttribute("booksInCart", booksInCart);
				response.sendRedirect("cart.jsp");
			} catch (Exception e) {
				e.printStackTrace();
				// Handle the exception appropriately
			}
		} else {
			response.sendRedirect("cart.jsp");
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