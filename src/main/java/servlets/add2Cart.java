package servlets;

import java.util.*;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Cookie;

/**
 * Servlet implementation class add2Cart
 */
@WebServlet("/add2Cart")
public class add2Cart extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public add2Cart() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    String bookIdParam = request.getParameter("bookId");
	    HttpSession session = request.getSession();

	    // Retrieve the cart from the session or create a new one if it doesn't exist
	    ArrayList<Integer> cart = (ArrayList<Integer>) session.getAttribute("cart");
	    if (cart == null) {
	        cart = new ArrayList<Integer>();
	    }

	    if (bookIdParam != null && !bookIdParam.isEmpty()) {
	        int bookId = Integer.parseInt(bookIdParam);

	        cart.add(bookId);
	        session.setAttribute("cart", cart);
	        response.sendRedirect(request.getContextPath() + "/getCartServlet");
	    } else {
	        response.sendRedirect("home.jsp");
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