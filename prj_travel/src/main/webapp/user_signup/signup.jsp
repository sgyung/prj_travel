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
<style type="text/css">
.content_wrap {
	margin-top: 100px;
	width: 100%;
}

.terms_wrap {
	width : 50%;
	max-width : 600px;
	height : 1000px;
	margin: 0 auto;
	padding : 50px;
	border: 1px solid rgba(0,0,0,.12);
}

.terms_wrap > h1 {
	text-align: center;
}

.terms_area {
	width: 100%;
	margin-top: 20px;
}

.terms_p {
	width:100%;
}

.terms_p > p {
	text-align: left;
}

.terms_box {
	width:100%;
	height:100px;
	padding:15px;
	overflow:auto;
	border:1px solid #ccc;
	border-radius: 5px;
}

em {
	font-style: normal;
}

.next_btn {
	width:100%;
	height:50px;
	margin-top: 30px;
}

</style>
<script type="text/javascript">
$(function(){
	$("#allcheck").click(function() {
		
        var isChecked = $(this).prop("checked");
        $("input[type='checkbox']").prop("checked", isChecked);
    });
	
	$("#nextBtn").click(function() {
        // Check if the checkbox with id "essential_check" is checked
        var isEssentialChecked = $("#essential_check").prop("checked");

        if (!isEssentialChecked) {
            alert("[필수] 항목을 동의해야 합니다.");
        } else {
            // If the essential checkbox is checked, navigate to signup_next.jsp
            window.location.href = "signup_next.jsp";
        }
    });
	
});//ready
</script>
</head>
<body>
<div class="wrap">
    <%@ include file="../common/jsp/header.jsp" %>
    
    <div class="content_wrap">

        <div class="terms_wrap">
            <h1>회원가입</h1>
            <form action="#">
            
            <div class="terms_area">
	            <div class="terms_name">
		        	<input type="checkbox" id="allcheck">
		            <span>전체 동의하기</span>
	            </div>
	           	<div class="terms_p">
		           	<p>실명 인증된 아이디로 가입, 위치기반서비스 이용약관(선택), 이벤트・혜택 정보 수신(선택) 동의를 포함합니다.</p>
	           	</div>
            </div>
            
            <div class="terms_area">
	            <div class="terms_name">
		        	<input type="checkbox" id="essential_check">
		        	<em>[필수]</em>
		            <span>네이버 이용약관</span>
	            </div>
	           	<div class="terms_box">
		           	<h3>여러분을 환영합니다.</h3>
		           	<p>네이버 서비스 및 제품(이하 ‘서비스’)을 이용해 주셔서 감사합니다. 본 약관은 다양한 네이버 서비스의 이용과 관련하여 네이버 서비스를 제공하는 네이버 주식회사(이하 ‘네이버’)와 이를 이용하는 네이버 서비스 회원(이하 ‘회원’) 또는 비회원과의 관계를 설명하며, 아울러 여러분의 네이버 서비스 이용에 도움이 될 수 있는 유익한 정보를 포함하고 있습니다.</p>
	           	</div>
            </div>
            
            <div class="terms_area">
	            <div class="terms_name">
		        	<input type="checkbox" id="essential_check">
		        	<em>[필수]</em>
		            <span>개인정보 수집 및 이용</span>
	            </div>
	           	<div class="terms_box">
		           	<h3>4. 개인정보 수집 및 이용 동의를 거부할 권리</h3>
		           	<p>이용자는 개인정보의 수집 및 이용 동의를 거부할 권리가 있습니다. 회원가입 시 수집하는 최소한의 개인정보, 즉, 필수 항목에 대한 수집 및 이용 동의를 거부하실 경우, 회원가입이 어려울 수 있습니다.</p>
	           	</div>
            </div>
            
            <div class="terms_area">
	            <div class="terms_name">
		        	<input type="checkbox">
		        	<em>[선택]</em>
		            <span>실명 인증된 아이디로 가입</span>
	            </div>
	           	<div class="terms_box">
		           	<p>실명 인증된 아이디로 가입하시면 본인인증이 필요한 서비스(네이버 페이, 쇼핑, 멤버십 등)를 가입 후 바로 이용하실 수 있어요.</p>
	           	</div>
            </div>
            
            <div class="terms_area">
	            <div class="terms_name">
		        	<input type="checkbox">
		        	<em>[선택]</em>
		            <span>위치기반서비스 이용약관</span>
	            </div>
	           	<div class="terms_box">
	           		
		           	<p>위치기반서비스 이용약관에 동의하시면, 위치를 활용한 광고 정보 수신 등을 포함하는 네이버 위치기반 서비스를 이용할 수 있습니다.</p>
		           	<h3>제 1 조 (목적)</h3>
		           	<p>이 약관은 네이버 주식회사 (이하 “회사”)가 제공하는 위치기반서비스와 관련하여 회사와 개인위치정보주체와의 권리, 의무 및 책임사항, 기타 필요한 사항을 규정함을 목적으로 합니다.</p>
	           	</div>
            </div>
            
            <div class="terms_area">
	            <div class="terms_name">
		        	<input type="checkbox">
		        	<em>[선택]</em>
		            <span>개인정보 수집 및 이용</span>
	            </div>
	           	<div class="terms_p">
		           	<p>이벤트・혜택 정보 수신</p>
	           	</div>
            </div>
            <input type="button" value="다음" class="btn btn-info next_btn" id="nextBtn"> 
            </form>
            
        </div>

    </div>

	<div class="footer">
        <span style="font-size: 60px; color: white; ">FOOTER</span> 
    </div>
	
</div>
      
</body>
</html>