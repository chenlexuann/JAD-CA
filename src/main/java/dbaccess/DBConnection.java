package dbaccess;
/* ===========================================================
Author: Chen Lexuan (2212562)
Date: 5/7/2023
Description: ST0510/JAD
============================================================= */ 
import java.sql.*;

public class DBConnection {
	public static Connection getConnection() {
		String dbUrl = "jdbc:mysql://localhost/bookstore";
		String dbUser = "root";
		String dbPassword = "root";
		String dbClass = "com.mysql.cj.jdbc.Driver";
		Connection connection = null;
		try {
			Class.forName(dbClass);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		try {
			connection = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return connection;
	}
}
