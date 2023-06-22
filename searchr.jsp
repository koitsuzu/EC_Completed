<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>饈WAKASHI</title>
    <link rel="stylesheet" href="assets/good.css">
    <link rel="stylesheet" href="assets/nav.css">
    <link href="https://fonts.googleapis.com/css2?family=Shippori+Mincho&display=swap" rel="stylesheet">
    <link rel="icon" href="image/logo.ico" type="image/x-icon" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Shippori+Mincho&display=swap');
		
	</style>
</head>


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
    <script>
        function minus1(){
            var num=Number(document.getElementsByClassName('qtyy')[0].value);
            if(num>1){
                document.getElementsByClassName('qtyy')[0].value= num-1;
            }
        }
        function add1(){
            var num=Number(document.getElementsByClassName('qtyy')[0].value);
            if(num<100){
                document.getElementsByClassName('qtyy')[0].value= num+1;
            }
        }
    </script>
<div class="main">
	<%
String searchQuery = request.getParameter("search");

	if (searchQuery != null && !searchQuery.isEmpty()) {
  
        PreparedStatement stmt = con.prepareStatement("SELECT * FROM `product` WHERE `ProductName` LIKE ?");
        stmt.setString(1, "%" + searchQuery + "%");
        ResultSet rss = stmt.executeQuery();

        if (rss.next()) {
%>

        <div class="g_img">
            <img src="image/<%=rss.getString(4)%>" alt="">
        </div>
        <div class="g_intro">
		<%		  String PID= rss.getString("ProductID");
					if(server.equals(userin)){
						
						%>
						  <form action="DeleteP.jsp" style='margin-left:350px;'>
						    <input type="hidden" name="PID" value="<%= PID %>">
							<button type="submit"  onclick="javascript:alert('刪除商品')">X</button>
                   
						  </form>
						  <form action="ReviseP.jsp" style='margin-left:350px;'>
						    <input type="hidden" name="PID" value="<%= PID %>">
							<button type="submit">修改</button>
                   
						  </form>
				
						
					<%}%>
				
            <h1><%=rss.getString(3)%></h1>
            <p class="price">NT$<%=rss.getString(6)%></p>
            <p>
                <%=rss.getString(5)%></p>
            <div>
                <form action="addcart.jsp">
                    <div class="btn_set">
                        <div class="btn_font">
						    <input type="hidden" name="PID" value="<%= PID %>">
							<input type="hidden" name="IMG" value="<%= rss.getString(4) %>">
                            <input type="button" value="-" class="btn" onclick="minus1(0)">
                            <input type="text" value="1" class="qtyy" name="quantity">
                            <input type="button" value="+" class="btn" onclick="add1(0)">
                        </div>
                        <button type="submit" class="btn_cart" onclick="javascript:alert('加入購物車')">加入購物車</button>
                    </div>
                </form>
            </div>
            <p><font size="5px" color="#A39274">庫存:<%=rss.getString(7)%>個</font></p>
        </div>
 


         <div class="g_write">
            <h1>商品評論</h1>
            <form action="addcomment.jsp">
				<input type="hidden" name="PID" value="<%= PID %>">
                <input type="text" name="NickName" placeholder="Name" class="input_font">
                <br>
                <textarea  class="input_font2"  name="comment" placeholder="COMMENT"></textarea>
                <div class="rating">
                    <input type="text" value="ipconfig" id="star"> <br>
                      <input type="radio" name="star" value="★★★★★" onclick="star(this)" id="star5"><label for="star5"></label>
                      <input type="radio" name="star" value="★★★★"  onclick="star(this)"id="star4"><label for="star4"></label>
                      <input type="radio" name="star" value="★★★" onclick="star(this)" id="star3"><label for="star3"></label>
                      <input type="radio" name="star" value="★★" onclick="star(this)" id="star2"><label for="star2"></label>
                      <input type="radio" name="star" value="★" onclick="star(this)" id="star1"><label for="star1"></label>
                </div>
                <button type="submit" class="btn_send" onclick="javascript:alert('謝謝你的評論')">Send</button>
            </form>
        </div>
     <div class="g_comment">
		<h1>REVIEW</h1>
		<div class="viewbox">
		<%
		if (PID != null) {
		sql = "SELECT * FROM `comment` WHERE `ProductID` =" +PID+ "";
                ResultSet rs=con.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY).executeQuery(sql);
            //ResultSet.TYPE_SCROLL_INSENSITIVE表紀錄指標可前後移動，ResultSet.CONCUR_READ_ONLY表唯讀
            //先移到檔尾, getRow()後, 就可知道共有幾筆記錄
            rs.last();
            int total_content=rs.getRow();

           
            //每頁顯示5筆, 算出共幾頁
            int page_num=(int)Math.ceil((double)total_content/3.0); //無條件進位
            
            //使用超連結方式, 呼叫自己, 使用get方式傳遞參數(變數名稱為page)
            

            //讀取page變數
            String page_string = request.getParameter("page");
            if (page_string == null) 
               page_string = "0";          
            int current_page=Integer.valueOf(page_string);
            if(current_page==0) //若未指定page, 令current_page為1
                current_page=1;
            //計算開始記錄位置   
            //Step 5: 顯示結果 
            int start_record=(current_page-1)*3;
            //遞減排序, 讓最新的資料排在最前面


      

            rs=con.createStatement().executeQuery(sql);
			if (rs.next()) {			
							
		%>
        
            
            
                <span class="v-name"><%=rs.getString(3)%></span>
                <span class="v-star"><%=rs.getString(5)%></span><br>
                <div class="v-txt"><p><%=rs.getString(4)%></p></div>
                <!-- <div>----------------------------------------------------</div> -->
            
		<%
				}
							
		%>
	
		</div>
 
        </div>
		 	<p  style="margin-left:850px; font-size:25px">共<%=total_content%>筆留言</p>
            <p style="margin-left:850px; font-size:25px"><%for(int i=1;i<=page_num;i++) //建立1,2,...頁超連結
                out.print("<a href='good.jsp?page="+i+"&id="+PID+"'>"+i+"</a>&nbsp;"); //&nbsp;html的空白

            out.println("<p>");%></p>

            <%
            }
							
			%>
    </div>
	<%
		
		}else {
        out.println("<script>alert('查無此商品'); window.history.back();</script>");
    }

    rss.close();
    stmt.close();
    con.close();


} else {
    out.println("Please enter a search query.");
}
%>
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