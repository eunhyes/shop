package shop.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class CustomerDAO {

	// customer 회원가입
	public static int insertCustomer(String customerMail, String customerPw, String customerName, String customerBirth, String customerGender) throws Exception {
		int row = 0;
		// DB접근
		Connection conn = DBHelper.getConnection();
		
		String sql = "INSERT INTO customer (c_mail, c_pw, c_name, c_birth, c_gender) \n"
				+ "VALUES(?, SHA2(?, 256), ?, ?, ?);";
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
