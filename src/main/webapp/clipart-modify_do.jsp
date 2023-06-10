<%@ page import="java.sql.*, java.util.*, javax.naming.*, java.time.LocalDateTime, java.io.File" %>
<%@ page import="myBean.db.*, myBean.part.MyPart" %>
<%
    request.setCharacterEncoding("utf-8");
    int id = Integer.parseInt(request.getParameter("id"));
    String title = request.getParameter("title");
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
    String tag = request.getParameter("tags");
    String[] tags = tag.split(",");
    String author = request.getParameter("author");
    String password = request.getParameter("password");
    String description = request.getParameter("description");
    Part part = request.getPart("imageFile");

    System.out.println(part);

    ClipartDB db = new ClipartDB();
    if (!db.checkPassword(id, password)) {
        response.sendRedirect("clipart-modify.jsp?id=" + id + "&passwordDoesNotMatch=true");
    } else {
        String originalFileName, savedFileName;
        Clipart oldClipart = db.getRecord(id);
        if (part.getSubmittedFileName() == null || part.getSubmittedFileName().length() == 0) {
            originalFileName = oldClipart.getOriginalFileName();
            savedFileName = oldClipart.getSavedFileName();
        } else {
            String realFolder = request.getSession().getServletContext().getRealPath("/upload");
            realFolder = "/Users/wibaek/Development/ClipClip/src/main/webapp/upload";

            File oldFile = new File(realFolder + File.separator + oldClipart.getSavedFileName());
            oldFile.delete();
            MyPart mypart = new MyPart(part, realFolder);
            originalFileName = mypart.getOriginalFileName();
            savedFileName = mypart.getSavedFileName();
        }

        Clipart clipart = new Clipart();
        clipart.setId(id);
        clipart.setTitle(title);
        clipart.setAuthor(author);
        clipart.setCategoryId(categoryId);
        clipart.setTags(tags);
        clipart.setDescription(description);
        clipart.setLastUpdate(LocalDateTime.now());
        clipart.setOriginalFileName(originalFileName);
        clipart.setSavedFileName(savedFileName);

        db.updateRecord(clipart);
        response.sendRedirect("clipart.jsp?id=" + id);
    }
    db.close();

%>