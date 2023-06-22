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
    <link rel="stylesheet" href="assets/view.css">
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
        <form action="search.jsp" method="get">
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
        
    </nav>
    <!--頁面內容-->
    <div class="main"> 
<%	if(server.equals(userin)){
	//Step 3: 選擇資料庫   
           
           con.createStatement().execute("USE wakashi");
            //Step 4: 執行 SQL 指令, 若要操作記錄集, 需使用executeQuery, 才能傳回ResultSet	
            sql="SELECT * FROM `confuse`"; //算出共幾筆留言
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
            sql="SELECT * FROM `confuse` ORDER BY `Date` DESC LIMIT ";
            sql+=start_record+",3";

            rs=con.createStatement().executeQuery(sql);
			%>
           
					
        <div class="com">
            <table>
                <tr style="font-size: 45px;">
                    <td >name</td>
                    <td>confuse</td>
                    <td>date</td>
                </tr>
          <%while(rs.next()) {
	
						%>
			<table>			
                <tr>
                    <td><%=rs.getString(2)%></td>
                    <td><%=rs.getString(3)%></td>
                    <td><%=rs.getString(4)%></td>
                </tr>
                
            </table>
            
           <%           
            }
            
            // 结束留言板的 </div> 标签
            %> </div>

            <p style="margin-left:950px; font-size:30px">共<%=total_content%>筆留言</p>
            <p style="margin-left:950px; font-size:30px"><%for(int i=1;i<=page_num;i++) //建立1,2,...頁超連結
                out.print("<a href='view.jsp?page="+i+"'>"+i+"</a>&nbsp;"); //&nbsp;html的空白

            %></p>
           

            <%
            //Step 6: 關閉連線
            con.close();
			%>
        </div>

    



<%

}%>



    </div>
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
</body>
</html>
