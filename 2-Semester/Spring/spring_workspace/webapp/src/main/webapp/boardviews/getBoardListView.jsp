<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- jstl 라이브러리 추가-->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>getBoardListView</title>
	
	<!--BootStrap 5.1.3ver CSS 라이브러리-->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	
	<!--JavaScript 라이브러리-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	
    <style>
        .form-style {max-width: 1200px;
				margin-top: 40px;
				padding: 32px;
				background-color: rgb(237, 255, 241);
				border-radius: 10px;
				box-shadow: 0 8px 20px rgb(199, 201, 204);
			}
    </style>
	
</head>
<body>
	<div class="container form-style">
		<p class="fs-2 text-center"> 전체 게시판 데이터</p>
		
		<nav class="navbar">
			<div class="container-fluid d-flex justify-content-between">
				<button type="button" class="btn btn-outline-primary"
					onclick="location.href='insertBoard.do'">게시판 추가</button>
				
				<form action="searchBoardList.do" class="d-flex align-items-center">
					<select name="searchCon" class="form-select">
						<option value="title">제목</option>
						<option value="wirter">글쓴이</option>
						<option value="content">내용</option>
					</select>
					<input name="searchKey" class="form-control me-2">
					<button type="submit" class="btn btn-outline-success text-nowrap">검색</button>
				</form>
			</div>
		</nav>
		
			
		<table class="table">
		  <thead>
		    <tr>
		      <th scope="col">번호</th>
		      <th scope="col">제목</th>
		      <th scope="col">글쓴이</th>
		      <th scope="col">내용</th>
			  <th scope="col">modify/delete</th>
		    </tr>
		  </thead>
		  <tbody>
			
			<c:forEach items="${bData}" var="board">
				<tr>
			      <th scope="row"> ${board.seq}</th>
			      <td>${board.title}</td>
			      <td>${board.writer}</td>
				  <td>${board.content}</td>
				  <td>
					<button type="button" class="btn btn-primary"
						onclick="location.href='modifyBoard.do?seq=${board.seq}'">Modify</button>
					<button type="button" class="btn btn-danger"
						onclick="location.href='deleteBoard.do?seq=${board.seq}'">Delete</button>
				  </td>
			    </tr>
			</c:forEach>
			
		  </tbody>
		</table>
	</div>
	
	
	
</body>
</html>
