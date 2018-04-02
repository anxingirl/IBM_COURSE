<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@page import="ibm.util.tool.StringUtil"%>
<%@ taglib prefix="myFunc" uri="myFunctions"%>
<%
request.setCharacterEncoding("UTF-8");
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
response.setCharacterEncoding("UTF-8");

%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'authenticate.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
	<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
	
  </head>
  
  <body>
   <%-- 如果存在valideUser会话bean 就将它删除 --%>
   <c:remove var="validUser"/>
   <c:if test="${empty param.registeEmail || empty param.password}">
   	<c:redirect url="login.jsp">
   		<c:param name="errorMsg" 
   		value = "请输入邮箱和密码登录"/>
   	</c:redirect>
   </c:if>
   <%-- 查看验证码是否正确，如果不合法就返回登录页面，同时给出提示 --%>
   <c:if test="${empty param.validate  || sessionScope.valicode != param.validate}">
    	<c:redirect url="login.jsp">
   		<c:param name="errorMsg" 
   		value = "验证码输入错误"/>
   	</c:redirect>  		
   </c:if>

  <sql:setDataSource dataSource="jdbc/ibmcourse"/>
   <%-- 查看用户名和密码是否合法，如果不合法就返回登录页面，同时给出提示 --%>
     <sql:query var="userInfo">
     	SELECT * FROM User 
     		WHERE RegisterEmail = ?
     	<sql:param value="${param.registeEmail}" />
     </sql:query>
   	 <c:if test="${userInfo.rowCount == 0}">
   	 	<c:redirect url="login.jsp">
   	 		<c:param name="errorMsg"
   	 			value="不存在该邮箱用户"
   	 		/>
   	 	</c:redirect>
   	 </c:if>
	
   	 <%--验证密码是否正确 --%>
	<c:if test="${userInfo.rows[0].PassWord ne myFunc:toSHA(param.password)}">
   	 	<c:redirect url="login.jsp">
   	 		<c:param name="errorMsg"
   	 			value="密码输入错误"
   	 		/>
   	 	</c:redirect>			
	</c:if>
	
	<%-- 新建一个bean 并且在会化作用于保存它，重定向到一个合适的页面 --%>
	<c:set var="user" value="${userInfo.rows[0]}" />
	<jsp:useBean id="validUser" scope="session" class="ibm.util.user.User">
		<c:set target="${validUser}" property="userID" value="${user.UserID}"/>
		<% validUser.makeUser(); %>
	</jsp:useBean>
	<c:choose>
		<c:when test="${!empty param.origURL}">
			<c:redirect url="${param.origURL}" />
		</c:when>
		<c:otherwise>
			<c:redirect url="/web/man_resource/resource_upload.jsp" />	
		</c:otherwise>
	</c:choose>
	
  </body>
</html>
