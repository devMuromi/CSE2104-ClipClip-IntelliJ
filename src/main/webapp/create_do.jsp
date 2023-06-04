<%@ page import="java.sql.*, java.util.*, myBean.db.*, myBean.part.MyPart, javax.naming.*, java.time.LocalDateTime" %>
<%
    request.setCharacterEncoding("utf-8");
    String title = request.getParameter("title");
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
    String tag = request.getParameter("tags");
    String[] tags = tag.split(",");
    String author = request.getParameter("author");
    String password = request.getParameter("password");
    String description = request.getParameter("description");
    Part part = request.getPart("imageFile");
    if (title == null)
        title = "no data";
    if (author == null)
        author = "no data";

// 파일 저장
String realFolder = request.getSession().getServletContext().getRealPath("/upload");
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
clipart.setOriginalFileName(mypart.getOriginalFileName());
System.out.println(mypart.getOriginalFileName());
clipart.setSavedFileName(mypart.getSavedFileName());
System.out.println(mypart.getSavedFileName());


ClipartDB db = new ClipartDB();
int id = db.insertRecord(clipart);

db.close();

//만일, 저장이 안되면, 아래 코드 주석처리하여 오류 확인할 것.
response.sendRedirect("clipart.jsp?id=" + id);
%>