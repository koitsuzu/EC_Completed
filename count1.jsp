<%@page contentType="text/html"%>
<%@page import="java.util.*"%>
<%@page pageEncoding="utf-8"%>
<html>
<head>
<title>計數</title>
</head>

<body>
<%

application.setAttribute("counter","1");
out.print("已設定初始值1");
out.println("<script language='javascript'>alert('已設定初始值1');window.location.href='index.jsp';</script>") ;
%>

</body>
</html>
