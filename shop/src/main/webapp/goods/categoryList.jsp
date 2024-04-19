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
	//DB연결
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