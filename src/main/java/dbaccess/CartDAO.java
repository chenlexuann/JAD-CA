package dbaccess;

import java.sql.*;
import java.util.*;
import model.*;

public class CartDAO {
	Connection conn = null;

	public List<Cart> getCartProducts(ArrayList<Cart> cartList) throws SQLException {
		List<Cart> bookList = new ArrayList<>();
		try {
			conn = DBConnection.getConnection();
			ResultSet rs = null; // Declare the ResultSet variables outside the if conditions

			if (cartList.size() > 0) {
				for (Cart item : cartList) {

					String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE book_id = ?;";
					PreparedStatement pstmt = conn.prepareStatement(sqlStr);
					pstmt.setInt(1, item.getBookId());
					rs = pstmt.executeQuery();
					while (rs.next()) {
						Cart row = new Cart();
						row.setBookId(rs.getInt("book_id"));
						row.setTitle(rs.getString("title"));
						row.setPrice(rs.getDouble("price"));
						row.setBookQuantity(rs.getInt("quantity"));
						row.setISBN(rs.getString("ISBN"));
						row.setImageUrl(rs.getString("image_url"));
						row.setAuthorName(rs.getString("author_name"));
						row.setGenreName(rs.getString("genre_name"));
						row.setPublisherName(rs.getString("publisher_name"));
						row.setPublicationDate(rs.getString("publication_date"));
						row.setRating(rs.getString("rating"));
						row.setDescription(rs.getString("description"));
						row.setPrice(rs.getDouble("price")*item.getCartQuantity());
                        row.setCartQuantity(item.getCartQuantity());
						bookList.add(row);
					}
				}
			}

		} catch (SQLException e) {
			e.printStackTrace();
			System.out.println(e.getMessage());

		} finally {
			conn.close();
		}
		return bookList;
	}
	
	public double getTotalCartPrice(ArrayList<Cart> cartList) throws SQLException {
        double sum = 0;
        try {
        	ResultSet rs = null; // Declare the ResultSet variables outside the if conditions
        	conn = DBConnection.getConnection();
            if (cartList.size() > 0) {
                for (Cart item : cartList) {
                	String sqlStr = "SELECT book_id, title, price, quantity, ISBN, image_url, author_name, genre_name, publisher_name, publication_date, rating, description FROM bookstore.books join authors on authors.author_id=books.author_id join genres on genres.genre_id= books.genre_id join publishers on publishers.publisher_id=books.publisher_id WHERE book_id = ?;";
					PreparedStatement pstmt = conn.prepareStatement(sqlStr);
					pstmt.setInt(1, item.getBookId());
					rs = pstmt.executeQuery();
                    while (rs.next()) {
                        sum+=rs.getDouble("price")*item.getCartQuantity();
                    }
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
            System.out.println(e.getMessage());
        } finally {
			conn.close();
		}
        return sum;
    }
}
