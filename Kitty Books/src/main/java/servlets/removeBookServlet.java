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

import java.util.ArrayList;
import books.Book;

@WebServlet("/removeBookServlet")
public class removeBookServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public removeBookServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String bookOrderParam = request.getParameter("WhichBook");
		HttpSession session = request.getSession();

		if (bookOrderParam != null && !bookOrderParam.isEmpty()) {
			int bookOrder = Integer.parseInt(bookOrderParam);

			// Retrieve cart details from session
			ArrayList<Book> booksInCart = (ArrayList<Book>) request.getSession().getAttribute("cart");

			if (booksInCart != null && bookOrder >= 0 && bookOrder <= booksInCart.size()) {
                booksInCart.remove(bookOrder - 1); // Remove the book using the specified index

                if (booksInCart.isEmpty()) {
                    // No more books in the cart, remove the cart session attribute
                    session.removeAttribute("cart");
                }
			}
		}

//		// Redirect back to the cart page
		response.sendRedirect(request.getContextPath() + "/getCartServlet");
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}