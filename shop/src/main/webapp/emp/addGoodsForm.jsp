<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>  
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
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	
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
</head>
<body>
<!-- 메인메뉴 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>

	<form method="post" action="/shop/emp/addGoodsAction.jsp">
	
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










</body>
</html>