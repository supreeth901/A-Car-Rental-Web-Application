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
<title>Car Types</title>

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
					<!-- <h1 class="page-header">Tables</h1> -->
					<br />
					<br />
				</div>
				<!-- /.col-lg-12 -->
			</div>

			<div class="row">
				<div class="col-lg-12">

					<%@include file="msg.jsp"%>
					<br />
					<br />

					<div class="panel panel-default">
						
						<div class="panel-heading"> <h4>Car Types</h4></div>

						<!-- <div class="panel-heading">DataTables Advanced Tables</div> -->
						<!-- /.panel-heading -->
						<div class="panel-body">

							<%
								String sql = "select typeId, type, dailyRate, weeklyRate from cartype; ";
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
											<th>Car Type</th>
											<th>Daily Rate</th>
											<th>Weekly Rate</th>
										</tr>
									</thead>
									<tbody>
									    <% while(rs.next()) { %>
									       <tr>
												<td><%= rs.getInt("typeId")%></td>
												<td><%= rs.getString("type")%></td>
												<td><%= rs.getDouble("dailyRate")%></td>
												<td><%= rs.getDouble("weeklyRate")%></td>
												<%-- <td>
												   <a href="updateUser.jsp?id=<%= rs.getString("id")%>"> <img class="icon-img" alt="Update" src="icons/edit.png" title="Update"> </a> &nbsp;
												   <a onclick="deleteData('<%= rs.getInt("id")%>')"><img class="icon-img" alt="Update" src="icons/delete.png" title="Delete"></a>
												</td> --%>
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
