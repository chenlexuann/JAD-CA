package servlets;
//Author: Chen Lexuan
//Class: DIT/FT/2A/02
//Date: 8/6/2023
//Description: ST0510/JAD Assignment 1

import java.io.*;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Invocation;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import model.Book;
import dbaccess.*;


/**
 * Servlet implementation class bookDetails
 */
@WebServlet("/bookDetailsServlet")
public class bookDetailsServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public bookDetailsServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Client client = ClientBuilder.newClient();
        String bookId = request.getParameter("bookId"); // Get the userid from the request parameter

	    String restUrl = "http://localhost:8081/getBook/"+bookId;
	    WebTarget target = client.target(restUrl);
	    Invocation.Builder invocationBuilder = target.request(MediaType.APPLICATION_JSON);
	    Response resp = invocationBuilder.get();

	    if (resp.getStatus() == Response.Status.OK.getStatusCode()) {
	      Book book = resp.readEntity(Book.class);
	      request.setAttribute("bookDetail",book);
	      String url = "bookDetails.jsp";
	      RequestDispatcher rd = request.getRequestDispatcher(url);
	      rd.forward(request, response);
	    } else {
	      String url = "bookDetails.jsp";
	      request.setAttribute("err", "NotFound");
	      RequestDispatcher rd = request.getRequestDispatcher(url);
	      rd.forward(request, response);
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
