package com.carrental.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.carrental.db.ConnectionFactory;

@WebServlet("/customerServlet")
public class CustomerServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response); 
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String customerType = request.getParameter("customerType");
		String fName = null;
		String lName = null;
		String cName = null;
		String phone = request.getParameter("phone");;
		
		String sql = "";
		
		if(customerType.equalsIgnoreCase("individuals")){
			fName = request.getParameter("fName");
			lName = request.getParameter("lName");
			sql = "insert into customer (CustType, Fname, Lname, Phone) value ('"+customerType+"', '"+fName+"', '"+lName+"', '"+phone+"' );";
		} else {
			cName = request.getParameter("cName");
			sql = "insert into customer (CustType, Phone, Cname) value ('"+customerType+"', '"+phone+"', '"+cName+"');";
		}
		
		HttpSession session = request.getSession();
		Connection con = null;
		Statement stmt = null;
		try{
			con = ConnectionFactory.getConnection();
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
			session.setAttribute("MSG", "Customer added successfully.");
		} catch(Exception e){
			e.printStackTrace();
			session.setAttribute("MSG", "<font color='red'>Error : "+e.getMessage()+"</font>");
		} finally{
			try {
				stmt.close();
				con.close();
			} catch (SQLException e) {
				session.setAttribute("MSG", "<font color='red'>Error : "+e.getMessage()+"</font>");
				e.printStackTrace();
			}
		}
		
	  response.sendRedirect("addCustomer.jsp"); 	
	}
	
}
