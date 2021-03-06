<%@page import="com.zea.geverytime.common.model.vo.Attachment"%>
<%@page import="java.util.List"%>
<%@page import="com.zea.geverytime.info.model.vo.InfoReview"%>
<%@page import="com.zea.geverytime.info.model.vo.Salon"%>
<%@page import="com.zea.geverytime.info.model.vo.Pension"%>
<%@page import="com.zea.geverytime.info.model.vo.CafeRestaurant"%>
<%@page import="com.zea.geverytime.info.model.vo.Hospital"%>
<%@page import="com.zea.geverytime.info.model.vo.Info"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
	Info info = (Info) request.getAttribute("info"); 
	String site1 = (String) request.getAttribute("site1");
	String site2 = (String) request.getAttribute("site2");
	String codeN = (String) request.getAttribute("codeN");
	
	String pic1 = "";
	String pic2 = "";
	
	if(info.getAttachments() != null && !info.getAttachments().isEmpty()){
		if(info.getAttachments().size() == 1){
			pic1 = info.getAttachments().get(0).getRenamedFilename();
		}else if(info.getAttachments().size() == 2){
			pic1 = info.getAttachments().get(0).getRenamedFilename();
			pic2 = info.getAttachments().get(1).getRenamedFilename();
		}
	}
	
%>
<%@ page import="java.sql.*" %>
<%
	String msg = (String) session.getAttribute("msg");
	if(msg != null) session.removeAttribute("msg");
	
%>
 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>index</title>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/style.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/admin/infoCheck.css" />
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/summernote/summernote-lite.css">
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<script src="<%= request.getContextPath() %>/js/summernote/summernote-lite.js"></script>
<script src="<%= request.getContextPath() %>/js/summernote/lang/summernote-ko-KR.js"></script>

</head>
<body>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=4247f28f0dc06c5cc8486ac837d411ff&libraries=services"></script>
<div class="info-view-wrapper">
	<div class="info-head-wrapper">
		<div class="left-side">
			<h1><%= info.getBusinessName() %></h1>
			<img style="width:150px; height:150px;" src="<%= request.getContextPath() %>/upload/info/<%= pic1 %>" alt="" />
			<p><%= info.getHeadContent() %></p>
		</div><br />
		<div class="right-side">
			<p>???????????? : <%= info.getBusinessTel() %></p>
			<p>?????? : <%= info.getBusinessAddress() %></p>
			<table>
				<tr>
					<th colspan="2">????????????</th>
					<th colspan="2">????????????</th>
					<th colspan="2">????????????</th>
				</tr>
				<tr>
					<td><%= info.getStartHour() == null ? "" : info.getStartHour() %>~</td>
					<td><%= info.getEndHour() == null ? "" : info.getEndHour() %></td>
					<td><%= info.getStartLaunch() == null ? "" : info.getStartLaunch() %>~</td>
					<td><%= info.getEndLaunch() == null ? "" : info.getEndLaunch() %></td>
					<td><%= info.getStartDinner() == null ? "" : info.getStartDinner() %>~</td>
					<td><%= info.getEndDinner() == null ? "" : info.getEndDinner() %></td>
				</tr>
			</table>
