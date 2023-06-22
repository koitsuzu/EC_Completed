<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>訂單確認</title>
     <link rel="stylesheet" href="assets/nav.css">
    <link rel="stylesheet" href="assets/pay.css">
    <link rel="icon" href="../image/logo.ico" type="image/x-icon" />
   <script type="text/javascript" src="../jsp1/js/car.js"></script>
   <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>

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
            <li><a href="index.jsp"><img src="image/logo.png" alt=""></a></li>
            <li>
                <div class="dropdown">
                    商品瀏覽
                    <div class="dropdown-content">
                    <a href="yokan.jsp">羊羹</a>
                    <a href="dango.jsp">大福/糰子</a>
                    <a href="namagashi.jsp">上生菓子</a>
                    <a href="wagashi.jsp">禮盒</a>
                    </div>
                </div>
            </li>
             <%
                Object userin = session.getAttribute("id");
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
    </nav>

    <!--頁面內容-->

    <article class="main">
        <div class="information">
            
                <section>
                    <div class="p_title">----------------訂單資訊----------------</div>
                    <div class="show">
                        <div class="s1">訂單商品</div>
                        <div class="s2">單價</div>
                        <div class="s3">數量</div>
                        <div class="s4">總價</div>
                    </div>
                    
                        <%
                     	if (userin != null) {
										con.createStatement().execute("use wakashi");
										request.setCharacterEncoding("UTF-8");  
									   sql="CALL wakashi.GetCartItems((SELECT `MemberID` FROM `member` WHERE `MemberEmail`='"+userin+"'));";
									   ResultSet  rs=con.createStatement().executeQuery(sql);		   
                   
                                        // Step 5：進行資料的處理
                                        int total=0;
                                        while (rs.next()) { %>
										
									<div class="show_more">
										<div class="sm1"><img src="image/<%= rs.getString(4) %>" alt=""></div>
										<div class="sm1_1"><%= rs.getString(3) %></div>
										<div class="sm2">NT$<%= rs.getString(5) %></div>
										<div class="sm3"><%= rs.getString(6) %></div>
										<div class="sm4">NT$<%= rs.getString(7) %></div>
									</div>
<%  
							int quantity = Integer.parseInt(rs.getString(6));
							int price = Integer.parseInt(rs.getString(5));
							int subTotal = quantity * price;
							total += subTotal;							
										}
        
	} else {
                    out.println("<script language='javascript'>alert('尚未登入');window.location.href='login.jsp';</script>");
                }
%>

                </section>
				   <%     
                if (userin != null) {
					con.createStatement().execute("use wakashi");
				    request.setCharacterEncoding("UTF-8");  
				   sql="SELECT * FROM `member` WHERE `MemberEmail`='"+userin+"';";
				   ResultSet  rs=con.createStatement().executeQuery(sql);
				   if (rs.next()) {
					
				%>
				<form action="order.jsp">
                <section class="p_img">
                    <div  class="p_title">----------------取貨資料----------------</div>
                    <div class="fillin">
                        <div class="fill1"><input type="text" name="Payname" placeholder="姓名:" value="<%=rs.getString(2)%>"><br></div>
                        <div class="fill2"><input type="text" name="Payphone" placeholder="電話:" value="<%=rs.getString(3)%>" ><br></div>
                        <div class="fill2_2">
                            <label for="payment" >付款方式:</label>
                            <select name="payment" id="payment">
                                <option value="貨到付款">貨到付款</option>
                                <option value="銀行轉帳">銀行轉帳</option>
                                <option value="信用卡">信用卡</option>
                            </select><br>
                        </div>
                        <div class="fill3"> 
                            <label for="ship" >取貨方式:</label>
                            <input type="radio" name="ship" value="711" onclick="ship(this)" id="seven">
                            <label for="seven">7-ELEVEN</label>
                            <input type="radio" name="ship" value="全家"  onclick="ship(this)"id="fami">
                            <label for="fami">全家</label>
                            <input type="radio" name="ship" value="宅配" onclick="ship(this)" id="home">
                            <label for="home">宅配</label><br>
                        </div>
                        <div class="fill4"><input type="text" name="Address" placeholder="地址:"><br></div>
                        <div class="fill5"><textarea name="PS" id="" cols="30" rows="10" placeholder="備註:" ></textarea><br></div>
                    </div>
                    <div class="payit">
                        <button type="submit">送出訂單</button>
                    </div>
                    <div class="pay_img">
                        <img src="image/checkout.png" alt="">
                    </div>
                </section>
		<%}
				   
                }
                    
        %>				
            </form>
        </div>               
       

                
    </article>
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
            function ship(obj){
              document.getElementById('ship').value = obj.value;
                       }
        </script>
        
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
    <script type="text/javascript" src="../jsp1/js/car.js"></script>
</body>
</html>
