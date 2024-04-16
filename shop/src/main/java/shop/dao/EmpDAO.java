package shop.dao;

import java.sql.*;
import java.util.HashMap;

import org.apache.catalina.connector.Response;

// emp 테이블을 CRUD 하는 static 메서드 컨테이너
public class EmpDAO {
	// emp 회원가입
	public static int insertEmp(String empId, String empPw, String empName, String empJop, String hireDate) throws Exception {
		int row = 0;
		// DB접근
		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO emp (emp_id, emp_pw, emp_name, emp_job, hire_date) VALUES(?, password(?), ?, ?, ?);";
		PreparedStatement stmt = null; 	
		ResultSet rs = null;
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		stmt.setString(3, empName);
		stmt.setString(4, empJop);
		stmt.setString(5, hireDate);
		
		row = stmt.executeUpdate();
		
		if(row ==1) {
			
			System.out.println("입력성공");
			
		} else {
			
			System.out.println("입력실패");
			
		}
		
		conn.close();
		return row;
	}
	
	// emp 로그인
	// HashMap<Strign, Object> : null 이면 로그인 실패, 아니면 성공
	// String empId, String empPw : 로그인폼에서 사용자가 입력한 id/pw
	
	// 호출코드 HashMap<Strign, Object> m = empDAO.empLogin("admin", "1234");
	public static HashMap<String, Object> empLogin(String empId, String empPw) throws Exception {
		HashMap<String, Object> resultMap = null;
		
		// DB접근
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop","root","java1234");

		String sql = "select emp_id empId, emp_name empName, grade from emp where emp_id =? and emp_pw = password(?)";
		PreparedStatement stmt = null; 	
		ResultSet rs = null;
		stmt=conn.prepareStatement(sql);
		stmt.setString(1,empId);
		stmt.setString(2,empPw);
		rs = stmt.executeQuery();
		
		if(rs.next()) {
			
			resultMap = new HashMap<String, Object>();
			resultMap.put("empId", rs.getString("empId"));
			resultMap.put("empName", rs.getString("empName"));
			resultMap.put("grade", rs.getInt("grade"));
			
		}
		
		conn.close();
		return resultMap;
		
	}
}
