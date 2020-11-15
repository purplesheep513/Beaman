<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.sql.*"%>
<jsp:useBean class="com.koreait.Member.Member_DAO" id="mem_dao" />
<jsp:useBean class="com.koreait.Member.Member" id="member" />

<%
	request.setCharacterEncoding("UTF-8");
String userid ="";
if(session.getAttribute("id") != null){
	userid = (String)session.getAttribute("id");
}
 member = mem_dao.usermodi(member,userid);
%>




<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<link href="css/style_w.css" rel="stylesheet" type="text/css">
<script src="https://smtpjs.com/smtp.js"></script>
<script src="jquery-3.5.1.min.js"></script>
<script src="js/info_modi.js"></script>
<style>
input:focus {
	outline: none
}
</style>
</head>
<body>

	<form name="regForm" method="POST" action="info_modi_ok.jsp"
		onsubmit="return regCheck()">
		<div class="info_modi">
			<div class="add_m_img">
				<a href="#"><img src="./images/logo_web.png" alt="배민"></a>
			</div>
			<div class="input_id">
				<input type="hidden" name="id" value="<%=userid%>">
			</div>
			<div class="modi_IP">
				<p>비밀번호 변경</p>
				<p>비밀번호 확인</p>
			</div>
			<div class="ip_type">
				<p>
					<input type="password" placeholder="영문/숫자를 혼용하여 8자 이상" id="Kpw1"
						name="pw" value="">
				</p>
				<p>
					<input type="password" id="Kpw2" value="">
				</p>
			</div>
			<div class="modi_email">
				<p>이메일 주소 변경</p>
			</div>



			<div class="email_type">
				<p>
					<span><input type="text" id="email_1" name="email1"
						value="<%=member.getEmail1()%>"></span> <span>@</span> <span
						id="email_b"><input type="text" id="email_2" name="email2"
						value="<%=member.getEmail2()%>"></span> <select name="month"
						id="month" onchange="chageLangSelect()">
						<option value="#" disabled selected>이메일 선택</option>
						<option value="naver.com">naver.com</option>
						<option value="daum.net">daum.net</option>
						<option value="nate.com">nate.com</option>
						<option value="hanmail.net">hanmail.net</option>
						<option value="gmail.com">gmail.com</option>
						<option value="#">직접입력</option>
					</select>
					<script>
						function chageLangSelect() {
							var langSelect = document.getElementById("month");
							var selectText = langSelect.options[langSelect.selectedIndex].text;
							var email_b = document.getElementById("email_b");
							if (selectText == "직접입력") {
								email_b.setAttribute('value', '');
								email_b.focus();
							} else {
								email_b.setAttribute('value', selectText);
							}
							$("#email_2").val(selectText);
							if ($("#email_2").val() == "직접입력") {
								$("#email_2").val("");
								$("#email_2").focus();
							}
						}
					</script>


					<input type="button" value="인증받기" class="in_btn">
				<p>
					<span><input type="text" class="innum"></span><input
						type="button" value="인증확인" class="input_btn"><input
						type="hidden" value="ok" id="isemailCheck">
				</p>
				</p>
			</div>
			<div class="ph_modi">
				<p class="ph_font">휴대폰 번호 변경</p>
				<p>기본배송지 변경</p>
			</div>
			<div class="ph_type">
				<p>
					<input type="text" name="tel" id="modi_hp"
						value="<%=member.getTel()%>"
						placeholder="' - ' 하이픈을 사용해서 정확히 입력해주세요">
				</p>
				<p>
					<input type="text" id="sample3_postcode" placeholder="우편번호"
						name="sample3_postcode" value="<%=member.getSample3_postcode()%>">
					<input type="button" onclick="sample3_execDaumPostcode()"
						value="우편번호 찾기" id="find_addr">
				</p>
				<p class="inline_b">
					<input type="text" id="sample3_address" placeholder="주소"
						name="sample3_address" value="<%=member.getSample3_address()%>">
					<input type="text" id="sample3_detailAddress" placeholder="상세 주소"
						name="sample3_detailAddress"
						value="<%=member.getSample3_detailAddress()%>">
				</p>
				<div id="wrap"
					style="display: none; border: 1px solid black; width: 100%; height: 300px; margin: 5px 0; position: relative">
					<img
						src="https://cdn2.iconfinder.com/data/icons/flaticons-solid/16/x-3-512.png"
						id="btnFoldWrap"
						style="cursor: pointer; position: absolute; right: 0px; top: -1px; z-index: 1; width: 15px; height: 15px;"
						onclick="foldDaumPostcode()" alt="접기 버튼">
				</div>

				<script
					src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script>
					// 우편번호 찾기 찾기 화면을 넣을 element
					var element_wrap = document.getElementById('wrap');

					function foldDaumPostcode() {
						// iframe을 넣은 element를 안보이게 한다.
						element_wrap.style.display = 'none';
					}

					function sample3_execDaumPostcode() {
						// 현재 scroll 위치를 저장해놓는다.
						var currentScroll = Math.max(document.body.scrollTop,
								document.documentElement.scrollTop);
						new daum.Postcode(
								{
									oncomplete : function(data) {
										var addr = ''; // 주소 변수

										//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
										if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
											addr = data.roadAddress;
										} else { // 사용자가 지번 주소를 선택했을 경우(J)
											addr = data.roadAddress;
										}

										// 우편번호와 주소 정보를 해당 필드에 넣는다.
										document
												.getElementById('sample3_postcode').value = data.zonecode;
										document
												.getElementById("sample3_address").value = addr;
										// 커서를 상세주소 필드로 이동한다.
										document.getElementById(
												"sample3_detailAddress")
												.focus();

										// iframe을 넣은 element를 안보이게 한다.
										// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
										element_wrap.style.display = 'none';

										// 우편번호 찾기 화면이 보이기 이전으로 scroll 위치를 되돌린다.
										document.body.scrollTop = currentScroll;
									},
									// 우편번호 찾기 화면 크기가 조정되었을때 실행할 코드를 작성하는 부분. iframe을 넣은 element의 높이값을 조정한다.
									onresize : function(size) {
										element_wrap.style.height = size.height
												+ 'px';
									},
									width : '100%',
									height : '100%'
								}).embed(element_wrap);

						// iframe을 넣은 element를 보이게 한다.
						element_wrap.style.display = 'block';
					}
				</script>
			</div>
			<div class="name_modi">
				<p>닉네임변경</p>
			</div>
			<div class="name_type">
				<p>
					<span><input type="text" id="nick" name="nName"
						value="<%=member.getnName()%>" onkeyup="nickChk()"></span><input
						type="button" value="중복확인" id="nick_btn" name="nick_btn"><input
						type="hidden" value="ok" id="isnickCheck">
				</p>
			</div>
			<p class="complete_type">
				<input type="submit" value="수정완료" id="complete_modi">
	
			</p>
			<div class="add_m_r">
				<p>
		
					<span id="nickChk"></span>
				</p>
			</div>
		</div>
	</form>
</body>
</html>