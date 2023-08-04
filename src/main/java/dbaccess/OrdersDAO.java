package dbaccess;

import java.sql.*;
import java.util.*;
import model.*;

public class OrdersDAO {
	public int createOrder(String memberID) throws SQLException {
		Connection conn = null;
		int orderId = 0;
		try {
			conn = DBConnection.getConnection();
			String sqlStr = "INSERT INTO bookstore.orders (member_id) VALUES (?);";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr, Statement.RETURN_GENERATED_KEYS);
			pstmt.setString(1, memberID);

			int affectedRows = pstmt.executeUpdate();
			if (affectedRows > 0) {
                // Retrieve the auto-incremented value of the order_id
                ResultSet generatedKeys = pstmt.getGeneratedKeys();
                if (generatedKeys.next()) {
                    orderId = generatedKeys.getInt(1);
//                    System.out.println("Generated Order ID: " + orderId);
                } else {
                    System.out.println("Auto-generated keys not available.");
                }
            }
		} catch (Exception e) {
			System.out.print("......UserDetailsDB:" + e);
		} finally {
			conn.close();
		}
		return orderId;
	}
	
	public int createOrderItems(Cart c, int orderID) throws SQLException {
		Connection conn = null;
		int affectedRows = 0;
		try {
			conn = DBConnection.getConnection();
			String sqlStr = "INSERT INTO bookstore.order_items (order_id, book_id, quantity, unit_price) VALUES (?, ?, ?, ?);";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setInt(1, orderID);
			pstmt.setInt(2, c.getBookId());
			pstmt.setInt(3, c.getCartQuantity());
			pstmt.setDouble(4, (c.getPrice()/c.getCartQuantity()));

			affectedRows = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.print("......UserDetailsDB:" + e);
		} finally {
			conn.close();
		}
		return affectedRows;
	}
}
