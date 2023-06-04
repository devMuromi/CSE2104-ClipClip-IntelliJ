<%@ page contentType="text/html;charset=utf-8" import="java.sql.*, java.util.*, myBean.db.*, myBean.part.MyPart, javax.naming.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%
    request.setCharacterEncoding("utf-8");
    String title = request.getParameter("title");
//    int categoryId = Integer.parseInt(request.getParameter("category"));
    int categoryId = 1;
    String tag = request.getParameter("tag");
    String[] tags = tag.split(",");
    String author = request.getParameter("author");
    String password = request.getParameter("password");
    String description = request.getParameter("description");
    Part part = request.getPart("imageFile");
    // ~~~ image
    if (title == null)
        title = "no data";
    if (author == null)
        author = "no data";

String id = request.getParameter("id");

// 파일 저장
ServletContext context = getServletContext();
String realFolder = context.getRealPath("upload");
MyPart mypart = new MyPart(part, realFolder);


Clipart clipart = new Clipart();
clipart.setTitle(title);
clipart.setAuthor(author);
clipart.setCategoryId(categoryId);
clipart.setPassword(password);
clipart.setTags(tags);
clipart.setDescription(description);
clipart.setViewCount(0);
clipart.setDownloadCount(0);
clipart.setCreateDate(LocalDateTime.now());
clipart.setLastUpdate(LocalDateTime.now());
clipart.setOriginalFileName();
clipart.setSavedFileName();


ClipartDB db = new ClipartDB();
db.insertRecord();

db.close();

//만일, 저장이 안되면, 아래 코드 주석처리하여 오류 확인할 것.
response.sendRedirect("clipart.jsp");
%>
<%-- 테스트 시작 파일 : user_list.jsp --%>