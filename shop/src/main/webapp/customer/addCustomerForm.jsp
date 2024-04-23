<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%

/* 	if(session.getAttribute("loginCustomer") != null) {
		
		response.sendRedirect("/shop/goods/goodslist.jsp");
		return;
		
	} */


%>
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
			margin: 150px;
			border-radius: 10px;
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
<body class="container" style="background-color: rgba(219, 210, 224, 0.8)">
<div class="row justify-content-center">
	<div class="back-box">
 		<form method="post" action="/shop/customer/addCustomerAction.jsp">
 		
 			<div class="mb-3">
 				<input type="email" class="form-control" name="customerMail" id="customerMail" placeholder="이메일">
 			</div>
 			
 			<div class="mb-3">
 				<input type="password" class="form-control" name="customerPw" id="customerPw" placeholder="비밀번호">
 			</div>
 			
 			<div class="mb-3">
 				<input type="text" class="form-control" name="customerName" id="customerName" placeholder="이름">
 			</div>
 		
 			<div class="mb-3">
 				<input type="text" class="form-control" name="customerBirth" id="customerBirth" placeholder="생년월일 8글자">
 			</div>
 		
 			<div class="mb-3 col">
	 			<div>
	 				<label class="form-check-label" for="customerGenderM">남자
	 				<input type="radio" class="form-check-input" name="customerGender" id="customerGenderM" value="남">
	 				</label>

					<label class="form-check-label" for="customerGenderF">여자
	 				<input type="radio" class="form-check-input" name="customerGender" id="customerGenderF" value="여">
	 				</label>
	 			</div>
 			</div>
 			
 			<div class="mb-3">
				<button type="submit" class="button mt-3 btn" style="width: 100%;">완료</button>
			</div>

 		</form>
 		
 		<div class="mb-3"><a class="btn button a" style="width: 100%;" href="/shop/customer/loginForm.jsp">로그인하기</a></div>
 
	</div>


</div>
</body>
</html>