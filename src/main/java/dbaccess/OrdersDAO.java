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

	public List<Order> getOrderHistory(String userid) throws SQLException {
		Connection conn = null;
		List<Order> OrderHistory = new ArrayList<>();
		try {
			conn = DBConnection.getConnection();
			String sqlStr = "SELECT m.member_id, o.order_id, m.email AS member_email, o.order_date, GROUP_CONCAT(DISTINCT b.title ORDER BY b.title ASC SEPARATOR ', ') AS titles, GROUP_CONCAT(oi.quantity ORDER BY b.title ASC SEPARATOR ', ') AS quantities, SUM(oi.unit_price * oi.quantity) AS total_price FROM orders o JOIN order_items oi ON o.order_id = oi.order_id JOIN books b ON oi.book_id = b.book_id JOIN members m ON o.member_id = m.member_id WHERE m.member_id = ? GROUP BY m.member_id, o.order_id, m.email, o.order_date;";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, userid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				Order order = new Order();
				order.setMember_id(rs.getString("member_id"));
				order.setOrder_id(rs.getString("order_id"));
				order.setPrice(rs.getDouble("total_price"));
				order.setQuantities(rs.getString("quantities"));
				order.setTitle(rs.getString("titles"));
				order.setOrder_date(rs.getString("order_date"));
				OrderHistory.add(order);
			}
			
		} catch (Exception e) {
			System.out.print(".................userDetailsDB:" + e);
		} finally {
			conn.close();
		}
		return OrderHistory;
	}
}
