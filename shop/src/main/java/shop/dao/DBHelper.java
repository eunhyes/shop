package shop.dao;

import java.io.*;
import java.sql.*;
import java.util.Properties;

public class DBHelper {

	public static Connection getConnection() throws Exception{
		
		Class.forName("org.mariadb.jdbc.Driver");
		
		// 로컬 PC의 properties파일 읽어오기(id, pw)
		FileReader fr = new FileReader("D:\\data\\dev\\auth\\mariadb.properties");
		Properties prop = new Properties();
		prop.load(fr);
		System.out.println(prop.getProperty("id"));
		System.out.println(prop.getProperty("pw"));
		
		String id = prop.getProperty("id");
		String pw = prop.getProperty("pw");
		
		Connection conn = DriverManager.getConnection("jdbc:mariadb://127.0.0.1:3306/shop", id, pw);
		return conn;

	}
	
	public static void main(String[] args) throws Exception {
		
		DBHelper.getConnection();
	}
	
}
