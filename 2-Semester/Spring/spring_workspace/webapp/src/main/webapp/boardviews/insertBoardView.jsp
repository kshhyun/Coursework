<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>JSP 예시 페이지</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            background-color: #f7f7f7;
            color: #222;
        }
        .container {
            max-width: 720px;
            margin: 0 auto;
            padding: 24px;
            background: #fff;
            border-radius: 12px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }
        h1 {
            color: #ff7a00;
        }
        .info {
            padding: 12px;
            background-color: #fff4e8;
            border-left: 4px solid #ff7a00;
            margin-bottom: 20px;
        }
        input, button {
            padding: 8px 10px;
            font-size: 14px;
        }
        button {
            background-color: #ff7a00;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
    </style>
</head>
<body>
<%
    // JSP 스크립틀릿 예시: 서버에서 현재 시간을 생성
    String now = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));

    // 요청 파라미터 처리 예시
    String name = request.getParameter("name");
    if (name == null || name.trim().isEmpty()) {
        name = "방문자";
    }
%>

<div class="container">
    <h1>JSP 예시 페이지</h1>

    <div class="info">
        <p><strong>현재 서버 시간:</strong> <%= now %></p>
        <p><strong>환영합니다:</strong> <%= name %>님</p>
    </div>

    <form method="get" action="example.jsp">
        <label for="name">이름 입력:</label>
        <input type="text" id="name" name="name" placeholder="예: 홍길동">
        <button type="submit">전송</button>
    </form>

    <hr>

    <h2>반복문 예시</h2>
    <ul>
        <%
            for (int i = 1; i <= 5; i++) {
        %>
            <li>목록 항목 <%= i %></li>
        <%
            }
        %>
    </ul>
</div>
</body>
</html>
