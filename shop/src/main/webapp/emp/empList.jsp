<%@page import="java.util.Locale.Category"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>

<!-- Controller Layer -->
<%
	System.out.println("---------------- empList ---------------");
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
// 페이징
	//DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");

	// 페이징 - totalRow, lastPage 구하기
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 20;
	int startRow = (currentPage -1) * rowPerPage ;
	
	ResultSet rs2 = null;
	PreparedStatement stmt2 = null;
	String sql2 = "select count(*) totalRow from emp";
	
	stmt2 = conn.prepareStatement(sql2);
	rs2 = stmt2.executeQuery();
	
	// 마지막 페이지 = 전체 행 수 / 각 페이지에 보이는 행 수
	int totalRow = 0;
	
	if(rs2.next()) {
		
		totalRow = rs2.getInt("totalRow");
	}
	// 디버깅코드
	System.out.println(totalRow + " ======= totalRow");
	
	int lastPage = totalRow / rowPerPage;
	
	if(totalRow % rowPerPage != 0) {
		
		lastPage = lastPage + 1;
	}
	// 디버깅코드
	System.out.println(lastPage + " ======= lastPage");
	
	
%>
<!-- Model Layer -->
<%
	// 특수한 형태의 데이터(RDBMS:mariadb)
	// -> API 사용(JDBC API)하여 자료구조(ResultSet) 취득
	// -> 일반화된 자료구조(ArrayList<HashMap>)로 변경 -> 모델 취득
	
	ResultSet rs1 = null;
	PreparedStatement stmt1 = null;
	
	String sql1 = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by active asc, hire_date desc limit ?, ?";
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setInt(1, startRow);
	stmt1.setInt(2, rowPerPage);
	
	rs1 = stmt1.executeQuery();
	
	// JDBC API 종속된 자료구조 모델 ResultSet -> 기본 API 자료구조(ArrayList)로 변경
	
	ArrayList<HashMap<String, Object>> empList = new ArrayList<HashMap<String, Object>>();
	
	// ResultSet -> ArrayList<HashMap<String, Object>>
	
	while(rs1.next()) {
		
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("empId", rs1.getString("empId"));
		m.put("empName", rs1.getString("empName"));
		m.put("empJob", rs1.getString("empJob"));
		m.put("hireDate", rs1.getString("hireDate"));
		m.put("active", rs1.getString("active"));
		
		empList.add(m);
	}
	
	// JDBC API 사용 끝 -> DB자원 반납
	rs1.close();
	stmt1.close();
	conn.close();


%>

<!-- View Layer : 모델(ArrayList<HashMap<String, Object>>) 출력-->
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
		
</head>

<body class="container" style="background-color: rgba(219, 210, 224, 0.8)">
<div class="row justify-content-center">
	<!-- empMenu.jsp include(주체 : 서버) vs redirect(주체 : 클라이언트) -->
	<!-- 주체가 서버이기 때문에 /shop부터 시작하지 않음 -->
	<div>
		<jsp:include page="/emp/inc/empMenu.jsp"></jsp:include>
	</div>
	
	<h3>사원 목록</h3>
	
	<table class="table table-hover">
		<tr>
			<th>empId</th>
			<th>empName</th>
			<th>empJob</th>
			<th>hireDate</th>
			<th>active</th>
		</tr>
		<%
			for(HashMap<String, Object> m : empList) {
		%>
			<tr>
				<td><%=(String)(m.get("empId")) %></td>
				<td><%=(String)(m.get("empName")) %></td>
				<td><%=(String)(m.get("empJob")) %></td>
				<td><%=(String)(m.get("hireDate")) %></td>
				<td>
					<%
						HashMap<String, Object> sm = (HashMap<String, Object>)(session.getAttribute("loginEmp"));
						
						if((Integer)(sm.get("grade")) > 0) {
					%>
				
					<a href='modifyEmpActive.jsp?empId=<%=(String)(m.get("empId")) %>&active=<%=(String)(m.get("active")) %>'>			
					<%=(String)(m.get("active")) %></a>	
					
					<%
						}
					%>
				
				</td>
			</tr>
		
		<%		
				
			}
		
		%>
	
	</table>

	<!-- empList 페이징 -->
	<div>
	
		<ul class="pagination">
			<%
				if(currentPage > 1 && currentPage < lastPage) { 
				// 현재 페이지가 1 ~ lastPage 사이일 경우 -> <<, < , > , >> 모두 활성화
			%>
		
				<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=1">&laquo;</a></li>
				<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage -1 %>"><%=currentPage -1 %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage %>"><%=currentPage %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage +1 %>"><%=currentPage +1 %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=lastPage %>">&raquo;</a></li>
				
			<%
				} else if(currentPage == 1) {
				// 현재 페이지가 1 일 경우 ->  << , < 비활성화
			%>
				<li class="page-item disabled"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=1">&laquo;</a></li>
				<li class="page-item disabled"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage -1 %>"><%=currentPage -1 %></a></li>
				<li class="page-item active"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage %>"><%=currentPage %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage +1 %>"><%=currentPage +1 %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=lastPage %>">&raquo;</a></li>
		
		
			<%
				} else if(currentPage == lastPage) {
				// 현재 페이지가 lastPage 일 경우 ->  > , >> 비활성화
			%>		
				<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=1">&laquo;</a></li>
				<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage -1 %>"><%=currentPage -1 %></a></li>
				<li class="page-item"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage %>"><%=currentPage %></a></li>
				<li class="page-item disabled"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=currentPage +1 %>"><%=currentPage +1 %></a></li>
				<li class="page-item disabled"><a class="page-link" href="/shop/emp/empList.jsp?currentPage=<%=lastPage %>">&raquo;</a></li>
				
					
					
			<%		
				}
			%>
		
		
		</ul>
	
	
	</div>




</body>
</html>