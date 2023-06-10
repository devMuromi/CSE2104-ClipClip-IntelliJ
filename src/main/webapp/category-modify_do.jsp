<%@ page import="java.sql.*, myBean.db.*, javax.naming.NamingException" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    } else {
        String username = session.getAttribute("username").toString();
        String password = session.getAttribute("password").toString();
        UserDB db = new UserDB();
        if (!db.checkPassword(username, password)) {
            response.sendRedirect("login.jsp");
        } else {
            int id = Integer.parseInt(request.getParameter("id"));
            String changedName = request.getParameter("changedName");
            try {
                Category category = new Category();
                category.setId(id);
                category.setName(changedName);

                CategoryDB CategoryDb = new CategoryDB();
                CategoryDb.updateRecord(category);
                CategoryDb.close();
            } catch (SQLException e) {
                out.println("err:" + e.toString());
            }
            response.sendRedirect("category-manage.jsp");
        }
        db.close();
    }
%>