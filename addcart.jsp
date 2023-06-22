<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp" %>
<%
                Object userin = session.getAttribute("id");
                if (userin != null) {
					con.createStatement().execute("use wakashi");
				    request.setCharacterEncoding("UTF-8");  
				  
				    int PID = Integer.parseInt(request.getParameter("PID"));
				    String qty =request.getParameter("quantity");
				    String img =request.getParameter("IMG");
				    sql="SELECT `MemberID` FROM `member` WHERE `MemberEmail`='"+userin+"';";
				    ResultSet  rs=con.createStatement().executeQuery(sql);
				    if (rs.next()) {
						int M_ID = rs.getInt("MemberID");
						sql = "call AddCart('" + PID + "', '" + img + "', '" + qty + "', '" + M_ID + "')";
						con.createStatement().execute(sql);
						out.println("<script language='javascript'>alert('成功加入購物車');window.history.back();</script>");
					}
				   
                } else {
                    out.println("<script language='javascript'>alert('尚未登入');window.location.href='login.jsp';</script>");
                }
%>