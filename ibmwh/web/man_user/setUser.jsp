<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<base href="<%=basePath%>">

		<title>My JSP 'resource_upload.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">

		<link rel="stylesheet" type="text/css" href="style/contentFrame.css">
			<link rel="stylesheet" type="text/css" href="style/pager.css">
			  <%-- 验证用户是否已经登录 --%>
	 <%@ include file="validate.jsp" %>
	<jsp:useBean id="info" class="ibm.util.resource.Info" scope="session">
	</jsp:useBean>			
<c:choose>
	<c:when test="${not empty param.search}">
		<%
		info.getAllUsers(request.getParameter("search"),request.getParameter("point"));
		 %>
	</c:when>
	<c:when test="${not empty param.admin}">
		<%
		info.getAllUsers(request.getParameter("admin")); 
		%>
	</c:when>
	<c:otherwise>
		<%
		info.getAllUsers(); 
		%>
	</c:otherwise>
</c:choose>
		<script language="JavaScript" type="text/javascript"
			src="js/jquery-1.7.1.js"></script>
			
		<script language="JavaScript" type="text/javascript"
			src="js/jQuery.page.js"></script>
			
	  <script type="text/javascript">
	   var mount = ${fn:length(info.users)};
	   var pagesize = ${dog.pagesize};
	   var pagecount = mount/pagesize;
	   if(mount%pagesize>0) pagecount = pagecount+1;
		PageClick = function(pageclickednumber) {  
            $("#pager").pager({ pagenumber: pageclickednumber, pagecount: pagecount, buttonClickCallback: PageClick });  
           // alert(pageclickednumber);
             $("table").find('tbody tr').hide()
            		.slice((pageclickednumber-1) * pagesize, pageclickednumber * pagesize).show();
        }
        
       $(document).ready(function(){
	    $("table").find('tbody tr').hide()
            		.slice(0, pagesize).show();
	    $("#pager").pager({ pagenumber: 1, pagecount: pagecount, buttonClickCallback: PageClick });  
	    });
			function changeValue(){
			
				var search =$.trim($("#searchTxt").val());
				if(search != null && search != ''){
					var point = $("#searchPoint").val();
					var quer = $("#find").attr('href')+"?search="+search+"&point="+point;
					
					$("#find").attr('href',quer);
				}else{
					alert("查询条件不能为空");
				}
			}
		</script>

	</head>
<body>
<h3>用户权限设置</h3>

<p>注册账户共${fn:length(info.users)}人&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<span>只查看<a href="web/man_user/setUser.jsp?admin=Y">管理员</a>/<a href="web/man_user/setUser.jsp?admin=N">用户</a></span>
<span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;检索用户
<select id="searchPoint">
	<option value="name">姓名</option>
	<option value="email">E-MAIL</option>
</select>
<input type="text" id="searchTxt"/>

<a id="find" href="web/man_user/setUser.jsp" onClick="changeValue()">查询</a>

</span>
</p>
<DIV
style="overflow: scroll; OVERFLOW-Y: auto; OVERFLOW-X: auto; MARGIN: 10px auto; WIDTH:700px; scrollbar-face-color: #889B9F;
scrollbar-shadow-color: #3D5054;
scrollbar-highlight-color: #C3D6DA;
scrollbar-3dlight-color: #3D5054;
scrollbar-darkshadow-color: #85989C;
scrollbar-track-color: #95A6AA;
scrollbar-arrow-color: #FFD6DA;">
<table border="0" bordercolor="#FFFFFF" bgcolor="#6c6c6c">
<thead>
	<tr bgcolor="#FFFFFF">
		<td class="column-short">ID</td>
		<td class="column-middle">注册时间</td>
		<td class="column-middle">电子邮件</td>
		<td class="column-short">姓名</td>
		<td class="column-short">权限</td>
		<td class="column-middle">大学</td>
		<td class="column-middle">学院</td>
		<td class="column-short">教育程度</td>
		<td class="column-middle">最近登录时间</td>
		<td class="column-short">下载</td>
		<td class="column-short">管理员权限</td>
	</tr>
</thead>
<tbody>
	<fmt:parseDate value="1971-01-01 00:00:00" var="date" pattern="yyyy-MM-dd HH:mm:ss" />
	<c:set var="compar"><fmt:formatDate value="${date}" pattern="yyyy-MM-dd HH:mm:ss" /></c:set>
	<c:forEach var="users" items="${info.users}" >
		<tr class="tab-row" bgcolor="#FFFFFF">
			<td><a href="web/man_user/setAuth.jsp?userid=${users['UserID']}" title="点击进入修改权限" class="editInfo"><c:out value="${users['UserID']}" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></td>
			<td><fmt:formatDate value="${users['RegisterDate']}" type="date" pattern="yyyy年MM月d日"/></td>
			<td><c:out value="${users['RegisterEmail']}" /></td>
			<td><c:out value="${users['Name']}" /></td>
			<td><c:out value="${users['Auth']}" /></td>
			<td><c:out value="${users['University']}" /></td>
			<td><c:out value="${users['School']}" /></td>
			<td><c:out value="${users['Education']}" /></td>
			<td>
			<c:set var="lastDate"><fmt:formatDate value="${users['LastDate']}" pattern="yyyy-MM-dd HH:mm:ss" /></c:set>
			<c:if test="${lastDate > compar}" >
			<fmt:formatDate value="${users['LastDate']}" pattern="yyyy年MM月dd日" />
			</c:if>
			</td>
			<td><c:out value="${users['Download']}" /></td>
			<td><c:out value="${users['Admin']}" /></td>
		</tr>
	</c:forEach>
</tbody>

</table>

</DIV>
   	<div id="pager" ></div> 
</body>
</html>