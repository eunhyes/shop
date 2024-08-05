<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	System.out.println("---------------- addCustomerAction -----------------");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}

%>
<%
	// post방식 -> 인코딩
	request.setCharacterEncoding("UTF-8");

	// 1. 입력값 받기
	String customerMail = request.getParameter("customerMail");
	String customerPw = request.getParameter("customerPw");
	String customerName = request.getParameter("customerName");
	String customerBirth = request.getParameter("customerBirth");
	String customerGender = request.getParameter("customerGender");
	String updateDate = request.getParameter("updateDate");
	String createDate = request.getParameter("createDate");
	
	System.out.println(customerMail + " ======= customerMail");
	System.out.println(customerPw + " ======= customerPw");
	System.out.println(customerName + " ======= customerName");
	System.out.println(customerBirth + " ======= customerBirth");
	System.out.println(customerGender + " ======= customerGender");
	System.out.println(updateDate + " ======= updateDate");
	System.out.println(createDate + " ======= createDate");
%>
<%
	// 회원가입 모델 호출 
	CustomerDAO.insertCustomer(customerMail, customerPw, customerName, customerBirth, customerGender);
	// 회원가입 성공시 addCustomerForm2 로 이동
	response.sendRedirect("/shop/customer/addCustomerForm2.jsp");
%>
