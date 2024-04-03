<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>  
<!-- Controller Layer -->
<%
	System.out.println("------------------ addGoodsAction -----------------");
	request.setCharacterEncoding("UTF-8");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>   
<!-- Session 설정값 : 입력시 로그인 emp의 emp_id값 필요 -->
<%
	HashMap<String, Object> loginMember = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
	// 여기다시확인
	String empId = (String)(loginMember.get("empId"));
	System.out.println(empId + " ======== empId");

%>

<!-- Model Layer -->
<%
	// 입력값 받기
	String category = request.getParameter("category");
	String goodsTitle = request.getParameter("goodsTitle");
	String goodsPrice = request.getParameter("goodsPrice");
	String goodsAmount = request.getParameter("goodsAmount");
	String goodsContent = request.getParameter("goodsContent");
	// 디버깅 코드
	System.out.println(category + " ======== category");
	System.out.println(goodsTitle + " ======== goodsTitle");
	System.out.println(goodsPrice + " ======== goodsPrice");
	System.out.println(goodsAmount + " ======== goodsAmount");
	System.out.println(goodsContent + " ======== goodsContent");

%>
<!-- Controller Layer -->
<%
	// DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	ResultSet rs1 = null;
	PreparedStatement stmt1 = null;
	
/* 
	INSERT INTO goods(category, emp_id, goods_title, goods_price, goods_amount, goods_content, update_date)
	VALUES('나루토', 'admin', 'hihi','41212', '100', 'gg', NOW());
 */
 	// ? = category, emp_id, goods_title, goods_price, goods_amount, goods_content
	String sql = "INSERT INTO goods(category, emp_id, goods_title, goods_price, goods_amount, goods_content, update_date) VALUES(?, ?, ?, ?, ?, ?, NOW());";

	stmt1 = conn.prepareStatement(sql);
	stmt1.setString(1, category);
	stmt1.setString(2, empId);
	stmt1.setString(3, goodsTitle);
	stmt1.setString(4, goodsPrice);
	stmt1.setString(5, goodsAmount);
	stmt1.setString(6, goodsContent);
	
	System.out.println(stmt1);
	
	int row = stmt1.executeUpdate();
	
	if(row == 1) {
		
		System.out.println("등록 성공");
		response.sendRedirect("/shop/emp/goodsList.jsp");
		
	} else {
		
		System.out.println("등록 실패");
		response.sendRedirect("/shop/emp/addGoodsForm.jsp");
	}

%>

