<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, myBean.db.*, javax.naming.NamingException"%>
<!DOCTYPE html>
<html lang="ko">
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
        .form--image > input {
            width: 100%;
            height: 100%;
            opacity: 0;
            cursor: pointer;
        }
        .form--image > img {
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
        function submitForm(event) {
            if (document.getElementById("image-upload").files.length == 0) {
                window.alert("사진을 업로드해주세요.");
                return false;
            }
            else if (!document.getElementById("title").value) {
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
                var image = document.getElementById("image-upload").files[0].name;
                var title = document.getElementById("title").value;
                var author = document.getElementById("author").value;
                var categoryId = document.getElementById("categoryId").value;
                var password = document.getElementById("password").value;
                var tags = document.getElementById("tags").value;
                var description = document.getElementById("description").value;
                var msg = "입력을 확인해주세요.\n";
                msg += "이미지파일: " + image + "\n";
                msg += "제목: " + title + "\n";
                msg += "작성자: " + author + "\n";
                msg += "분류번호: " + categoryId + "\n";
                msg += "비밀번호: " + "*".repeat(password.length) + "\n";
                msg += "태그: " + tags + "\n";
                msg += "설명: " + description + "\n";
                window.alert(msg);

                return true;
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
    <form onsubmit="return submitForm()" action="clipart-create_do.jsp" method="post" class="d-flex w-75 mt-5 justify-content-center" enctype="multipart/form-data">
        <div class="form--image align-self-center">
            <label for="image-upload">
                <img class="" id="preview-image"/>
            </label>
            <input type="file" id="image-upload" name="imageFile" onchange="previewImage(event)"/>
        </div>
        <div class="form__box border p-3 ms-5 align-self-center">
            <div class="form-floating mb-3">
                <input class="form-control" type="text" id="title"
                       placeholder="title" name="title">
                <label for="title">제목</label>
            </div>

            <select class="form-select mb-3" id="categoryId" name="categoryId">
                <option value="0" selected>분류</option>
                <%
                    Connection con = null;
                    Statement stmt = null;
                    ResultSet rs = null;
                    try {
                        con = DsCon.getConnection();
                        stmt = con.createStatement();
                        String query = "SELECT id, name FROM category";
                        rs = stmt.executeQuery(query);

                        while (rs.next()) {
                %>
                <option value="<%=rs.getInt("id")%>"><%=rs.getString("name")%></option>
                <%
                        }
                        rs.close(); // ResultSet 종료
                        stmt.close(); // Statement 종료
                        con.close(); // Connection 종료
                    } catch (SQLException e) {
                        out.println("err:" + e.toString());
                        return;
                    } catch (NamingException e) {
                        out.println("err:" + e.toString());
                        return;
                    }
                %>
            </select>
            <div class="form-floating mb-3">
                <input class="form-control" type="text" id="tags"
                        name="tags" placeholder="tags">
                <label for="tags">태그(','로 구분)</label>
            </div>
            <div class="form-floating mb-3">
                <input class="form-control" type="textarea" id="description"
                       name="description" placeholder="description">
                <label for="description">설명</label>
            </div>
            <div class="form-floating mb-3">
                <input class="form-control" type="text" id="author"
                       name="author" placeholder="author">
                <label for="author">작성자</label>
            </div>
            <div class="form-floating mb-3">
                <input class="form-control" type="password"
                       id="password" name="password"
                       placeholder="password">
                <label for="password">비밀번호</label>
            </div>
            <button class="btn btn-outline-dark" onclick="">등록하기</button>
        </div>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
</body>
</html>
