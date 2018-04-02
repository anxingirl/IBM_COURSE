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
    
  <% session.invalidate(); %>
  
  <c:redirect url="login.jsp" />
  </body>
</html>
