<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.SQLException"%>
<%@page import="user.vo.UserVO"%>
<%@page import="user.dao.UserDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="정보수정" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.139/jsp_prj/common/main/favicon.png">
<!-- bootstrap CDN -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<!-- bootstrap JS  -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<!-- jQuery CDN -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
<!-- header&footer css -->
<link rel="stylesheet" href="../common/CSS/header_footer.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function searchZipcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('zipcode').value = data.zonecode;
                document.getElementById("addr").value = roadAddr;
                document.getElementById("addr_d").focus();
            }
        }).open();
    }
</script>

<style type="text/css">
.content_wrap {
	margin-top: 100px;
	width: 100%;
}

.signup_form_wrap {
	width : 50%;
	max-width : 600px;
	height : 900px;
	margin: 0 auto;
	padding : 50px;
	border: 1px solid rgba(0,0,0,.12);
	position: relative;
}

.signup_form_wrap > h1 {
	text-align: center;
}

.input_area_img {
	margin: 30px 10px 0px 10px ;
}

.input_area_img > svg {
	width:24px;
	height: 24px;
}

.input_box {
	width:100%;
	height: 50px;
	margin-top:20px;
	border: solid #ccc;
    border-width: 0 0 2px;
}

.small_input_box {
	width:91%;
}

.input_box:focus {
	outline : none;
	border: solid #0DCAF0;
    border-width: 0 0 2px;
}

.btn_check {
	position:absolute;
	right:50px;
	width:90px;
	height:30px;
	margin-top:30px;
	font-size: 12px;
}


.mod_btn {
	width:100%;
	height:50px;
	margin-top: 30px;
}

.reverse {
	flex-direction: row-reverse;
}

</style>

<script type="text/javascript">
$(function(){

	 $("#btnId").click(function(){
		 alert("아이디는 수정 불가합니다.");
	}); 
	 
	 $("#btnName").click(function(){
		 alert("이름은 수정 불가합니다.");
	}); 
	
	 $("#btnBirth").click(function(){
		 alert("생년월일은 수정 불가합니다.");
	}); 
	
	$("#btnZipcode").click(function(){
	      searchZipcode();
   	});
	
	$("#mod_btn").click(function(){
		//입력값에 대한 유효성 검증
		if($("#idDupFlag").val() == 0){
			alert($("#id").val()+"정보수정 완료.");
	        location.href="../user_mypage/mypage.jsp"
			return;
		}//end if
		
		if($("#password").val() != $("#re_password").val()){
	        alert("비밀번호가 서로 다릅니다. 비밀번호를 확인해 주세요."); 
	        $("#password").focus();
	        return; 
	    }
		
		$("#frm").submit();
	});//click
	
	$("#id").keydown(function(){
		$("#idDupFlag").val(0);
	});
	
});//ready
</script>
</head>
<body>
<div class="wrap">
    <%@ include file="../common/jsp/header.jsp" %>
    
    <%
    String userId=(String)session.getAttribute("sesId");
    System.out.println(userId);
    
    if( userId == null ){
    	response.sendRedirect("http://192.168.10.132/prj_travel/user_main/main.jsp");
    	return;
    }//end if
    if( userId != null ){
    	pageContext.setAttribute("userId", userId);
    }//end if
    
    UserDAO uDAO = UserDAO.getInstance();
	try{
		UserVO uVO = uDAO.selectUserInfo(userId);
		//ex) 1998-09-30 00:00으로 출력되기에
		String birthdate = uVO.getBirthdate().substring(0,11).replace("-","");
		uVO.setBirthdate(birthdate);
		
		System.out.println(uVO);
		
		DataDecrypt dd = new DataDecrypt("a12345678901234567");
		uVO.setTel(dd.decryption(uVO.getTel())); 
		
		/* uVO.setPw(DataEncrypt.messageDigest("MD5", uVO.getPw()));*/
		
		
		
		/* String tel = uVO.getTel() */
		
		pageContext.setAttribute("user", uVO);
	}catch(SQLException se){
		se.printStackTrace();
	}
	
    
    
    %>
    
    <div class="content_wrap">

        <div class="signup_form_wrap">
            <h1>정보수정</h1>
            <form action="info_modify_process.jsp" name="frm" id="frm"  method="post">
				<div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16"><path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0Zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4Zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10Z"/></svg></label>
					<input type="text" value="${ user.id }" name="id" class="input_box" id="id" readonly="readonly">
				</div>
				<div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-key" viewBox="0 0 16 16"><path d="M0 8a4 4 0 0 1 7.465-2H14a.5.5 0 0 1 .354.146l1.5 1.5a.5.5 0 0 1 0 .708l-1.5 1.5a.5.5 0 0 1-.708 0L13 9.207l-.646.647a.5.5 0 0 1-.708 0L11 9.207l-.646.647a.5.5 0 0 1-.708 0L9 9.207l-.646.647A.5.5 0 0 1 8 10h-.535A4 4 0 0 1 0 8zm4-3a3 3 0 1 0 2.712 4.285A.5.5 0 0 1 7.163 9h.63l.853-.854a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.646-.647a.5.5 0 0 1 .708 0l.646.647.793-.793-1-1h-6.63a.5.5 0 0 1-.451-.285A3 3 0 0 0 4 5z"/><path d="M4 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0z"/></svg></label>
					<input type="password" placeholder="비밀번호" name="pw" class="input_box" id="password">
				</div>
				<div class="input_area flex reverse">
					<input type="password" placeholder="재확인" name="re_pw" class="input_box small_input_box" id="re_password">
				</div>
				<div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16"><path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0Zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4Zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10Z"/></svg></label>
					<input type="text" value="${ user.name }" name="name" class="input_box" id="name" readonly="readonly">
				</div>
				<div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16"><path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/><path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/></svg></label>
					<input type="text" value="${ user.birthdate }" name="birthdate" class="input_box" id="birthdate" readonly="readonly">
				</div>
				<div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-phone" viewBox="0 0 16 16"><path d="M11 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h6zM5 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H5z"/><path d="M8 14a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/></svg></label>
					<input type="tel" placeholder="휴대전화번호" value="${ user.tel }" name="tel" class="input_box" id="cel" >
				</div>
				<div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house" viewBox="0 0 16 16"><path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L2 8.207V13.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V8.207l.646.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5ZM13 7.207V13.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V7.207l5-5 5 5Z"/></svg></label>
					<input type="text" value="${ user.zipcode }" name="zipcode" class="input_box" id="zipcode" readonly="readonly">
					<input type="button" value="우편번호검색" class="btn btn-info btn_check" id="btnZipcode">
				</div>
				<div class="input_area flex reverse">
					
					<input type="text" value="${ user.addr }" name="addr" class="input_box small_input_box" id="addr" readonly="readonly">
				</div>
				<div class="input_area flex reverse">
					
					<input type="text" placeholder="상세주소" value="${ user.addrdetail }" name="addrdetail" class="input_box small_input_box" id="addr_d" >
				</div>

            	<input type="button" value="수정하기" class="btn btn-info mod_btn" id="mod_btn">
            </form>
            
        </div>

    </div>

	<%@ include file="../common/jsp/footer.jsp" %>
    </div>
	
</div>
      
</body>
</html>