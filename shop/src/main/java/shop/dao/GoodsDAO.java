package shop.dao;

import java.sql.*;
import java.util.*;

public class GoodsDAO {

	// 상품 List 출력
	// /shop/goods/goodsList.jsp  || /shop/customer/customerGoodsList.jsp
	// param : String category, int startRow, int rowPerPage
	// return : HashMap<String, Object>
	public static ArrayList<HashMap<String, Object>> selectGoodsList(String category, int startRow, int rowPerPage) throws Exception {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연결
		Connection conn = DBHelper.getConnection();
		
		//TODO : put 부분 수정, list 완성, list페이지에서 모델부분 수정
		String sql = "SELECT goods_no goodsNo, category, emp_id empId, goods_title goodsTitle, filename, goods_price goodsPrice, goods_amount goodsAmount, update_date updateDate "
				+ "FROM goods WHERE category LIKE ? ORDER BY create_date DESC LIMIT ?, ?;";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+category+"%");
		stmt.setInt(2, startRow);
		stmt.setInt(3, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			
			HashMap<String, Object> g = new HashMap<String, Object>();
			g.put("goodsNo", rs.getInt("goodsNo"));
			g.put("category", rs.getString("category"));
			g.put("empId", rs.getString("empId"));
			g.put("goodsTitle", rs.getString("goodsTitle"));
			g.put("filename", rs.getString("filename"));
			g.put("goodsPrice", rs.getInt("goodsPrice"));
			g.put("goodsAmount", rs.getInt("goodsAmount"));
			g.put("updateDate", rs.getString("updateDate"));
		
			list.add(g);
			
		}
		
		conn.close();
		
		return list;
		
	}
	
	// 상품 개수 구하기
	// 
	
	
	
}
