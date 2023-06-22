<%@ page import = "java.sql.*"%>
<%@ page language="java" contentType="text/html" pageEncoding="UTF-8"%>
<%@include file="config.jsp" %>
<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<title>關於我們</title>
		<link rel="stylesheet" href="assets/aboutus.css">
		<link rel="stylesheet" href="assets/nav.css">
		<link href="https://fonts.googleapis.com/css2?family=Shippori+Mincho&display=swap" rel="stylesheet">
		<link rel="icon" href="../image/logo.ico" type="image/x-icon" />
	</head>
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
<%						Object userin = session.getAttribute("id");
						String server="32127@tm";
						if(server.equals(userin)){
						out.print("<a href='AddP.jsp' >新增商品</a>");
						}
%>
					</div>
				</div>
			</li>
<%
		if (userin != null) {
			out.print("<li><a href='member.jsp'>會員資料</a></li>");
		} else {
			out.print("<div class='login'><a href='login.jsp'>[登入]</a></div>");
		}

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


	<h1>----前端水水們----</h1>
	<section class="right">
		<div class="bg1">
			<div class="slide-left">
				<img src="image/bg.png" alt="">
			</div>
		</div>

		<div class="c1">
		這次做前端我覺得蠻好玩的，<br>雖然我們圖片選了很久，<br>選到我近半年都不想再看到和菓子了，<br>但我還是很想吃草莓大福(｡･ω･｡)ﾉ
		</div>


		<div class="img1">
			<div class="name1"><img src="image/1.png" alt="" width="320px" height="300px"></div>
		</div>
	</section>

	<div class="clear"></div>

	<div class="fade">
		<section class="left">
			<div class="bg2">
				<div class="slide-right"><img src="image/bg2.png" alt=""></div>
			</div>

			<div class="c2">
				這次輪到我們做前端網頁了，<br>
				前端做起來感覺比後端有趣多了，<br>
				大家一起努力製做出漂亮的網頁!    <br>
				我覺得很讚 ฅ՞•ﻌ•՞ฅ 瑪咖八咖
			</div>

			<div class="img2">
				<div class="name2">
					<img src="image/2.png" alt="" width="500px" height="350px">
				</div>
			</div>
		</section>
	</div>

	<div class="clear"></div>


	<div class="fade">
		<section class="right">
			<div class="bg3">
				<div class="slide-left"><img src="image/bg3.png" alt=""></div>
			</div>

			<div class="c3">
				雖然做前端需要用到邏輯的不多，<br>但對我來說把頁面用美比動腦更難，<br>但做完很有成就感。
			</div>

			<div class="img3">
				<div class="name3">
					<img src="image/3.png" alt="" width="340px" height="320px">
				</div>
			</div>
		</section>
	</div>

	<div class="clear"></div>
	<h1 class="bm">----後端水水們----</h1>
	<section class="right">
		<div class="bg4">
		<div class="slide-left">
			<img src="image/bg.png" alt=""></div>
		</div>

		<div class="c4">
			後端做到身心俱疲◡ ヽ(`Д´)ﾉ ┻━┻<br>
			跑不出來的瞬間火就跑出來了，<br>
			不過這是一個操練自己程式能力的過程。<br>很感謝組員都會一起討論，非常考驗耐心及細心。
		</div>


		<div class="img4">
			<div class="name4">
				<img src="image/4.png" alt="" width="280px" height="280px">
			</div>
		</div>
	</section>

	<div class="clear"></div>

	<div class="fade">
		<section class="left">
			<div class="bg5">
				<div class="slide-right">
					<img src="image/bg2.png" alt="">
				</div>
			</div>

			<div class="c5">
				這學期輪到我們做後端，<br>我覺得比前端還要更複雜一些，<br>還要看到一大堆的error (  -᷄ ˍ-᷅)。<br>
				希望可以好好合作，<br>也能順利完成一個漂亮的網頁！
			</div>

			<div class="img5">
				<div class="name5">
					<img src="image/5.png" alt="" width="320px" height="390px">
				</div>
			</div>
		</section>
	</div>

	<div class="clear"></div>


	<div class="fade">
		<section class="right">
			<div class="bg6">
				<div class="slide-left">
					<img src="image/bg3.png" alt="">
				</div>
			</div>

			<div class="c6">
				我覺得jsp做起來很複雜，<br>看到505、404就讓我很崩潰..！<br>但很感謝組員的協助~！

			</div>

			<div class="img6">
				<div class="name6">
					<img src="image/6.png" alt="" width="280px" height="280px">
				</div>
			</div>
		</section>
	</div>

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
				<div class="time">
					TEL:03-265-9999<br>
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


	</body>
</html>
