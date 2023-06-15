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
 * Servlet implementation class createUserServlet
 */
@WebServlet("/createUserServlet")
public class createUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       private String firstName = "";
       private String lastName = "";
       private String email = "";
       private String pwd = "";
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public createUserServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		firstName = request.getParameter("firstName");
	    lastName = request.getParameter("lastName");
	    email = request.getParameter("email");
	    pwd = request.getParameter("password");

	    try {
	        // Step 1: Load JDBC Driver
	        Class.forName("com.mysql.cj.jdbc.Driver");

	        // Step 2: Define Connection URL
	        String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=root&serverTimezone=UTC";

	        // Step 3: Establish connection to URL
	        Connection conn = DriverManager.getConnection(connURL);

	        // Step 4: Create Statement object
	        ResultSet rs = null;

	        // Step 5: Execute SQL Command
	        String sqlStr = "INSERT INTO bookstore.members (first_name, last_name, email, password) VALUES (?, ?, ?, ?);";
	        PreparedStatement pstmt = conn.prepareStatement(sqlStr);

	        pstmt.setString(1, firstName);
	        pstmt.setString(2, lastName);
	        pstmt.setString(3, email);
	        pstmt.setString(4, pwd);

	        // Execute the SQL statement
	        int rowsAffected = pstmt.executeUpdate();

	        if (rowsAffected > 0) {
	            // Registration successful
	            response.sendRedirect("register_member.jsp?statusCode=success");
	        } else {
	            // Duplicate email
	            response.sendRedirect("register_member.jsp?statusCode=duplicateEmail");
	        }

	        // Close the connection
	        conn.close();
	    } catch (SQLIntegrityConstraintViolationException e) {
	        // Duplicate entry for email
	        response.sendRedirect("register_member.jsp?statusCode=duplicateEmail");
	    } catch (Exception e) {
	        PrintWriter out = response.getWriter();
	        System.out.println("Error: " + e);
	        out.close();
	    }
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
