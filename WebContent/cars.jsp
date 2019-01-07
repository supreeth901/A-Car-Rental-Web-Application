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
<title>Cars</title>

<!-- Core CSS - Include with every page -->
<link href="css/bootstrap.min.css" rel="stylesheet">
<link href="font-awesome/css/font-awesome.css" rel="stylesheet">

<!-- Page-Level Plugin CSS - Dashboard -->
<link href="css/plugins/morris/morris-0.4.3.min.css" rel="stylesheet">
<link href="css/plugins/timeline/timeline.css" rel="stylesheet">

<!-- SB Admin CSS - Include with every page -->
<link href="css/sb-admin.css" rel="stylesheet">


 <script src="js/common.js"></script>
 
<link href="css/plugins/dataTables/dataTables.bootstrap.css"
	rel="stylesheet">

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

						<div class="panel-heading"> <h4>Cars</h4></div>

						<!-- <div class="panel-heading">DataTables Advanced Tables</div> -->
						<!-- /.panel-heading -->
						<div class="panel-body">

							<%
								String sql = "SELECT VehicleID, Model, year, cartype.Type, owner.OwnerType, ";
							    sql = sql + "TRIM(BOTH ' ' FROM CONCAT_WS(' ', Fname, Lname, Bname, Rcname)) as ownerName ";
							    sql = sql + "FROM car ";
							    sql = sql + "left join cartype on cartype.TypeID = car.TypeID ";
							    sql = sql + "left join owner on owner.OID = car.OID ";
								
								Connection con = ConnectionFactory.getConnection();
								Statement stmt = con.createStatement();
								ResultSet rs = stmt.executeQuery(sql);
								%>

							<div class="table-responsive">
								<table class="table table-striped table-bordered table-hover"
									id="dataTables-example">
									<thead>
										<tr>
											<th>Vehicle ID</th>
											<th>Type</th>
											<th>Model</th>
											<th>Year</th>
											<th>Owner Type</th>
											<th>Owner Name</th>
										</tr>
									</thead>
									<tbody>
									    <% while(rs.next()) { %>
									       <tr>
												<td><%= rs.getInt("VehicleID")%></td>
												<td><%= rs.getString("Type")%></td>
												<td><%= rs.getString("Model")%></td>
												<td><%= rs.getString("year")%></td>
												<td><%= rs.getString("OwnerType")%></td>
												<td><%= rs.getString("ownerName")%></td>
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
