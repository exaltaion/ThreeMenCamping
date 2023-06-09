<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="camping.dao.OrderDao"%>
<%@ page import="camping.dao.ReservationDao"%>
<%@ include file="header2.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>결제 페이지</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-Zenh87qX5JnK2Jl0vWa8Ck2rdkQ2Bzep5IDxbcnCeuOxjzrPF/et3URy9Bv1WTRi"
	crossorigin="anonymous">
<script src="https://js.tosspayments.com/v1/payment"></script>
<style>
@import url(//fonts.googleapis.com/earlyaccess/notosanskr.css);

body {
	font-family: 'Noto Sans KR', sans-serif;
}

.mb2 {
	margin-bottom: 25px;
}

.gray {
	color: rgb(78, 89, 104);
	font-size: 13px;
}

.red {
	color: rgb(240, 68, 82);
	font-size: 13px;
}

.box_section {
	background-color: white;
	border-radius: 10px;
	box-shadow: 0 10px 20px rgb(0 0 0/ 1%), 0 6px 6px rgb(0 0 0/ 6%);
}
.container {
	margin-top:80px;
}
</style>
</head>

<body class="bg-light">
<%
	request.setCharacterEncoding("UTF-8"); //한글 정상 인식을 위해 써준다.
	int id = Integer.parseInt(request.getParameter("id"));
	
	OrderDao orderDao = new OrderDao();
	String cpname = orderDao.getCampName(id);
	ReservationDao reservationDao = new ReservationDao();
	String username =  reservationDao.getUserName(id);
	int amount = orderDao.getAmount(id);
	
 %>
	<div class="container">
		<div class="row">
			<div class="col-md-3"></div>

			<div class="col-md-6">

				<h2 style="margin-top: 10px; padding: 20px 0px 10px 0px; text-align: center;">
					<img width="45px" src="https://static.toss.im/3d-emojis/u1F60E-apng.png">
					<img width="45px" src="https://static.toss.im/3d-emojis/u1F60E-apng.png">
					<img width="45px" src="https://static.toss.im/3d-emojis/u1F60E-apng.png">
					삼남자 캠핑 결제 페이지
				</h2>

				<div id="requestPayment_form" class="box_section"
					style="padding: 40px 30px 50px 30px; margin-top: 30px; margin-bottom: 50px">

					<label class="form-label" for="paymentType">결제수단
					<span class="gray">(payType)</span></label>
					<select id="paymentType" class="form-select form-control-lg mb2">
						<option value="토스페이" selected="selected">토스페이</option>
						<option value="카드">카드</option>
						<option value="계좌이체">계좌이체</option>
						<option value="가상계좌">가상계좌</option>
						<option value="휴대폰">휴대폰</option>
						<option value="문화상품권">문화상품권</option>
						<option value="도서문화상품권">도서문화상품권</option>
						<option value="게임문화상품권">게임문화상품권</option>
					</select>

					<div class="mb2">
						<label class="form-label" for="orderId">주문번호
						<span class="gray">(order_no)</span></label>
						<input id="orderId" class="form-control form-control-lg" type="text" readonly="readonly">
					</div>
					<form name="userInfoForm" action="success.jsp">
						<div class="mb2">
							<label class="form-label" for="r_number">예약번호 <span
								class="gray">(reservation_no) </span></label> <input
								id="r_number" class="form-control form-control-lg" type="text"
								name="r_number" value="<%=id%>" readonly="readonly">
						</div>
					</form>

					<div class="mb2">
						<label class="form-label" for="orderName">캠핑장명 <span
							class="gray">(CampName) </span></label> <input
							id="orderName" class="form-control form-control-lg" type="text"
							value="<%=cpname %>" readonly="readonly">
					</div>

					<div class="mb2">
						<label class="form-label" for="amount">금액 <span
							class="gray">(amount) </span></label> <input
							id="amount" class="form-control form-control-lg" type="text"
							value="<%=amount %>" readonly="readonly">
					</div>

					<div class="mb2">
						<label class="form-label" for="customerName">구매자명 <span
							class="gray">(customerName)</span></label> <input id="customerName"
							class="form-control form-control-lg" type="text" value="<%=username %>" name="customerName" readonly="readonly">
					</div>

					<div class="d-grid gap-2">
						<button id="requestPayment" type="button"
							class="btn btn-lg btn-primary">결제하기</button>
					</div>

				</div>
				<div class="col-md-3"></div>
			</div>
		</div>
	</div>
<%@ include file="footer2.jsp"%>	
</body>
<script>
  /* =================================  API KEY 세팅 ================================== */
  let clientKey = 'test_ck_D5GePWvyJnrK0W0k6q8gLzN97Eoq'; // [TODO] https://developers.tosspayments.com 로그인 후 API Key발급 가능
  let tossPayments = TossPayments(clientKey);


  /* =================================  결제데이터 ================================== */
  /* 각 파라미터별 세부 내용은 다음 링크 참고 https://docs.tosspayments.com/reference/js-sdk */
  let paymentData = ["공통", "카드", "가상계좌", "계좌이체", "휴대폰", "문화상품권", "도서상품권", "게임문화상품권", "토스페이"];
  let currentURL = window.location.protocol + "//" + window.location.host + window.location.pathname;

  paymentData["공통"] = {
    "amount": "",
    "orderId": "",
    "orderName": "",
    "customerName": "",
    "customerEmail": "",
    "customerMobilePhone": null,
    "successUrl": "http://localhost:8080/ThreeMenCamping/" + "success.jsp?id="+<%=id%>,
    "failUrl": "http://localhost:8080/ThreeMenCamping/" + "fail.jsp",
    "windowTarget": "iframe",
    "taxFreeAmount": null,
    "cultureExpense": false
  }

  paymentData["카드"] = {
    "cardCompany": null,
    "cardInstallmentPlan": null,
    "maxCardInstallmentPlan": null,
    "freeInstallmentPlans": null,
    "useCardPoint": false,
    "useAppCardOnly": false,
    "useInternationalCardOnly": false,
    "flowMode": "DEFAULT",
    "easyPay": null,
    "discountCode": null,
    "appScheme": null
  }

  paymentData["가상계좌"] = {
    "validHours": 72,
    "cashReceipt": {
      "type": "소득공제"
    },
    "useEscrow": false,
    "escrowProducts": null,
    "currency": "KRW"
  }

  paymentData["계좌이체"] = {
    "cashReceipt": {
      "type": "소득공제"
    },
    "useEscrow": false,
    "escrowProducts": null
  }

  paymentData["휴대폰"] = {
    "mobileCarrier": null // [NOTE] 테스트 환경에서 동작 X
  }


  /* ================== '결제' Btn Event ================== */
  document.getElementById("requestPayment").addEventListener('click', function () {  
	
	let amount = document.getElementById("amount").value;
    let paymentType = document.getElementById("paymentType").value;
    let requestJson = initPaymentsData("공통",paymentType);
    
    tossPayments.requestPayment(paymentType, requestJson)
      .catch(function (error) {
        // 응답 처리 (https://docs.tosspayments.com/reference/js-sdk#응답-처리)
        if (error.code === 'USER_CANCEL') {
          // 결제 고객이 결제창을 닫았을 때 에러 처리
        } else if (error.code === 'INVALID_CARD_COMPANY') {
          // 유효하지 않은 카드 코드에 대한 에러 처리
        }
      })
  })

  /* ================== 페이지 로딩시 실행 ================== */
  document.addEventListener("DOMContentLoaded", function () {
    makeOrderId("ThreeMenCamping");
    document.getElementById('r_number').value = id;
  });

  /* ================= 주문번호(OrderID) 자동생성 =================== */
  function makeOrderId (prefix){
    let x = Math.floor(Math.random() * 100000000);
    document.getElementById("orderId").value = prefix + x;
  }

  /* ============= [공통] + [결제수단] JSON DATA 합치기 ================= */
  function initPaymentsData(general, paymentType){
    paymentData[general].amount = document.getElementById("amount").value;
    paymentData[general].orderId = document.getElementById("orderId").value;
    paymentData[general].orderName = document.getElementById("orderName").value;
    //paymentData[general].userNumber = document.getElementById("userNumber").value;
    //paymentData[general].customerName = document.getElementById("customerName").value;
    //paymentData[general].customerEmail = document.getElementById("customerEmail").value;
    
    return Object.assign(paymentData[general], paymentData[paymentType]);
  }

</script>
</html>