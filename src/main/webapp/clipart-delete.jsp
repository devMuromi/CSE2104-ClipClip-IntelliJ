<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
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
<%@ include file="template-header.jsp"%>

<div class="main mt-5">
    <form action="clipart-delete_do.jsp?id=<%=request.getParameter("id")%>" method="post" class="w-25 border p-3">
        <div class="form-floating m-3">
            <input class="form-control" type="password" id="password" name="password" placeholder="password">
            <label for="password">비밀번호</label>
        </div>
        <button class="btn btn-outline-dark m-3" onclick="">등록하기</button>
    </form>
</div>