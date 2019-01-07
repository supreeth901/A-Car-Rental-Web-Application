package com.carrental.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ConnectionFactory {

	private static final String DB_USERNAME = "root";
	private static final String DB_PASSWORD = "Subbu@123!";
	private static final String DB_URL = "jdbc:mysql://localhost:3306/";
	private static final String DB_NAME = "car_rental";
	private static final String DRIVER_NAME = "com.mysql.jdbc.Driver";
	private static Connection con = null;
	private ResultSet rs = null;

	static {
		try {
			Class.forName(DRIVER_NAME);
			con = DriverManager.getConnection(DB_URL + DB_NAME, DB_USERNAME,
					DB_PASSWORD);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	public static Connection getConnection() {
		try {
			con = DriverManager.getConnection(DB_URL + DB_NAME, DB_USERNAME,
					DB_PASSWORD);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return con;
	}

	public static void main(String[] args) {
		System.out.println("Connection is :" + getConnection());
	}

}
