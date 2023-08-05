package servlets;

import java.util.*;
import model.*;
import dbaccess.*;
import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class addOrderToDB
 */
@WebServlet("/addOrderToDB")
public class addOrderToDB extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public addOrderToDB() {
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
		ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
		String memberID = session.getAttribute("sessMemberID") + "";
		User user = new User();
		user = (User) session.getAttribute("user");
		int rows = 0;
		int rows2 = 0;
		try {
			if (memberID != null) {
				UserDAO uDAO = new UserDAO();
				rows = uDAO.updateUser(user);

				if (rows == 1) {
					if (cart_list != null) {
						CartDAO cDAO = new CartDAO();
						List<Cart> cartProduct = cDAO.getCartProducts(cart_list);
						OrdersDAO oDAO = new OrdersDAO();
						int orderID = oDAO.createOrder(memberID);

						for (Cart c : cartProduct) {
							rows2 = oDAO.createOrderItems(c, orderID);
							session.removeAttribute("cart-list");
							if (rows2 <= 0) {
								throw new Exception("Error creating order items.");
							}
						}
					} else {
						throw new Exception("Cart is empty.");
					}
				} else {
					throw new Exception("Failed to update user details.");
				}
			}

			request.getRequestDispatcher("receipt.jsp").forward(request, response);

		} catch (SQLException | IOException | ServletException e) {
			e.printStackTrace();
			response.sendRedirect("home.jsp?statusCode=err");
		} catch (Exception e) {
			response.sendRedirect("home.jsp?statusCode=err");
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
