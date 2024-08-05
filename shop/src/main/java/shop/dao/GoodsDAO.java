package shop.dao;

import java.sql.*;
import java.util.*;

public class GoodsDAO {

	// 상품 List 출력
	// /goods/goodsList.jsp -> emp용   /customer/customerGoodsList.jsp
	// param : String category, int startRow, int rowPerPage
	// return : HashMap<String, Object>
	public static ArrayList<HashMap<String, Object>> selectGoodsList(String category, int startRow, int rowPerPage) throws Exception {
		
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB연결
		Connection conn = DBHelper.getConnection();
		
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
	
	// 카테고리 리스트 + 상품 개수 구하기
	// /goods/goodsList.jsp		/customer/customerGoodsList.jsp
	// param : String category, int cnt
	// return : HashMap<String, Object>
	public static ArrayList<HashMap<String, Object>> categoryList(String category, int cnt) throws Exception	{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB 연결 
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT category, COUNT(*) AS cnt from goods"
				+ " GROUP BY category"
				+ " ORDER BY category ASC";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		
		while(rs.next())	{
			
			HashMap<String, Object> c = new HashMap<String, Object>();
			
			c.put("category", rs.getString("category"));
			c.put("cnt", rs.getInt("cnt"));
			list.add(c);
		}
		
		System.out.println(list + " ====== categoryList");
		
		conn.close();
		return list;
		
	}
	
	
	// 상품 목록 페이징
	// /goods/goodsList.jsp		/customer/customerGoodsList.jsp
	// param : String category, int totalRow, int rowPerPage
	// return : HashMap<String, Object>
	public static ArrayList<HashMap<String, Object>> listPaging (String category, int totalRow, int rowPerPage, int lastRow) throws Exception	{
		ArrayList<HashMap<String, Object>> list = new ArrayList<HashMap<String, Object>>();
		// DB 연결 
		Connection conn = DBHelper.getConnection();
		
		String sql = "SELECT COUNT(*) AS cnt FROM goods"
				+ " WHERE category LIKE ?";
		
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, "%"+ category + "%");
		
		ResultSet rs = stmt.executeQuery();
		
		if(rs.next())	{
			
			totalRow = rs.getInt("cnt");
			
		}
		System.out.println(totalRow + " ======= totalRow");
		
		int lastPage = totalRow / rowPerPage;
		if(totalRow % rowPerPage != 0) {
			
			lastPage = lastPage + 1;
		}
		System.out.println(lastPage + " ======= lastPage");
		
		HashMap<String, Object> p = new HashMap<String, Object>();
		p.put("totalRow", totalRow);
		p.put("rowPerPage", rowPerPage);
		p.put("lastPage", lastPage);
		list.add(p);
		
		conn.close();
		return list;
		
		
	}
	
	
	
}
