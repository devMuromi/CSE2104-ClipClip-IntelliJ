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
    <script>
        function modifyCategory(id) {
            let changedName = prompt("수정할 이름을 입력해주세요")
            if (changedName === "") {
                alert("분류명은 공백이 될 수 없습니다");
            } else if(changedName == null){
                return;
            } else{
                location.href = "category-modify_do.jsp?id=" + id + "&changedName=" + changedName;
            }
        }
    </script>
</head>
<body>
<%@ include file="template-header.jsp"%>
<div class="main">
    <table class="w-50 table">
        <tr>
            <th>이름</th>
            <th>개수</th>
            <th>수정</th>
            <th>삭제</th>
        </tr>
        <%
            Connection con = null;
            Statement stmt = null;
            ResultSet rs = null;
            try{
                con = DsCon.getConnection();
                stmt = con.createStatement();
                String query = "SELECT id, name FROM category";
                rs = stmt.executeQuery(query);
                CategoryDB categoryDb = new CategoryDB();
                while (rs.next()) {
                    String name = rs.getString("name");
                    int id = rs.getInt("id");
                    int viewCount = categoryDb.getCount(id);
        %>
        <tr>
            <td><%=name%></td>
            <td><%=viewCount%></td>
            <td><button onclick="modifyCategory(<%=id%>)">수정</button></td>
            <td><%if(viewCount == 0){%>
                <a href="category-delete_do.jsp?id=<%=id%>">삭제</a>
                <%} else { %>
                <span>삭제불가</span>
                <% }%>
            </td>
        </tr>
        <%
                }
                rs.close(); // ResultSet 종료
                stmt.close(); // Statement 종료
                con.close(); // Connection 종료
                categoryDb.close();
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