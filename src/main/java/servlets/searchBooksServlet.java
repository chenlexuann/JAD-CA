package servlets;
//Author: Chen Lexuan
//Class: DIT/FT/2A/02
//Date: 8/6/2023
//Description: ST0510/JAD Assignment 1

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import books.Book;

/**
 * Servlet implementation class searchBooksServlet
 */
@WebServlet("/searchBooksServlet")
public class searchBooksServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String genre_ID;
	private String price;
	private String titleSearch;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public searchBooksServlet() {
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
		genre_ID = request.getParameter("genre");
		price = request.getParameter("maxPrice");
		titleSearch = request.getParameter("searchTitle");

		try {
			// Step1: Load JDBC Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Step 2: Define Connection URL
			String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=root&serverTimezone=UTC";

			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Step 4: Create Statement object
			// Statement stmt = conn.createStatement();

			ResultSet rs = null; // Declare the ResultSet variables outside the if conditions

			if (genre_ID.equals("0") && price.equals("") && titleSearch.equals("")) {
				String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id;";
				PreparedStatement pstmt = conn.prepareStatement(sqlStr);

				rs = pstmt.executeQuery(); // Assign the result to the rs variable

			} else if (genre_ID.equals("0") || price.equals("") || titleSearch.equals("")) {
				if (genre_ID.equals("0") && price.equals("")) {
					String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE title LIKE UPPER(?)";
					PreparedStatement pstmt = conn.prepareStatement(sqlStr);
					pstmt.setString(1, "%" + titleSearch + "%");

					rs = pstmt.executeQuery(); // Assign the result to the rs variable
				} else if (genre_ID.equals("0")) {
					if(price.equals("")) {
						String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE title LIKE UPPER(?)";
						PreparedStatement pstmt = conn.prepareStatement(sqlStr);
						pstmt.setString(1, "%" + titleSearch + "%");

						rs = pstmt.executeQuery(); // Assign the result to the rs variable
					} else {
						String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE books.price <= ? AND title LIKE UPPER(?)";
						PreparedStatement pstmt = conn.prepareStatement(sqlStr);
						pstmt.setString(1, price);
						pstmt.setString(2, "%" + titleSearch + "%");

						rs = pstmt.executeQuery(); // Assign the result to the rs variable
					}
					
				} else if (price.equals("")) {
					if(genre_ID.equals("0")) {
						String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id title LIKE UPPER(?)";
						PreparedStatement pstmt = conn.prepareStatement(sqlStr);
						pstmt.setString(1, "%" + titleSearch + "%");

						rs = pstmt.executeQuery(); // Assign the result to the rs variable
					} else {
						String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE books.genre_id = ? AND title LIKE UPPER(?)";
						PreparedStatement pstmt = conn.prepareStatement(sqlStr);
						pstmt.setString(1, genre_ID);
						pstmt.setString(2, "%" + titleSearch + "%");
						
						rs = pstmt.executeQuery(); // Assign the result to the rs variable
					}
				} else if (titleSearch.equals("")) {
					if(genre_ID.equals("0")) {
						String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE books.price <= ?";
						PreparedStatement pstmt = conn.prepareStatement(sqlStr);
						pstmt.setString(1, price);

						rs = pstmt.executeQuery(); // Assign the result to the rs variable
					} else {
						String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE books.genre_id = ? AND books.price <= ?";
						PreparedStatement pstmt = conn.prepareStatement(sqlStr);
						pstmt.setString(1, genre_ID);
						pstmt.setString(2, price);
						
						rs = pstmt.executeQuery(); // Assign the result to the rs variable
					}
				}
			} else {
				String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE books.genre_id = ? AND title LIKE UPPER(?) AND books.price <= ?";
				PreparedStatement pstmt = conn.prepareStatement(sqlStr);
				pstmt.setString(1, genre_ID);
				pstmt.setString(2, "%" + titleSearch + "%");
				pstmt.setString(3, price);
				
				rs = pstmt.executeQuery(); // Assign the result to the rs variable
			}

			// Step 6: Process Result
			List<Book> books = new ArrayList<>();

			while (rs.next()) {
				Book book = new Book();
				book.setBookId(rs.getInt("book_id"));
				book.setTitle(rs.getString("title"));
				book.setPrice(rs.getDouble("price"));
				book.setQuantity(rs.getInt("quantity"));
				book.setISBN(rs.getString("ISBN"));
				book.setImageUrl(rs.getString("image_url"));
				book.setAuthorName(rs.getString("author_name"));
				book.setGenreName(rs.getString("genre_name"));
				book.setPublisherName(rs.getString("publisher_name"));
				book.setPublicationDate(rs.getDate("publication_date"));
				book.setRating(rs.getString("rating"));
				book.setDescription(rs.getString("description"));

				books.add(book);
			}

			// Set the categories as request attributes
			request.setAttribute("books", books);

			RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
			dispatcher.forward(request, response);

			// Close the connection
			conn.close();
		} catch (

		Exception e) {
			PrintWriter out = response.getWriter();
			out.println("Error: " + e);
			out.close();
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
