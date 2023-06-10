<%@ page import="java.sql.*, myBean.db.*" %>
<%
  int id = Integer.parseInt(request.getParameter("id"));

  ClipartDB clipardDB = new ClipartDB();
  clipardDB.incrementDownloadCount(id);
  clipardDB.close();

  response.sendRedirect("clipart.jsp?id=" + id);
%>