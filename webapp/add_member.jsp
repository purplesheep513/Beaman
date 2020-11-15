<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="./css/style.css">

    <script src="./jquery-3.5.1.min.js"></script>
    <script src="https://smtpjs.com/smtp.js"></script>
    <script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <script src="./js/add_member.js"></script>
</head>

<body>
    <form method="post" name="susu" action="add_member_ok.jsp" onsubmit="return checkSignUp()">
        <div class="add_member">
            <div class="add_m_img"><a href="./login.jsp"><img src="./images/logo_web.png" alt="배민"></a></div>
            <div class="add_m_j">
                <p>아이디</p>
                <p>닉네임</p>
                <p>비밀번호/비밀번호확인</p>
                <p>이메일</p>
                <p>인증확인</p>
                <p>이름</p>
                <p>휴대폰번호</p>
                <p>주소</p>
            </div>
            <div class="add_m_c">
                <p><input type="text" name="id" id="id" class="id" placeholder="(4~20자 영문/숫자)" maxlength="20"
                        onkeyup="idChk()"><input type="button" value="중복체크" id="btnUserid" class="button_css"><input type="hidden" value="no" id="isIdCheck" name="memberid"></p>
                <p><input type="text" name="nName" id="nick"><input type="button" value="중복확인" id="nick_btn" name="nick_btn" class="button_css"><input type="hidden" value="ok" id="isnickCheck"></p>
                <p><input type="password" name="pw" id="pw" placeholder="(8~20자 영문/숫자/특문 혼용)" onkeyup="passChk1()"><input type="password" id="pw_re" placeholder="(8~20자 영문/숫자/특문 혼용)" onkeyup="passChk2()"></p>
                <p id="add_member_email">
                    <span><input type="text" name="email1" id="email1" onkeyup="emailChk()"></span>
                    <span>@</span>
                    <span id="email_b"><input type="text" name="email2" id="email2" onkeyup="emailChk2()"></span>
                    <select name="month" id="month" onchange="chageLangSelect()">
                        <option value="#" disabled selected>이메일 선택</option>
                        <option value="naver.com">naver.com</option>
                        <option value="daum.net">daum.net</option>
                        <option value="nate.com">nate.com</option>
                        <option value="hanmail.net">hanmail.net</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="write">직접입력</option>
                    </select>
                    <input type="button" value="인증받기" class="button_css" name="email_checkBtn" id="email_checkBtn">
                </p>
                <p><input type="text" id="email3"><input type="button" value="인증확인" class="button_css" id="btn_inzeungCheck"><input type="hidden" value="no" id="isemailCheck"></p>
                <p><input type="text" name="name" id="name" onkeyup="nameChk()"></p>
                <p>
                    <input type="tel" name="tel" id="tel" onkeyup="telChk()">
                </p>
                <p class="address">
                    <input type="text" name="sample3_postcode" id="sample3_postcode" placeholder="우편번호" onkeyup="codeChk()">
                    <input type="hidden" value="no" id="isaddrCheck" name="memberid">
                    <input type="button" onclick="sample6_execDaumPostcode()" value="주소찾기" id="find_addr">
                </p>
                <p class="inline_b"><input type="text" name="sample3_address" id="sample3_address" placeholder="주소"></p>
                <p class="inline_b"><input type="text" name="sample3_detailAddress" id="sample3_detailAddress" placeholder="상세 주소"></p>
                <div id="wrap"
                    style="display:none;border:1px solid black;width:100%;height:300px;margin:5px 0;position:relative">
                    <img src="https://cdn2.iconfinder.com/data/icons/flaticons-solid/16/x-3-512.png" id="btnFoldWrap"
                        style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1; width: 15px;height: 15px;"
                        onclick="foldDaumPostcode()" alt="접기 버튼">
                </div>
                <p class="check_y" id="big_check"><input type="checkbox" name="chk_all" id="chk_all" class="chk">전체약관에
                    동의합니다.</p>
                <p class="check_y"><input type="checkbox" class="chk" id="chk1" name="chk">개인정보 수집이용에 동의합니다.(필수)</p>
                <p class="check_y"><input type="checkbox" class="chk" id="chk2" value="N" name="chk">광고성 정보 수신에 동의합니다.(선택)</p>
                <p><input type="submit" value="가입완료" name="submit" id="add_mem" ></p>

            </div>
            <div class="add_m_r">
                <p><span id="idChk"></span></p>
                <p><span id="nNameChK"></span></p>
                <p><span id="passChk1"></span><br><span id="passChk2"></span></p>
                <p><span id="emailChk"></span><br>
                <p><span id="emailIS"></span></p>
                <p><span id="nameChk"></span></p>
                <p><span id="telChk"></span></p>
                <p><span id="codeChk"></span></p>
            </div>
        </div>
    </form>
</body>

</html>