  $(function () {
			/* 아이디 부분과 비밀번호 찾기 부분을 클릭하면 해당 정보를 입력할 수 있게 보여줌*/		
      $("#btnPw").on("click", function () {
          $(".find_id").css("borderBottom", "3px solid #2AC1BC");
          $(".find_id").css("backgroundColor", "#ccc");
          $(".find_pw").css("backgroundColor", "#2AC1BC");
          $("#id_bo").css("display", "none");
          $("#pw_bo").css("display", "block");
      });

      $("#btnId").on("click", function () {
          $(".find_pw").css("borderBottom", "3px solid #2AC1BC");
          $(".find_pw").css("backgroundColor", "#ccc");
          $(".find_id").css("backgroundColor", "#2AC1BC");
          $("#id_bo").css("display", "block");
          $("#pw_bo").css("display", "none");
      });	
  })