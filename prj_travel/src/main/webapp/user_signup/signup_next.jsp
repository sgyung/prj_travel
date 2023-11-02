<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page info="" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="http://192.168.10.160/jsp_prj/common/main/favicon.png">
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
	height : 950px;
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
	border: solid #ef6d00;
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

.textBox{
	width:100%;
	margin-top:20px;
	padding: 20px;
	display: none;
	background-color: #fafafa;
}

.textBox > p {
	font-size: 13px;
	color: #e65f3e;
	margin-bottom: 0px;
	text-align: left;
}

.request_btn {
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

	$("#btnDup").click(function(){
		var getId= RegExp(/^[a-z0-9]{4,16}$/);
		if(!getId.test($("#id").val())) {
	        $("#warningBox").show();
		    $("#warningBox").html("<p>아이디는 4~16자, 영문(소문자), 숫자만 가능합니다.</p>");
	        $("#id").val("");
	        $("#id").focus();
	        return false;
      	}
		
   	 	var id=$("#id").val();
   	 	
   		window.open("id_dup.jsp?id="+id,"id_dup","width=512,height=313,top="
        +( window.screenY+150)+",left="+( window.screenX+200) + ",resizable=no");   
	});
	
	$("#id").keydown(function(){
		$("#idDupFlag").val(0);
	});
	
	$("#btnZipcode").click(function(){
	      searchZipcode();
   	});
	
	//NullCheck시작
	
	// "request_btn" 버튼의 초기 상태를 비활성화로 설정
    $("#request_btn").prop("disabled", true);
	
	// "input_box" 입력란에서 포커스 아웃될 때 검증
    $(".input_box").blur(function () {
        var allInputsFilled = true;

    // 모든 "input_box" 입력란을 반복하고 비어 있는지 확인
    $(".input_box").each(function () {
        if ($(this).val().trim() === '') {
            allInputsFilled = false;
            return false; // 하나라도 비어 있으면 루프 종료
        }
    });

        // 모든 입력란이 채워져 있으면 "request_btn" 버튼 활성화, 그렇지 않으면 비활성화
        if (allInputsFilled) {
            $("#request_btn").prop("disabled", false);
        } else {
            $("#request_btn").prop("disabled", true);
        }
    });
	
  	//NullCheck종료
	
	
	$("#request_btn").click(function(){
		
    	var getId= RegExp(/^[a-z0-9]{4,16}$/);
    	var getPw= RegExp(/^(?=.*[a-z])(?=.*[0-9]).{8,16}$/);
    	var getName= RegExp(/^[가-힣]+$/);
    	var getBirth= RegExp(/^(19|20)[0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1-2][0-9]|3[0-1])$/);
    	var getCel= RegExp(/^01[0179][0-9]{7,8}$/);

		//중복확인 검사
		if($("#idDupFlag").val() == 0){
	      	$("#warningBox").show();
		  	$("#warningBox").html("<p>" + $('#id').val() + "은 중복확인 되지 않은 아이디 입니다.\n중복확인을 수행해 주세요.</p>");
			return;
		}//end if
		
		// 아이디 유효성검사
		if(!getId.test($("#id").val())) {
	        $("#warningBox").show();
		    $("#warningBox").html("<p>아이디는 4~16자, 영문(소문자), 숫자만 가능합니다.</p>");
	        $("#id").val("");
	        $("#id").focus();
	        return false;
	      }
	      
	
		// 비밀번호 유효성검사
	    if(!getPw.test($("#password").val())) {
	    	$("#warningBox").show();
		    $("#warningBox").html("<p>비밀번호는 8~16자 영문(소문자), 숫자 를혼합해서 사용해야 됩니다.</p>");
	        $("#password").val("");
	        $("#password").focus();
	        return false;
	      }
	         
	 	// 아이디 비밀번호 같음 확인
	    if($("#id").val() == $("#password").val()) {
	    	$("#warningBox").show();
		    $("#warningBox").html("<p>아이디와 비밀번호가 같습니다.</p>");
	        $("#password").val("");
	        $("#password").focus();
	        return false;
	      }
		
		// 비밀번호 확인
	    if($("#password").val() != $("#re_password").val()){
		      $("#warningBox").show();
			  $("#warningBox").html("<p>비밀번호가 다릅니다. 다시 입력해주세요.</p>");
	          $("#password").val("");
	          $("#re_password").val("");
	          $("#password").focus();
	          return false;
	      }
	          
		// 이름 유효성 검사
	    if(!getName.test($("#name").val())){
	      	$("#warningBox").show();
		  	$("#warningBox").html("<p>이름은 한글만 입력 가능합니다.</p>");
	        $("#name").val("");
	        $("#name").focus();
	        return false;
	      }
		
	  	//생년월일 유효성 검사
	    if(!getBirth.test($("#birthdate").val())){
	      	$("#warningBox").show();
		  	$("#warningBox").html("<p>올바른 생년월일을 입력해주세요.</p>");
	        $("#birthdate").val("");
	        $("#birthdate").focus();
	        return false;
	      }
	  
		//전화번호 유효성 검사
	    if(!getCel.test($("#cel").val())){
	      	$("#warningBox").show();
		  	$("#warningBox").html("<p>올바른 전화번호를 입력해주세요.</p>");
	        $("#cel").val("");
	        $("#cel").focus();
	        return false;
	      }
		
		$("#frm").submit();
	});//click
	
	
	
	
	
});//ready
</script>
</head>
<body>
<div class="wrap">
    <%@ include file="../common/jsp/header.jsp" %>
    
    <div class="content_wrap">

        <div class="signup_form_wrap">
            <h1>회원가입</h1>
            <form action="signup_next_request.jsp" name="frm" id="frm"  method="post">
				<div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-person" viewBox="0 0 16 16"><path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6Zm2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0Zm4 8c0 1-1 1-1 1H3s-1 0-1-1 1-4 6-4 6 3 6 4Zm-1-.004c-.001-.246-.154-.986-.832-1.664C11.516 10.68 10.289 10 8 10c-2.29 0-3.516.68-4.168 1.332-.678.678-.83 1.418-.832 1.664h10Z"/></svg></label>
					<input type="text" placeholder="아이디" name="id" class="input_box" id="id">
					<input type="button" value="중복확인" class="btn btn-warning btn_check" id="btnDup">
					<input type="hidden" id="idDupFlag" name="idDupFlag"/>
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
					<input type="text" placeholder="이름" name="name" class="input_box" id="name">
				</div>
				<div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-calendar-check" viewBox="0 0 16 16"><path d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0z"/><path d="M3.5 0a.5.5 0 0 1 .5.5V1h8V.5a.5.5 0 0 1 1 0V1h1a2 2 0 0 1 2 2v11a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V3a2 2 0 0 1 2-2h1V.5a.5.5 0 0 1 .5-.5zM1 4v10a1 1 0 0 0 1 1h12a1 1 0 0 0 1-1V4H1z"/></svg></label>
					<input type="text" placeholder="생년월일 8자리" name="birthdate" class="input_box" id="birthdate" maxlength="8">
				</div>
				<div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-phone" viewBox="0 0 16 16"><path d="M11 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1h6zM5 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h6a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2H5z"/><path d="M8 14a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/></svg></label>
					<input type="text" placeholder="휴대전화번호" name="tel" class="input_box" id="cel" maxlength="11">
				</div>
				<div class="input_area flex">
					<label class="input_area_img"><svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-house" viewBox="0 0 16 16"><path d="M8.707 1.5a1 1 0 0 0-1.414 0L.646 8.146a.5.5 0 0 0 .708.708L2 8.207V13.5A1.5 1.5 0 0 0 3.5 15h9a1.5 1.5 0 0 0 1.5-1.5V8.207l.646.647a.5.5 0 0 0 .708-.708L13 5.793V2.5a.5.5 0 0 0-.5-.5h-1a.5.5 0 0 0-.5.5v1.293L8.707 1.5ZM13 7.207V13.5a.5.5 0 0 1-.5.5h-9a.5.5 0 0 1-.5-.5V7.207l5-5 5 5Z"/></svg></label>
					<input type="text" placeholder="우편번호" name="zipcode" class="input_box" id="zipcode" readonly="readonly">
					<input type="button" value="우편번호검색" class="btn btn-warning btn_check" id="btnZipcode">
				</div>
				<div class="input_area flex reverse">
					
					<input type="text" placeholder="주소" name="addr" class="input_box small_input_box" id="addr" readonly="readonly">
				</div>
				<div class="input_area flex reverse">
					
					<input type="text" placeholder="상세주소" name="addrdetail" class="input_box small_input_box" id="addr_d" >
				</div>
				
				<div class="textBox" id="warningBox"></div>

            	<input type="button" value="가입요청" class="btn btn-warning request_btn" id="request_btn">
            </form>
            
        </div>

    </div>

	<%@ include file="../common/jsp/footer.jsp" %>
	
</div>
      
</body>
</html>