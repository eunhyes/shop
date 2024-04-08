<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>

<%
	System.out.println("---------------- loginAction ---------------");
	// 인증분기	 : 세션변수 이름 - loginCustomer
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>
<%
/*
	select customer_no customerNo, customer_mail customerMail, customer_name customerName from customer 
	where customer_mail =? and customer_pw = password(?);
	
	실패 /customer/loginForm.jsp
	성공 /goods/goodsList.jsp
*/

	//DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");

	// 입력값 받기
	String customerMail = request.getParameter("customerMail");
	String customerPw = request.getParameter("customerPw");
	
	String sql = "select customer_no customerNo, customer_mail customerMail, customer_name customerName from customer where customer_mail =? and customer_pw = password(?)"; 
	PreparedStatement stmt = null;
	ResultSet rs = null;
	stmt = conn.prepareStatement(sql);
	stmt.setString(1, customerMail);
	stmt.setString(2, customerPw);
	rs = stmt.executeQuery();
	// 디버깅코드
	System.out.println(customerMail + " ======== customerMail");
	System.out.println(customerPw + " ======== customerPw");
	System.out.println(stmt);
	
	if(rs.next()) {  // 로그인성공 (select문 결과값이 있을때)
			
		System.out.println("로그인성공");			
		// 세션 변수 안에 여러개의 값을 저장하기 위해서 HashMap타입을 사용
		HashMap<String, Object> loginCustomer = new HashMap<String, Object>();
		loginCustomer.put("customerNo", rs.getInt("customerNo"));
		loginCustomer.put("customerMail", rs.getString("customerMail"));
		loginCustomer.put("customerName", rs.getString("customerName"));
		
		session.setAttribute("loginCustomer", loginCustomer);
		// 디버깅
		HashMap<String, Object> m = (HashMap<String, Object>)(session.getAttribute("loginCustomer"));
		
		System.out.println((Integer)(m.get("customerNo"))); // 로그인 된 customerNo
		System.out.println((String)(m.get("customerMail"))); // 로그인 된 customerMail
		System.out.println((String)(m.get("customerName"))); // 로그인 된 customerName
		
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
				
	} else { // 로그인실패
			
		System.out.println("로그인실패");
	
		String errMsg =  URLEncoder.encode("아이디와 비밀번호가 잘못되었습니다","utf-8");		
		response.sendRedirect("/shop/customer/loginForm.jsp?errMsg="+errMsg); // 자동으로 로그인페이지로 넘어감
	}
	
	//자원반납
	rs.close();
	stmt.close();
	conn.close();
	
	

%>

