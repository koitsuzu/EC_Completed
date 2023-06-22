<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>大福糰子</title>
    <link rel="stylesheet" href="assets/nav.css">
    <link rel="stylesheet" href="assets/dango.css">
    <link rel="icon" href="image/logo.ico" type="image/x-icon" />
   <script type="text/javascript" src="../jsp1/js/car.js"></script>
   <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
   <script>
        function selectOption(id) {
            document.getElementById("selected").value = id;
            document.getElementById("form").submit();
        }
    </script>
</head>

<style>
    @import url('https://fonts.googleapis.com/css2?family=Shippori+Mincho&display=swap');
  </style>

  


<body>
    <!-- 頂端選單 -->
    <nav class="navset">
        <div class="search">
            <form action="searchr.jsp" method="get">
                <input type="text" name="search" placeholder="Search for products...">
            </form>
			<script>
				document.getElementById("searchForm").addEventListener("keydown", function(event) {
					if (event.keyCode === 13) { 
						event.preventDefault(); 
						document.getElementById("searchForm").submit(); 
					}
				});
			</script>
            <div class="search1"><img src="image/search.png" alt=""></div>
        </div> 
        <ul>
            <li><a href="brand.jsp">品牌介紹</a></li>
            <li><a href="aboutus.jsp">關於我們</a></li>
            <li><a href="index.jsp" name="#top"><img src="image/logo.png" alt=""></a></li>
            <li>
                <div class="dropdown">
                    商品瀏覽    
                    <div class="dropdown-content">
                    <a href="yokan.jsp">羊羹</a>
                    <a href="dango.jsp">大福/糰子</a>
                    <a href="namagashi.jsp">上生菓子</a>
                    <a href="wagashi.jsp">禮盒</a>
					<%Object userin = session.getAttribute("id");
					String server="32127@tm";
					if(server.equals(userin)){
						out.print("<a href='AddP.jsp' >新增商品</a>");
					}%>
                    </div>
                </div>
            </li>
             <%
              
                if (userin != null) {
                    out.print("<li><a href='member.jsp'>會員資料</a></li>");
                } else {
                    out.print("<div class='login'><a href='login.jsp'>[登入]</a></div>");
                }
