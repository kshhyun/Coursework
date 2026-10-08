<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- jstl 라이브러리 추가-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

	
</head>
<body>
	<h2> JSTL 연습 페이지 </h2>
	<hr>
	<h3> c: if 연습 </h3>
	
	<c:set value="hong" var="user" />
	<p> user: ${user} </p>
	
	<c:if test="${user == 'hong'}" var="result">
		<p> body content : result : ${result} </p>
	</c:if>
	
	<c:if test="${user == dong}" var="result">
		<p> if문 안 : result : ${result} </p>
	</c:if>
	<p> if문 밖 : result : ${result} </p>
	
	<hr>
	<h3>c:forEach 연습</h3>
	
	<c:forEach var="i" begin="0" end="4">
		i -> ${i} <br>
	</c:forEach>
	<hr>
	<c:forEach var="i" begin="0" end="4" step="${i+2}">
			i -> ${i} <br>
	</c:forEach>
	<hr>
	<h3> c:forEach : 콜렉션 객체의 크기만큼 for문 이용 반복 </h3>
	
	<!--
		ctrl + shift + / : 자동 주석
		jsp:useBean : ProductDo로부터 product 이름의 객체를 생성해주는 jsp 태그
	-->
	<jsp:useBean id = "productList" class="com.springboot.webapp.model.ProductDo"/>
	<c:forEach var ="product" items="${productList.getProductList()}">
		${product} <br>
	</c:forEach>
	
	<hr>
	<select>
		<c:forEach var ="product" items="${productList.getProductList()}">
			<option> ${product} </option>
		</c:forEach>
	</select>
	
	
	
	
	
	
	
	
</body>
</html>
