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
    int idx = Integer.parseInt(request.getParameter("idx"));
    try {
        ClipartDB db = new ClipartDB();
        CategoryDB categoryDb = new CategoryDB();

        Clipart clipart = db.getRecord(idx);
        int categoryIdx = clipart.getCategoryId();

        Category category = categoryDb.getRecord(categoryIdx);

%>
<div class="main mt-5">
    <div class="clipart-image align-self-center">
        <img class="" id="preview-image"/>
    </div>
    <div class="clipart-info border ms-5 p-3">
        <div>
            <span class="fs-1"><%=clipart.getTitle()%></span>
            <span class="float-end fs-4 mt-2"><%=category.getName()%></span>
        </div>
        <div class="fst-italic">
            <%
                String[] tags = clipart.getTags();
                for (String tag: tags){
                    out.print("#" + tag + " ");
                }
            %>
        </div>
        <div><%=clipart.getDescription()%></div>
        <div>
            <span><%=clipart.getUser()%></span>
            <span class="float-end">최종 수정일시: <%=clipart.getLastUpdate()%></span>
        </div>
        <div>
            <button class="btn btn-outline-dark">수정</button>
            <button class="btn btn-outline-dark">삭제</button>
        </div>
    </div>
</div>

<%
        db.close();
        categoryDb.close();
    } catch (SQLException e) {
        out.print(e);
        return;
    } catch (NamingException e) {
        out.print(e);
        return;
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
