<!-- Step 0: import library -->
<%@ page import = "java.sql.*, java.util.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<title>join</title>
</head>
<body>
<%
try {
//Step 1: 載入資料庫驅動程式 
    Class.forName("com.mysql.jdbc.Driver");
    try {
//Step 2: 建立連線 	
        String url="jdbc:mysql://localhost/?serverTimezone=UTC";
        String sql="";
        Connection con=DriverManager.getConnection(url,"root","1234");
        if(con.isClosed()){
		out.println("連線建立失敗");}
        else {
//Step 3: 選擇資料庫   
           
           con.createStatement().execute("use wakashi");
		   request.setCharacterEncoding("UTF-8");  
		  
           String new_name=request.getParameter("user_name");
           String new_user_email=request.getParameter("user_email");
		   String new_user_password=request.getParameter("user_password");
		   String new_user_phone=request.getParameter("user_phone");
		   
//判斷密碼相符
           sql="SELECT `MemberEmail` FROM `member` WHERE `MemberEmail`='"+new_user_email+"';";
	       ResultSet  rs=con.createStatement().executeQuery(sql);
		   String Idcheck="";
		   while(rs.next()){
		   Idcheck=rs.getString("MemberEmail");}
		   if(Idcheck.equals(new_user_email)){
			   out.println("<script language='javascript'>alert('帳號已存在');window.location.href='reg.jsp';</script>");	
		   }
           else{
		   
		   
		      out.println("<script language='javascript'>alert('註冊成功');window.location.href='login.jsp';</script>");
               java.sql.Date new_date=new java.sql.Date(System.currentTimeMillis());
//Step 4: 執行 SQL 指令	
		   sql="call AddMember('" + new_name + "', " + "'"+new_user_phone+"', '"+new_user_email+"', '"+new_user_password+"')";


           con.createStatement().execute(sql);
		   	   
//Step 6: 關閉連線
           con.close();
		   }
		   
		  
//Step 5: 顯示結果 
          //直接顯示最新的資料
           //response.sendRedirect("index.jsp");
		   }
        
	 }
    
         catch (SQLException sExec) {
           out.println("SQL錯誤"+sExec.toString());
		 }
          
} 
catch (ClassNotFoundException err) {
   out.println("class錯誤"+err.toString());
}
%>
</body>
</html>
