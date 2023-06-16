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
    private String firstName = "";
    private int MemberID = 0;
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

            // Step 5: Execute SQL Command for admin login
            String adminSqlStr = "SELECT * FROM bookstore.admin WHERE email=? AND password=?;";
            PreparedStatement adminPstmt = conn.prepareStatement(adminSqlStr);

            adminPstmt.setString(1, email);
            adminPstmt.setString(2, pwd);

            ResultSet adminRs = adminPstmt.executeQuery();

            // Step 6: Process Result for admin login
            if (adminRs.next()) {
                password = adminRs.getString("password");
                username = adminRs.getString("email");

                String userRole = "adminUser";
                session.setAttribute("sessUserRole", userRole);
                session.setAttribute("sessUserID", email);
				session.setAttribute("loginStatus", "success");
				session.setMaxInactiveInterval(5 * 60);

                response.sendRedirect("CA1/admin/menu.jsp?role=" + userRole + "&user=" + email + "&statusCode=validLogin");
                return; // Exit the method after redirecting
            }

            // Step 7: Execute SQL Command for member login
            String memberSqlStr = "SELECT * FROM bookstore.members WHERE email=? AND password=?;";
            PreparedStatement memberPstmt = conn.prepareStatement(memberSqlStr);

            memberPstmt.setString(1, email);
            memberPstmt.setString(2, pwd);

            ResultSet memberRs = memberPstmt.executeQuery();

            // Step 8: Process Result for member login
            if (memberRs.next()) {
                password = memberRs.getString("password");
                username = memberRs.getString("email");
                firstName = memberRs.getString("first_name");
                MemberID = Integer.parseInt(memberRs.getString("member_id"));

                String userRole = "memberUser";
                session.setAttribute("sessUserRole", userRole);
                session.setAttribute("sessUserID", email);
                session.setAttribute("sessMemberID", MemberID);
                session.setAttribute("sessUserName", firstName);
				session.setAttribute("loginStatus", "success");
				session.setMaxInactiveInterval(5 * 60);
				
                response.sendRedirect("home.jsp?role=" + userRole + "&user=" + firstName + "&statusCode=validLogin");
                return; // Exit the method after redirecting
            }

            // Step 9: Close connection
            conn.close();
        } catch (Exception e) {
            PrintWriter out = response.getWriter();
            out.println("Error: " + e);
            out.close();
        }

        // If no matching admin or member found, redirect to login page with an invalid login status
        response.sendRedirect("login.jsp?statusCode=invalidLogin");
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
