<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, myBean.db.*, javax.naming.NamingException"%>
<%
    request.setCharacterEncoding("UTF-8");
    String order_by = request.getParameter("order_by");
    if (order_by == null) {
        order_by = "latest";
    }
%>
<!DOCTYPE html>
<html lang="ko">
<head>
    <%@ include file="template-style.jsp"%>
    <style>
        .main {
            display: flex;
        }

        .nav {
            border-right: 1px solid lightgray;
            width: 300px;
            display: flex;
            flex-direction: column;
        }

        .nav a {
            padding: 10px;
            color: gray;
        }

        nav a:hover {
            color: black;
        }

        .nav--line {
            width: 128px;
            border-bottom: 1px solid lightgray;
            margin: 5px auto 5px auto;
        }

        .nav--imp {
            font-size: 20px;
        }

        .nav__selected {
            color: black !important;
        }

        .content {
            margin: 20px;
            display: flex;
            flex-flow: row wrap;
        }

        .clip-art {
            margin: 10px;
            border: 1px solid lightgray;
            border-radius: 16px;
            padding: 8px;
        }

        .clip-art__image img {
            width: 247px;
            height: 247px;
            border-radius: 16px;
        }

        .clip-art__meta {
            display: flex;
            justify-content: space-around;
            align-items: center;
        }

        .clip-art__author {
            color: gray;
        }
    </style>
</head>
<body>
<%@ include file="template-header.jsp"%>
<div class="main">
    <nav class="nav">
        <a class="nav--imp" href="index.jsp?order_by=latest">최신순</a> <a class="nav--imp" href="index.jsp?order_by=download">다운로드순</a> <a class="nav--imp" href="index.jsp?order_by=random">무작위</a>
        <div class="nav--line"></div>
        <div id="category-list">
            <%
                Connection con = null;
                Statement stmt = null;
                ResultSet rs = null;
                try {
                    con = DsCon.getConnection();
                    stmt = con.createStatement();
                    String query = "SELECT id, name FROM category";
                    rs = stmt.executeQuery(query);

                    while (rs.next()) {
            %>
            <a href="index.jsp?category=<%=rs.getInt("id")%>"><%=rs.getString("name")%></a>
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
        </div>
    </nav>
    <div class="content">
        <%
            try {
                con = DsCon.getConnection();
                stmt = con.createStatement();
                String query = "SELECT id, title, author, savedFileName FROM clipart";
                rs = stmt.executeQuery(query);

                while (rs.next()) {
        %>
        <div class="clip-art">
            <a onclick="location.href='clipart.jsp?id=<%=rs.getInt("id")%>'" class="clip-art__image">
                <img src="./upload/<%=rs.getString("savedFileName")%>" alt="<%=rs.getString("title")%>">
            </a>
            <div class="clip-art__meta">
                <a onclick="location.href='clipart.jsp?id=<%=rs.getInt("id")%>'" class="clip-art__title"><%=rs.getString("title")%></a>
                <a onclick="location.href='clipart.jsp?id=<%=rs.getInt("id")%>'" class="clip-art--author"><%=rs.getString("author")%></a>
                <a onclick="location.href='clipart-delete.jsp?id=<%=rs.getInt("id")%>'" class="">삭제</a>
            </div>
        </div>
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
    </div>
</div>
<div class="footer"></div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
        integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
        crossorigin="anonymous"></script>
</body>
</html>
