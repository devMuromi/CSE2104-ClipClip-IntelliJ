<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*, java.util.*, javax.naming.NamingException"%>
<%@ page import="myBean.db.*"%>
<%
    request.setCharacterEncoding("UTF-8");
    String currentOrderBy = request.getParameter("orderBy");
    String currentCategoryParam = request.getParameter("category");
    int currentCategory; // 0 is All
    String currentSearchKeyword = request.getParameter("searchKeyword");
    if (currentOrderBy == null) {
        currentOrderBy = "latest";
    }
    if (currentCategoryParam == null) {
        currentCategory = 0;
    } else {
        currentCategory = Integer.parseInt(currentCategoryParam);
    }
    if (currentSearchKeyword == null) {
        currentSearchKeyword = "";
    }

    Connection con = null;
    Statement stmt = null;
    ResultSet rs = null;
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

        .nav__line {
            width: 128px;
            border-bottom: 1px solid lightgray;
            margin: 5px auto 5px auto;
        }

        .nav__order {
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
<%--// <%@ include file="template-header.jsp"%>--%>
<header class="header">
    <div class="header__menu">
        <a class="logo" href="index.jsp">ClipClip</a>
        <form action="index.jsp" method="GET">
            <input type="hidden" name="orderBy" value="<%=currentOrderBy%>" />
            <input type="hidden" name="category" value="<%=currentCategory%>" />
            <input class="search-bar" type="text" placeholder="검색" name="searchKeyword" value="<%=currentSearchKeyword%>"/>
            <button class="btn btn-outline-dark" type="submit">검색</button>
        </form>
    </div>
    <div class="header__menu">
        <a class="btn btn-outline-dark" href="clipart-create.jsp">새 클립아트 업로드</a>
        <a class="btn btn-outline-dark" href="category-manage.jsp">☰</a>
    </div>
</header>
<div class="main">
    <nav class="nav">
        <%--정렬 설정 네비게이션--%>
        <a class="nav__order <% if (currentOrderBy.equals("latest")){%>text-dark<%}%>" href="index.jsp?orderBy=latest&category=<%=currentCategory%>&searchKeyword=<%=currentSearchKeyword%>">최신순</a>
        <a class="nav__order <% if (currentOrderBy.equals("download")){%>text-dark<%}%>" href="index.jsp?orderBy=download&category=<%=currentCategory%>&searchKeyword=<%=currentSearchKeyword%>">다운로드순</a>
        <a class="nav__order <% if (currentOrderBy.equals("view")){%>text-dark<%}%>" href="index.jsp?orderBy=view&category=<%=currentCategory%>&searchKeyword=<%=currentSearchKeyword%>">조회순</a>
        <div class="nav__line"></div>
        <%
            // 분류 설정 네비게이션
            CategoryDB categoryDb = new CategoryDB();
            List<Category> categoryList = categoryDb.getCategoryList();

            for(Category category : categoryList){
        %>
        <a href="index.jsp?orderBy=<%=currentOrderBy%>&category=<%=category.getId()%>&searchKeyword=<%=currentSearchKeyword%>" class="<% if (category.getId() == currentCategory){%>text-dark<%}%>">
            <%=category.getName()%>(<%=category.getClipartCount()%>)
        </a>
        <%
            }
            categoryDb.close();
        %>
    </nav>
    <div class="content">
        <%
            try {
                String sql = "SELECT id, title, author, savedFileName FROM clipart";
                if (currentCategory != 0) {
                    sql += " WHERE categoryId=";
                    sql += currentCategory;
                }
                if (currentSearchKeyword != "") {
                    if (currentCategory != 0) {
                        sql += " AND";
                    }
                    else{
                        sql += " WHERE";
                    }
                    sql += " tags LIKE '%" + currentSearchKeyword + "%'";
                }
                if (currentOrderBy.equals("latest")) {
                    sql += " ORDER BY lastUpdate DESC";
                } else if (currentOrderBy.equals("downlaod")) {
                    sql += " ORDER BY donwloadCount DESC";
                } else if (currentOrderBy.equals("view")) {
                    sql += " ORDER BY viewCount DESC";
                }

                con = DsCon.getConnection();
                stmt = con.createStatement();
                rs = stmt.executeQuery(sql);

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
<%
    if(rs != null) rs.close();
    if(stmt != null) stmt.close();
    if(con != null) con.close();
%>