<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>  
<%@ page import="shop.dao.*" %>
<!-- Controller Layer -->
<%
	System.out.println("------------------ addGoodsForm -----------------");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>   
<!-- Model Layer -->
<%
	//DB연결
	Connection conn = DBHelper.getConnection();
	ResultSet rs1 = null;
	PreparedStatement stmt1 = null;
	// goods의 개수가 없는 category는 출력 X, category별 상품 개수
	String sql1 = "select category from category";
	stmt1 = conn.prepareStatement(sql1);
	
	rs1 = stmt1.executeQuery();
	
	ArrayList<String> categoryList = new ArrayList<String>();
	
	while(rs1.next()){
		
		categoryList.add(rs1.getString("category"));
		
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

</head>

<body class="container" style="background-color: rgba(219, 210, 224, 0.8)">
<div class="row justify-content-center">
<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>

	<form action="/shop/goods/addGoodsAction.jsp" method="post" enctype="multipart/form-data">
	
		<div>
			category :
			<select name="category">
			
				<option value="">선택</option>
				<%
					for(String c : categoryList) {
				%>		
					<option value="<%= c %>"><%= c %></option>	
				<%		
					}
				%>
			
			</select>
		</div>
	
	<!-- emp_id 값은 action페이지 세션 변수에서 바인딩 -->
		<div>
			goodsTitle :
			<input type="text" name="goodsTitle">
		</div>
		
		<div>
			goodsImage :
			<input type="file" name="goodsImg">
		</div>
		
		<div>
			goodsPrice :
			<input type="number" name="goodsPrice">
		</div>
		
		<div>
			goodsAmount :
			<input type="number" name="goodsAmount">
		</div>
		
		<div>
			goodContent :
			<textarea rows="5" cols="50" name="goodsContent"></textarea>
		</div>
	
		<div>
			<button type="submit">등록</button>
		</div>
	
	</form>
	
</div>
</body>
</html>