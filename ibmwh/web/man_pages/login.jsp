<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		
		<script type="text/javascript">

		</script>
      <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	</head>
  
  <body>
  <br>
    <h3>管理员登录页面</h3>
	<p style="color:green;font-size:14px">
		<c:if test="${not empty param.errorMsg}">
		${param.errorMsg}
		</c:if>
	</p>
<form action="web/man_pages/authenticate.jsp" method="post">
    <table class="bigTable">
 
    	<tr  class="tab-row"><td class="column-middle"></td><td class="column-middle">注册邮箱：</td><td class="column-middle"><input type="text" name="registeEmail"/></td></tr>
    	<tr  class="tab-row"><td class="column-middle"></td></tr>
    	
    	<tr  class="tab-row"><td class="column-middle"><td class="column-middle">密码：</td><td><input type="password" name="password"/></td></tr>
    	<tr  class="tab-row"><td></td></tr>
    	
    	<tr class="tab-row"><td class="column-middle"><td class="column-middle">请输入验证码:</td><td><input type="text" name="validate"/></td><td><jsp:include page="imageFrom.jsp"></jsp:include></td></tr>
    	<tr  class="tab-row"><td></td></tr>
    	<tr  class="tab-row"><td class="column-middle"><td></td>
    	
    	<td><input type="hidden" name="origURL" value="${param.origURL}"/></td>
    	<td><input type="submit" value="登录"/></td></tr>
    	  	
    </table>
</form>
  </body>
</html>
