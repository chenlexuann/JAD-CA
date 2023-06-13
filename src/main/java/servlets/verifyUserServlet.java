package servlets;

import java.io.*;
import java.sql.*;
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
 * Servlet implementation class verifyUserServlet
 */
@WebServlet("/verifyUserServlet")
public class verifyUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String username = "";
	private String password = "";
	private String username2 = "";
	private String password2 = "";
	private String email = "";
	private String pwd = "";

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public verifyUserServlet() {
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
		email = request.getParameter("email");
		pwd = request.getParameter("pwd");
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
			String sqlStr = "SELECT * FROM bookstore.admin WHERE email=? AND password=?;";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);

			pstmt.setString(1, email);
			pstmt.setString(2, pwd);

			ResultSet rs = pstmt.executeQuery();

			// Step 6: Process Result
			while (rs.next()) {
				password = rs.getString("password");
				username = rs.getString("email");
			}

			// second statement to check if member or admin
			String sqlStr2 = "SELECT * FROM bookstore.members where email = ? AND password = ?;";
			PreparedStatement pstmt2 = conn.prepareStatement(sqlStr2);
			// using prepared statement
			pstmt2.setString(1, email);
			pstmt2.setString(2, pwd);

			ResultSet rs2 = pstmt2.executeQuery();

			// Step 6: Process Result
			while (rs2.next()) {
				password2 = rs2.getString("password");
				username2 = rs2.getString("email");
				System.out.println(password2);
				System.out.println(username2);
			}
			// Step 7: Close connection
			conn.close();
		} catch (Exception e) {
			PrintWriter out = response.getWriter();
			out.println("Error :" + e);
			out.close();
		}

		if (username.equals(email) && password.equals(pwd)) {
			String userRole = "adminUser";
			session.setAttribute("sessUserRole", userRole);
			session.setAttribute("sessUserID", email);
			
			response.sendRedirect("home.jsp?role=" + userRole + "&user=" + email + "&statusCode=validLogin");
		} else if (username2.equals(email) && password.equals(pwd)) {
			String userRole = "memberUser";
			session.setAttribute("sessUserRole", userRole);
			session.setAttribute("sessUserID", email);
			/*
			 * response.sendRedirect("displayMember.jsp?role=" + userRole + "&user=" +
			 * user);
			 */
			response.sendRedirect("home.jsp?role=" + userRole + "&user=" + email + "&statusCode=validLogin");
		} else {
			response.sendRedirect("login.jsp?statusCode=invalidLogin");
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
