function func1(i){
    let iframe = document.getElementById("question123")
    switch(i){
        case 'no1':
            iframe.setAttribute('src','top10.jsp');
            break;
        case 'no2':
            iframe.setAttribute('src','inquire_signup.jsp');
            break;
        case 'no3':
            iframe.setAttribute('src','inquire_payment.jsp');
            break;
        case 'no4':
            iframe.setAttribute('src','inquire_review.jsp');
            break;
        case 'no5':
            iframe.setAttribute('src','inquire_help.jsp');
            break;
        case 'no6':
            iframe.setAttribute('src','inquire_list.jsp');
            break;
        case 'no7':
            iframe.setAttribute('src','inquire_etc.jsp');
            break;
    }
}

$(function(){
    $(window).scroll(function(){//스크롤하면 아래 코드 실행
     var num = $(this).scrollTop(); // 스크롤값
     if( num > 177 ){ // 스크롤을?177이상 했을?때
        $("#order_list").css("position","fixed");
              $("#order_list").css("top","10px");
     }else{
        $("#order_list").css("position","absolute");
             $("#order_list").css("top","177px");
     }
     });
    });
 function setCookie(name, value) {//쿠키만들기 기간은 하루
     var date = new Date();
     date.setTime(date.getTime() + 24 * 60 * 60 * 1000);
     document.cookie = name + '=' + value + ';expires=' + date.toUTCString() + ';path=/';
 }

 function getCookie(name) {//쿠키의 value를 리턴해주는 함수. 이것을 이용하여 set시키자
     var value = document.cookie.match('(^|;) ?' + name + '=([^;]*)(;|$)');
     return value ? value[2] : null;
 }

 $(".search_a").on("click", function (e) {
     var sWidth = window.innerWidth;
     var sHeight = window.innerHeight;

     var oWidth = $('.search_div').width();
     var oHeight = $('.search_div').height();

     var divLeft = e.clientX + 10;
     var divTop = e.clientY + 5;

     if (divLeft + oWidth > sWidth) divLeft -= oWidth;
     if (divTop + oHeight > sHeight) divTop -= oHeight;

     if (divLeft < 0) divLeft = 0;
     if (divTop < 0) divTop = 0;

     $('.search_div').css({
         "top": divTop,
         "left": divLeft,
         "position": "absolute"
     })
     $(".search_div").stop().fadeToggle(200); //팝업창 뜨는 속도
     return false; //중요
 });

 $(document).click(function (e) { //문서 body를 클릭했을때
     if (e.target.className == "search_input") {
         return true
     } // 검색창 누르면 안 닫히게
     if (e.target.className == "search_div") {
         return false
     } //내가 클릭한 요소(target)를 기준으로 상위요소에 .share-pop이 없으면 (갯수가 0이라면)
     $(".search_div").stop().fadeOut(500);
 });


 $(document).on("click", "#sh-link", function (e) { // 링크복사 시 화면 크기 고정 
     $('html').find('meta[name=viewport]').attr('content',
         'width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no');
     var html = "<input id='clip_target' type='text' value='' style='position:absolute;top:-9999em;'/>";
     $(this).append(html);
     var input_clip = document.getElementById("clip_target"); //현재 url 가져오기 
     var _url = $(location).attr('href');
     $("#clip_target").val(_url);
     if (navigator.userAgent.match(/(iPod|iPhone|iPad)/)) {
         var editable = input_clip.contentEditable;
         var readOnly = input_clip.readOnly;
         input_clip.contentEditable = true;
         input_clip.readOnly = false;
         var range = document.createRange();
         range.selectNodeContents(input_clip);
         var selection = window.getSelection();
         selection.removeAllRanges();
         selection.addRange(range);
         input_clip.setSelectionRange(0, 999999);
         input_clip.contentEditable = editable;
         input_clip.readOnly = readOnly;
     } else {
         input_clip.select();
     }
     try {
         var successful = document.execCommand('copy');
         input_clip.blur();
         if (successful) {
             alert("URL이 복사 되었습니다. 원하시는 곳에 붙여넣기 해 주세요."); // 링크복사 시 화면 크기 고정 
             $('html').find('meta[name=viewport]').attr('content',
                 'width=device-width,initial-scale=1.0,minimum-scale=1.0,maximum-scale=1.0,user-scalable=yes'
             );
         } else {
             alert('이 브라우저는 지원하지 않습니다.');
         }
     } catch (err) {
         alert('이 브라우저는 지원하지 않습니다.');
     }
 }); //클립보드 복사

 //주문표
 $(function(){
     let totPrice=0;
     let forcookie ="";
     let cookieP ="";
     let cnt=1;
     let op="";
     let str="";
     let mStr ="";
 $(".add_menu").on("click",function(){//금액 추가
    $(".menuOption").css({"display":"none"});
    $(this).parents(".menu_controll").next().css({"display":"inline-block"});
    $(".s_num").text(0)
    $(".m_num").text(1)
    $(".option_chk").prop("checked",false);
     let modiPrice = $(this).find(".menu_price").text();
     modiPrice = modiPrice.replace(",","");
     totPrice =modiPrice;
     $(".m_price").text(modiPrice);
     $(this).parents(".menu_controll").next().find(".tot_price").text(totPrice);
     $("#kf_pay").val(totPrice);
 });
 $('input').mouseup(function(){
     let before = $('input[name='+$(this).parent().prev().text()+']:checked').val();
	  if(!$(this).is(":checked")){
      if(before == undefined){
          before = 0;
      }else{//라디오버튼 이전값을 빼고
         before = $('input[name='+$(this).parent().prev().text()+']:checked').val();
         totPrice= Number($(this).parents(".menuOption").find(".tot_price").text())
         totPrice -= Number(before);
         $(".tot_price").text(totPrice);
      }
	  }else{}
  }).change(function(){//이후값을 추가한다.
      let after =$('input[name='+$(this).parent().prev().text()+']:checked').val();
      totPrice =Number($(this).parents(".menuOption").find(".tot_price").text())
      totPrice +=Number(after)
      $(".tot_price").text(totPrice);
      $("#kf_pay").val(totPrice);
  });
 
 $(".close_order").on("click",function(){//옵션닫기
    
    $(".menuOption").css({"display":"none"});
 })
 
 
 $("#quantity").on('click', "button", function () {//아이템 삭제
   let getNum = $(this).parent().index()
   let tot_p_num = Number($("#tot_price").text())-Number($(this).parents("#order_list").find("#tb_price").find('p').eq(getNum).text())
    $("#hiddenContainer").find('p').eq(getNum).remove();
	$(this).parents("#order_list").find("#tb_order").find('p').eq(getNum).remove();
	$(this).parents("#order_list").find("#tb_price").find('p').eq(getNum).remove();
	$("#order_list").find("#tot_price").text(tot_p_num)
	$(this).parent().remove();
	$("#kf_pay").val(tot_p_num);
 });
 
 $(".MplusOne").on("click",function(){//메뉴+1
    let p = Number($(this).prev().text())
    $(this).prev().text(p+1)
    let t_price = Number($(this).parents(".menuOption").find(".tot_price").text());
    t_price += Number($(this).parents(".menuOption").find(".m_price").text());
    $(this).parents(".menuOption").find(".tot_price").text(t_price)
    $("#kf_pay").val(t_price);
 });

 $(".MminusOne").on("click",function(){//메뉴-1
    let m = Number($(this).next().text())
    if((m-1)>0){
       $(this).next().text(m-1)
       let t_price = Number($(this).parents(".menuOption").find(".tot_price").text());
    t_price -= Number($(this).parents(".menuOption").find(".m_price").text());
    $(this).parents(".menuOption").find(".tot_price").text(t_price)
    $("#kf_pay").val(t_price);
    }else{
       $(this).next().text(1)
    }
 });
 
 $(".SplusOne").on("click",function(){//사이드+1
    let p = Number($(this).prev().text())
    $(this).prev().text(p+1)
       let t_price = Number($(this).parents(".menuOption").find(".tot_price").text());
       t_price += Number($(this).siblings(".findSide").find(".s_price").text());
       $(this).parents(".menuOption").find(".tot_price").text(t_price)
       $("#kf_pay").val(t_price);
 })
 
 $(".SminusOne").on("click",function(){//사이드-1
    let m = Number($(this).next().text())
    if((m-1)>=0){
       $(this).next().text(m-1)
       let t_price = Number($(this).parents(".menuOption").find(".tot_price").text());
       t_price -= Number($(this).siblings(".findSide").find(".s_price").text());
       $(this).parents(".menuOption").find(".tot_price").text(t_price)
    }else{
       $(this).next().text(0)
       $("#kf_pay").val(t_price);
    }
 });
let Ccnt =0;
 $(".add_order").on("click",function(){//옵션주문하기 추가했을때      
    let i=0;
    let j=0;
    let option="";
    let side="";
    $(".s_num").each(function(){
       if($("#sideQ"+j).text()>0){
          side += "/"+$("#sideN"+j).text()+"("+$("#sideQ"+j).text()+")"
       }
       j++
    })
    $(".o_name").each(function(){//옵션 추가하는 함수
       if($("input:radio[id=op"+i+"]").is(":checked")){
          option +="(" + $("input:radio[id=op"+i+"]").parent().text()+")"
       }
       i++;
    })
    
   let move_totalPrice_to_orderList = Number($(this).parents(".menuOption").find(".tot_price").text());//total price
   let move_menuName_to_orderList = $(this).parents(".menuOption").find(".m_name").text();//메뉴이름
   let how_many_menuOrder = $(this).parent().prev().find(".m_num").text();
       let price_i_picked = Number($("#order_list").find("#tot_price").text()) + move_totalPrice_to_orderList
   $("#order_list").find("#tb_order").append("<p>"+move_menuName_to_orderList+"<br>"+option+"<br>"+side+"</p></span>");//메뉴이름/옵션/사이드 추가
     //hidden에 값 추가
       $("#pay_name").val(move_menuName_to_orderList);
       $("#pay_option").val(option);
       $("#pay_side").val(side);
       //
   $("#order_list").find("#tb_price").append("<p>"+move_totalPrice_to_orderList+"</p>");//메뉴가격
   $("#order_list").find("#quantity").append("<p>"+how_many_menuOrder+"개"+"<button></button></p>");//개수
   $("#order_list").find("#tot_price").text(price_i_picked)
   $("#hiddenContainer").append("<p><input type='hidden' name='hiddenMenu' value='"+move_menuName_to_orderList+"<br>"+option+"<br>"+side+"'><input type='hidden' name='hiddenQuantity' value='"+how_many_menuOrder+"'></p>")
   $("#kf_pay").val(price_i_picked);
   $("#pay_howmany").val(how_many_menuOrder);
   i=0;
   j=0;
   $(".menuOption").css({"display":"none"});
 });
 
 $("#go_to_pay").on("click",function(){
    location.href="pay.jsp";
 })
 
});
 // 공지사항 gong.jsp
 $(function(){
	$(".btn_gong").on("click", function(){
    $(".hideline").css({"display":"none"});
    $(".okup").css({"display":"none"});
    $(".btn_gong").css({"display":"block"});
    $(this).parents('li').next(".hideline").css({"display":"block"});
  $(this).parents('div').next().css({"display":"block"});
  $(this).css({"display":"none"});
 });

 $(".okup").on("click", function(){
  $(this).parent().next().css({"display":"none"});
  $(this).css({"display":"none"});
  $(this).prev().find(".btn_gong").css({"display":"block"});
 });
 })
