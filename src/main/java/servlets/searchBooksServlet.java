package servlets;
//Author: Chen Lexuan
//Class: DIT/FT/2A/02
//Date: 8/6/2023
//Description: ST0510/JAD Assignment 1

import dbaccess.*;
import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.Book;

/**
 * Servlet implementation class searchBooksServlet
 */
@WebServlet("/searchBooksServlet")
public class searchBooksServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private String genre_ID;
	private String price;
	private String titleSearch;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public searchBooksServlet() {
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
		List<Book> books = null;
		genre_ID = request.getParameter("genre");
		price = request.getParameter("maxPrice");
		titleSearch = request.getParameter("searchTitle");

		try {
			BookDAO bdatabase = new BookDAO();
			books = bdatabase.searchBooks(genre_ID, price, titleSearch);

			// Set the categories as request attributes
			request.setAttribute("books", books);

			RequestDispatcher dispatcher = request.getRequestDispatcher("home.jsp");
			dispatcher.forward(request, response);
		} catch (Exception e) {
			PrintWriter out = response.getWriter();
			out.println("Error: " + e);
			out.close();
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
