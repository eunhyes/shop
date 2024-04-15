<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="shop.dao.*" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
	<!-- bootstrap -->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
	
	<!-- google font -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Gowun+Batang&display=swap" rel="stylesheet">
	
	<style type="text/css">
	
		.a {
			color : black;
			text-decoration: none;
			margin-right: 5px;
		}
	
		.back-box {
			background-color: rgba(255, 255, 255, 0.5);
			border-radius: 10px;
			margin : 300px;
			width: 400px;
			padding: 30px;
			text-align: center;
		}
			
		.button {
			background-color: rgba(210, 190, 222, 1);
			border-color : rgba(210, 190, 222, 1);
			text-align: center;
			color: black;
			text-decoration: none;
		}
	</style>
	
</head>

<body class="container a" style="background-color: rgba(219, 210, 224, 0.8)">
<div class="row">
	<div class="back-box">
	
		<div class="mb-3">가입이 완료되었습니다.</div>
		
		<div>
			<a href="/shop/emp/empLoginForm.jsp" class="btn button mb-3" style="width: 100%;">로그인하기</a>
		</div>
	
	</div>

</div>
</body>
</html>