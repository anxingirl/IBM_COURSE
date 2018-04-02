<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'imageFrom.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta http-equiv="content-type" content="image/jpg; charset=UTF-8">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

	<script type="text/javascript">
		function getValidate(){
			var pic = document.getElementById("src1");
			pic.src="ValidateCodeServlet.do";
		}
	</script>
  </head>
  
  <body>
    ${basePath}
   	<img src="ValidateCodeServlet.do?theDate=<%= java.lang.System.currentTimeMillis()%>" id="src1" width="60" height="20" alt="图片看不清?点击换一张" onclick="getValidate()" />
  </body>
</html>
