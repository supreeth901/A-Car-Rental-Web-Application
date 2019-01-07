package com.carrental.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Statement;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.carrental.db.ConnectionFactory;

@WebServlet("/carRentServlet")
public class CarRentServlet extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Integer VehicleID = Integer.parseInt(request.getParameter("VehicleID"));
		Integer ID = Integer.parseInt(request.getParameter("ID"));
		HttpSession session = request.getSession();
		String sql = "update rents set Active='inactive' where vehicleId="+VehicleID+" and ID="+ID;
		try{
			Connection con = ConnectionFactory.getConnection();
			Statement stmt = con.createStatement();
			stmt.executeUpdate(sql);
			
			session.setAttribute("MSG", "Vehicle returned successfully.");
			
			con.close();
			stmt.close();
		}catch(Exception e){
			session.setAttribute("MSG", "<font color='red'>Error : "+e.getMessage()+"</font>");
			e.printStackTrace();
		}
		
		response.sendRedirect("returnCar.jsp"); 
		
	}
	
	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		 
		HttpSession session = request.getSession();
		try{
			String rentType =  request.getParameter("rentType");
			Integer vehicleId = Integer.parseInt(request.getParameter("vehicleId"));
			Integer customerId = Integer.parseInt(request.getParameter("customerId"));
			String startDate =  request.getParameter("startDate");
			Integer noOfDays = null;
			Double dailyRent = null;
			Integer noOfWeeks = null;
			Double weeklyRent = null;
			String location =  request.getParameter("location");
			double amountDue = 0;
			String scheduled = null;
			
			Calendar calReturnDate = Calendar.getInstance(); 
			
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date selectedDate = sdf.parse(startDate);
			Date curDate = new Date();
			if(selectedDate.after(curDate)){
				scheduled = "scheduled";
			}
			
			
			if(rentType.equals("dailyRent")){
				noOfDays = Integer.parseInt(request.getParameter("noOfDays"));
				dailyRent = Double.parseDouble(request.getParameter("dailyRent"));
				calReturnDate.add(Calendar.DATE, noOfDays);
				amountDue = dailyRent * noOfDays;
			} else {
				noOfWeeks = Integer.parseInt(request.getParameter("noOfWeeks"));
				weeklyRent = Double.parseDouble(request.getParameter("weeklyRent"));
				calReturnDate.add(Calendar.DATE, noOfWeeks * 7);
				amountDue = weeklyRent * noOfWeeks;
			}
			
			String returnDate = calReturnDate.get(Calendar.YEAR)+"-"+(calReturnDate.get(Calendar.MONTH)+1)+"-"+calReturnDate.get(Calendar.DATE);
			
			
			String sql = "insert into rents (VehicleID, ID, StartDate, Returndate, Location, NoOfDays, NoOfWeeks, AmountDue, DailyRent," +
					" WeeklyRent, Active, Scheduled) values ("+vehicleId+", "+customerId+", '"+startDate+"', '"+returnDate+"', " +
							"'"+location+"', "+noOfDays+", "+noOfWeeks+", "+amountDue+", "+dailyRent+", "+weeklyRent+", 'active', '"+scheduled+"' )";
			
			Connection con = ConnectionFactory.getConnection();
			Statement stmt = con.createStatement();
			stmt.executeUpdate(sql);
			
			con.close();
			stmt.close();
			
			session.setAttribute("MSG", "Vehicle added successfully for Rent.");
			
		}catch (Exception e) {
			session.setAttribute("MSG", "<font color='red'>Error : "+e.getMessage()+"</font>");
			e.printStackTrace();
		}
		
		response.sendRedirect("rentCar.jsp");
		
	}
}
