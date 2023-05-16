<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    <!-- 사용하는 controller java쪽 클래스들 -->
<%@ page import="camping.dao.PersonDao" %>
<%@ page import="camping.dto.PersonDto" %>
<%@ page import="Controller.mainController" %>

<%@ page import="Controller.ChongchungmainController" %>

<%@ page import="camping.dto.campzone" %>
<%@ page import="camping.dto.emp" %>
<%@ page import="java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

<!-- CSS only -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-rbsA2VBKQhggwzxH7pPCaAqO46MgnOM80zW1RWuH61DGLwZJEdK2Kadq2F9CUG65" crossorigin="anonymous">
<!-- jQuery -->
	 <script
  src="https://code.jquery.com/jquery-3.7.0.js"
  integrity="sha256-JlqSTELeR4TLqP0OG9dxM7yDPqX1ox/HfgiSLBj8+kM="
  crossorigin="anonymous"></script>

</head>
<body>
<%@ include file = "header.jsp" %>
<br><br><br>
<div id="bbsList" style = "text-align: center;">
	<div id="bbsList_title">
	<h1> 서울경기 campDetail (TM_CAMPINGZONE_TM_CAMPINGZONE_Chongchung 서울경기campDetail test) </h1>
	<h2>서울경기Detail(JSP)</h2>
	</div>
	<table class = "table table-striped" border="1">
			<tr>
<!-- 				<td>
					고유번호 cpname
				</td> -->
				<td>
					야영장명 <!-- cpname -->
				</td>
				<td>
					인트로 <!-- cpLineIntro-->
				</td>
				<td>
					입지구분 <!-- cpLctCl -->
				</td>
				<td>
					주소 <!-- addr -->
				</td>
				<td>
					주변이용가능시설 <!-- cpPosblFcltyCl -->
				</td>
				<td>
					전화번호 <!-- cptel -->
				</td>
				<td>
					홈페이지 <!-- cpHomepage -->
				</td>
				<td>
					애완동물출입 <!-- cpAnimalCmgCl -->
				</td>
				<td>
					캠핑장 형태 <!-- cpInduty -->
				</td>
				<td>
					예약하기
				</td>
	<%
	 	request.setCharacterEncoding("UTF-8");
    	String data = request.getParameter("data");
		String aa = "";
		mainController mains = new mainController();
		 aa = mains.TestingApiChongchung(request);
		campzone campzonelist = new campzone();
		//하이퍼 링크를 통하여 넘어온 값을 저장하여 활용.
		campzonelist = mains.ChongchungDBDetail(data);
				
	%>
			<tr>
<%-- 				<td>
					<%out.print(campzonelist.getIdx()); %>
				</td> --%>
				<td>
					<%out.print(campzonelist.getCpname()); %>
				</td>
				<td>
					<%out.print(campzonelist.getCpIntro()); %>
				</td>
				<td>
					<%out.print(campzonelist.getCpLctCl()); %>
				</td>
				<td>
					<%out.print(campzonelist.getAddr()); %>
				</td>
				<td>
					<%out.print(campzonelist.getCpPosblFcltyCl()); %>
				</td>
				<td>
					<%out.print(campzonelist.getCptel()); %>
				</td>
				<td>
					<%out.print(campzonelist.getCpHomepage()); %>
				</td>
				<td>
					<%out.print(campzonelist.getCpAnimalCmgCl()); %>
				</td>
				<td>
					<%out.print(campzonelist.getCpInduty()); %>
				</td>
				<td>
					<button id="<%=campzonelist.getIdx() %>" class="btn btn-primary orderBtn">예약하기</button>
				</td>
			</tr>	
	</table>
</div>

<script>
	 $(document).ready(function () {
		 
         $('.orderBtn').click(function(){
        	 
             let tempId = $(this).attr('id');
             var link = 'http://localhost:8080/ThreeMenCamping/reservation.jsp?id=' +tempId;
             location.href=link; //페이지 이동
         });
  
     });
	 </script>

<!-- JavaScript Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-kenU1KFdBIe4zVF0s0G1M5b4hcpxyD9F7jL+jjXkk+Q2h455rYXK/7HAuoJl+0I4" crossorigin="anonymous"></script>
<%@ include file = "footer.jsp" %>

</body>
</html>