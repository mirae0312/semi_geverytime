<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<%
	List<Map<String, Object>> list = (List<Map<String, Object>>) request.getAttribute("list");
	Map<String, Object> delCartMap = (Map<String, Object>) new HashMap<String, Object>();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구매페이지</title>
  <script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
  <script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
	<h1>결제페이지</h1>
	<table>
		<thead>
			<tr>
				<th>상품번호</th>
				<th>게시글제목</th>
				<th>가격</th>
				<th>선택수량</th>
			</tr>
		</thead>
		<tbody>
		<%
		int countNum = 1;
		for(Map<String, Object> pdt : list) {
		%>
			<tr>
				<td>
					<%= pdt.get("no") %>
					<input type="hidden" id="pdtNo<%= countNum %>" value="<%= pdt.get("no") %>"/>
				</td>
				<td>
					<%= pdt.get("title") %>
					<input type="hidden" id="pdtTitle<%= countNum %>" value="<%= pdt.get("title") %>" />
				</td>
				<td>
					<%= pdt.get("price") %>
					<input type="hidden" id="pdtPrice<%= countNum %>" value="<%= pdt.get("price") %>" />
				</td>
				<td>
					<%= pdt.get("count") %>
					<input type="hidden" id="pdtCount<%= countNum %>" value="<%= pdt.get("count") %>" />
				</td>
			</tr>
			
		<%
			delCartMap.put("bdn"+countNum, pdt.get("boardNo"));
		countNum++;
		}
		%>			
		</tbody>
	</table>

	<br />
	<!-- 주문자 정보 테이블 -->
	<h3>주문자 정보</h3>
	<table id="consumerInfo">
		<tbody>
			<tr>
				<th>이름</th>
				<td>
					<input type="text" name="conName" id="" value="<%= loginMember != null ? loginMember.getMemberName() : "" %>"/>
				</td>
			</tr>
			<tr>
				<th>전화번호</th>
				<td>
					<input type="text" name="conPhone" value="<%= loginMember != null ? loginMember.getPhone() : "" %>" />
				</td>
			</tr>
			<tr>
				<th>주소</th>
				<td>
					<input type="text" name="conAddr" value="<%= loginMember != null ? loginMember.getAddress() : "" %>" />
				</td>
				<td>
					<span>상세주소</span><input type="text" name="conAddrDetail" />
				</td>
			</tr>
			<tr>
				<td>인적사항이 다른 경우 다시 입력해주세요.</td>
			</tr>
		</tbody>
	</table>
	
	<br />
	
	<h3>포인트 적용</h3>
	<span>나의 보유 point : </span><span id="myPoint"></span><br />
	<label for="usePoint">사용할 포인트 입력 </label><input type="text" name="conPoint" id="usePoint" value="0"/>
	<input type="button" value="적용하기" id="pointSet" />
	<br /><br />
	
	
	<!-- 최종 결제 금액 영역 -->
	<span>최종 결제 금액은 : </span><span id="totalPricePlace"></span><span>원 입니다.</span>
	
	<br /><br />	
	<button onclick="requestPay()">결제하기</button>
	
	<input type="hidden" id="countNum" value="<%= countNum - 1 %>"/>
	<input type="hidden" id="defaultTotalPrice" value="" />
	
	<input type="button" value="test" onclick="testBtn();" />
	
	<!-- 선택한 장바구니 삭제를 위한 hidden 영역 -->
<%-- 	<form action="<%= request.getContextPath() %>/cart/delete" name="cartDeleteFrm" method="POST">
	<%
		for(int i = 1; i < countNum; i++){
			int no = (int)delCartMap.get("bdn"+i);
	%>
		<input type="text" name="delCart<%= i %>" value="<%= no %>"/>
	<%
		}
	%>
		<input type="hidden" name="delCartLoginMember" value="<%= loginMember.getMemberId() %>" />
		<input type="hidden" name="delCartCountNum" value="<%= countNum - 1 %>" />
	</form> --%>
