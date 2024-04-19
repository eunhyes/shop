<%@ page language="java" contentType="text/html;" charset=UTF-8 pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>

<%
	System.out.println("---------------- goodsOne -----------------");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if (session.getAttribute("loginEmp") == null) {
		
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	
	} 
%>
<%
	// DB접근
	Connection conn = DBHelper.getConnection();





%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>

</body>
</html>