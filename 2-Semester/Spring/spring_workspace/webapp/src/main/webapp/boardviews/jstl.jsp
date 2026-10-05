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
	<p> user: ${user}) </p>
	
	<c:if test="${user == hong}" var="result">
		<p> body content : result : ${result} </p>
	</c:if>
	
	<c:if test="${user == dong}" var="result">
		<p> if문 안 : result : ${result} </p>
	</c:if>
	<p> if문 밖 : result : ${result} </p>
	
</body>
</html>
