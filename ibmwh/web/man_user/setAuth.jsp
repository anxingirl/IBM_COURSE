<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
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

		<link type="text/css"
			href="css/ui-lightness/jquery-ui-1.8.18.custom.css" rel="Stylesheet" />

		<script language="JavaScript" type="text/javascript"
			src="js/jquery-1.7.1.js"></script>

		<script language="JavaScript" type="text/javascript"
			src="js/jquery.form.js"></script>

		<script type="text/javascript" src="js/jquery-ui-1.8.18.custom.min.js"></script>

		<script language="JavaScript" type="text/javascript"
			src="js/man_resource/resource_upload.js"></script>
		  <%-- 验证用户是否已经登录 --%>
	 <%@ include file="validate.jsp" %>
	</head>

	<jsp:useBean id="user" class="ibm.util.user.User" scope="request" />

	<c:set target="${user}" property="userID" value="${param.userid}"> </c:set>
	 
		<% user.makeUser(); //执行更新bean%>
	<script language="JavaScript" type="text/javascript">
			
			function uploadUser(){
				var userID = ${user.userID};
				var auth = $("#auth").val();
				var n = $("input[name='admin']:checked").length;
				var admin = $("input[name='admin']:checked");
				var adminval = "";
				admin.each(function(){
					adminval += $(this).val() + ",";
				});
				var n = adminval.length-1;
				adminval = adminval.substr(0,adminval.length-1);
				alert(auth + "||" + adminval );
				$.post("uploadUser.do",{type:0, userID:userID, admin:adminval, auth:auth},function(result){
					alert(result);
				});
			}
	</script> 
<body>
<h3>用户ID${param.userid}</h3>
<DIV	
style="overflow: scroll; OVERFLOW-Y: auto; OVERFLOW-X: auto; MARGIN: 10px auto; WIDTH:700px; HEIGHT: 600px;scrollbar-face-color: #889B9F;
scrollbar-shadow-color: #3D5054;
scrollbar-highlight-color: #C3D6DA;
scrollbar-3dlight-color: #3D5054;
scrollbar-darkshadow-color: #85989C;
scrollbar-track-color: #95A6AA;
scrollbar-arrow-color: #FFD6DA;
">
<sql:setDataSource dataSource="jdbc/ibmcourse"/>
<!--将数据库某查询的结果申明为一个变量 -->
<sql:query var="authRs">
	select AuthName, Type from Auth 
</sql:query>
<sql:query var="adminRs">
    select Level,Descrip from AdminLevel
</sql:query>
<form action="uploadUser.do" method="post">

<table border="0" bordercolor="#FFFFFF" bgcolor="#6c6c6c">

	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-middle">注册时间</td>
	    <td><fmt:formatDate value="${user['registerDate']}" type="date" pattern="yyyy年MM月d日"/></td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-middle">电子邮件</td>
	   <td><c:out value="${user.registerEmail}" /></td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-short">姓名</td>
		<td><c:out value="${user.name}" /></td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-short">权限</td>
		<td>
		<select id="auth">
		<c:forEach var="row" items="${authRs.rows}">
			<option value="${row.Type}" 
			<c:if test="${user.auth == row.Type}">
				selected="selected"
			</c:if>
 			 >${row.AuthName}</option>
		</c:forEach> 
		</select>
		</td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-middle">大学</td>
		<td><c:out value="${user.university}" /></td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-middle">学院</td>
		<td><c:out value="${user.school}" /></td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-short">教育程度</td>
		<td><c:out value="${user.education}" /></td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-middle">最近登录时间</td>
		<td>
		<c:set var="lastDate"><fmt:formatDate value="${user['lastDate']}" pattern="yyyy-MM-dd HH:mm:ss" /></c:set>
		<fmt:parseDate value="1971-01-01 00:00:00" var="date" pattern="yyyy-MM-dd HH:mm:ss" />
		<c:set var="compar"><fmt:formatDate value="${date}" pattern="yyyy-MM-dd HH:mm:ss" /></c:set>
		<c:if test="${lastDate > compar}" >
			<fmt:formatDate value="${user['lastDate']}" pattern="yyyy年MM月dd日" />
		</c:if>
		</td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-short">下载</td>
		<td><c:out value="${user.download}" /></td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-short">管理员权限</td>
		<td>
		<c:forEach var="row" items="${adminRs.rows}">
		<c:set var="flag" value="n" /> <!-- 两个循环，找到相同值的标志 -->
			${row.Descrip}
		   <c:forEach var="ad" items="${fn:split(user.admin,',')}">
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
<p style="float:right; margin-right:100px"><input type="button" onclick="uploadUser()" value="确认修改权限"/></p>
</form>
</DIV>


</body>
</html>