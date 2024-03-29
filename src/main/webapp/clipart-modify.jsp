<%@ page contentType="text/html;charset=UTF-8" import="java.sql.*, javax.naming.NamingException"%>
<%@ page import="myBean.db.*" %>
<!DOCTYPE html>
<html lang="ko">
<html>
<head>
    <%@ include file="template-style.jsp"%>
    <style>
        .main {
            display: flex;
            justify-content: center;
        }
        .form--image {
            position: relative;
            width: 512px;
            height: 512px;
            border: 1px solid lightgray;
            text-align: center;
            overflow: hidden;
        }
        .form--image input {
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }
        .form--image img {
            display: block;
            max-width: 100%;
            max-height: 100%;
            margin: auto;
        }

        .form__box {
            width: 600px;
        }
    </style>
    <script>
        function submitForm() {
            if (!document.getElementById("title").value) {
                window.alert("제목을 입력해주세요.");
                return false;
            }
            else if (!document.getElementById("author").value) {
                window.alert("작성자를 입력해주세요.");
                return false;
            }
            else if (document.getElementById("categoryId").value == '0') {
                window.alert("분류를 선택해주세요.");
                return false;
            }
            else if (!document.getElementById("password").value) {
                window.alert("비밀번호를 입력해주세요.");
                return false;
            } else {
                if (confirm("정말 수정하시겠습니까?")){
                    document.modifyForm.submit();
                }else{
                    return false;
                }
            }
        }
        function previewImage(event) {
            var input = event.target;
            var reader = new FileReader();

            reader.onload = function(){
                var preview = document.getElementById('preview-image');
                preview.src = reader.result;
            };

            reader.readAsDataURL(input.files[0]);
        }
    </script>
</head>
<body>
<%@ include file="template-header.jsp"%>

<div class="main">
    <%
        int id = -1;
        String rawId = request.getParameter("id");
        if (rawId == null || rawId == "-1") {
            response.sendRedirect("index.jsp");
        }
        else {
            id = Integer.parseInt(rawId);
        }
        try {
            ClipartDB db = new ClipartDB();
            CategoryDB categoryDb = new CategoryDB();

            Clipart clipart = db.getRecord(id);
            int categoryIdx = clipart.getCategoryId();

            Category category = categoryDb.getRecord(categoryIdx);
    %>
    <form onsubmit="return submitForm()" action="clipart-modify_do.jsp?id=<%=id%>" name="modifyForm" method="post" class="d-flex w-75 mt-5 justify-content-center" enctype="multipart/form-data">
        <div class="form--image align-self-center">
            <label for="image-upload">
                <img src="./upload/<%=clipart.getSavedFileName()%>" class="" id="preview-image"/>
            </label>
            <input type="file" id="image-upload" name="imageFile" onchange="previewImage(event)"/>
        </div>
        <div class="form__box border p-3 ms-5 align-self-center">
            <%
                if(request.getParameter("passwordDoesNotMatch") != null){
            %>
            <div class="alert alert-warning" role="alert">
                비밀번호가 일치하지 않습니다
            </div>
            <%
                }
            %>
            <div class="form-floating mb-3">
                <input class="form-control" type="text" id="title"
                       placeholder="title" name="title" value="<%=clipart.getTitle()%>">
                <label for="title">제목</label>
            </div>
            <select class="form-select mb-3" id="categoryId" name="categoryId">
                <option value="0" selected>분류</option>
                <%
                    Connection con = null;
                    Statement stmt = null;
                    ResultSet rs = null;

                    con = DsCon.getConnection();
                    stmt = con.createStatement();
                    String query = "SELECT id, name FROM category";
                    rs = stmt.executeQuery(query);



                    while (rs.next()) {
                        if (clipart.getCategoryId() == rs.getInt("id")) {
                            out.print("<option value='" + rs.getInt("id") + "' selected>" + rs.getString("name") + "</option>");
                        } else {
                            out.print("<option value='" + rs.getInt("id") + "'>" + rs.getString("name") + "</option>");
                        }
                    }
                %>
            </select>
            <div class="form-floating mb-3">
                <input class="form-control" type="text" id="tags"
                       name="tags" placeholder="tags" value="<%=String.join(",", clipart.getTags())%>">
                <label for="tags">태그(','로 구분)</label>
            </div>
            <div class="form-floating mb-3">
                <input class="form-control" type="textarea" id="description"
                       name="description" placeholder="description" value="<%=clipart.getDescription()%>">
                <label for="description">설명</label>
            </div>
            <div class="form-floating mb-3">
                <input class="form-control" type="text" id="author"
                       name="author" placeholder="author" value="<%=clipart.getAuthor()%>">
                <label for="author">작성자</label>
            </div>
            <div class="form-floating mb-3">
                <input class="form-control" type="password"
                       id="password" name="password"
                       placeholder="password">
                <label for="password">비밀번호 확인</label>
            </div>
            <input class="btn btn-outline-dark" type="button" value="등록하기" onclick="submitForm()" />
        </div>
    </form>
    <%
            rs.close(); // ResultSet 종료
            stmt.close(); // Statement 종료
            con.close(); // Connection 종료
            db.close();
            categoryDb.close();

        } catch (SQLException e) {
            out.println("err:" + e.toString());
            return;
        } catch (NamingException e) {
            out.println("err:" + e.toString());
            return;
        }
    %>
</div>
</body>
</html>
