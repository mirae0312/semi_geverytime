package com.zea.geverytime.market.cart.model.service;

import static com.zea.geverytime.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;

import com.zea.geverytime.market.cart.model.dao.CartDao;
import com.zea.geverytime.market.cart.model.vo.Cart;

public class CartService {
	
	private CartDao cartDao = new CartDao();

	public int insertIntoCart(Cart cart) {
		Connection conn = getConnection();
		int result = 0;
		
		try {
			// 중복여부 판단.
			int dupCheck = cartDao.checkDupPdt(conn, cart);
			if(dupCheck == 0) {
				result = cartDao.insertIntoCart(conn, cart);				
				commit(conn);
			}			
		} catch(Exception e) {
			rollback(conn);
			e.printStackTrace();
		} finally {
			close(conn);
		}
		return result;
	}

	public List<Cart> getCartList(String memberId) {
		Connection conn = getConnection();
		List<Cart> cartList = cartDao.getCartList(conn, memberId);
		close(conn);
		return cartList;
	}

	public int deleteCart(List<Integer> list, String memberId) {
		Connection conn = getConnection();
		int result = 0;
		try {
			int countNum = 0;
			for(Integer num : list) {
				result += cartDao.deleteCart(conn, num, memberId);
				countNum++;
			}
			if(result == countNum) {
				commit(conn);				
			} else {
				System.out.println("뭔가 등록이 안되었음");
			}
		} catch(Exception e) {
			rollback(conn);
			e.printStackTrace();
		} finally {
			close(conn);
		}
		return result;
	}

}
