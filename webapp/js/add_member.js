/* 정보가 모두 올바르게 쓰였는지 알려주는 불린.(이게 모두 true여야 가입완료버튼클릭가능)*/
let id_bool = false;
let pass1_bool = false;
let name_bool = false;
let email1_bool = false;
let email2_bool = false;
let address_bool = false;

let a = String(Math.floor(Math.random() * 10));
let b = String(Math.floor(Math.random() * 10));
let c = String(Math.floor(Math.random() * 10));
let d = String(Math.floor(Math.random() * 10));
let e = a + b + c + d;


$(function () {
	
	/*아이디중복체크*/
	$("#id").on("keyup", function(){
		$("#isIdCheck").val("no");
		$("#checkMsg").html("");
	});
	
    
	$("#btnUserid").on("click", function(){
		if($("#id").val() == ""){
			alert("아이디를 입력하세요.");
			$("#id").focus();
			return false;
		}
		
		let xhr = new XMLHttpRequest();
		let userid = $("#id").val();
		xhr.open("GET", "idCheck.jsp?userid="+userid, true);
		xhr.send();
		xhr.onreadystatechange = function(){
			if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
				let result = xhr.responseText;
				if(result.trim() == "ok"){
					$("#isIdCheck").val("ok");
					alert("사용가능한 아이디입니다.")
				}else{
					alert("중복되는 아이디입니다.")
					$("#idChk").html("중복되는 아이디입니다.");
				}
			}
		}
	});
	
	
	/*인증메일 보내는 함수*/
    $("#email_checkBtn").on("click", function () {

        Email.send(
            "prune2020@naver.com", //보내는 이메일 계정
            $("#email1").val() + "@" + $("#email2").val(), //받는 이메일 계정
            "이메일인증메일",
            e,
            "smtp.naver.com", //네이버 smtp
            "prune2020", //네이버 아이디
            "Sksmsqhfk1313!");
        alert("이메일이 전송됐습니다.");
        console.log(e);
    })
    
    /*이메일 인증 버튼 누르면*/
    $("#btn_inzeungCheck").on("click",function(){
    	
    	if($("#email3").val() == e){
    		alert("확인되었습니다.")
    		$("#isemailCheck").val("ok")
    	}else{
    		alert("번호가 틀렸습니다.")
    	}
    });

    
    /*전체약관 클릭하면 전부 선택되는 함수 */
     $("#chk_all").on("click", function () {
         if ($("#chk_all").is(":checked")) {
             $(".chk").prop("checked", true);
         } else {
             $(".chk").prop("checked", false);
         }
     });
     $(".chk").on("click", function () {
         if ($("input[name='chk']:checked").length == 2) {
             $("#chk_all").prop("checked", true);
         } else {
             $("#chk_all").prop("checked", false);
         }
     });
     
     
     /*선택약관 누르면 Y내보내는 함수아니면 N임*/
     $("#chk_all").on("click",function(){
         if($("#chk2").prop("checked")==true){
            $("#chk2").val('Y')
         }else{$("#chk2").val('N')}
         console.log($("#chk2").val())
      })
      $("#chk2").on("click",function(){
         if($("#chk2").prop("checked")==true){
            $("#chk2").val('Y')
         }else{$("#chk2").val('N')}
         console.log($("#chk2").val())
      })
      $("#chk1").on("click",function(){
         if($("#chk2").prop("checked")==true){
            $("#chk2").val('Y')
         }else{$("#chk2").val('N')}
         console.log($("#chk2").val())
      })


	       if($("#isnickCheck").val() == "" ){
             
           alert("닉네임을 입력해주세요");
           
           return false;
       }




   /*닉네임중복체크*/
   $("#nick").on("keyup", function(){
      $("#isnickCheck").val("no");
      $("#checkMsg").html("");
   });
   

   
    
   $("#nick_btn").on("click", function(){
      if($("#nick").val() == ""){
         alert("닉네임을 입력하세요.");
         $("#nick").focus();
         return false;
      }
      
      let xhr = new XMLHttpRequest();
      let nick = $("#nick").val();
      xhr.open("GET", "nickCheck.jsp?nick="+nick, true);
      xhr.send();
      xhr.onreadystatechange = function(){
         if(xhr.readyState == XMLHttpRequest.DONE && xhr.status == 200){
            let result = xhr.responseText;
            if(result.trim() == "ok"){
               $("#isnickCheck").val("ok");
               alert("사용가능한 닉네임입니다.")
            }else{
               alert("중복되는 닉네임입니다.")
               $("#nickChk").html("중복되는 닉네임입니다.");
            }
         }
      }
   });
   




})


/*정규식으로 아이디 체크하는 함수*/
function idChk() {
    let id = document.getElementById("id");
    let idChk = document.getElementById("idChk");
    let exptext = /^[a-zA-Z0-9]{4,20}$/;
    if (exptext.test(id.value)) {
        idChk.innerHTML = "";
        id_bool = true;
    } else {
        idChk.innerHTML = "아이디를 형식에 맞게 입력하세요.";
        id_bool = false;
    }
}


/*정규식으로 비밀번호 체크하는 함수*/
function passChk1() {
    let pass1 = document.getElementById("pw");
    let passChk1 = document.getElementById("passChk1");
    let exptext = /^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;
    if (exptext.test(pass1.value)) {
        passChk1.innerHTML = "";
        pass1_bool = true;
    } else {
        passChk1.innerHTML = "비밀번호가 유효하지 않습니다.";
        pass1_bool = false;
    }
}

