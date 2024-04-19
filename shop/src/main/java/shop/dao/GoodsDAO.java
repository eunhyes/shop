package shop.dao;

import java.sql.*;
import java.util.*;

public class GoodsDAO {

	public ArrayList<HashMap<String, Object>> selectGoodsList(int startRow, int rowPerPage) throws Exception {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		
		Connection conn = DBHelper.getConnection();
		

		//TODO : 쿼리 수정, list 완성, list페이지에서 모델부분 수정 
		String sql = "select * from goods order by create_date desc limit ?, ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, startRow);
		stmt.setInt(1, rowPerPage);
		
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			
			HashMap<String, Object> m = new HashMap<String, Object>();
			m.put("goodsNo", rs.getInt("goods_no"));
			m.put("Category", rs.getString("category"));
			
		}
		
		conn.close();
		
		return list;
		
	}
	
	
}
