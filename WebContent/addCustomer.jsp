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
<title>Add Customer</title>

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


<script type="text/javascript">

	function showForm() {
		resetForm();
		$("#customerFormDiv").fadeIn("slow");
		$("#customerType").focus();

	}

	function hideForm() {
		$("#customerFormDiv").fadeOut("slow");
		$("#addCustomerLink").focus();

	}

	function resetForm() {					
		document.getElementById("customerForm").customerType.value = "individuals";
		checkCustomerType('individuals');
		document.getElementById("customerForm").fName.value = "";
		document.getElementById("customerForm").lName.value = "";		
		document.getElementById("customerForm").cName.value = "";
		document.getElementById("customerForm").phone.value = "";
	}
	
	function checkCustomerType(val){
		if(val == 'individuals'){
			$('#nameDiv').show();
			$('#cNameDiv').hide();
		} else {
			$('#nameDiv').hide();
			$('#cNameDiv').show();
		}
	}
	
	function validationForm(){
		var cusType = $('#customerType').val();
		var fName = $('#fName').val();
		var lName = $('#lName').val();
		var cName = $('#cName').val();
		var phone = $('#phone').val();
		
		var isValid = true;
		
		if(cusType == 'individuals'){
			if(fName == ''){
				alert('Please enter First Name');
				isValid =false;
			}	
			else if(lName == ''){
				alert('Please enter Last Name');
				isValid =false;
			}	
		} else {
			if(cName == ''){
				alert('Please enter Company Name');
				isValid =false;
			}
		} 
		
		if(isValid && phone == ''){
			alert('Please enter Phone number ');
			isValid =false;
		}
		
		
		
		if(isValid){
			document.getElementById("customerForm").action = "customerServlet";
			document.getElementById("customerForm").submit();
		}
		
	}
</script>

</head>

<body>

	<div id="wrapper">

		<%@include file="menu.jsp"%>

		<div id="page-wrapper">
			

			<div class="row">
				<div class="col-lg-12">

					<%@include file="msg.jsp"%>
					<br />
					<br />

					<div class="panel panel-default">

						<a id="addCustomerLink"  onclick="showForm();" class="panel-heading"> 
							<img class="icon-img" src="icons/add.png" /> <b> Add Customer </b> 
						</a>

						<!-- <div class="panel-heading">DataTables Advanced Tables</div> -->
						<!-- /.panel-heading -->
						<div class="panel-body">

							<%
								String sql = "SELECT ID, CustType, TRIM(BOTH ' ' FROM CONCAT_WS(' ', Fname, Lname, Cname)) as customerName, phone FROM customer ";
								
								Connection con = ConnectionFactory.getConnection();
								Statement stmt = con.createStatement();
								ResultSet rs = stmt.executeQuery(sql);
								%>

							<div class="table-responsive">
								<table class="table table-striped table-bordered table-hover"
									id="dataTables-example">
									<thead>
										<tr>
											<th>ID</th>
											<th>Customer Type</th>
											<th>Name</th>
											<th>Phone</th>
										</tr>
									</thead>
									<tbody>
									    <% while(rs.next()) { %>
									       <tr>
												<td><%= rs.getInt("ID")%></td>
												<td><%= rs.getString("CustType")%></td>
												<td><%= rs.getString("customerName")%></td>
												<td><%= rs.getString("phone")%></td>
											</tr>
									    <% }
									    	con.close();
									    	stmt.close();
									    	rs.close();
									    %>										
									</tbody>
								</table>
							</div>
							<!-- /.table-responsive -->

						</div>
						<!-- /.panel-body -->
					</div>
					<!-- /.panel -->
					
					<div class="col-lg-6" id="customerFormDiv" style="display: none">
						<form action="javascript:void(0);" method="post" id="customerForm" class="sky-form" role="form">
							<input type="hidden" name="id" id="id" />

							<div class="form-group">
								<label> Customer Type  </label> 
								<select name="customerType" id="customerType" class="form-control" onchange="checkCustomerType(this.value);">
									<option value="individuals">Individuals</option>
									<option value="companies">Companies</option>
								</select> 
							</div>

							<div id="nameDiv" style="display: none">
								<div class="form-group">
									<label> First Name  </label> 
									<input class="form-control" type="text"  name="fName" id="fName">
								</div>
							
								<div class="form-group">
									<label> Last Name  </label> 
									<input class="form-control" type="text" name="lName" id="lName">
								</div>
							
							</div>
							
							<div class="form-group" id="cNameDiv" style="display: none">
								<label> Company Name  </label> 
								<input class="form-control" type="text" name="cName" id="cName">
							</div>
							
							<div class="form-group">
								<label> Phone  </label> 
								<input class="form-control" type="text" name="phone" id="phone" maxlength="12">
							</div>

							<input class="btn btn-primary" type="button" onclick="validationForm();" class="button" value="Add Customer" />
							&nbsp; <a href="javascript:void(0);" onclick="hideForm()">Cancel</a>
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
	<script>
		$(document).ready(function() {
			$('#dataTables-example').dataTable();
		});
	</script>

</body>

</html>
