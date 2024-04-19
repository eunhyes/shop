<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>
<%
	System.out.println("---------------- empLoginAction ---------------");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>
<%

	//DB연결
	Connection conn = DBHelper.getConnection();

	/*
		select emp_id empId, emp_name empName, grade from emp 
		where emp_id =? and emp_pw = password(?)";
		
		실패 /emp/empLoginForm.jsp
		성공 /emp/empList.jsp
	*/
	
	//1. 요청값분석
	String empId = request.getParameter("empId");
	String empPw = request.getParameter("empPw");
	
	System.out.println(empId + " ======== empId");
	System.out.println(empPw + " ======== empPw");
	
	// 2. model 호출
	HashMap<String, Object> loginEmp = EmpDAO.empLogin(empId, empPw);
	
	if(loginEmp == null) {  // 로그인실패
		
		System.out.println("로그인실패");
	
		String errMsg =  URLEncoder.encode("아이디와 비밀번호가 잘못되었습니다","utf-8");		
		response.sendRedirect("/shop/emp/empLoginForm.jsp?errMsg="+errMsg); // 자동으로 로그인페이지로 넘어감
			
	} else { // 로그인성공
		System.out.println("로그인성공");
		session.setAttribute("loginEmp", loginEmp);
		response.sendRedirect("/shop/emp/empList.jsp");
			
	}
		
%>

