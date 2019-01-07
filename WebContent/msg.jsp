
<%
	String msg = (String) session.getAttribute("MSG");
	if (msg != null && !msg.equals("")) {
		out.print(msg);
		session.removeAttribute("MSG");
	}
%>