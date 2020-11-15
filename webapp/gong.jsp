<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page isELIgnored="false"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="noticeDTO" class="com.koreait.notice.NoticeDTO" />
<jsp:useBean id="noticeDAO" class="com.koreait.notice.NoticeDAO" />
<c:set var="noticeList" value="${noticeDAO.selectNotice() }" />
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="./jquery-3.5.1.min.js"></script>
    <script type="text/javascript" src="./js/script.js"></script>
    <title>배달의 민족</title>
    <link href="./css/style.css" rel="stylesheet" type="text/css">
<style>
		*{margin:0; padding:0;}
       .hideline { padding: 0 120px 0 150px; margin 0; }
       .okup { width: 40px; height: auto; display: none; position: absolute; right: 3.3%; }       
</style>    
</head>
<body>
    <div class="gong_cont">
        <div>
            <h1 id="notice_not">공지사항</h1>
            <p id="qna_tes"><span id="small_not"><img src="images/deco_line.png">배달의 민족 공지사항 입니다</span></p>
        </div>
        <div class="box_inner">
            <div id="menutitle">
                <div class="titlef">
                    Notice
                </div>
            </div>
            <div id="question_cont2">
                <ul>
                    <li class="menuline">
                        <div class="menulef">No</div>
                        <div class="menucen">내용</div>
                        <div class="menurig">펼쳐보기</div>
                    </li>
				<c:forEach var="item" items="${noticeList }" varStatus="status">
					<c:if test="${param.n_name != item.n_title}">
						<li>
	                        <div class="menulef">${item.n_idx }</div>
	                        <div class="menucen">${item.n_title }</div>
	                        <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" class="btn_gong"></button></div>
	                       <img src="./images/qnadup.png" class="okup">
	                    </li>
	                    <li class="hideline" style="display:none; word-break: break-all;">
	                       <p>${item.n_content }</p>
	                    </li>
					</c:if>
					<c:if test="${param.n_name == item.n_title}">
						<li>
	                        <div class="menulef">${item.n_idx }</div>
	                        <div class="menucen">${item.n_title }</div>
	                        <div class="menurig"><button class="orderHistoryBtn"><img src="./images/qnad.png" alt="펼쳐보기" class="btn_gong"></button></div>
	                       <img src="./images/qnadup.png" class="okup">
	                    </li>
	                    <li class="hideline" style="display:block; word-break: break-all;">
	                       <p>${item.n_content }</p>
	                    </li>
					</c:if>
				</c:forEach>
                </ul>
            </div>
            <p></p>
        </div>
   </div>
</body>
</html>