function passChk2() {
    let pass1 = document.getElementById("pw")
    let pass2 = document.getElementById("pw_re")
    let passChk1 = document.getElementById("passChk1");
    if (pass1.value == pass2.value) {
        passChk1.innerHTML = "";
    } else {
        passChk1.innerHTML = "비밀번호가 일치하지 않습니다.";
    }
}

/*이메일 체크하는 함수*/
function emailChk() {
    let email1 = document.getElementById("email1")
    let emailChk = document.getElementById("emailChk")
    let exptext = /^[a-zA-Z0-9\.\-]+$/;
    if (exptext.test(email1.value)) {
        emailChk.innerHTML = "";
        email1_bool = true;
    } else {
        emailChk.innerHTML = "형식에 맞게 입력하세요.";
        email1_bool = false;
    }
}

/* 이메일 (셀렉트박스에서 선택했을경우or아닐경우) */
function chageLangSelect() {
    let emailChk = document.getElementById("emailChk")
    $("#month option:selected").each(function () {
        if ($(this).val() == "write") { // 직접입력일 경우 
            $("#email2").val(""); //값 초기화 
            $("#email2").attr("disabled", false); // 활성화
        } else { // 직접입력이 아닐경우 
            $("#email2").attr("disabled", true); //비활성화 
            $("#email2").val($(this).val()); // 선택값 입력 
            let email1 = document.getElementById("email1")
            let email2 = document.getElementById("email2")
            let emailChk = document.getElementById("emailChk")
            let exptext2 = /^[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-]+/;
            let exptext1 = /^[a-zA-Z0-9\.\-]+/;
            if (!exptext1.test(email1.value) || !exptext2.test(email2.value)) {
                emailChk.innerHTML = "형식에 맞게 입력하세요.";
                email2_bool = false;
            } else {
                emailChk.innerHTML = "";
                email2_bool = true;
            }
        }
    });
}
/* @뒷부분 체크하는 함수 */
function emailChk2() {
    let email2 = document.getElementById("email2")
    let emailChk = document.getElementById("emailChk")
    let exptext = /^[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-]+/;
    if (exptext.test(email2.value)) {
        emailChk.innerHTML = "";
        email2_bool = true;
    } else {
        emailChk.innerHTML = "형식에 맞게 입력하세요.";
        email2_bool = false;
    }
}

/*이름체크하는함수*/
function nameChk() {
    let name = document.getElementById("name")
    let nameChk = document.getElementById("nameChk")
    let exptext = /^[가-힣]+$/;
    if (exptext.test(name.value)) {
        nameChk.innerHTML = "";
        name_bool = true;
    } else {
        nameChk.innerHTML = "한글만 사용가능합니다.";
        name_bool = false;
    }
}

/*휴대폰번호체크 */
function telChk() {
    let tel = document.getElementById("tel")
    let telChk = document.getElementById("telChk")
    let exptext = /^\d{3}-\d{3,4}-\d{4}$/;
    if (exptext.test(tel.value)) {
        telChk.innerHTML = "";
    } else {
        telChk.innerHTML = "하이픈(-)을 써서 입력하세요.";
    }
}

/*우편번호 입력 */
function codeChk() {
    let zipCode = document.getElementById("sample3_postcode")
    let codeChk = document.getElementById("codeChk")
    let exptext = /^\d{4,6}$/;
    if (exptext.test(zipCode.value)) {
        codeChk.innerHTML = "";
    } else {
        codeChk.innerHTML = "올바른 형식으로 입력하세요.";
    }
}

/* 정보를 제대로 했나 */
function checkSignUp() {
    let pass1 = document.getElementById("pw")
    let pass2 = document.getElementById("pw_re")
    let chkCheck = false;

	if (!name_bool) {
        alert("이름을 확인해주세요.");
        $("#name").focus();
        return false;
    }

	if (!address_bool) {
        alert("주소를 작성해주세요.");
        $("#sample3_postcode").focus();
        return false;
    }

    if ($("input:checkbox[id='chk1']").is(":checked") == true) {
        chkCheck = true;
    }
    if (!chkCheck) {
        alert("필수 약관에 동의해주세요.");
        return false;
    }

    if (!id_bool) {
        alert("아이디를 확인해주세요.");
        $("#id").focus();
        return false;
    }


    if($("#isIdCheck").val() == "no"){
    	alert("아이디 중복체크를 해주세요.");
        return false;
    }

		if($("#nick").val() == "" ){
        alert("닉네임을 입력해주세요");
        $("#nick").focus();
        return false;
    }


    if (!pass1_bool || pass1.value != pass2.value) {
        alert("비밀번호를 확인해주세요.");
        $("#pw").focus();
        return false;
    }

    if (!email1_bool) {
        alert("이메일을 확인해주세요.");
        $("#email1").focus();
        return false;
    }
    if (!email2_bool) {
        alert("이메일을 확인해주세요.");
        $("#email1").focus();
        return false;
    }
    if ($("#isemailCheck").val()=="no") {
        alert("이메일 인증을 확인해주세요.");
        $("#email3").focus();
        return false;
    }
    if (!eamil3_bool) {
        alert("인증번호를 확인해주세요.");
        $("#email_checkBtn").focus();
        return false;
    }


    return true;
}


function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function (data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if (data.userSelectedType === 'R') {
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if (data.buildingName !== '' && data.apartment === 'Y') {
                    extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if (extraAddr !== '') {
                    extraAddr = ' (' + extraAddr + ')';
                }
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample3_postcode').value = data.zonecode;
            document.getElementById("sample3_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample3_detailAddress").focus();
			address_bool = true;
        }
    }).open();
}