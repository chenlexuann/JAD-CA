package dbaccess;

import java.sql.*;
import java.util.*;

import model.*;

public class UserDAO {
	public User getUserDetails(String userid) throws SQLException {
		User uBean = null;
		Connection conn = null;
		try {
			conn = DBConnection.getConnection();
			String sqlStr = "SELECT * FROM bookstore.members where member_id = ?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, userid);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				uBean = new User();
				uBean.setUserID(rs.getInt("member_id"));
				uBean.setEmail(rs.getString("email"));
				uBean.setFirstName(rs.getString("first_name"));
				uBean.setLastName(rs.getString("last_name"));
				uBean.setAddress(rs.getString("address"));
				uBean.setPostalCode(rs.getString("postalCode"));
			}
		} catch (Exception e) {
			System.out.print(".................userDetailsDB:" + e);
		} finally {
			conn.close();
		}
		return uBean;
	}

	public int insertUser(String firstName, String lastName, String email, String password) throws SQLException, ClassNotFoundException {
		Connection conn = null;
		int nrow = 0;
		try {
			conn = DBConnection.getConnection();
			String sqlStr = "INSERT INTO bookstore.members (first_name, last_name, email, password) VALUES (?,?,?,?);";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, firstName);
			pstmt.setString(2, lastName);
			pstmt.setString(3, email);
			pstmt.setString(4, password);
			nrow = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (Exception e) {
			System.out.print(".................userDetailsDB:" + e);
		} finally {
			conn.close();
		}
		return nrow;
	}
	
	public int updateUser(User user) throws SQLException {
		Connection conn = null;
		int rec = 0;
		try {
			conn = DBConnection.getConnection();
			String sqlStr = "UPDATE bookstore.members SET first_name = ?, last_name = ?, address = ?, postalCode = ? WHERE (member_id = ?);";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);

			pstmt.setString(1, user.getFirstName());
			pstmt.setString(2, user.getLastName());
			pstmt.setString(3, user.getAddress());
			pstmt.setString(4, user.getPostalCode());
			pstmt.setInt(5, user.getUserID());

			rec = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.print("......UserDetailsDB:" + e);
		} finally {
			conn.close();
		}
		return rec;
	}
}
