package com.springboot.webapp.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import org.springframework.stereotype.Repository;

@Repository("boardDao")
public class BoardDao {
	//DB 접속을 위한 기본 정보
	String id = "root";
	String password="11111111";
	String url = "jdbc:mysql://localhost:3306/springdb?characterEncoding=utf-8";
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	//DB 연동 모듈
	public Connection getConn() {
		try {
			//mysql Driver 로딩
			Class.forName("com.mysql.jdbc.Driver");
			
			//DB 연동
			return DriverManager.getConnection(url, id, password);
			
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return null;
	}
	
	//DB 연동 해제
	public void closeConn(Connection conn, ResultSet rs, PreparedStatement pstmt) {
		//connection 객체 해제
		if(conn != null) { //사용 중이면
			try {
			    if (!conn.isClosed()) //해제되어있지 않으면
			        conn.close();
			} catch (Exception e) {
				// TODO Auto-generated catch block
			    e.printStackTrace();
			} finally {
			    conn = null;
			}
		}
		
		
		//PreparedStatement 객체 해제
		if(pstmt != null) { //사용 중이면
			try {
			    if (!pstmt.isClosed()) //해제되어있지 않으면
			        pstmt.close();
			} catch (Exception e) {
			    e.printStackTrace();
			} finally {
			    pstmt = null;
			}
		}
		
		
		//ResultSet 객체 해제
		if(rs != null) { //사용 중이면
			try {
			    if (!rs.isClosed()) //해제되어있지 않으면
			        rs.close();
			} catch (Exception e) {
			    e.printStackTrace();
			} finally {
			    rs = null;
			}
		}
	}
	
}
