package com.zea.geverytime.info.model.service;

import static com.zea.geverytime.common.JdbcTemplate.close;
import static com.zea.geverytime.common.JdbcTemplate.getConnection;
import static com.zea.geverytime.common.JdbcTemplate.close;
import static com.zea.geverytime.common.JdbcTemplate.commit;
import static com.zea.geverytime.common.JdbcTemplate.getConnection;
import static com.zea.geverytime.common.JdbcTemplate.rollback;

import java.sql.Connection;

import com.zea.geverytime.info.model.dao.MemberDao;
import com.zea.geverytime.info.model.vo.Member;



public class MemberService {
	public static final String USER_ROLE = "U";
	public static final String ADMIN_ROLE = "A";
	public static final String USER_TYPE = "N";
	public static final String BUSINESS_TYPE = "B";
	
	private MemberDao memberDao = new MemberDao();

	public Member selectOneMember(String memberId) {
		// 1. Connection객체 생성
		Connection conn = getConnection();
		
		// 2. Dao에 쿼리실행 요청
		Member member = memberDao.selectOneMember(conn, memberId);
		
		// 3. Connection자원반납
		close(conn);
		
		return member;
	}

	public int insertMember(Member member) {
		Connection conn = null;
		int result = 0;
		try {
			// 1.Connection객체 생성
			conn = getConnection();
			
			// 2.Dao요청
			result = memberDao.insertMember(conn, member);
			
			// 3.트랜잭션처리
			commit(conn);
		} catch (Exception e) {
			rollback(conn);
			throw e;
		} finally {
			// 4.Connection 자원반납
			close(conn);
		}
		return result;
	}
}
