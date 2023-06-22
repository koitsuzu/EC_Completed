<%@page contentType="text/html;charset=utf-8" language="java" import="java.sql.*"%>

<% 
session.removeAttribute("id");
//response.sendRedirect("login.html") ;
out.println("<script language='javascript'>alert('登出成功');window.location.href='index.jsp';</script>");
%>