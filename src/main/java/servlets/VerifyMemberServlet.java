package servlets;

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
 * Servlet implementation class VerifyMemberServlet
 */
@WebServlet("/VerifyMemberServlet")
public class VerifyMemberServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VerifyMemberServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		PrintWriter out = response.getWriter();
		HttpSession session = request.getSession();
		
		try {
			String user = request.getParameter("loginid");
			String pwd = request.getParameter("password");
			String userRole = "member";
			boolean found = false; // set found flag to false by default

			// Step1: Load JDBC Driver
			Class.forName("com.mysql.cj.jdbc.Driver");

			// Step 2: Define Connection URL
			String connURL = "jdbc:mysql://localhost/bookstore?user=root&password=T0513022G&serverTimezone=UTC";

			// Step 3: Establish connection to URL
			Connection conn = DriverManager.getConnection(connURL);

			// Step 4: Create Statement object
			// Statement stmt = conn.createStatement();

			// Step 5: Execute SQL Command
			String sqlStr = "SELECT * FROM members WHERE email=? AND password=?";
			PreparedStatement pstmt = conn.prepareStatement(sqlStr);
			pstmt.setString(1, user);
			pstmt.setString(2, pwd);
			ResultSet rs = pstmt.executeQuery();

			// Step 6: Process Result
			if (rs.next()) { // if there exist a record
				// set the found flag
				found = true;
			} else {
				// print out not found message
			}

			if (found) {
				session.setAttribute("sessUserID", user);
				session.setAttribute("sessUserRole", userRole);
				session.setAttribute("loginStatus", "success");
				session.setMaxInactiveInterval(5 * 60);
				response.sendRedirect("CA1/member/viewAccount.jsp");

				out.print("record found");
				//response.sendRedirect("displayMember.jsp?userID=" + user + "&userRole=" + userRole + "&class=DIT2A02");
			} else {
				out.print("Sorry, login fail!");
				response.sendRedirect("CA1/member/login.jsp?errCode=invalidLogin");
			}

			// Step 7: Close connection
			conn.close();

		} catch (Exception e) {
			out.println("Error :" + e);
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
