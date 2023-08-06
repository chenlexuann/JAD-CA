package servlets;
//Author: Chen Lexuan
//Class: DIT/FT/2A/02
//Date: 6/8/2023
//Description: ST0510/JAD Assignment 2


import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import dbaccess.*;
import model.*;
import java.util.*;

import com.paypal.base.rest.PayPalRESTException;

/**
 * Servlet implementation class checkoutServlet
 */
@WebServlet("/checkoutServlet")
public class checkoutServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public checkoutServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
		User user = new User();
		List<Cart> cartProduct = null;
		OrderDetail orderDetail = null;
		String memberID = session.getAttribute("sessMemberID") + "";
		double total = Double.parseDouble(request.getParameter("total"));
		double GST = 0.08 * total;
		double totalwGST = total + GST;
		ArrayList<Cart> cart_list = (ArrayList<Cart>) session.getAttribute("cart-list");
		try {
			if (memberID != null) {
				UserDAO uDAO = new UserDAO();
				user = uDAO.getUserDetails(memberID);
				user.setFirstName(request.getParameter("firstname"));
				user.setLastName(request.getParameter("lastname"));
				user.setAddress(request.getParameter("address"));
				user.setPostalCode(request.getParameter("postal"));
				session.setAttribute("user", user);
			}
			if (cart_list != null) {
				CartDAO cDAO = new CartDAO();
				cartProduct = cDAO.getCartProducts(cart_list);
				orderDetail = new OrderDetail(cartProduct, GST, total, totalwGST);
			}

			PaymentServices paymentServices = new PaymentServices();
			String approvalLink = paymentServices.authorizePayment(orderDetail, user);

			response.sendRedirect(approvalLink);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (PayPalRESTException ex) {
			request.setAttribute("errorMessage", ex.getMessage());
			ex.printStackTrace();
			request.getRequestDispatcher("cart.jsp").forward(request, response);
		} catch (Exception e) {
			request.getRequestDispatcher("cart.jsp");
		}
	}

}
