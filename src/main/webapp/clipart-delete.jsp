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
    <script>
        function confirmDelete(){
            if (confirm("정말 삭제하시겠습니까?")){
                document.deleteForm.submit();
            }else{
                return false;
            }
        }
    </script>
</head>
<%@ include file="template-header.jsp"%>

<div class="main mt-5">
    <form action="clipart-delete_do.jsp?id=<%=request.getParameter("id")%>" method="post" class="w-25 border p-3" name="deleteForm">
        <%
            if(request.getParameter("passwordDoesNotMatch") != null){
        %>
        <div class="alert alert-warning" role="alert">
            비밀번호가 일치하지 않습니다
        </div>
        <%
            }
        %>
        <div class="form-floating m-3">
            <input class="form-control" type="password" id="password" name="password" placeholder="password">
            <label for="password">비밀번호</label>
        </div>
        <input class="btn btn-outline-dark m-3" type="button" value="삭제하기" onclick="confirmDelete()" />
    </form>
</div>