%>
               <%
               if (userin!= null){
                out.print("<div class='login'><a href='logout.jsp'>[登出]</a></div>");
            }
            %>  
        </ul>
        <!--購物車-->
        <div class="flower">
			<div id="main" onclick="openNav()"><img src="image/car.png" alt="" onmouseover="this.src='image/bag.png';" onmouseout="this.src=' image/car.png';" class="openbtn"></div>  

            <div id="car" class="sidebar" >
                <a href="javascript:void(0)" class="closebtn" onclick="closeNav()">×</a>
                <%
                if (userin != null) {
                    con.createStatement().execute("use wakashi");
				    request.setCharacterEncoding("UTF-8");  
				   sql="CALL wakashi.GetCartItems((SELECT `MemberID` FROM `member` WHERE `MemberEmail`='"+userin+"'));";
				   ResultSet  rs=con.createStatement().executeQuery(sql);		   
                   
%>
					<div class="buy">
                    
                        <div class="good">
					<%	int total=0;
						 while (rs.next()) { %>
                            <div class="numm">
                                <img src="image/<%= rs.getString(4) %>">
                                <div>
                                    <!--商品名稱-->
                                    <div class="nu1">  
                                        <div><%= rs.getString(3) %></div>
                                        </div> NT$<%= rs.getString(5) %>
                                    <!--商品數量-->
                                    <div class="nu2"> 
                                        <input type="button" value="-" class="btn" onclick="minus(0)">
                                        <input type="text" id="number" value="<%= rs.getString(6) %>" class="qty">
                                        <input type="button" value="+" class="btn" onclick="add(0)">
                                    </div>
                                </div>
								
                                <form action="DeleteCart.jsp" >
								    <input type="hidden" name="CID" value="<%=rs.getString(1) %>">
									<button type="submit" class="x" onclick="javascript:alert('刪除商品')">X</button>
								</form>

                            </div>
	<%  
							int quantity = Integer.parseInt(rs.getString(6));
							int price = Integer.parseInt(rs.getString(5));
							int subTotal = quantity * price;
							total += subTotal;							
							} %>
                        </div>
                        <!-- 總金額-->
						
                        <div class="total">
                            <p class="r"> 總金額  $<%=total%></p>
                            <div class="but"><a href="pay.jsp" > 結帳</a></div>
                        </div>

                </div>

<%		} 
%>
             </div>
        </div>
    </nav>
    <section>
        <img src="image/dango.png" class="rr">
        <div class="shape-ex2">大福/糰子<br><font size="100">-Daifuku  Dango-</font></div>
        
    </section>
    <div class="fuku">——————— 大福 / 糰子———————</div>
    <main>
        <form id="form" class="container x" action="good.jsp" method="post">
        <%
                    sql = "SELECT * FROM `product` Where `Class`='大福團子';";
                    ResultSet rs = con.createStatement().executeQuery(sql);
                    //Step 5：進行資料的處理
                    while (rs.next()) {
						String PID=rs.getString(1);
                        String Name = rs.getString(3);
                        String Img = rs.getString(4);
                        String price = rs.getString(6);
					
        %>
       <div class="image">
                <img src="image/<%= Img %>" onclick="selectOption('<%=PID%>')" class="item" >
                    <div class="tt"><font size="5px"><%= Name %></font><br><%= price %></div>
               
            </div>

<%}%>
        <input type="hidden" id="selected" name="id">
    
        

    </main>
    
    
    <!-- 尾端 -->
    <footer>
     <div class="footerr">
        <section class="f1">
            <div class="chinmi">❃ 饈菓子CHINMI </div>
            <div class="slogan">甘い幸福の一口。和菓子、<br>あなたの心を癒します。</div>
            <div class="address">地址:桃園市中壢區中北路200號</div>
        </section>
        <section class="f2">
            <div class="time">TEL:03-265-9999<br>
                營業時間：9:00〜18:00<br>
                公休日：週一・週二<br>
                <hr>
                
                <a href="https://www.facebook.com/CYCU.PR/?locale=zh_TW"><img src="image/fb.png"></a>
                <a href="https://www.instagram.com/cycusa/"><img src="image/ig.png"></a>
                <a href="mailto:8973088@gmail.com"><img src="image/em.png"></a>
                
                </div>
			    <div class="copy">
			   <%
				int counter;
				String a=(String)application.getAttribute("counter");
				counter=Integer.parseInt(a);
				if(session.isNew()){
				counter++;}
				a=String.valueOf(counter);
				application.setAttribute("counter",a);

				%>
				你是第<%=counter%>位訪客<br>
				Copyright © 2023 Chinmi  All Rights.
			</div>
        </section>
        <section>
            <img src="image/bobo.png" class="bobo">
            <div class="f3"><a href="#top" class="f3">page<br>top</a></div>
        </section>
     </div>
     <div class="foot">
     <div class="scroll">
        <div class="text">
        ❃ CHINMI  ❃ CHINMI  ❃CHINMI  ❃CHINMI  ❃CHINMI  ❃CHINMI  ❃CHINMI  ❃CHINMI    ❃CHINMI  ❃CHINMI  ❃CHINMI  ❃CHINMI  
        </div>
        <div class="text">
        ❃  CHINMI  ❃ CHINMI  ❃CHINMI  ❃CHINMI  ❃CHINMI  ❃CHINMI  ❃CHINMI  ❃CHINMI  ❃CHINMI  ❃CHINMI  ❃CHINMI  ❃CHINMI     
        </div>
      </div>
    </div>
    </footer>
    <script>
        function openNav() {
          document.getElementById("car").style.width = "400px";
          document.getElementById("main").style.marginLeft = "0px";
        }
        
        function closeNav() {
          document.getElementById("car").style.width = "0";
          document.getElementById("main").style.marginLeft= "0px";
        }
        </script>
           
           <script>
            function minus(number){
                var num=Number(document.getElementsByClassName('qty')[number].value);
                if(num>1){
                    document.getElementsByClassName('qty')[number].value= num-1;
                }
            }
            function add(number){
                var num=Number(document.getElementsByClassName('qty')[number].value);
                if(num<100){
                    document.getElementsByClassName('qty')[number].value= num+1;
                }
            }
        </script>
        <script>
            function star(obj){
              document.getElementById('star').value = obj.value;
                       }
        </script>
        <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
        <script type="text/javascript" src="../jsp1/js/car.js"></script>
</body>
</html>