<%@ page import="myBean.db.*" %>
<%
    request.setCharacterEncoding("utf-8");
    String username = request.getParameter("username");
    String password = request.getParameter("password");

    UserDB db = new UserDB();
    User user = new User();

    if(!db.checkPassword(username,password)) {
        response.sendRedirect("login.jsp");
    } else {
        session.setAttribute("username", username);
        session.setAttribute("password", password);
        response.sendRedirect("category-manage.jsp");
    }
    db.close();

//만일, 저장이 안되면, 아래 코드 주석처리하여 오류 확인할 것.

%>