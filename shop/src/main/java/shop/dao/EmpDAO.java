package shop.dao;

import java.sql.*;
import java.util.*;
import org.apache.catalina.connector.Response;

// emp 테이블을 CRUD 하는 static 메서드 컨테이너
public class EmpDAO {
	
	// 관리자(emp) 회원가입
	// /shop/emp/addEmpAction.jsp
	// param : String empId, String empPw, String empName, String empJob, String hireDate 
	// return : int(성공 = 1, 실패 = 0)
	public static int insertEmp(String empId, String empPw, String empName, String empJob, String hireDate) throws Exception {
		
		int row = 0;
		// DB접근
		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO emp (emp_id AS empId, emp_pw AS empPw, emp_name AS empName, emp_job AS empJob, hire_date AS hireDate) "
				+ "VALUES(?, SHA2(?, 256), ?, ?, ?);";
		PreparedStatement stmt = null; 	
		ResultSet rs = null;
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, empId);
		stmt.setString(2, empPw);
		stmt.setString(3, empName);
		stmt.setString(4, empJob);
		stmt.setString(5, hireDate);
		
		row = stmt.executeUpdate();
		
		if(row ==1) {//
			
			System.out.println("입력성공");
			
		} else {
			
			System.out.println("입력실패");
			
		}
		
		conn.close();
		return row;
	}
	
	// 관리자(emp) 로그인
	// /shop/emp/empLoginAction.jsp
	// param : String empId, String empPw  (로그인폼에서 사용자가 입력한 id/pw)
	// return : HashMap<String, Object> : null 이면 로그인 실패, 아니면 성공
	// 호출코드 HashMap<String, Object> m = empDAO.empLogin("admin", "1234");
	public static HashMap<String, Object> empLogin(String empId, String empPw) throws Exception {
		
		HashMap<String, Object> resultMap = null;
		
		// DB접근
		Class.forName("org.mariadb.jdbc.Driver");
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT emp_id AS empId, emp_name AS empName, grade FROM emp WHERE emp_id=? AND emp_pw = SHA2(?, 256);";
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
