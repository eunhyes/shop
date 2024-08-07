<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	System.out.println("---------------- LoginForm -----------------");
	// 인증분기	 : 세션변수 이름 - loginCustomer
	if(session.getAttribute("loginCustomer") != null) {
		response.sendRedirect("/shop/customer/customerGoodsList.jsp");
		return;
	}
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
	
		.login-box {
		
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
		}
		
	</style>

</head>

<body class="container" style="background-color: rgba(219, 210, 224, 0.8)">
<div class="row justify-content-center">
	<div class="login-box">
	
		<div class="col mb-4"><a href="/shop/customer/loginForm.jsp">
			<img alt="unicorn-p" src="/shop/img/unicorn-p.png" style="width: 100px; height: 100px; margin-right: 30px;">
			<img alt="unicorn-p" src="/shop/img/unicorn-b.png" style="width: 100px; height: 100px;">
		</a></div>
	
		<form method="post" action="/shop/customer/loginAction.jsp">
			<div class="mb-3">
				<input type="text" class="form-control" name="customerMail" id="customerMail"	placeholder="ID">
			</div>
			<div class="mb-3">
				<input type="password" class="form-control" name="customerPw" id="customerPw"	placeholder="PW">
			</div>
			
			<div class="mb-3">
				<button type="submit" class="button mt-3 btn" style="width: 100%;">login</button>
			</div>
		</form>
		
		<div>
			<a href="/shop/customer/addCustomerForm.jsp" class="btn button" style="width: 100%;">회원가입</a>
		</div>
		
	</div>
	
</div>
</body>
</html>