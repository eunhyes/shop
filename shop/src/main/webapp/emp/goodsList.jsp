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
<%
// 페이징

	//DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
	int currentPage = 1;
	if (request.getParameter("currentPage") != null) {
	
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	
	}
	
	int rowPerPage = 20;
	int startRow = (currentPage - 1) * rowPerPage;
	int totalRow = 0;
	
	ResultSet pageRs = null;
	PreparedStatement pageStmt = null;
	
	// SELECT COUNT(*) FROM goods WHERE category = '슬램덩크';
	String pageSql = "select count(*) from goods where category = ?";
	
	pageStmt = conn.prepareStatement(pageSql);
	pageRs = pageStmt.executeQuery();
	
	if(pageRs.next()) {
		
		totalRow = pageRs.getInt("totalRow");
		
	}
	// 디버깅코드
	System.out.println(totalRow + " ======= totalRow");
	
	int lastPage = totalRow / rowPerPage;
	
	if(totalRow % rowPerPage != 0) {
		
		lastPage = lastPage + 1;
	}
	// 디버깅코드
	System.out.println(lastPage + " ======= lastPage");
	
	String category = request.getParameter("category");
	// 디버깅코드
	System.out.println(category + " ========= category");
	
	/* 
		null 이면 select * from goods
	   	null이 아니면 select * from goods where category = ? 
	*/
%>
<!-- Model Layer -->
<%
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
// goodsList HashMap으로 구해서 넣기
	// null이 아니면 select * from goods where category = ? 
	// category = ?, limit ?, ?
	String sql2 = "SELECT goods_no goodsNo, category, emp_id empId, goods_title goodsTitle, goods_price goodsPrice, update_date updateDate FROM goods WHERE category = ? ORDER BY update_date DESC limit ?, ?";
	
	ResultSet rs2 = null;
	PreparedStatement stmt2 = null;
	stmt2 = conn.prepareStatement(sql2);
	stmt2.setString(1, category);
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
<%
	// null 이면 select * from goods
	// limit ?, ?
	String sql3 = "SELECT goods_no goodsNo, category, emp_id empId, goods_title goodsTitle, goods_price goodsPrice, update_date updateDate FROM goods ORDER BY update_date DESC limit ?, ?";
	
	ResultSet rs3 = null;
	PreparedStatement stmt3 = null;
	stmt3 = conn.prepareStatement(sql3);
	stmt3.setInt(1, startRow);
	stmt3.setInt(2, rowPerPage);
	
	rs3 = stmt3.executeQuery();
	// 디버깅코드
	System.out.println(stmt3);
	
	// ArrayList<HashMap> 에 넣기
	ArrayList<HashMap<String, Object>> totalList = new ArrayList<HashMap<String, Object>>();
	
	while (rs3.next()) {
	
		HashMap<String, Object> t = new HashMap<String, Object>();
	
		t.put("goodsNo", rs3.getInt("goodsNo"));
		t.put("category", rs3.getString("category"));
		t.put("empId", rs3.getString("empId"));
		t.put("goodsTitle", rs3.getString("goodsTitle"));
		t.put("goodsPrice", rs3.getString("goodsPrice"));
		t.put("updateDate", rs3.getString("updateDate"));
	
		totalList.add(t);
	
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
</head>
<body class="container">
<div class="row">
	<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>

	<div>
		<a href="/shop/emp/addGoodsForm.jsp">상품등록</a>
	</div>

	<!-- 서브메뉴 카테고리별 상품 리스트 -->
	<div>
		<a href="/shop/emp/goodsList.jsp">전체</a>
		<%
			for (HashMap m : categoryList) {
		%>
		<a
			href="/shop/emp/goodsList.jsp?category=<%=(String) (m.get("category"))%>">
			<%=(String) (m.get("category"))%>(<%=(Integer) (m.get("cnt"))%>)
		</a>

		<%
			}
		%>
	</div>
	<div>
		<table border="1">
			<tr>
				<th>goodsNo</th>
				<th>category</th>
				<th>empId</th>
				<th>goodsTitle</th>
				<th>goodsPrice</th>
				<th>updateDate</th>
			</tr>

			<%
			if (category == null) {

				for (HashMap<String, Object> t : totalList) {
			%>
				<tr>
					<td><%=(Integer)(t.get("goodsNo"))%></td>
					<td><%=(String)(t.get("category"))%></td>
					<td><%=(String)(t.get("empId"))%></td>
					<td><%=(String)(t.get("goodsTitle"))%></td>
					<td><%=(String)(t.get("goodsPrice"))%></td>
					<td><%=(String)(t.get("updateDate"))%></td>
				</tr>

			<%
				}

			} else {

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

			}
			%>

		</table>
	</div>
</div>
</body>
</html>