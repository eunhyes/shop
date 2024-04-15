<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	System.out.println("---------------- addEmpAction -----------------");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>
<%
	//post방식 -> 인코딩
	request.setCharacterEncoding("UTF-8");

	// 1. 입력값 받기
	String empId = request.getParameter("empId");
	String grade = request.getParameter("grade");
	String empPw = request.getParameter("empPw");
	String empName = request.getParameter("empName");
	String empJop = request.getParameter("empJop");
	String hireDate = request.getParameter("hireDate");
	String updateDate = request.getParameter("updateDate");
	String createDate = request.getParameter("createDate");
	String active = request.getParameter("active");
	
	System.out.println(empId + " ======= empId");
	System.out.println(grade + " ======= grade");
	System.out.println(empPw + " ======= empPw");
	System.out.println(empName + " ======= empName");
	System.out.println(empJop + " ======= empJop");
	System.out.println(hireDate + " ======= hireDate");
	System.out.println(updateDate + " ======= updateDate");
	System.out.println(createDate + " ======= createDate");
	System.out.println(active + " ======= active");
	
%>
<%
	// 2. model 호출
	EmpDAO.insertEmp(empId, empPw, empName, empJop, hireDate);
	
	response.sendRedirect("/shop/emp/addEmpForm2.jsp");
%>
