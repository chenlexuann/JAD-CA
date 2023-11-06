package servlets;
//Author: Chen Lexuan
//Class: DIT/FT/2A/02
//Date: 8/6/2023
//Description: ST0510/JAD Assignment 1

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class logoutUserServlet
 */
@WebServlet("/logoutUserServlet")
public class logoutUserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public logoutUserServlet() {
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
		HttpSession session = request.getSession(false);
		if (session != null) {
			session.removeAttribute("sessUserID");
			session.removeAttribute("sessUserRole");
			session.removeAttribute("sessUserName");
	        session.removeAttribute("booksInCart");
            session.removeAttribute("cart");
		}
		
		String redirectURL = "/JAD-CA/home.jsp";
		if (session == null) {
			redirectURL += "?statusCode=loggedOut";
		}
		response.sendRedirect(redirectURL);
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
