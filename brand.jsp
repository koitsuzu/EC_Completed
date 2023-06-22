<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>品牌介紹</title>
    <link rel="stylesheet" href="assets/nav.css">
    <link rel="stylesheet" href="assets/brand.css">
    <link href="https://fonts.googleapis.com/css2?family=Shippori+Mincho&display=swap" rel="stylesheet">
    <link rel="icon" href="image/logo.ico" type="image/x-icon" />
</head>
<style>
    @import url('https://fonts.googleapis.com/css2?family=Shippori+Mincho&display=swap');
</style>
<!-- 滾動fade -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>
    $(document).ready(function() {
    
    /* Every time the window is scrolled ... */ 
    $(window).scroll( function(){
    
        /* Check the location of each desired element */
        $('.fade').each( function(i){
            
            var bottom_of_object = $(this).offset().top + $(this).outerHeight();
            var bottom_of_window = $(window).scrollTop() + $(window).height();
            
            /* If the object is completely visible in the window, fade it it */
            if( bottom_of_window > bottom_of_object ){
                
                $(this).animate({'opacity':'1'},1700);
                    
            }
            
        }); 
    
    });
    
});
</script>
<!-- Q&A -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script>
        $(function(){
      $(".flip").click(function(){
          $(".panel").slideToggle("slow");
      
        });});
      $(function(){
      $(".flip1").click(function(){
          $(".panel1").slideToggle("slow");
        });});

        $(function(){
      $(".flip2").click(function(){
          $(".panel2").slideToggle("slow");
        });});

        $(function(){
      $(".flip3").click(function(){
          $(".panel3").slideToggle("slow");
        });});

        $(function(){
      $(".flip4").click(function(){
          $(".panel4").slideToggle("slow");
        });});

        $(function(){
      $(".flip5").click(function(){
          $(".panel5").slideToggle("slow");
        });});
    </script>
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
    <!--頁面內容-->
    <div class="brandimg">
        <img src="image/main.jpg" width="100%" class="rr">
        <div class="shape-ex2">ようこそ、chinmiへ</div>
    </div>

    
    <div class="fade">
        <section>
        
            <article>
                <div class="chimi">ようこそ、chinmiへ！</div><p>私たちは、最も本格的で美味しくて精巧な日本のお菓子たいけんを提供することに力を注いでいます。
            </article>
            <aside>
                
                <div class="pics">
                    <img src="image/brandf1.jpg"  width="400" height="250">
                    <img src="image/brandf.jpg"  width="400" height="250">
                  </div>
                
            </aside>
        </section>
    </div>
    <div class="clear"></div>

    <div class="fade">
        <div class="logo">
            <div class="bigger"><img src="image/logo.png" height="250px" width="250px"></div>
        </div>
        
        <div class="named">
            我們的名字「<font color="#7575A9">饈菓子chinmi</font>」<br>
            靈感來自於日語中「饈（Nokashi）」<br>意味著美味的點心和小食品<br>
        </div>           
        
    </div>
    <div class="clear"></div>

    <div class="ee">
        <div class="fade">
            <div class="intro">我們的團隊由專業的點心師和廚師組成，</div>        
        </div>
        <div class="fade">
            <div class="intro">對於製作日式點心有著豐富的經驗和獨特技藝。</div>
        </div>
        <div class="fade">
            <div class="intro">以高品質的食材、精心製作的工藝和注重細節的態度，</div>
        </div>
        <div class="fade">
            <div class="intro">打造出一個讓人愉悅和著迷的點心世界。</div>
        </div>
       
    </div>
    
    <div class="fade">
        <div class="tt"><img src="image/bg1.jpg" alt="" width="605px"></div>
    </div>
    
    <div class="clear"></div>
    <div class="fade">
        <div class="special">
            饈菓子提供各種口味的和菓子、<br>
            &nbsp; &nbsp; &nbsp;  創意獨特的羊羹和豐富多樣的大福。
        </div>
    </div>
    <!-- <div class="fade"> -->
        <div class="pa">
            <div class="bigger">
                <a href="wagashi.jsp"><img src="image/p3.jpg" alt="" height="360px"></a>
            </div>
            <div class="bigger">
                <a href="yokan.jsp"><img src="image/y4.jpg" alt="" height="360px"></a>
            </div>
            <div class="bigger">
                <a href="dango.jsp"><img src="image/d10.jpg" alt="" height="360px"></a>
            </div>          
        </div>
        
    
    <div class="fade">
        <div class="eve">
            無論是作為個人享用、禮物或節日慶典贈送，<br>
            我們都希望能為您提供令人難以忘懷的點心體驗。
        </div>
    </div>
    <div class="fade">
        <div class="qa">  —常見問題—  </div>
    </div>
    <!-- QA -->
    <div class="">
        <div>
            <div class="flip"><span> Q: 食物的保存期限是多久？  ▼</span></div>
            <div class="panel">食物的保存期限會因不同的產品而有所不同。<br>在每個產品的頁面上，我們會提供詳細的保存期限資訊。請在收到食品後確認保存期限並適時食用或儲存。</div>
        </div>
        <div>
            <div class="flip1"><span> Q: 如果收到的食品有問題該怎麼辦？  ▼</span></div>
            <div class="panel1">如果您收到的食品有任何問題，如損壞、過期或錯誤配送，請立即聯繫我們的客戶服務團隊。<br>我們將盡力協助解決問題，包括提供退款、換貨或其他解決方案。</div>
        </div>
        <div>
            <div class="flip2"><span> Q: 是否提供退換貨服務？  ▼</span></div>
            <div class="panel2">是的，我們提供退換貨服務。如果您對收到的食品不滿意或有其他原因需要退換貨，<br>請聯繫我們的客戶服務團隊。或請查閱我們的退換貨政策以獲取更多資訊。</div>
        </div>
        <div>
            <div class="flip3"><span> Q: 可以更改或取消已下單的訂單嗎？  ▼</span></div>
            <div class="panel3">若您需要更改或取消已下單的訂單，請儘快聯繫我們的客戶服務團隊。我們將盡力協助您處理訂單的更改或取消，但請注意，一旦訂單已經處理或運送，可能無法進行更改或取消。</div>
        </div>
        <div>
            <div class="flip4"><span> Q: 運送需要多久時間？  ▼</span></div>
            <div class="panel4">運送時間取決於您的所在地和選擇的運送方式。通常，我們會在收到訂單後的1-3個工作日內處理並安排運送。</div>
        </div>
        <div>
            <div class="flip5"><span> Q: 如果我的付款出現問題該怎麼辦？  ▼</span></div>
            <div class="panel5">如果您在付款過程中遇到任何問題，請立即聯繫我們的客戶服務團隊。我們將竭誠協助您解決問題並完成付款。</div>
        </div>
    </div>

    <section>
        <div class="g_write">
            <h1>CONTACT US</h1>
            <form action="qa.jsp">
                <input type="text" name="name" placeholder="NAME" class="input_font">
                <br>
                <textarea  class="input_font2"  name="confuse" placeholder="COMMENT"></textarea>
                <button type="submit" class="btn_send" onclick="javascript:alert('已收到您的回覆')">Send</button>
            </form>
		<%	
		if(server.equals(userin)){
%>		
			<a href="view.jsp" style="font-size: 35px; margin-left: 270px;">查看留言</a>

		<%}%>
        </div>

        <div class="map">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3617.2670373550463!2d121.24097727505581!3d24.957027677866368!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x346822143c046009%3A0x63e3ef21e3beebac!2z6LOH6KiK566h55CG5a2457O7!5e0!3m2!1szh-TW!2stw!4v1684761782612!5m2!1szh-TW!2stw"
            width="500" height="400" style="border:0;" allowfullscreen="" loading="lazy" maptype="satellite" referrerpolicy="no-referrer-when-downgrade"></iframe>
        </div>
    </section>










<div class="clear"></div>
<!-- 夫特 -->
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
			</div>       </section>
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
</body>
</html>
