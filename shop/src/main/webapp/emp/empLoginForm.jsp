<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") != null) {
		response.sendRedirect("/shop/emp/empList.jsp");
		return;
	}
%>
    
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title></title>
</head>
<body>
<div>
	<form action="/shop/emp/empLoginAction.jsp">
		<div>
			<input type="text" name="empId" id="empId"	placeholder="ID">
		</div>
		<div>
			<input type="password" name="empPw" id="empPw"	placeholder="PW">
		</div>
		
		<div>
			<button type="submit" >login</button>
		</div>
	</form>



</div>


</body>
</html>