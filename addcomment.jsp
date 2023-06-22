<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp" %>
<%
                Object userin = session.getAttribute("id");
                if (userin != null) {
					try{
						con.createStatement().execute("use wakashi");
						request.setCharacterEncoding("UTF-8");  
						  
					    int PID = Integer.parseInt(request.getParameter("PID"));
					    String NickName =request.getParameter("NickName");
						String comment=request.getParameter("comment");
					    String star=request.getParameter("star");
					    sql="SELECT `MemberID` FROM `member` WHERE `MemberEmail`='"+userin+"';";
					    ResultSet  rs=con.createStatement().executeQuery(sql);
					    if (rs.next()) {
							int M_ID = rs.getInt("MemberID");
							sql = "call AddComment('" + M_ID + "','" + PID + "', '" +NickName+ "', '" + comment + "', '" + star + "')";
							con.createStatement().execute(sql);
							out.println("<script language='javascript'>window.history.back();</script>");
						}
				    } catch (SQLException e) {
						con.close();
						out.println("<script language='javascript'>alert('您已做過評論');window.history.back();</script>");
					}
                } else {
                    out.println("<script language='javascript'>alert('尚未登入');window.location.href='login.jsp';</script>");
                }
%>