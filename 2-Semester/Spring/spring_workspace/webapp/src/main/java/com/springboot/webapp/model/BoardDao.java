package com.springboot.webapp.model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import com.sun.jdi.connect.spi.ClosedConnectionException;

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
	
	// 1. insertBoard(BoardDo bdo) : DB에 BoardDo로 전달되는 데이터를 저장
	public void insertBoard(BoardDo bdo) {
		System.out.println("insertBoard(BoardDo bdo) 처리 중-----");
		
		//DB 연동
		conn = getConn();
		
		try {
			// 2. SQL문 완성
			String sql = "insert into board (title, writer, content) values (?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bdo.getTitle());   // 1번째 ?값
			pstmt.setString(2, bdo.getWriter());  // 2번째 ?값
			pstmt.setString(3, bdo.getContent()); // 3번째 ?값
			
			// 3. sql문 실행 및 결과값 처리
			pstmt.executeUpdate();
			
			// 4. 연결 해제
			closeConn(conn, rs, pstmt);
			System.out.println("insertBoard(BoardDo bdo) 처리 완료");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
	}
	
	
	public ArrayList<BoardDo> getBoardList(){
		System.out.println("BoardDao : getBoardList() 처리 중");
		ArrayList<BoardDo> bList = new ArrayList<BoardDo>();
		
		//DB 연동
		conn = getConn();
		
		try {
			// 2. SQL문 완성
			String sql = "select * from board";
			pstmt = conn.prepareStatement(sql);
			
			
			// 3. sql문 실행 및 결과값 처리
			rs = pstmt.executeQuery();
			while(rs.next()) { //rs.next() 이용, 테이블의 각각의 로우 데이터에 접근
				BoardDo bdo = new BoardDo();
				bdo.setSeq(rs.getInt(1));
				bdo.setTitle(rs.getString(2));
				bdo.setWriter(rs.getString(3));
				bdo.setContent(rs.getString(4));
				
				//읽어온 데이터 확인 --> 확인 후 삭제 또는 주석
				System.out.println(bdo.toString());
				
				bList.add(bdo);
			}
			
			
			// 4. 연결 해제
			closeConn(conn, rs, pstmt);
			System.out.println("insertBoard(BoardDo bdo) 처리 완료");
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return bList;
	}
	
	
}
