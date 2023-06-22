<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>

<%
Object userin = session.getAttribute("id");

    String name = request.getParameter("Payname");
    String phone = request.getParameter("Payphone");
    String payment = request.getParameter("payment");
    String ship = request.getParameter("ship");
    String address = request.getParameter("Address");
    String ps = request.getParameter("PS");
    
    sql = "SELECT `MemberID` FROM `member` WHERE `MemberEmail`='" + userin + "';";
    ResultSet rs = con.createStatement().executeQuery(sql);
    if (rs.next()) {
        int M_ID = rs.getInt("MemberID");
        sql = "call AddToOrder('" + M_ID + "', '" + name + "', '" + phone + "', '" + payment + "', '" + ship + "', '" + address + "', '" + ps + "')";
        con.createStatement().execute(sql);
        out.println("<script language='javascript'>alert('成功訂購');window.location.href='index.jsp';</script>");
    }
 else {
    out.println("<script language='javascript'>alert('尚未登入');window.location.href='login.jsp';</script>");
}

%>
