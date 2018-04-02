<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'myAccount.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
		<link rel="stylesheet" type="text/css" href="style/contentFrame.css">
	  <%-- 验证用户是否已经登录 --%>
	 <c:if test="${validUser == null}">
	 	<c:redirect url="web/man_pages/login.jsp">
	 		<c:param name="origURL" value="${pageContext.request.requestURL}"/>
	 		<c:param name="errorMsg" value="还未登录账户"/>
 	 	</c:redirect>
	 
	 </c:if>
	  
  </head>
  
  <body>
  <sql:setDataSource dataSource="jdbc/ibmcourse"/>
<!--将数据库某查询的结果申明为一个变量 -->
<sql:query var="authRs">
	select AuthName, Type from Auth 
</sql:query>
<sql:query var="adminRs">
    select Level,Descrip from AdminLevel
</sql:query>

<h3>当前登录用户信息：</h3>
    <table border="0" bordercolor="#FFFFFF" bgcolor="#6c6c6c">
		<tr bgcolor="#FFFFFF" class="tab-row">
    		<td>用户姓名:</td><td>${validUser.name}</td>
    	</tr>
    	<tr bgcolor="#FFFFFF" class="tab-row">
    		<td>用户注册邮箱:</td><td>${validUser.registerEmail}</td>
    	</tr>
    	<tr bgcolor="#FFFFFF" class="tab-row">
    		<td>用户注册时间:</td><td>${validUser.registerDate}</td>
    	</tr>
    	<tr bgcolor="#FFFFFF" class="tab-row">
    		<td>用户权限:</td>
    	<td>
			<c:forEach var="row" items="${authRs.rows}">
			<c:if test="${validUser.auth == row.Type}">
				${row.AuthName}
			</c:if>
		</c:forEach> 
    	</td>
    	</tr>
    	<tr bgcolor="#FFFFFF" class="tab-row">
    		<td>大学:</td><td>${validUser.university}</td>
    	</tr>
    	<tr bgcolor="#FFFFFF" class="tab-row">
    		<td>学校:</td><td>${validUser.school}</td>
    	</tr>
    	<tr bgcolor="#FFFFFF" class="tab-row">
    		<td>教育程度:</td><td>${validUser.education}</td>
    	</tr>
    	<tr bgcolor="#FFFFFF" class="tab-row">
    		<td>最后一次登录时间:</td><td>${validUser.lastDate}</td>
    	</tr>
    	<tr bgcolor="#FFFFFF" class="tab-row">
    		<td>管理员权限:</td><td>
    	<c:forEach var="row" items="${adminRs.rows}">
		<c:set var="flag" value="n" /> <!-- 两个循环，找到相同值的标志 -->
			${row.Descrip}
		   <c:forEach var="ad" items="${fn:split(validUser.admin,',')}">
		   	     <c:if test="${ad == row.Level}">
		   	     	<c:set var="flag" value="y" />
		   	     </c:if>
 		   </c:forEach>
			 <input type="checkbox" name="admin" value="${row.Level}"
			 	<c:if test="${flag == 'y'}">
			 		checked="checked"
				 </c:if>
			  /> 
		</c:forEach> 
    		
    		</td>
    	</tr>
    </table>
  </body>
</html>
