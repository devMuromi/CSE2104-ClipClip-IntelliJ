<%@ page pageEncoding="UTF-8" %>
<header class="header">
  <div class="header__menu">
    <a class="logo" href="index.jsp">ClipClip</a>
    <form action="index.jsp" method="GET">
      <input class="search-bar" type="text" placeholder="검색" name="searchKeyword" />
      <button class="btn btn-outline-dark" type="submit">검색</button>
    </form>
  </div>
  <div class="header__menu">
    <a class="btn btn-outline-dark" href="clipart-create.jsp">새 클립아트 업로드</a>
    <a class="btn btn-outline-dark" href="category-manage.jsp">☰</a>
  </div>
</header>