<% if(site1 != null && !site1.isEmpty()){ %>
			<p>???????????? : <%= site1 %></p>
<% } %>
<% if(site2 != null && !site2.isEmpty()){ %>
			<p>???????????? : <%= site2 %></p>
<% } %>
<% if("1".equals(codeN)){ %>
			<p>????????????</p>
	<% if(info.getHospitals() != null && !info.getHospitals().isEmpty()){ %>
		<% for(Hospital h : info.getHospitals()){ %>
			<p><%= h.getService() %></p>		
		<% } %>
	<% } %>
<% }else if("2".equals(codeN) || "3".equals(codeN)){ %>
			<table>
				
	<% if(info.getCafeRestaurants() != null && !info.getCafeRestaurants().isEmpty()){ %>
		<% for(CafeRestaurant cr : info.getCafeRestaurants()){ %>
				<tr>
					<td><%= cr.getService() %></td>
					<td><%= cr.getPrice() %></td>
				</tr>
		<% } %>
	<% } %>
			</table>
<% }else if("4".equals(codeN)){ %>
			<table>
				<tr>
					<th rowspan="2">???</th>
					<th colspan="2">?????????</th>
					<th colspan="2">?????????</th>
					<th colspan="2">?????????</th>
				</tr>
				<tr>
					<th>??????</th>
					<th>??????</th>
					<th>??????</th>
					<th>??????</th>
					<th>??????</th>
					<th>??????</th>
				</tr>
	<% if(info.getPensions() != null && !info.getPensions().isEmpty()){ %>
		<% for(Pension p : info.getPensions()){ %>
				<tr>
					<td><%= p.getRoom() == null ? "" : p.getRoom() %></td>
					<td><%= p.getPrice1() == null ? "" : p.getPrice1() %></td>
					<td><%= p.getPrice2() == null ? "" : p.getPrice2() %></td>
					<td><%= p.getPrice3() == null ? "" : p.getPrice3() %></td>
					<td><%= p.getPrice4() == null ? "" : p.getPrice4() %></td>
					<td><%= p.getPrice5() == null ? "" : p.getPrice5() %></td>
					<td><%= p.getPrice6() == null ? "" : p.getPrice6() %></td>
				</tr>
		<% } %>
	<% } %>
			</table>
<% }else if("5".equals(codeN)){ %>
			<table>
				<tr>
					<th rowspan="5">?????? ??? ??????</th>
					<th colspan="3">??????</th>
					<th colspan="3">??????+??????</th>
					<th colspan="3">?????????</th>
					<th colspan="3">?????????</th>
					<th colspan="3">?????????</th>
				</tr>
				<tr>
					<th>?????????</th>
					<th>?????????</th>
					<th>?????????</th>
					<th>?????????</th>
					<th>?????????</th>
					<th>?????????</th>
					<th>?????????</th>
					<th>?????????</th>
					<th>?????????</th>
					<th>?????????</th>
					<th>?????????</th>
					<th>?????????</th>
					<th>?????????</th>
					<th>?????????</th>
					<th>?????????</th>
				</tr>
	<%if(info.getSalons() != null && !info.getSalons().isEmpty()){ %>
		<% for(Salon s : info.getSalons()){ %>
				<tr>
					<td><%= s.getSmallBath() == null ? "" : s.getSmallBath() %></td>
					<td><%= s.getMiddleBath() == null ? "" : s.getMiddleBath() %></td>
					<td><%= s.getSpecialBath() == null ? "" :s.getSpecialBath() %></td>
					<td><%= s.getSmallBathAnd() == null ? "" : s.getSmallBathAnd() %></td>
					<td><%= s.getMiddleBathAnd() == null ? "" : s.getMiddleBathAnd() %></td>
					<td><%= s.getSpecialBathAnd() == null ? "" : s.getSpecialBathAnd() %></td>
					<td><%= s.getSmallMachine() == null ? "" : s.getSmallMachine() %></td>
					<td><%= s.getMiddleMachine() == null ? "" : s.getMiddleMachine() %></td>
					<td><%= s.getSpecialMachine() == null ? "" : s.getSpecialMachine() %></td>
					<td><%= s.getSmallSpotting() == null ? "" : s.getSmallSpotting() %></td>
					<td><%= s.getMiddleSpotting() == null ? "" : s.getMiddleSpotting() %></td>
					<td><%= s.getSpecialSpotting() == null ? "" : s.getSpecialSpotting() %></td>
					<td><%= s.getSmallScissors() == null ? "" : s.getSmallScissors() %></td>
					<td><%= s.getMiddleScissors() == null ? "" : s.getMiddleScissors() %></td>
					<td><%= s.getSpecialScissors() == null ? "" : s.getSpecialScissors() %></td>
				</tr>
		<% } %>
	<% } %>
			</table>
<% } %>
		</div>	<br />	
	</div><br />
	<%-- ?????? ?????? --%>
	<div class="info-body-wrapper">
		<img style="width:300px; height:200px;" src="<%= request.getContextPath() %>/upload/info/<%= pic2 %>" alt="" />
		<p><%= info.getBodyContents() %></p>
		<%-- ?????? --%>
		<div id="map" style="width:400px;height:300px;"></div><br />
		<%-- ????????? --%>
		<div class="way-content">
			<h1>????????? ???</h1>
			<p><%= info.getRoadGuide() %></p>
		</div>
	</div>
</div>
	<input type="hidden" id="code" name="code" value="<%= info.getCode() %>" />
	<button id="checkButton" class="approve-btn btn">??????</button>
	<button id="falseButton" class="reject-btn btn">??????</button>
	<button id="deleteButton" class="delete-btn btn">??????</button>
<script>
// ??????
$("#checkButton").click((e) => {
	$.ajax({
		url: "<%= request.getContextPath() %>/admin/check",
		method: "POST",
		data: {
			code: $("#code").val(),
			output: "I"
		},
		success(data){
			console.log(data);
			opener.location.reload();		
			close();
		},
		error:console.log
	});
});
// ??????
$("#falseButton").click((e) => {
	$.ajax({
		url: "<%= request.getContextPath() %>/admin/check",
		method: "POST",
		data: {
			code: $("#code").val(),
			output: "O"
		},
		success(data){
			console.log(data);
			opener.location.reload();		
			close();
		},
		error:console.log
	});
});
// ??????
$("#deleteButton").click((e) => {
	$.ajax({
		url: "<%= request.getContextPath() %>/info/deleteMain",
		method: "POST",
		data: {
			code: $("#code").val(),
			output: "A"
		},
		success(data){
			console.log(data);
			opener.location.reload();		
			close();
		},
		error:console.log
	});
});
/* const checkTrue = () => {
	e.preventDefault();
	$(checkTrueFrm).submit();
	opener.parent.location.reload();
	//window.close();
}; */

const checkFalse = () => {
	close();
};

// ????????? ?????? api
var mapContainer = document.getElementById('map'), // ????????? ????????? div 
	mapOption = {
	    center: new kakao.maps.LatLng(33.450701, 126.570667), // ????????? ????????????
	    level: 3 // ????????? ?????? ??????
};  

//????????? ???????????????    
var map = new kakao.maps.Map(mapContainer, mapOption); 

//??????-?????? ?????? ????????? ???????????????
var geocoder = new kakao.maps.services.Geocoder();

//????????? ????????? ???????????????
geocoder.addressSearch('<%= info.getBusinessAddress() %>', function(result, status) {

// ??????????????? ????????? ??????????????? 
	if (status === kakao.maps.services.Status.OK) {
	
		var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		// ??????????????? ?????? ????????? ????????? ???????????????
		var marker = new kakao.maps.Marker({
		    map: map,
		    position: coords
		});
		
		// ?????????????????? ????????? ?????? ????????? ???????????????
		var infowindow = new kakao.maps.InfoWindow({
		    content: '<div style="width:150px;text-align:center;padding:6px 0;">????????????</div>'
		});
		infowindow.open(map, marker);
		
		// ????????? ????????? ??????????????? ?????? ????????? ??????????????????
		map.setCenter(coords);
		console.log(coords);
	} 
});   


</script>
</body>
</html>