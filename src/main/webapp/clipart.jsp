<%@ page contentType="text/html; charset=UTF-8" language="java" import="java.sql.*, myBean.db.*, javax.naming.*" %>
<html>
<head>
    <%@ include file="template-style.jsp" %>
    <style>
        .main {
            display: flex;
            justify-content: center;
        }

        .clipart-image {
            position: relative;
            width: 512px;
            height: 512px;
            border: 1px solid lightgray;
            text-align: center;
            overflow: hidden;
        }

        .clipart-image > img {
            display: block;
            max-width: 100%;
            max-height: 100%;
            margin: auto;
        }

        .clipart-info {
            width: 600px;
        }
    </style>
</head>
<body>
<%@ include file="template-header.jsp" %>

<%
    int id = -1;
    String raw_id = request.getParameter("id");
    if (raw_id == null || raw_id == "-1") {
        response.sendRedirect("index.jsp");
    }
    else {
        id = Integer.parseInt(raw_id);
    }
    try {
        ClipartDB clipartDb = new ClipartDB();
        clipartDb.incrementViewCount(id);
        CategoryDB categoryDb = new CategoryDB();

        Clipart clipart = clipartDb.getRecord(id);
        int categoryIdx = clipart.getCategoryId();

        Category category = categoryDb.getRecord(categoryIdx);
%>
<div class="main mt-5">
    <div class="clipart-image align-self-center">
        <img id="preview-image" src="./upload/<%=clipart.getSavedFileName()%>"/>
    </div>
    <div class="clipart-info border ms-5 p-3">
        <div>
            <span class="fs-1"><%=clipart.getTitle()%></span>
            <span class="float-end fs-4 mt-3"><%=category.getName()%></span>
        </div>
        <div class="fst-italic">
            <%
                // 태그(문자열)
                String[] tags = clipart.getTags();
                for (String tag: tags) {
                    if(tag.isEmpty()) { continue; }
                    out.print("#" + tag + " ");
                }
            %>
        </div>
        <div>클립아트 설명: <%out.print((clipart.getDescription()==null ||clipart.getDescription().equals("null"))? "설명이 없습니다":clipart.getDescription());%></div>
        <div>
            <span>업로더명: <%=clipart.getAuthor()%></span>
            <span class="float-end">최종 수정일시:
                <%=clipart.getLastUpdate().getYear()%>-<%=clipart.getLastUpdate().getMonthValue()%>-<%=clipart.getLastUpdate().getDayOfMonth()%>
                <%=clipart.getLastUpdate().getHour()%>:<%=clipart.getLastUpdate().getMinute()%>
            </span>
        </div>
        <div>
            <span>다운로드수: <%=clipart.getDownloadCount()%></span>
            <span>조회수: <%=clipart.getViewCount()%></span>
        </div>
        <div>
            <button class="btn btn-outline-dark" onclick="location.href='clipart-modify.jsp?id=<%=clipart.getId()%>'">수정</button>
            <button class="btn btn-outline-dark" onclick="location.href='clipart-delete.jsp?id=<%=clipart.getId()%>'">삭제</button>
        </div>
    </div>
</div>
<%
        clipartDb.close();
        categoryDb.close();
    } catch (Exception e) {
        out.print(e);
        return;
    }

%>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
</body>
</html>
