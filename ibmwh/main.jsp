<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'main.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	
	  <%-- 验证用户是否已经登录 --%>
	 <c:if test="${validUser == null}">
	 	<c:redirect url="web/man_pages/login.jsp">
	 		<c:param name="origURL" value="${pageContext.request.requestURL}"/>
	 		<c:param name="errorMsg" value="请先登录"/>
 	 	</c:redirect>
	 
	 </c:if>
	  
  </head>
  
  <body>

   	IBM资料中心-后台管理 <br>
   	
  </body>
</html>
