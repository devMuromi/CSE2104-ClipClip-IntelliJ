<%@ page contentType="text/html;charset=UTF-8" import="java.sql.*, myBean.db.*, javax.naming.NamingException" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.jsp");
    }
    else{
        String username = session.getAttribute("username").toString();
        String password = session.getAttribute("password").toString();
        UserDB db = new UserDB();
        if(!db.checkPassword(username,password)){
            response.sendRedirect("login.jsp");
        }
        else {


%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="template-style.jsp"%>
        <style>
            .main {
                display: flex;
            }
        </style>
</head>
<body>
<%@ include file="template-header.jsp"%>
<div class="main">
    <table class="w-50 table">
            <th>이름</th>
            <th>삭제</th>
        <%
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            try{
                con = DsCon.getConnection();
                stmt = con.createStatement();
                String query = "SELECT id, name FROM category";
                rs = stmt.executeQuery(query);
                while (rs.next()) {
        %>
        <tr>
            <td><%=rs.getString("name")%></td><td><a href="category-delete_do.jsp?id=<%=rs.getInt("id")%>">삭제</a></td>
        </tr>
        <%
                }
                rs.close(); // ResultSet 종료
                stmt.close(); // Statement 종료
                con.close(); // Connection 종료
            } catch (SQLException e) {
                out.println("err:" + e.toString());
                return;
            } catch (NamingException e) {
                out.println("err:" + e.toString());
                return;
            }

        %>
    </table>
    <div class="w-25">
        <form action="category-create_do.jsp" method="post" class="">
            <div class="form-floating mb-3">
                <input class="form-control" type="text" id="category"
                       placeholder="category" name="category">
                <label for="category">새 분류명</label>
            </div>
            <button class="btn btn-outline-dark" onclick="">등록</button>
        </form>
    </div>
    <div class="w-25">
        <a class="btn btn-outline-dark m-4" href="logout_do.jsp">로그아웃</a>
    </div>

</div>
</body>
</html>
<%
        }
    db.close();
    }
%>