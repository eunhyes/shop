<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	System.out.println("---------------- loginAction ---------------");
	// 인증분기	 : 세션변수 이름 - loginCustomer
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
%>
<%
	// post방식 -> 인코딩
	request.setCharacterEncoding("UTF-8");
	
	// 입력값 받기
	String customerMail = request.getParameter("customerMail");
	String customerPw = request.getParameter("customerPw");
	
	// 로그인 모델 호출 
	HashMap<String, Object> loginCustomer = CustomerDAO.loginCustomer(customerMail, customerPw);

	if(loginCustomer == null)	{
		
		System.out.println("로그인실패");
		String errMsg =  URLEncoder.encode("아이디와 비밀번호가 잘못되었습니다","utf-8");		
		response.sendRedirect("/shop/customer/loginForm.jsp?errMsg="+errMsg); // 자동으로 로그인페이지로 넘어감
	
	} else {
		
		System.out.println("로그인성공");
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		
	}

%>

