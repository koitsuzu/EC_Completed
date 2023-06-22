<%@ page import = "java.io.*"%>  <%@ page import="java.sql.ResultSet" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>  <%@ page import="java.sql.DriverManager" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>饈WAKASHI</title>
    <link rel="stylesheet" href="assets/revise_goods.css">
    <link rel="stylesheet" href="assets/nav.css">
    <link href="https://fonts.googleapis.com/css2?family=Shippori+Mincho&display=swap" rel="stylesheet">
    <link rel="icon" href="../image/logo.ico" type="image/x-icon" />
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Shippori+Mincho&display=swap');
    </style>
</head>



<body>
   <!-- 頂端選單 -->
   <nav class="navset">
    <div class="search">
        <form action="#" method="post">
            <input type="text" name="" placeholder="Search...">
        </form>
        <div class="search1"><img src="image/search.png" alt=""></div>
    </div> 
    <ul>
        <li><a href="goods_check.jsp">瀏覽訂單</a></li>
        <li><a href="manage.jsp">新增商品</a></li>
        <li><a href="index.jsp"><img src="image/logo.png" alt=""></a></li>
        <li>
            <div class="dropdown">
                <a href="revise_goods.jsp">修改商品</a>
                <div class="dropdown-content">
                <a href="yokan.jsp">羊羹</a>
                <a href="dango.jsp">大福/糰子</a>
                <a href="namagashi.jsp">上生菓子</a>
                <a href="wagashi.jsp">禮盒</a>
                </div>
            </div>
        </li>
        <%
        Object usin = session.getAttribute("email");
        if (usin != null) {
            out.print("<li><a href='../jsp1/memberback.jsp'>後臺管理</a></li>");
        } else {
            out.print("<div class='login'><a href='../jsp1/login.jsp'>[登入]</a></div>");
        }
%>
       <%
       if (usin!= null){
        out.print("<div class='login'><a href='logout.jsp'>[登出]</a></div>");
    }
    %>  
    </ul>
    <!--購物車-->
    
    </nav>
    <!--頁面內容-->
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

<script>
    // 在頁面載入完成後執行
    window.onload = function() {
        // 取得顯示內容的元素
        var contentElement1 = document.getElementById("content1");
        var contentElement2 = document.getElementById("content2");
        var contentElement3 = document.getElementById("content3");
        var contentElement4 = document.getElementById("content4");
        var editButton = document.getElementById("editButton");
        var saveButton = document.getElementById("saveButton");

        // 監聽編輯按鈕的點擊事件
        editButton.addEventListener("click", function() {
            // 將內容區塊變為可編輯狀態
            contentElement1.contentEditable = true;
            contentElement1.focus();
        });

        editButton.addEventListener("click", function() {
            // 將內容區塊變為可編輯狀態
            contentElement2.contentEditable = true;
            contentElement2.focus();
        });

        editButton.addEventListener("click", function() {
            // 將內容區塊變為可編輯狀態
            contentElement3.contentEditable = true;
            contentElement3.focus();
        });

        editButton.addEventListener("click", function() {
            // 將內容區塊變為可編輯狀態
            contentElement4.contentEditable = true;
            contentElement4.focus();
        });

        // 監聽儲存按鈕的點擊事件
        saveButton.addEventListener("click", function() {
            // 將內容區塊變為不可編輯狀態
            contentElement1.contentEditable = false;
            contentElement2.contentEditable = false;
            contentElement3.contentEditable = false;
            contentElement4.contentEditable = false;

            // 取得修改後的內容
            var modifiedContent1 = contentElement1.innerHTML;
            var modifiedContent2 = contentElement2.innerHTML;
            var modifiedContent3 = contentElement3.innerHTML;
            var modifiedContent4 = contentElement4.innerHTML;

            // 儲存修改後的內容，這裡可以使用適合你的方式，比如將修改後的內容發送到後端伺服器儲存

            // 將修改後的內容存儲到本地存儲或 cookie 中
            localStorage.setItem("content1", modifiedContent1);
            localStorage.setItem("content2", modifiedContent2);
            localStorage.setItem("content3", modifiedContent3);
            localStorage.setItem("content4", modifiedContent4);

            // 顯示儲存成功訊息，你可以根據你的需求自行調整這部分
            alert("儲存成功！");
        });

        // 在頁面載入時從本地存儲或 cookie 中獲取內容並顯示
        contentElement1.innerHTML = localStorage.getItem("content1") || contentElement1.innerHTML;
        contentElement2.innerHTML = localStorage.getItem("content2") || contentElement2.innerHTML;
        contentElement3.innerHTML = localStorage.getItem("content3") || contentElement3.innerHTML;
        contentElement4.innerHTML = localStorage.getItem("content4") || contentElement4.innerHTML;
    };
</script>


<%@ include file="configproducts.jsp" %>
        <%
        String Img = "";
        String Name = "";
        String description = "";
        String price = "";

        if(session.getAttribute("Img") != null) {
            sql = "SELECT * FROM `members` WHERE `Img`='" + session.getAttribute("Img") + "'"; 
            ResultSet rs = con.createStatement().executeQuery(sql);
            
            while(rs.next()) {
                Img = rs.getString("Img");
                Name = rs.getString("Name");
                description = rs.getString("description");
                price = rs.getString("price");
            }
            con.close();
            }
        %>

<div class="main">
    <div class="g_img" value="<%= Img %>">
        <img src="image/d1.jpg" alt="">
    </div>
    <div class="g_intro">
        <div id="content1" value="<%= Name %>"><h1>提拉米蘇大福</h1></div>
        <div id="content2" class="price" value="<%= price %>">NT$45</div>
        <div id="content3" value="<%= description %>"><p>紅豆餡中加入酸酸甜甜的草莓包入大福皮中，大口的咬下，紅豆餡與草莓在口中搭配出巧妙的滋味。</p></div>
        <div id="content4"><p>賞味期限:冷藏5天(18度C以下)</p></div>
        <div>
            <div class="btn_set">
                <button class="btn_cart1" id="saveButton" name="b1" >儲存</button>
                <button  class="btn_cart2" id="editButton" >編輯</button>
            </div>
        </div>
    </div>

    <%@ page import="java.sql.Connection" %>

    <%
    Class.forName("com.mysql.jdbc.Driver");
    String Url = "jdbc:mysql://localhost/?serverTimezone=UTC";
    Connection connection = DriverManager.getConnection(Url, "root", "1234");
    String useDatabaseSql = "USE `yokan`";
    connection.createStatement().execute(useDatabaseSql);
    %>

    


        <div class="g_write">
            <h1>商品評論</h1>
            <form action="">
                <input type="text" name="" placeholder="Name" class="input_font">
                <br>
                <textarea  class="input_font2"  name="" placeholder="COMMENT"></textarea>
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
                <span class="v-name">邱小柔</span>
                <span class="v-star">★★★★★</span><br>
                <div class="v-txt"><p>草莓</p></div>
                <!-- <div>----------------------------------------------------</div> -->
            </div>
            <div class="viewbox">
                <span class="v-name">楊小柔</span>
                <span class="v-star">★★★★★</span><br>
                <div class="v-txt"><p>大福</p></div>
           
                <!-- <div>----------------------------------------------------</div> -->
            </div>
            <div class="viewbox">
                <span class="v-name">李安安</span>
                <span class="v-star">★★★★</span><br>
                <div class="v-txt"><p>好好吃</p></div>
                <!-- <div>----------------------------------------------------</div> -->
            </div>
        </div>
    </div>

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
                   <div class="copy">訪客人數:100人<br>Copyright © 2023 Chinmi  All Rights.</div>
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
</body>
</html>