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

@WebServlet("/carTypeServlet")
public class CarTypeServlet extends HttpServlet {
 
	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		try {
			// typeId, type, dailyRate, weeklyRate
			Integer typeId = Integer.parseInt(request.getParameter("typeId"));
			Double dailyRate = Double.parseDouble(request.getParameter("dailyRate"));
			Double weeklyRate = Double.parseDouble(request.getParameter("weeklyRate"));
			
			
			Connection con = null;
			Statement stmt = null;
			try{
				String sql = "update cartype set DailyRate="+dailyRate+", WeeklyRate="+weeklyRate+" where TypeID="+typeId;
				con = ConnectionFactory.getConnection();
				stmt = con.createStatement();
				stmt.executeUpdate(sql);
				session.setAttribute("MSG", "Record updated successfully.");
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
			
		} catch (Exception e) {
			e.printStackTrace();
			session.setAttribute("MSG", "<font color='red'>Error : "+e.getMessage()+"</font>");
		}
		
		response.sendRedirect("updateRentalRates.jsp");
	}

}
