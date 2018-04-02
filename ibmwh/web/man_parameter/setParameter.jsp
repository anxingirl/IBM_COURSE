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
    
    <title>My JSP 'setParameter.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<script language="JavaScript" type="text/javascript"
			src="js/jquery-1.7.1.js"></script>	
	<script type="text/javascript">
		$(document).ready(function(){
			$("#changeParam").click(function(){
				var text = $.trim($("input[name='pagesize']").val());
				var pattern = new RegExp(/^[0-9]{1,3}$/);
				if(!pattern.test(text)){
					alert("最大设置不超过1000");
					return false;
				}
	     
				$.post("updateParams.do",{pagesize:text},function(result){alert(result);
					 location.reload();
				});
			});
		});
	</script>
	   <%-- 验证用户是否已经登录 --%>
	<%@ include file="validate.jsp" %>
  </head>
  
  <body>

     <br>
    
     <table>
     	<tr>
     		<td> <h3>设置参数</h3></td>
     	</tr>
     	<tr>
     		<td>设置页面最大显示行数：</td>
     		<td><input type="text" size="10" name="pagesize" value=${dog.pagesize} /></td>
     		<td><input id="changeParam" type="button" value="确认修改"/></td>
     	</tr>
     </table>
	

  </body>
</html>
