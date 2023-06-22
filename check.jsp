<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%@page contentType="text/html;charset=utf-8" language="java" import="java.sql.*"%>
<%@include file="config.jsp" %>
<%
if(request.getParameter("user_email") !=null && !request.getParameter("user_email").equals("") 
	&& request.getParameter("user_password") != null && !request.getParameter("user_password").equals("")){ 
    
	sql = "SELECT * FROM `member` WHERE `MemberEmail`=? AND `Password`=?";
    PreparedStatement pstmt = null;
	pstmt=con.prepareStatement(sql);
    pstmt.setString(1,request.getParameter("user_email"));
    pstmt.setString(2,request.getParameter("user_password"));
	
	ResultSet paperrs = pstmt.executeQuery();
	
    if(paperrs.next()){            
        session.setAttribute("id",request.getParameter("user_email"));
		con.close();//結束資料庫連結
		String server="32127@tm";
		if(server.equals(request.getParameter("user_email")))
		   {out.println("<script language='javascript'>alert('管理員你好');window.location.href='index.jsp';</script>");	
}
	else{
        response.sendRedirect("index.jsp") ;
    }
	}
    else{
        con.close();//結束資料庫連結
	    out.println("<script language='javascript'>alert('密碼錯誤');window.location.href='login.jsp';</script>") ;
	}
}
else
	response.sendRedirect("login.jsp");
%>
