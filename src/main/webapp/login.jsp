<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="template-style.jsp"%>
    <style>
        .main {
            display: flex;
            justify-content: center;
        }
    </style>
</head>
<body>
<%@ include file="template-header.jsp"%>
<div class="main">
    <form action="login_do.jsp" method="post" class="w-25">
        <div class="form-floating mb-3">
            <input class="form-control" type="text" id="username"
                   placeholder="username" name="username">
            <label for="username">유저네임</label>
        </div>
        <div class="form-floating mb-3">
            <input class="form-control" type="password" id="password"
                   placeholder="password" name="password">
            <label for="password">비밀번호</label>
        </div>
        <button class="btn btn-outline-dark" onclick="">로그인</button>
    </form>

</div>
</body>
</html>
