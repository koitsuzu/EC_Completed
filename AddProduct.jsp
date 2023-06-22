<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp" %>
<%
Object userin = session.getAttribute("id");
String server = "32127@tm";
if (server.equals(userin)) {
    con.createStatement().execute("use wakashi");
    request.setCharacterEncoding("UTF-8");  
    
    String P_class = request.getParameter("P_class");
    String P_name = request.getParameter("P_name");
    String P_img = request.getParameter("P_img");
    String P_detail = request.getParameter("P_detail");
   
	String  P_price = request.getParameter("P_price");
	String  P_qty = request.getParameter("P_qty");

	sql = "call AddProduct('" + P_class + "', '" + P_name + "', '" + P_img + "', '" + P_detail + "', " + P_price + ", " + P_qty + ")";
	con.createStatement().execute(sql);

	out.println("<script language='javascript'>alert('新增成功');window.location.href='AddP.jsp';</script>");

}

	
	
	
	%>