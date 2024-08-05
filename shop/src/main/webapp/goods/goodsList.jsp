<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>

<!-- Controller Layer -->
<%
	System.out.println("---------------- goodsList -----------------");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if (session.getAttribute("loginEmp") == null) {
		
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	
	} 
%>

<!-- Model Layer -->
<%
//카테고리별 개수 구하기 
	String category = request.getParameter("category");
	if(category == null) { // category가 null일 경우 -> 공백처리
		
		category = "";
	}
	// 디버깅코드
	System.out.println(category + " ========= category");
	 
	int cnt = 0;

	// category 리스트 + 상품 개수 출력 모델 호출 
	ArrayList<HashMap<String, Object>> categoryList = GoodsDAO.categoryList(category, cnt);
	
%>
<%
	// 상품 목록 페이징 
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
	
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
	}
	
	int rowPerPage = 20;
	int totalRow = 0;
	int lastPage = 0;
	int startRow = (currentPage - 1) * rowPerPage;

	// goodList 페이징 모델 호출
	ArrayList<HashMap<String, Object>> listPaging = GoodsDAO.listPaging(category, totalRow, rowPerPage, lastPage);

%>
<%
	// goodsList 출력 모델 호출
	ArrayList<HashMap<String, Object>> goodsList = GoodsDAO.selectGoodsList(category, startRow, rowPerPage);

%>


<!-- View Layer -->
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
	
	<style type="text/css">
	
		.a {
			color : black;
			text-decoration: none;
		}
	
	
		.back-box {
			background-color: rgba(255, 255, 255, 0.5);
		}
		
		.goods {
			display: flex;
			width: 25%;
			flex-wrap: wrap;
		
		}

		.goods > div {
			width: calc(100%/4);
			height: 400px;
			box-sizing: border-box;
			text-align: center;
		}
		
		.page-link {
			color: #000; 
			background-color: #fff;
			border: 1px solid #ccc; 
		}
		
		.page-item.active .page-link {
			z-index: 1;
			color: #555;
			font-weight:bold;
			background-color: #f1f1f1;
			border-color: #ccc;
		}
		
		
	 	.page-link:focus, .page-link:hover {
			color: #000;
			background-color: #fafafa; 
			border-color: #ccc;
		} 
		
		.button {
			background-color: rgba(210, 190, 222, 1);
			border-color : rgba(210, 190, 222, 1);
			text-align: center;
			color: black;
			text-decoration: none;
		}
		
	</style>
	
</head>
<body class="container" style="background-color: rgba(219, 210, 224, 0.8)">
<div class="back-box row">
<!-- 메인메뉴 -->
	<div class="mb-2">
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>

<!-- 서브메뉴 카테고리별 상품 리스트 -->
	<div class="mb-3">
		<a class="a" href="/shop/goods/goodsList.jsp">전체</a>
		<%
			for (HashMap m : categoryList) {
		%>
		<a class="a" href="/shop/goods/goodsList.jsp?category=<%=(String) (m.get("category"))%>">
			<%=(String) (m.get("category"))%>(<%=(Integer) (m.get("cnt"))%>)
		</a>
	
		<%
			} 
		%>
		
		<div class="btn button">
			<a class="button" href="/shop/goods/addGoodsForm.jsp" >상품등록</a>
		</div>
		
	</div>
	
<!-- 상품 정보 -->
	<div class="goods mb-5">
	
		<%
			for (HashMap<String, Object> g : goodsList) {
		%>
		<div><a class="a" href="/shop/goods/goodsOne.jsp?goodsNo=<%=(Integer) (g.get("goodsNo")) %>">
			
			<div style="">
				<img alt="" src="/shop/upload/<%=(String) (g.get("filename"))%>" style="width: 200px; height: 200px;">
			</div>
			<div>
				<%=(Integer) (g.get("goodsNo"))%>
			</div>
			<div>
				<%=(String) (g.get("category"))%>
			</div>
			<div>
				<%=(String) (g.get("goodsTitle"))%>
			</div>
			<div>
				<%=(Integer) (g.get("goodsPrice"))%>
			</div>
			
		</div>
		
		<%
				}
			
		%>
		
	</a></div>
	
<!-- goodsList 페이징 -->
	<div>
	
		<ul class="pagination">
			<%
				if(currentPage > 1 && currentPage < lastPage) { 
				// 현재 페이지가 1 ~ lastPage 사이일 경우 -> <<, < , > , >> 모두 활성화
			%>
		
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=1&category=<%=category %>">&laquo;</a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=currentPage -1 %>&category=<%=category %>"><%=currentPage -1 %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=currentPage %>&category=<%=category %>"><%=currentPage %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=currentPage +1 %>&category=<%=category %>"><%=currentPage +1 %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category %>">&raquo;</a></li>
			<%
				} else if(currentPage == 1) {
				// 현재 페이지가 1 일 경우 ->  << , < 비활성화
			%>
				<li class="page-item disabled"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=1&category=<%=category %>">&laquo;</a></li>
				<li class="page-item disabled"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=currentPage -1 %>&category=<%=category %>"><%=currentPage -1 %></a></li>
				<li class="page-item active"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=currentPage %>&category=<%=category %>"><%=currentPage %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=currentPage +1 %>&category=<%=category %>"><%=currentPage +1 %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category %>">&raquo;</a></li>
		
			<%
				} else if(currentPage == lastPage) {
				// 현재 페이지가 lastPage 일 경우 ->  > , >> 비활성화
			%>		
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=1&category=<%=category %>">&laquo;</a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=currentPage -1 %>&category=<%=category %>"><%=currentPage -1 %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=currentPage %>&category=<%=category %>"><%=currentPage %></a></li>
				<li class="page-item disabled"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=currentPage +1 %>&category=<%=category %>"><%=currentPage +1 %></a></li>
				<li class="page-item disabled"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=<%=lastPage %>&category=<%=category %>">&raquo;</a></li>
				
			<%		
				}
			%>
		
		</ul>
	
	</div>
</div>
</body>
</html>