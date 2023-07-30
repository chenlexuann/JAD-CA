package dbaccess;

import java.io.PrintWriter;
/* ===========================================================
Author: Chen Lexuan (2212562)
Date: 5/7/2023
Description: ST0510/JAD
============================================================= */
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;

import books.Book;

public class BookDAO {
	public List<Book> searchBooks(String genre, String maxPrice, String searchTitle) throws SQLException {
		List<Book> books = new ArrayList<>();
		String genre_ID;
		String price;
		String titleSearch;
		genre_ID = genre;
		price = maxPrice;
		titleSearch = searchTitle;
		Connection conn = null;
		try {
			conn = DBConnection.getConnection();
			ResultSet rs = null; // Declare the ResultSet variables outside the if conditions

			if (genre_ID.equals("0") && price.equals("") && titleSearch.equals("")) {
				String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id;";
				PreparedStatement pstmt = conn.prepareStatement(sqlStr);

				rs = pstmt.executeQuery(); // Assign the result to the rs variable

			} else if (genre_ID.equals("0") || price.equals("") || titleSearch.equals("")) {
				if (genre_ID.equals("0") && price.equals("")) {
					String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE (title LIKE UPPER(?) or author_name LIKE UPPER(?))";
					PreparedStatement pstmt = conn.prepareStatement(sqlStr);
					pstmt.setString(1, "%" + titleSearch + "%");
					pstmt.setString(2, "%" + titleSearch + "%");

					rs = pstmt.executeQuery(); // Assign the result to the rs variable
				} else if (genre_ID.equals("0")) {
					if (price.equals("")) {
						String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE (title LIKE UPPER(?) or author_name LIKE UPPER(?))";
						PreparedStatement pstmt = conn.prepareStatement(sqlStr);
						pstmt.setString(1, "%" + titleSearch + "%");
						pstmt.setString(2, "%" + titleSearch + "%");

						rs = pstmt.executeQuery(); // Assign the result to the rs variable
					} else {
						String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE books.price <= ? AND (title LIKE UPPER(?) or author_name LIKE UPPER(?))";
						PreparedStatement pstmt = conn.prepareStatement(sqlStr);
						pstmt.setString(1, price);
						pstmt.setString(2, "%" + titleSearch + "%");
						pstmt.setString(3, "%" + titleSearch + "%");

						rs = pstmt.executeQuery(); // Assign the result to the rs variable
					}

				} else if (price.equals("")) {
					if (genre_ID.equals("0")) {
						String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE (title LIKE UPPER(?) or author_name LIKE UPPER(?))";
						PreparedStatement pstmt = conn.prepareStatement(sqlStr);
						pstmt.setString(1, "%" + titleSearch + "%");
						pstmt.setString(2, "%" + titleSearch + "%");

						rs = pstmt.executeQuery(); // Assign the result to the rs variable
					} else {
						String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE books.genre_id = ? AND (title LIKE UPPER(?) or author_name LIKE UPPER(?))";
						PreparedStatement pstmt = conn.prepareStatement(sqlStr);
						pstmt.setString(1, genre_ID);
						pstmt.setString(2, "%" + titleSearch + "%");
						pstmt.setString(3, "%" + titleSearch + "%");

						rs = pstmt.executeQuery(); // Assign the result to the rs variable
					}
				} else if (titleSearch.equals("")) {
					if (genre_ID.equals("0")) {
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
				String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE books.genre_id = ? AND (title LIKE UPPER(?) or author_name LIKE UPPER(?)) AND books.price <= ?";
				PreparedStatement pstmt = conn.prepareStatement(sqlStr);
				pstmt.setString(1, genre_ID);
				pstmt.setString(2, "%" + titleSearch + "%");
				pstmt.setString(3, "%" + titleSearch + "%");
				pstmt.setString(4, price);

				rs = pstmt.executeQuery(); // Assign the result to the rs variable
			}

			// Step 6: Process Result
			

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
				book.setPublicationDate(rs.getString("publication_date"));
				book.setRating(rs.getString("rating"));
				book.setDescription(rs.getString("description"));

				System.out.println("success");
				books.add(book);
			}

		} catch (Exception e) {
			System.out.print(".................userDetailsDB:" + e);
		} finally {
			conn.close();
		}
		return books;
		
	}

}