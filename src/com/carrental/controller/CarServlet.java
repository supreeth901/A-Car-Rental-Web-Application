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

@WebServlet("/carServlet")
public class CarServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response); 
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		HttpSession session = request.getSession();
		Connection con = null;
		Statement stmt = null;
		try{
			Integer vehicleID = Integer.parseInt(request.getParameter("vehicleID"));
			Integer year = Integer.parseInt(request.getParameter("year"));
			Integer vehicleTypeId = Integer.parseInt(request.getParameter("vehicleTypeId"));
			Integer ownerId = Integer.parseInt(request.getParameter("ownerId"));
			String model = request.getParameter("model");
			
			String sql = "insert into car (vehicleID, model, year, TypeID, OID) values ("+vehicleID+", '"+model+"', "+year+", "+vehicleTypeId+", "+ownerId+");";
			con = ConnectionFactory.getConnection();
			stmt = con.createStatement();
			stmt.executeUpdate(sql);
			session.setAttribute("MSG", "Car added successfully.");
		} catch(Exception e){
			session.setAttribute("MSG", "<font color='red'>Error : "+e.getMessage()+"</font>");
			e.printStackTrace();
		} finally{
			try {
				stmt.close();
				con.close();
			} catch (SQLException e) {
				session.setAttribute("MSG", "<font color='red'>Error : "+e.getMessage()+"</font>");
				e.printStackTrace();
			}
		}
		
	  response.sendRedirect("addCar.jsp"); 	
	}
	
}
