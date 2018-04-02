<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'download_control.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<link rel="stylesheet" type="text/css" href="style/contentFrame.css">

	<script language="JavaScript" type="text/javascript"
			src="js/jquery-1.7.1.js"></script>
	  <%-- 验证用户是否已经登录 --%>
	<%@ include file="validate.jsp" %>
	
	<jsp:useBean id="info" class="ibm.util.resource.Info" scope="session">
	</jsp:useBean>	
	<%
		info.getDownloadCount();
	 %>
  </head>
  
  <body>
    	<h3>设置资源分类 </h3>

    	<table class="bigTable" border="0" bordercolor="#FFFFFF" bgcolor="#6c6c6c">
    		<thead>
    			<tr bgcolor="#c6c6c6">
    				<td class="column-short">资源ID</td><td class="column-middle">资源名称</td><td class="column-middle">被下载次数</td>
    			</tr>
    		</thead>
    		<tbody>
    		<c:forEach var="listElement" items="${info.downloadCount}">
    		    <tr bgcolor="#FFFFFF">
    		   		 <td class="column-short">
    		   		 	<A href="">${listElement['ResourceID']}</A>
    		   		 </td>
    				<td>
    					${listElement['ResourceName']}
    				</td>
    				<td>
    					${listElement['count']}
    				</td>
    			
    			</tr>
    		</c:forEach>

    		</tbody>
    	</table>
  </body>
</html>
