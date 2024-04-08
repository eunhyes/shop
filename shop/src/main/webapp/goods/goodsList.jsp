<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
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
	//DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	String category = request.getParameter("category");
	if(category == null) { // category가 null일 경우 -> 공백처리
		
		category = "";
	}
	// 디버깅코드
	System.out.println(category + " ========= category");
	 
// 카테고리별 개수 구하기
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
<%
// 페이징

	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
	
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
	}
	
	int rowPerPage = 20;
	int startRow = (currentPage - 1) * rowPerPage;
	int totalRow = 0;
	
	ResultSet rs = null;
	PreparedStatement stmt = null;
	
	// SELECT COUNT(*) FROM goods WHERE category = '슬램덩크';
	String sql = "select count(*) cnt from goods where category like ?";
	
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, "%" + category +"%");
	rs = stmt.executeQuery();
	
	if(rs.next()) {
		
		totalRow = rs.getInt("cnt");
		
	}
	// 디버깅코드
	System.out.println(totalRow + " ======= totalRow");
	
	int lastPage = totalRow / rowPerPage;
	if(totalRow % rowPerPage != 0) {
		
		lastPage = lastPage + 1;
	}
	// 디버깅코드
	System.out.println(lastPage + " ======= lastPage");
	 
	/* 
		null 이면 select * from goods
	   	null이 아니면 select * from goods where category = ? 
	*/
%>
<%
// goodsList HashMap으로 구해서 넣기
	// null이 아니면 select * from goods where category = ? 
	// category = ?, limit ?, ?
	String sql2 = "SELECT goods_no goodsNo, category, emp_id empId, goods_title goodsTitle, goods_price goodsPrice, update_date updateDate FROM goods WHERE category like ? ORDER BY update_date DESC limit ?, ?";
	
	ResultSet rs2 = null;
	PreparedStatement stmt2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, "%"+category+"%");
	stmt2.setInt(2, startRow);
	stmt2.setInt(3, rowPerPage);
	
	rs2 = stmt2.executeQuery();
	// 디버깅코드
	System.out.println(stmt2);
	
	// ArrayList<HashMap> 에 넣기
	ArrayList<HashMap<String, Object>> goodsList = new ArrayList<HashMap<String, Object>>();
	
	while (rs2.next()) {
	
		HashMap<String, Object> g = new HashMap<String, Object>();
	
		g.put("goodsNo", rs2.getInt("goodsNo"));
		g.put("category", rs2.getString("category"));
		g.put("empId", rs2.getString("empId"));
		g.put("goodsTitle", rs2.getString("goodsTitle"));
		g.put("goodsPrice", rs2.getString("goodsPrice"));
		g.put("updateDate", rs2.getString("updateDate"));
	
		goodsList.add(g);
	
	}
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
	
		.back-box {
		
			background-color: rgba(255, 255, 255, 0.5);
		
		}
		
		.goods-box {
		
			display: flex;
			width: 100%;
			flex-wrap: wrap;
		
		}

		.goods-box > div {
			
			width: calc(100%%4);
			height: 200px;
			box-sizing: border-box;
		
		}		
		
		
	</style>
	
</head>
<body class="container" style="background-color: rgba(250, 236, 197, 0.8)">
<div class="row justify-content-center">
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>

	<div>
		<a href="/shop/goods/addGoodsForm.jsp">상품등록</a>
	</div>

	<!-- 서브메뉴 카테고리별 상품 리스트 -->
	<div>
		
		
			<a href="/shop/goods/goodsList.jsp">전체</a>
			<%
				for (HashMap m : categoryList) {
			%>
			<a
				href="/shop/goods/goodsList.jsp?category=<%=(String) (m.get("category"))%>">
				<%=(String) (m.get("category"))%>(<%=(Integer) (m.get("cnt"))%>)
			</a>
	
			<%
				} 
			%>
		
		
	</div>
	
	<!-- 상품 사진 나오도록 -->
	<div>
	
	
	
	
	
	
	
	</div>
	
	
	
	<div>
		<table>
			<tr>
				<th>상품 번호</th>
				<th>카테고리</th>
				<th>판매자</th>
				<th>제목</th>
				<th>가격</th>
				<th>업데이트 날짜</th>
			</tr>

			<%
		
				for (HashMap<String, Object> g : goodsList) {
			%>

				<tr>
					<td><%=(Integer)(g.get("goodsNo"))%></td>
					<td><%=(String)(g.get("category"))%></td>
					<td><%=(String)(g.get("empId"))%></td>
					<td><%=(String)(g.get("goodsTitle"))%></td>
					<td><%=(String)(g.get("goodsPrice"))%></td>
					<td><%=(String)(g.get("updateDate"))%></td>
				</tr>
			<%
				}
			
			%>

		</table>
	</div>
	
	<!-- empList 페이징 -->
	<div>
	
		<ul class="pagination">
			<%
				if(currentPage > 1 && currentPage < lastPage) { 
				// 현재 페이지가 1 ~ lastPage 사이일 경우 -> <<, < , > , >> 모두 활성화
			%>
		
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=1">&laquo;</a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage="<%=currentPage -1 %>><%=currentPage -1 %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage="<%=currentPage %>><%=currentPage %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage="<%=currentPage +1 %>><%=currentPage +1 %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage="<%=lastPage %>>&raquo;</a></li>
				
			<%
				} else if(currentPage == 1) {
				// 현재 페이지가 1 일 경우 ->  << , < 비활성화
			%>
				<li class="page-item disabled"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=1">&laquo;</a></li>
				<li class="page-item disabled"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage="<%=currentPage -1 %>><%=currentPage -1 %></a></li>
				<li class="page-item active"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage="<%=currentPage %>><%=currentPage %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage="<%=currentPage +1 %>><%=currentPage +1 %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage="<%=lastPage %>>&raquo;</a></li>
		
		
			<%
				} else if(currentPage == lastPage) {
				// 현재 페이지가 lastPage 일 경우 ->  > , >> 비활성화
			%>		
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage=1">&laquo;</a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage="<%=currentPage -1 %>><%=currentPage -1 %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage="<%=currentPage %>><%=currentPage %></a></li>
				<li class="page-item disabled"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage="<%=currentPage +1 %>><%=currentPage +1 %></a></li>
				<li class="page-item disabled"><a class="page-link" href="/shop/goods/goodsList.jsp?currentPage="<%=lastPage %>>&raquo;</a></li>
				
					
					
			<%		
				}
			%>
		
		
		</ul>
	
	
	</div>
</div>
</body>
</html>