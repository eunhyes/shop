<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="shop.dao.*" %>

<%
	System.out.println("---------------- goodsOne -----------------");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if (session.getAttribute("loginEmp") == null) {
		
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	
	} 
%>
<%

	//DB연결
	Connection conn = DBHelper.getConnection();

	String category = request.getParameter("category");
	if(category == null) { // category가 null일 경우 -> 공백처리
		
		category = "";
	}
	// 디버깅코드
	System.out.println(category + " ========= category");
	
	String sql = "SELECT goods_no goodsNo, category, emp_id empId, goods_title goodsTitle, filename, goods_price goodsPrice, goods_amount goodsAmount, update_date updateDate FROM goods WHERE category like ?";
	PreparedStatement stmt = null;
	ResultSet rs = null;
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, "%"+category+"%");
	
	rs = stmt.executeQuery();
	System.out.println(stmt);
	
	// ArrayList<HashMap> 에 넣기
		ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
		
		while (rs.next()) {
		
			HashMap<String, Object> g = new HashMap<String, Object>();
		
			g.put("goodsNo", rs.getInt("goodsNo"));
			g.put("category", rs.getString("category"));
			g.put("empId", rs.getString("empId"));
			g.put("goodsTitle", rs.getString("goodsTitle"));
			g.put("filename", rs.getString("filename"));
			g.put("goodsPrice", rs.getInt("goodsPrice"));
			g.put("goodsAmount", rs.getInt("goodsAmount"));
			g.put("updateDate", rs.getString("updateDate"));
		
			goodsList.add(g);
		
		}
	
	
	
%>

<%
//카테고리별 개수 구하기
	ResultSet rs1 = null;
	PreparedStatement stmt1 = null;
	// goods의 개수가 없는 category는 출력 X, category별 상품 개수
	String sql1 = "select category, count(*) cnt from goods group by category order by category asc";
	stmt1 = conn.prepareStatement(sql1);
	
	rs1 = stmt1.executeQuery();
	
	ArrayList<HashMap<String, Object>> categoryList = new ArrayList<HashMap<String, Object>>();
	
	while (rs1.next()) {
	
		HashMap<String, Object> m = new HashMap<String, Object>();
	
		m.put("category", rs1.getString("category"));
		m.put("cnt", rs1.getInt("cnt"));
		categoryList.add(m);
	
	}
	// 디버깅코드
	System.out.println(categoryList + " ========== categoryList");

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
	
	<style type="text/css">
	
		.a {
			color : black;
			text-decoration: none;
			margin-right: 5px;
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
<div class="back-box row justify-content-center">
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

	<%
	%>

	<div class="mb-3">
		<div>상품 번호</div>
		<div>상품 사진</div>
		<div>판매자ID</div>
		<div>제목</div>
		<div>내용</div>
		<div>가격</div>
		<div>수량</div>
		<div>등록 날짜</div>
	
	
	</div>


</div>
</body>
</html>