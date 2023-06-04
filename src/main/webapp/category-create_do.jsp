<%@ page import="java.sql.*, myBean.db.*, javax.naming.NamingException" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
    else {
        String username = session.getAttribute("username").toString();
        String password = session.getAttribute("password").toString();
        UserDB db = new UserDB();
        if(!db.checkPassword(username,password)){
            response.sendRedirect("login.jsp");
        }
        else {
            String categoryName = request.getParameter("category");
            try {
                Category category = new Category();
                category.setName(categoryName);

                CategoryDB CategoryDb = new CategoryDB();
                CategoryDb.insertRecord(category);
                CategoryDb.close();
            } catch (SQLException e) {
                out.println("err:" + e.toString());
            }
            response.sendRedirect("category-manage.jsp");
        }
        db.close();
    }
%>