<script>
	// point 사용 시 잔액과 비교
	$("#pointSet").click((e) => {
		let pointBal = $("#myPoint").html();
		let usePoint = $("#usePoint").val();
		let defaultTotalPrice = $("#defaultTotalPrice").val();
		
		if(pointBal - usePoint < 0){
			alert("입력하신 금액이 보유하신 포인트보다 많습니다.");
			$("#usePoint").val(0);
		} else {
			let finalPrice = defaultTotalPrice - usePoint;
			$("#totalPricePlace").html(finalPrice);
			console.log(finalPrice);
		}
	})

	$(() => {
		// 금액 계산
		priceCalculate();
		
		// 포인트 잔액 load
		const loginMemberId = "<%= loginMember.getMemberId() %>";
		$.ajax({
			url: "<%= request.getContextPath() %>/point/getBalance",
			data: {
				memberId : loginMemberId  
			},
			success(data){
				$("#myPoint").html(data.pointBal);
			},
			error : console.log
		});
		
	});

	// 상품 총 금액 계산 함수(포인트 미적용)
	const priceCalculate = () => {
		let countNum = $("#countNum").val();
		
		let TotalPrice = 0;
		for(let i = 1; i <= countNum; i++){
			let price = parseInt($(`#pdtPrice\${i}`).val());
			let count = $(`#pdtCount\${i}`).val();
			$(`#pdtTotalVal\${i}`).html(price*count);
			TotalPrice += price*count;
		}			
		$("#defaultTotalPrice").val(TotalPrice);
		$("#totalPricePlace").html(TotalPrice);
	};
	
	
	
	// 카카오페이 연동
	var IMP = window.IMP; 
	IMP.init("imp00307901");
	
    function requestPay() {
    	const date = new Date();
		let day = String(date.getDate());
		let hours = String(date.getHours());
		let minute = String(date.getMinutes());
		let second = String(date.getSeconds());
		
		const totalPrice = $("#totalPricePlace").html();
		const usePoint = $("#usePoint").val();
		
        // IMP.request_pay(param, callback) 결제창 호출
        IMP.request_pay({ // param
            pg: "kakaopay",
            pay_method: "card",
            merchant_uid: "<%= loginMember.getMemberId() %>" + day+hours+minute+second,
            name: "geverytime결제",
            amount: totalPrice,
            buyer_email: "<%= loginMember.getEmail() %>",
            buyer_name: "<%= loginMember.getMemberName() %>",
            buyer_tel: "<%= loginMember.getPhone() %>",
            buyer_addr: "<%= loginMember.getAddress() %>",
            buyer_postcode: "010101"
        }, function (rsp) { // callback
            if (rsp.success) {
            	const impUid = rsp.imp_uid;
            	const merchantUid = rsp.merchant_uid;
            	let amount = totalPrice;
            	$.ajax({
            		url: "<%= request.getContextPath() %>/purchase/payments",
            		method: "POST",
            		dataType: "json",
            		data: {
            			imp_uid: impUid,
	            		merchant_uid: merchantUid,
	            		amountToBePaid: amount
            		},
            		success(data){
            			console.log(data.msg);
            			
            			var msg = data.msg;
                    	msg += "\n구매자 : " + "<%= loginMember.getMemberName() %>";
                    	msg += "고유ID : " + rsp.imp_uid;
                    	msg += "상점 거래 ID : " + rsp.merchant_uid;
                    	msg += "결제 금액 : " + rsp.paid_amount;
                        // 결제 성공 시 로직,
                        // 포인트 사용처리
                        pointHandling("<%= loginMember.getMemberId() %>", usePoint, rsp.imp_uid);
                        delCart();
                        alert(msg);
            			purchaseDone(rsp.imp_uid, rsp.merchant_uid, rsp.paid_amount);
            		},
            		error : console.log
            	});
            } else {
                alert("결제 실패")
                // 결제 실패 시 로직, 
            }
        });
      }
	
	const purchaseDone = (a, b, c) => {
		console.log(a, b, c);
		location.href=`<%= request.getContextPath() %>/purchase/Complete?uid=\${a}&muid=\${b}&amount=\${c}`;
	};
	
	const pointHandling = (useMemberId, usePoint, purchase_uid) => {
		$.ajax({
			url: "<%= request.getContextPath() %>/point/usePoint",
			method: "POST",
			data: {
				memberId: useMemberId,
				point: usePoint
			},
			success(data){
				addPointHistory(data.pointNo, '사용', data.usePoint, '일반 상품 결제', purchase_uid);
			},
			error: console.log
		});
	};
	
	const addPointHistory = (reqpointNo, reqdiv, reqpointVal, reqhistory, req_purchase_uid) => {
		$.ajax({
			url: "<%= request.getContextPath() %>/point/addPointHistory",
			method: "POST",
			data: {
				pointNo: reqpointNo,
				div: reqdiv,
				pointVal: reqpointVal,
				history: reqhistory,
				purchaseUid: req_purchase_uid
			},
			success(data){
				console.log(data);
			},
			error: console.log
		});
	};
	
	const delCart = () => {
		$.ajax({
			url: "<%= request.getContextPath() %>/cart/deleteCart",
			method: "POST",
			data:{
				<%
					for(int i = 1; i < countNum; i++){
						int no = (int)delCartMap.get("bdn"+i);
				%>
					delCart<%= i %>: "<%= no %>",
				<% } %>
					delCartLoginMember: "<%= loginMember.getMemberId() %>",
					delCartCountNum: "<%= countNum -1 %>"
			},
			success(data){
				console.log("장바구니 지워짐");
			},
			error: console.log
		})
	};
</script>
</body>
</html>
<%@ include file="/WEB-INF/views/common/footer.jsp" %>