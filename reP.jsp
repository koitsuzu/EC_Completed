<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp" %>
<%
Object userin = session.getAttribute("id");
String server = "32127@tm";
if (server.equals(userin)) {
    con.createStatement().execute("use wakashi");
    request.setCharacterEncoding("UTF-8");  
    String PID= request.getParameter("PID");
    String name = request.getParameter("name");
    String price= request.getParameter("price");
    String detial = request.getParameter("detial");
    String qty = request.getParameter("qty");

	sql = "call UpdateProduct('" + PID + "', '" +name + "', '" + detial + "', '" + price + "', '" + qty + "' )";
	con.createStatement().execute(sql);

	out.println("<script language='javascript'>alert('修改成功');window.location.href='good.jsp?id="+PID+"';</script>");

}

	
	
	
	%>