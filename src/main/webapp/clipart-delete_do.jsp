<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="myBean.db.ClipartDB, myBean.db.Clipart" %>
<%
    request.setCharacterEncoding("utf-8");
    int id = Integer.parseInt(request.getParameter("id"));
    String password = request.getParameter("password");

    ClipartDB db = new ClipartDB();
    if(!db.checkPassword(id, password)) {
        response.sendRedirect("clipart-delete.jsp?id=" + id + "&passwordDoesNotMatch=true");
    }
    else {
        db.deleteRecord(id);
        response.sendRedirect("index.jsp");
    }
    db.close();
%>