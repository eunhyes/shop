<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*"%>

<!-- Controller Layer -->
<%
	// 인증분기	 : 세션변수 이름 - loginEmp
	if(session.getAttribute("loginEmp") == null) {
		response.sendRedirect("/shop/emp/empLoginForm.jsp");
		return;
	}
%>
<%
	// request 분석
	int currentPage = 1;
	if(request.getParameter("currentPage") != null) {
		
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	
	int rowPerPage = 10;
	int startRow = (currentPage -1) * rowPerPage ;
%>

<!-- Model Layer -->
<%
	// 특수한 형태의 데이터(RDBMS:mariadb)
	// -> API 사용(JDBC API)하여 자료구조(ResultSet) 취득
	// -> 일반화된 자료구조(ArrayList<HashMap>)로 변경 -> 모델 취득
	
	//DB연결
	Class.forName("org.mariadb.jdbc.Driver");
	Connection conn = null;
	conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", "root", "java1234");
	ResultSet rs1 = null;
	PreparedStatement stmt1 = null;
	
	String sql1 = "select emp_id empId, emp_name empName, emp_job empJob, hire_date hireDate, active from emp order by active asc, hire_date desc limit ?, ?";
	stmt1 = conn.prepareStatement(sql1);
	stmt1.setInt(1, startRow);
	stmt1.setInt(2, rowPerPage);
	
	rs1 = stmt1.executeQuery();
	
	// JDBC API 종속된 자료구조 모델 ResultSet -> 기본 API 자료구조(ArrayList)로 변경
	
	ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
	
	// ResultSet -> ArrayList<HashMap<String, Object>>
	
	while(rs1.next()) {
		
		HashMap<String, Object> m = new HashMap<String, Object>();
		m.put("empId", rs1.getString("empId"));
		m.put("empName", rs1.getString("empName"));
		m.put("empJob", rs1.getString("empJob"));
		m.put("hireDate", rs1.getString("hireDate"));
		m.put("active", rs1.getString("active"));
		
		list.add(m);
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
</head>
<body>
	<div><a href="/shop/emp/empLogout.jsp">로그아웃</a></div>
	<h3>사원 목록</h3>
	<table border="1">
		<tr>
			<th>empId</th>
			<th>empName</th>
			<th>empJob</th>
			<th>hireDate</th>
			<th>active</th>
		</tr>
		<%
			for(HashMap<String, Object> m : list) {
				
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


</body>
</html>