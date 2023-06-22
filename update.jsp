<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp" %>

<%
if (session.getAttribute("id") != null) {
    if (request.getParameter("id") != null) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
		int rowsUpdated = 0; // 初始化 rowsUpdated 变量
        try {
            // 使用 Prepared Statement 進行 SQL 更新
			Object userin = session.getAttribute("id");
			sql="SELECT `MemberID` FROM `member` WHERE `MemberEmail`='"+userin+"';";
		    ResultSet  rs=con.createStatement().executeQuery(sql);
			if (rs.next()) {
				int M_ID = rs.getInt("MemberID");
				
            String updateSql = "call wakashi.UpdateMember(?, ?, ?, ?, ?);";
            PreparedStatement updateStatement = con.prepareStatement(updateSql);
			updateStatement.setInt(1, M_ID);
            updateStatement.setString(4, email);
            updateStatement.setString(5, password);
            updateStatement.setString(2, name);
            updateStatement.setString(3, phone);
            rowsUpdated = updateStatement.executeUpdate();
            updateStatement.close();
}
            // 檢查是否成功更新資料
            if (rowsUpdated > 0) {
                // 更新成功，將新密碼存儲到會話中
                session.setAttribute("password", password);
                con.close();
                
				out.println("<script language='javascript'>alert('更新成功');window.history.back();</script>");
            } else {
                con.close();
				out.println("<script language='javascript'>alert('更新失敗！請填寫完整');window.history.back();</script>");
            }
        } catch (SQLException e) {
            con.close();
            out.print("更新失敗！發生錯誤：" + e.getMessage());
        }
    } else {
        con.close();
        out.println("<script language='javascript'>alert('更新失敗！請填寫完整');window.history.back();</script>");

    }
} else {
    con.close();
%>
<h1><font color="red">您尚未登入，请登入！</font></h1>
<form action="check.jsp" method="POST">
    帳號：<input type="text" name="email" /><br />
    密碼：<input type="password" name="password" /><br />
    <input type="submit" name="b1" value="登入" />
</form>
<%  
}
%>
