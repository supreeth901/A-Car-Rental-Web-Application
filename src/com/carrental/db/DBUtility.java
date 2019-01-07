package com.carrental.db;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBUtility {
	
	public static ResultSet getResults(String sql) {
		ResultSet rs = null;
		
		Connection con = null;
		Statement stmt = null;
		try{
			con = ConnectionFactory.getConnection();
			stmt = con.createStatement();
			rs = stmt.executeQuery(sql);
		}catch(Exception e){
			e.printStackTrace();
		} 
		return rs;
	}
	
	
	/**
	 * Method to get select drop down list
	 * @param name
	 * @param tableName
	 * @param id
	 * @param field1
	 * @return
	 */
	public static String getDropDownTable(String name, String tableName, String id,
			String field1,String whereCondition, String aliasColName) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("<select class='form-control' name='" + name + "'  id='" + name + "' >");
		
		Connection con11 = null;
		Statement stmt11 = null;
		ResultSet rs11 = null;
		try {
			con11 = ConnectionFactory.getConnection();
			stmt11 = con11.createStatement();
			String sql = "select " + id + ", " + field1+ " from " + tableName + "  ";
			if(whereCondition!=null && !whereCondition.equals("")){
				sql = sql + "where "+whereCondition;
			}
			System.out.println("getDropDownTable query:"+sql);
			rs11 = stmt11.executeQuery(sql);
			buffer.append("<option value='0'>Select</option>");
			
			if(aliasColName!=null){
				field1 = aliasColName;
			}
			
			while (rs11.next()) {
				buffer.append("<option value='" + rs11.getString(id) + "'>"+rs11.getString(field1)+"</option>");
			}
			buffer.append("</select>");
		} catch (Exception e) {
			e.printStackTrace();
		}
		System.out.println("drop down :"+buffer.toString());
		return buffer.toString();
	}

	public static void main(String[] args) throws Exception{
		DBUtility.getDropDownTable("ownerId", "owner", "OID", "TRIM(BOTH ' ' FROM CONCAT_WS(' ', Fname, Lname, Bname, RCname)) as ownerName", null, "ownerName");
		 
	}
}
