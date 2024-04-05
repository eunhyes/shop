<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%
	HashMap<String,Object> loginMember = (HashMap<String,Object>)(session.getAttribute("loginEmp"));
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>

	<!-- bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- google font -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
</head>
<body class="container-fluid" style="background-color: rgba(250, 236, 197, 0.8)">
<div class="row justify-content-center">
<header>	
	<nav class="navbar navbar-expand-lg" style="background-color: rgba(255, 255, 255, 0.5); width: 100%;">
		<div style="margin-right: 700px;">
			<ul class="navbar-nav">
				<li class="nav-item">
					<a class="nav-link" href="/shop/emp/empList.jsp">사원관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/shop/goods/categoryList.jsp">카테고리관리</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" href="/shop/goods/goodsList.jsp">상품관리</a>
				</li>
			
			</ul>
		</div>
		
		<div>
			<!-- 개인정보수정 -->
			<span>
				<%=(String)(loginMember.get("empName"))%> 님 반갑습니다 
			</span>
			<a  class="btn btn-outline-warning"  href="/shop/emp/empOne.jsp"> 내정보</a>
			<a  class="btn btn-outline-warning" href="/shop/emp/empLogout.jsp">로그아웃</a>
		</div>
	
	</nav>

</header>
</div>
</body>
</html>