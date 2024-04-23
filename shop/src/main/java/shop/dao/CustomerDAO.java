package shop.dao;

import java.sql.*;
import java.util.*;

public class CustomerDAO {

	// 디버깅용 메인 메서드
	public static void main(String[] args) throws Exception {
		// 메일 체크 메서드 디버깅
		//System.out.println(CustomerDAO.checkMail("a@goodee.com")); // false
		 
		//System.out.println(CustomerDAO.insertCustomer(
		//		e@goodee.com","1234","zzz","1999/09/09","여")); // 1
		
		// System.out.println(CustomerDAO.login("a@goodee.com", "1234")); // 성공...
		//System.out.println(CustomerDAO.deleteCustomer("a@goodee.com", "1234")); 
	}
	
	// 회원탈퇴
	// 호출 : dropCustomerAction.jsp
	// param : String(세션안의 mail), String(pw)
	// return : int(1이면 탈퇴, 0이면 탈퇴실패)
	public static int deleteCustomer(String mail, String pw) throws Exception {
		
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		String sql = "delete from customer"
				+ " where mail = ? and pw = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		row = stmt.executeUpdate();
		
		if(row == 1) {
			
			System.out.println("수정성공");
			
		} else {
			
			System.out.println("수정실패");
			
		}
		
		conn.close();
		return row;
	}
	
	// 비밀번호 수정
	// 호출 : editPwAction.jsp
	// param : String(c_mail), String(원래 pw), String(수정할 pw)
	// return : int(1성공, 0실패)
	public static int updatePw(String mail, String oldPw, String newPw) throws Exception {
		
		int row = 0;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "UPDATE customer"
				+ " SET c_pw = ?"
				+ " where mail = ? and pw = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, newPw);
		stmt.setString(2, mail);
		stmt.setString(3, oldPw);
		
		row = stmt.executeUpdate();
		
		if(row == 1) {
			
			System.out.println("수정성공");
			
		} else {
			
			System.out.println("수정실패");
			
		}
		
		conn.close();
		return row;
	}
	
	// 회원가입시 mail 중복확인
	// 호출 : checkMailAction.jsp
	// param : String(메일문자열)
	// return : boolean(사용가능하면 true, 불가면 false)
	public static boolean checkMail(String mail) throws Exception {
		boolean result = false;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "select mail"
				+ " from customer"
				+ " where mail = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		
		stmt.setString(1, mail);
		
		ResultSet rs = stmt.executeQuery();
		
		if(!rs.next()) { // 사용불가
			result = true;
		}		
		conn.close();
		
		return result;
	}
	
	
	// 회원 로그인 메서드
	// 호출 : loginAction.jsp
	// param : String(mail), String(pw)
	// return : HashMap(메일, 이름)
	public static HashMap<String, String> login(String mail, String pw) throws Exception {
		HashMap<String, String> map = null;
		
		Connection conn = DBHelper.getConnection();
		
		String sql = "select mail, name"
				+ " from customer"
				+ " where mail = ? and pw = ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, mail);
		stmt.setString(2, pw);
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next()) {
			
			map = new HashMap<String, String>();
			map.put("mail", rs.getString("mail"));
			map.put("name", rs.getString("name"));
		}
		
		conn.close();
		return map;
	}
	//TODO : 위 메서드들 Action페이지에서 정리 및 추가 
	
	// customer 회원가입
	// /shop/customer/addCustomerAction.jsp
	// param : String customerMail, String customerPw, String customerName, String customerBirth, String customerGender
	// return : int(성공 = 1, 실패 = 0)
	public static int insertCustomer(String customerMail, String customerPw, String customerName, String customerBirth, String customerGender) throws Exception {
		int row = 0;
		// DB접근
		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO customer (c_mail, c_pw, c_name, c_birth, c_gender)"
				+ "VALUES(?, SHA2(?, 256), ?, ?, ?)";
		PreparedStatement stmt = null; 	
		ResultSet rs = null;
		stmt=conn.prepareStatement(sql);
		stmt.setString(1, customerMail);
		stmt.setString(2, customerPw);
		stmt.setString(3, customerName);
		stmt.setString(4, customerBirth);
		stmt.setString(5, customerGender);

		row = stmt.executeUpdate();
		
		if(row == 1) {
			
			System.out.println("입력성공");
			
		} else {
			
			System.out.println("입력실패");
			
		}
		
		conn.close();
		return row;
	}
	
	

}
