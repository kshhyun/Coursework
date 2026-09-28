<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>InsertBoardView</title>
	
	<!--BootStrap 5.1.3ver CSS 라이브러리-->
	<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
	
	<!--JavaScript 라이브러리-->
	<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	
    <style>
        .form-style {max-width: 600px;
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
		<p class="fs-2 text-center"> 게시판 등록</p>
		<form action="insertProcBoard.do" method="post">
			  <div class="mb-3">
			    <label for="example" class="form-label">글 제목 (Title) </label>
			    <input type="text" class="form-control" id="example" name="title">
			  </div>
			  
			  <div class="mb-3">
  			    <label for="example" class="form-label">글쓴이 (Writer) </label>
  			    <input type="text" class="form-control" id="example" name="writer">
  			  </div>
			  
			  <div class="mb-3">
  			    <label for="example" class="form-label">글내용 (Content) </label>
  			    <input type="text" class="form-control" id="example" name="content">
  			  </div>
			  
			  <button type="submit" class="btn btn-primary">저장</button>
			  <button type="reset" class="btn btn-danger">취소</button>
			</form>
	</div>
	
	
	
</body>
</html>
