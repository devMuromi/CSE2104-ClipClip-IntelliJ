<%@ page contentType="text/html;charset=utf-8" import="java.sql.*, myBean.db.*, javax.naming.*" %>
<%
    request.setCharacterEncoding("utf-8");
    String title = request.getParameter("title");
    String category = request.getParameter("category");
    String tag = request.getParameter("tag");
    String[] tags = tag.split(",");
    String author = request.getParameter("author");
    String password = request.getParameter("password");
    // ~~~ image
    if (title == null)
        title = "no data";
    if (author == null)
        author = "no data";
%>


String idx = request.getParameter("idx");

ArticleDB db = new ArticleDB();

db.deleteRecord(Integer.parseInt(idx));

db.close();

//만일, 저장이 안되면, 아래 코드 주석처리하여 오류 확인할 것.
response.sendRedirect("clipart.jsp");
%>
<%-- 테스트 시작 파일 : user_list.jsp --%>