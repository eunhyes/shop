package shop;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;

public class ExCollection {

	public static void main(String[] args) {
		
	// 1. 배열
		String[] arr = new String[3];
		arr[0] = "루피"; // a 배열에 데이터를 할당 시 인덱스를 알아야함
		arr[1] = "조로"; // b 인덱스는 가지고있는 데이터 추적이 힘듦
		arr[2] = "루피"; // c 중복된 데이터 값을 피할 수 없음
		// arr[3] = "나미"; // d 인덱스 범위를 초과할 수 없음		
		for(String s : arr) {
			System.out.println(s);
		}
		
		System.out.println("----------------------");
		
	// 2. 컬렉션 프레임워크(자바 기본 API 연동)
		ArrayList<String> list = new ArrayList<String>(2);
		
		list.add("루피"); // a
		list.add("조로"); // 
		list.add("나미"); // 
		list.add("루피"); // d 
		
		for(String s : list) {
			System.out.println(s);
		}
		
		System.out.println("----------------------");

		HashSet<String> set = new HashSet<String>();
		
		set.add("루피");
		set.add("나미");
		set.add("루피"); // c 중복된 데이터 X
		
		for(String s : set) {
			System.out.println(s);
		}
		
		// System.out.println(set.get(0)); // 순서X -> 인덱스X
		
		System.out.println("----------------------");
		
	
	// 3) 맵
		
		HashMap<String, String> map = new HashMap<String, String>();
		
		map.put("선장", "루피");
		map.put("부선장", "조로");
		map.put("항해사", "나미"); // b 인덱스 대신 문자열도 가능
		
		
	// 4) List + Map
		
		ArrayList<HashMap<String, String>> mapList
		= new ArrayList<HashMap<String, String>>();
		
		HashMap<String, String> m1 = new HashMap<String, String>();
		
		m1.put("선장", "루피");
		m1.put("pirateName", "밀짚모자해적단");
		
		
		HashMap<String, String> m2 = new HashMap<String, String>();
		
		m2.put("선장", "샹크스");
		m2.put("pirateName", "빨강머리해적단");
		
		mapList.add(m1);
		mapList.add(m2);
		
		
		for(HashMap<String, String> m : mapList) {
			
			System.out.printf("%s, %s\n" , m.get("name"), m.get("pirateName"));
			
		}
		
	}
}
