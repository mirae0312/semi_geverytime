<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html>
<meta charset="UTF-8">

<head>
<style>
input[type="number"]::-webkit-outer-spin-button,
input[type="number"]::-webkit-inner-spin-button 
{
    -webkit-appearance: none;
    margin: 0;
	
	
}
</style>
<script>

function handleOnInput(el, maxlength) {
	  if(el.value.length > maxlength)  {
	    el.value 
	      = el.value.substr(0, maxlength);
	  }
	}
</script>
<script src="<%= request.getContextPath() %>/js/jquery-3.6.0.js"></script>
<script src="<%= request.getContextPath() %>/js/Businesslocation/location.js"></script>
<title>회원가입</title>
<script>

function handleOnInput(el, maxlength) {
	  if(el.value.length > maxlength)  {
	    el.value 
	      = el.value.substr(0, maxlength);
	  }
	}
</script>

</head>

<body>


   
	
<section>
   <h3>회원가입</h3>
	<form  name ="memberEnrollFrm" action="" method="POST">
   <table cellpadding="5" cellspacing="0"

          bgcolor="eeeeee">

      <tr>

        <td>ID:</td>

        <td><input type="text" name="Id" id="_Id">

            <input type="button" value="중복확인" onclick="checkIdDuplicate();" />
          	
          	
            <input type="hidden" id="idValid" value="0" />
			
        </td>

      </tr>

      <tr>

        <td>비 번:</td>

        <td><input type="password" name="password" id="_password"> </td>

      </tr>

      <tr>

        <td>비번확인:</td>

        <td><input type="password"  name="passwordCheck" id="_passwordCheck"> </td>

      </tr>

      <tr>

        <td>이 름:</td>

        <td><input type="text" name="name" id="_name" > </td>

      </tr>
  		<tr>
      <td>이메일 : </td>
      
        <td><input type="text"  name="email" id="_email"> </td>
      
      </tr>
     

      <tr>
      <td>사업자번호 : </td>
  		<td ><input type="number"  name="businessNo1" id="_businessNo" oninput='handleOnInput(this, 9)'/>   
      	<select name="businessNo2" id="_businessNo" onchange= this.value>
      	<option value="1">1.병원</option>
      	<option value="2">2.카페</option>
      	<option value="3">3.음식점</option>
      	<option value="4">4.펜션</option>
      	<option value="5">5.미용실</option>
      	<option value="6">6.마켓</option>
      	
      	</select></td>
      </tr>
		
		<tr>
		<td>상호명 : </td>
		<td><input type="text"  name="businessName" id="_businessName"></td>
		</tr>
		
		<tr>
            <td>사업장주소 : </td>
        <td><input type="text"  name="baddress" id="baddress"> </td>
      </tr>
      
      <tr>
           <td> 지역 : </td>
				   <td >
				
				<select name="location1" id="location"  onchange= this.value></select>
				<select name="location2" id="location" onchange=this.value ></select>
					
				</td>
						
				     </tr>
     
      
      <tr>

        <td>전화번호:</td>

        <td>
        
         <select id="tel" name= "tel1" onchange=this.value>
    <option value="010-">010</option>
    <option value="055-">055</option>
    <option value="02-">02</option>
		</select>
				 -
			<input type="number" size="4" id="tel" name="tel2" style="width:4em"   oninput='handleOnInput(this, 4)'/> -
			<input type="number" size="4" id="tel" name="tel3" style="width:4em"  oninput='handleOnInput(this, 4)'/> 


        </td>

      </tr>

      <tr align="center">
        <td colspan="2">
           <input type="submit" value="등록">
           <input type="reset" value="취소">
        </td>       
      </tr>
   </table>
	</form>
</section>




</body>
<form 
	name="checkIdDuplicateFrm" 
	action="<%= request.getContextPath() %>/member/checkIdDuplicate" 
	method="GET">
	<input type="hidden" name="memberId" />
</form>
<script>
$("checkIdDuplicate").on("click",function(){
	var id = $("#Id").val();
  //window.open:  새창 띄우기.
  //idDuplCheck.jsp?  : idDuplCheck.jsp페이지로 이동할건데, key값(name)=id , value=id 를 전송
    window.open("chekcIdDuplicate.jsp?Id="+Id,"",width=400px,height=300px,top=300px,left=200px)
})


</script>
</html>