<%@page import="com.carrental.db.DBUtility"%>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Statement"%>
<%@page import="com.carrental.db.ConnectionFactory"%>
<%@page import="java.sql.ResultSet"%>
<%@page contentType="text/html"%>
<%@page pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="css/my.css" rel="stylesheet" />
<title>Rent a Car</title>

<!-- Core CSS - Include with every page -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="font-awesome/css/font-awesome.css" rel="stylesheet">

<!-- Page-Level Plugin CSS - Dashboard -->
<link href="css/plugins/morris/morris-0.4.3.min.css" rel="stylesheet">
<link href="css/plugins/timeline/timeline.css" rel="stylesheet">

<!-- SB Admin CSS - Include with every page -->
<link href="css/sb-admin.css" rel="stylesheet">


 <script src="js/common.js"></script>
 
<link href="css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">

<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker.min.css" />
<link rel="stylesheet" href="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/css/datepicker3.min.css" />



<script type="text/javascript">
	function checkRentType(rentType){
		if(rentType == 'dailyRent'){
			$('#dayDiv').show();
			$('#weekDiv').hide();
		} else {
			$('#dayDiv').hide();
			$('#weekDiv').show();
		}
	};
	
	function validateAndSubmit(){
		document.getElementById("rentCarForm").action = "carRentServlet";
		document.getElementById("rentCarForm").submit();
	};
</script>

</head>

<body onload="checkRentType('dailyRent');">

	<div id="wrapper">

		<%@include file="menu.jsp"%>

		<div id="page-wrapper">
			

			<div class="row">
				<div class="col-lg-12">

					<%@include file="msg.jsp"%>
					<br />
					<br />
					
					<div class="col-lg-6">
						<form action="javascript:void(0);"  method="post" id="rentCarForm" class="sky-form" role="form">
							<input type="hidden" name="id" id="id" />
							
							<div class="form-group">
								<label> Vehicle ID  </label>
								<%
									String sql = "select VehicleID, concat(model,' - ' ,cartype.Type) as vehicleType from car inner join cartype on cartype.TypeID = car.TypeID " + 
									 "and VehicleID not in (select VehicleID from rents where Active='active')";
									Connection con = ConnectionFactory.getConnection();
									Statement stmt = con.createStatement();
									ResultSet rs = stmt.executeQuery(sql);
								%> 
								
								<select name="vehicleId" id="vehicleId" class="form-control">
									<%
										while(rs.next()) {
									%>
									<option value="<%= rs.getInt("VehicleID") %>"><%= rs.getString("vehicleType") %></option>
									<% } %>
								</select> 
								
								<% 
									con.close();
									stmt.close();
									rs.close();	
								%>
								
							</div>
							
							
							<div class="form-group">
								<label> Customer  </label>
								<%
									String sql2 = "SELECT ID, CustType, TRIM(BOTH ' ' FROM CONCAT_WS(' ', Fname, Lname, Cname)) as customerName FROM customer";
									Connection con2 = ConnectionFactory.getConnection();
									Statement stmt2 = con2.createStatement();
									ResultSet rs2 = stmt2.executeQuery(sql2);
								%> 
								
								<select name="customerId" id="customerId" class="form-control" onchange="checkCustomerType(this.value);">
									<%
										while(rs2.next()) {
									%>
									<option value="<%= rs2.getInt("ID") %>"><%= rs2.getString("customerName") %> (<%= rs2.getString("CustType") %>)</option>
									<% } %>
								</select> 
								
								<% 
									con2.close();
									stmt2.close();
									rs2.close();	
								%>
								
							</div>
							
							<div class="form-group">
								<label> Rent Type </label> 
								<select name="rentType" id="rentType" class="form-control" onchange="checkRentType(this.value);">
									<option value="dailyRent">Daily Rent</option>
									<option value="weeklyRent">Weekly Rent</option>
								</select> 
							</div>
							
							<div class="form-group">
									<label> Start Date (yyyy-mm-dd)  </label> 
									<div class="input-group input-append date" id="datePicker">
						                <input type="text" class="form-control" name="startDate" id="startDate"/>
						                <span class="input-group-addon add-on"><span class="glyphicon glyphicon-calendar"></span></span>
						            </div>
							</div>
							
							
							
							<div id="dayDiv" style="display: none">
								<div class="form-group">
									<label> No of Days  </label> 
									<input class="form-control" type="text"  name="noOfDays" id="noOfDays"/>
								</div>
								
								<div class="form-group">
										<label> Daily Rent</label> 
										<input class="form-control" type="text"  name="dailyRent" id="dailyRent"/>
								</div>
							</div>
							
							<div id="weekDiv" style="display: none">
								<div class="form-group">
									<label> No of Weeks  </label> 
									<input class="form-control" type="text"  name="noOfWeeks" id="noOfWeeks"/>
								</div>
								
								<div class="form-group">
										<label> Weekly Rent</label> 
										<input class="form-control" type="text"  name="weeklyRent" id="weeklyRent"/>
								</div>
							</div>
							
							<div class="form-group">
									<label> Location  </label> 
									<input class="form-control" type="text"  name="location" id="location"/>
							</div>
							
							
														
							<input class="btn btn-primary" type="button" onclick="validateAndSubmit();" class="button" value="Rent a Car" />
						</form>
					</div>

				</div>
				<!-- /.col-lg-12 -->
			</div>
		</div>
		<!-- /.row -->
	</div>
	<!-- /#page-wrapper -->

	</div>
	<!-- /#wrapper -->

	<!-- Core Scripts - Include with every page -->
	<script src="js/jquery-1.10.2.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script src="js/plugins/metisMenu/jquery.metisMenu.js"></script>

	<!-- Page-Level Plugin Scripts - Tables -->
	<script src="js/plugins/dataTables/jquery.dataTables.js"></script>
	<script src="js/plugins/dataTables/dataTables.bootstrap.js"></script>

	<!-- SB Admin Scripts - Include with every page -->
	<script src="js/sb-admin.js"></script>

	<!-- Page-Level Demo Scripts - Tables - Use for reference -->
	
	<script src="//cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.3.0/js/bootstrap-datepicker.min.js"></script>
	
	<script>
		$(document).ready(function() {
			$('#dataTables-example').dataTable();
			
			 $('#datePicker').datepicker({
		            //format: 'mm/dd/yyyy'
				 format: 'yyyy-mm-dd'
		        });
		  

		});
	</script>

</body>

</html>
