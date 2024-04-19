<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>    
<%@ page import="shop.dao.*" %>

<%
	String empId = request.getParameter("empId");
	String active = request.getParameter("active");
	
	// 디버깅코드
	System.out.println("----------- modifyEmpAction -------------");
	System.out.println(empId + " ========== empId");
	System.out.println(active + " ========== active");
	
	// DB연결
	Connection conn = DBHelper.getConnection();

	ResultSet rs = null;
	PreparedStatement stmt = null;

	String sql = "update emp set active = ? where emp_id = ?";
	
	stmt = conn.prepareStatement(sql);

	// 디버깅코드
	System.out.println(stmt);
	
	// active 전환
	if(active.equals("ON")) {
		
		stmt.setString(1, "OFF");
		
	} else {
		
		stmt.setString(1, "ON");
	}
	
	stmt.setString(2, empId);
	
	int row = 0;
	row = stmt.executeUpdate();
	
	if(row == 1) {
		
		System.out.println("변경 성공");
	
	} else {
		
		System.out.println("변경 실패");
	}
	
	response.sendRedirect("/shop/emp/empList.jsp");
	
	
	
	
%>