let a = String(Math.floor(Math.random() * 10));
let b = String(Math.floor(Math.random() * 10));
let c = String(Math.floor(Math.random() * 10));
let d = String(Math.floor(Math.random() * 10));
let e = a + b + c + d;
let nick_bool = false;
$(function(){
	/*인증메일 보내는 함수*/
	$(".in_btn").on("click", function () {
		
		
	Email.send(
				"prune2020@naver.com", //보내는 이메일 계정
				$("#email_1").val() + "@" + $("#email_2").val(), //받는 이메일 계정
				"이메일인증메일",
				e,
				"smtp.naver.com", //네이버 smtp
				"prune2020", //네이버 아이디
		"Sksmsqhfk1313!")
		alert("이메일이 전송됐습니다.");
		console.log(e);
		
		

		
	
	});
	

 
 
    	 

    	  

	
	
	/*이메일 인증 버튼 누르면*/
	$(".input_btn").on("click",function(){
		
		if($(".innum").val() == e){
			alert("확인되었습니다.")
			$("#isemailCheck").val("ok")
		}else{
			alert("번호가 틀렸습니다.")
		}
	});
	
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
	
	function nickChk() {
	    let nick = document.getElementById("nick");
	    let nickChk = document.getElementById("nick");
	    let exptext = /^[가-힣a-zA-Z0-9]{1,20}$/;
	    if (exptext.test(nick.value)) {
	        nickChk.innerHTML = "";
	        nick_bool = true;
	    } else {
	        nickChk.innerHTML = "아이디를 형식에 맞게 입력하세요.";
	        nick_bool = false;
	    }
	}	
	
	//이메일 확인
		$("#email_1").on("keyup", function(){
		$("#isemailCheck").val("no");
	$("#checkMsg").html("");
		return false
	});
});
	
	
function regCheck() {
    let pwCheck = RegExp(/^.*(?=^.{8,20}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/);
    let mailCheck = RegExp(/^[a-zA-Z0-9\.\-]+/);
    let emailCheck = RegExp(/^[a-zA-Z0-9\-]+\.[a-zA-Z0-9\-]+/);
    let hpCheck = RegExp(/^\d{3}-\d{3,4}-\d{4}$/);
    
    if($("#nick").val() == "" ){
	      
        alert("닉네임을 입력해주세요");
        $("#nick").focus();
        return false;
    }

    if($("#Kpw1").val() != "" && !pwCheck.test($("#Kpw1").val())){
        // 비밀번호 칸이 비어있지 않고 양식에 맞지 않을 경우 실행
        alert("비밀번호 양식을 확인해주세요");
        $("#Kpw1").focus();
        $("input[type='text']").css("border","1px solid #ccc");
        $("#Kpw1").css("border","2px solid red");
        return false;
    }
    if($("#Kpw1").val() != $("#Kpw2").val()) {
        alert("비밀번호를 똑같이 입력해주세요");
        $("#Kpw2").focus();
        $("input[type='text']").css("border","1px solid #ccc");
        $("#Kpw1").css("border","2px solid red");
        $("#Kpw2").css("border","2px solid red");
        return false;
    }

    if($("#email_1").val() != "" && !mailCheck.test($("#email_1").val())) {
        alert("이메일 양식을 확인해주세요");
        $("#email_1").focus();
        $("input[type='text']").css("border","1px solid #ccc");
        $("input[type='password']").css("border","1px solid #ccc");
        $("#email_1").css("border","2px solid red");
        return false;
    }
    if($("#email_1").val() != "" && !emailCheck.test($("#email_2").val())) {
        alert("이메일 양식을 확인해주세요");
        $("#email_2").focus();
        $("input[type='text']").css("border","1px solid #ccc");
        $("input[type='password']").css("border","1px solid #ccc");
        $("#email_2").css("border","2px solid red");
        return false;
    }
    if($("#modi_hp").val() != "" && !hpCheck.test($("#modi_hp").val())) {
        alert("' - ' 하이픈을 사용해서 정확히 입력해주세요");
        $("#modi_hp").focus();
        $("input[type='text']").css("border","1px solid #ccc");
        $("input[type='password']").css("border","1px solid #ccc");
        $("#modi_hp").css("border","2px solid red");
        return false;
    }

    	

	 if($("#isemailCheck").val()=="no") {
		 
	       alert("이메일 인증을 확인해주세요.");
	       $("#email3").focus();
	      return false;
	    }
    
	    if ($("#isnickCheck").val()=="no") {
	        alert("닉네임을 입력해주세요.");
	        $("#nick").focus();
	        return false;
	    }
	    
	    if($("#isnickCheck").val() == "" ){
	        // 비밀번호 칸이 비어있지 않고 양식에 맞지 않을 경우 실행
	        alert("닉네임을 입력해주세요");
	        
	        return false;
	    }
	  
	    
}
 