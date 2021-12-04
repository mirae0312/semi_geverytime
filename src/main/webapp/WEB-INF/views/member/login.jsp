<%@page import="com.zea.geverytime.member.model.vo.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	String msg = (String) session.getAttribute("msg");
	if(msg != null) session.removeAttribute("msg");
	
	Member loginMember = (Member) session.getAttribute("loginMember");
	
				
		
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath() %>/css/member/login.css" />
<body>
<script>
$(() => {

	<% if(msg != null){ %>	

		alert("<%= msg %>");
		
	<% } %>



</script>
    <div class="inner_login">
        <div class="login_tistory">
    
            <form method="post" id="authForm" action="<%= request.getContextPath() %>/member/login">
                <input type="hidden" name="redirectUrl" value="">
                <fieldset>
                <legend class="screen_out">로그인 정보 입력폼</legend>
    
                <div class="box_login">
                    <div class="inp_text">
                    <label for="loginId" class="screen_out">아이디</label>
                    <input type="text" id="memberId" name="memberId" placeholder="ID" >
                    </div>
                    <div class="inp_text">
                    <label for="loginPw" class="screen_out">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="Password" >
                    </div>
                </div>
                <button type="submit" class="btn_login"  >로그인</button>
                <div class="login_append">
                    <div class="inp_chk"> 
                   
            <span class="enroll_"> <a href= "<%=request.getContextPath()%>/member/EnrollSplit">회원가입</a></span>
          
          
            </label>
                    </div>
                    <span class="txt_find">
                    <a href="<%=request.getContextPath()%>/member/findId" class="link_find">아이디</a>
                        /
                    <a href="/member/find/password" class="link_find">비밀번호 찾기</a>
                    </span>
                </div>
                
                </fieldset>
            </form>
            
        </div>
    </div>

</body>
</html>