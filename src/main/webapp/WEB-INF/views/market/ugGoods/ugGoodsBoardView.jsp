<%@page import="com.zea.geverytime.common.model.vo.Attachment"%>
<%@page import="java.util.List"%>
<%@page import="com.zea.geverytime.market.usedgoods.model.vo.UsedGoodsBoard"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>	
<%
	UsedGoodsBoard board = (UsedGoodsBoard) request.getAttribute("board");
	List<Attachment> attachments = (List<Attachment>) board.getAttachments();
	String state = (String) request.getAttribute("state");
%>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>중고거래 상품 상세보기</title>
</head>
<body>
	<h1>상품 상세보기</h1>
	<!-- 작성자에게만 수정/삭제 버튼이 노출되도록 함 -->
	<% if(loginMember != null && loginMember.getMemberId().equals(board.getWriter())) { %>
	<input type="button" value="수정하기" id="boardUpdate"/>
	<input type="button" value="삭제하기" id="boardDelete"/>
	<form action="<%= request.getContextPath() %>/ugGoods/deleteBoard" name="boardDeleteFrm" method="POST">
		<input type="hidden" name="boardNo" value="<%= board.getNo() %>" />
	</form>
	<% } %>
	<table>
		<thead>
			<tr><th colspan=2>중고물품 판매 게시글</th></tr>
		</thead>
		<tbody>
			<tr>
				<th>제목</th>
				<td><%= board.getTitle() %></td>
			</tr>
			<tr>
				<th>글 번호</th>
				<td><%= board.getNo() %></td>
			</tr>
			<tr>
				<th>작성자</th>
				<td><%= board.getWriter() %></td>
			</tr>
			<tr>
				<th>가격</th>
				<td><%= board.getPrice() %></td>
			</tr>
			
			<!-- 상태 -->
			<tr>
				<th>상태</th>
				<td><%= state %></td>
			</tr>
			
			<!-- 구매자 > 구매요청 : value는 비동기로 처리 -->
			<% if(loginMember != null && !loginMember.getMemberId().equals(board.getWriter())) { %>
			<tr>
				<td colspan=2><input type="button" value="구매요청" id="requestBtn"/></td>
			</tr>
			<% } %>
			
			<!-- 판매자 > 요청확인 : 비동기로 처리  -->
			<% if(loginMember != null && loginMember.getMemberId().equals(board.getWriter())) { %>
			<tr>
				<td colspan=2><input type="button" value="요청확인" id="requestBtn"/></td>
			</tr>
			<% } %>
			
		<%
		int imgNum = 1;
		for(Attachment attach : attachments) {
			
		%>
			<tr>
				<th>이미지<%= imgNum %></th>
				<td>
					<img src="<%= request.getContextPath() %>/upload/market/UgSale/<%= attach.getRenamedFilename() %>" style="width:300px;" alt="" />
				</td>			
			</tr>	
		<%
		imgNum++;
		}
		%>	
			<tr>
				<th>내용</th>
				<td><%= board.getContent() %></td>
			</tr>
		</tbody>
	</table>
	
	<br />
	<input type="button" value="목록으로 돌아가기" onclick="location.href='<%= request.getContextPath() %>/ugGoods/main'"/>
	
	<script>
		$("#boardUpdate").click((e) => {
			location.href="<%= request.getContextPath() %>/ugGoods/boardUpdateForm?boardNo=<%= board.getNo() %>";
		});
		$("#boardDelete").click((e) => {
			$(document.boardDeleteFrm).submit();
		});
	</script>
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %> 