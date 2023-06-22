<%@ page import="java.sql.*" %>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@ include file="config.jsp" %>

<%
Object userin = session.getAttribute("id");
if (userin != null) {
    int PID = Integer.parseInt(request.getParameter("PID"));
    try {
        con.createStatement().execute("USE wakashi");
        sql = "CALL DeleteProduct(?)";
        PreparedStatement deleteStatement = con.prepareStatement(sql);
        deleteStatement.setInt(1, PID);
        int rowsDeleted = deleteStatement.executeUpdate();
        deleteStatement.close();
        con.close();

        if (rowsDeleted > 0) {
            out.println("数据删除成功！");
        } else {
            out.println("数据删除失败！");
        }
        out.println("<script language='javascript'>alert('成功刪除');window.location.href='index.jsp';</script>");
    } catch (SQLException e) {
        out.println("发生错误：" + e.getMessage());
    }
} else {
    out.println("<script language='javascript'>alert('尚未登入');window.location.href='login.jsp';</script>");
}
%>