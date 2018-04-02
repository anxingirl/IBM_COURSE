<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    <title>My JSP 'data_cat.jsp' starting page</title>
    <script language="JavaScript" type="text/javascript"  src="js/jquery-1.7.1.js"></script>
	<script language="JavaScript" type="text/javascript"  src="js/jquery.metadata.js"></script>
    <link rel="stylesheet" type="text/css" href="style/contentFrame.css">
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">

		 <%-- 验证用户是否已经登录 --%>
	 <%@ include file="validate.jsp" %>
  </head>
	<jsp:useBean id="info" class="ibm.util.resource.Info" scope="session">
	</jsp:useBean>
	<%
		info.getAppCats();
		info.getTechCats();
		info.getDomainCats();
	 %>
  <body>
  	<script language="JavaScript" type="text/javascript">
  		$(document).ready(function(){

 			$("#confirmButton").click(function(){
 				var con = confirm("确定提交修改吗？");
 				if(con == true){
 				var appCatSelect = $("#appCatSelect option:selected").val();
 				var techCatSelect = $("#techCatSelect option:selected").val();
 				var domainCatSelect = $("#domainCatSelect option:selected").val();
 				var resourceID = $("input[name='resourceID']").val();
 				
 				
 				  	$.post("catUpload.do",{type:"user",appCatSelect:appCatSelect, techCatSelect:techCatSelect, domainCatSelect: domainCatSelect, resourceID:resourceID },
 				  	function(result){alert(result);}
 				  	);

 				}
 			});
   		});
  	</script>
  <div class="rightpart_main">
  <form id="theForm" action="" method="post">
    <table>
    	<tr class="tab-head">
    	<td class="column-middle">资源名称：</td>
    	<td class="column-middle">
    		${course.resourceName}
    		<input type="hidden" name="resourceID" value="${metadata.resourceID}"/>
       	</td>
    	</tr>
    	<tr class="tab-row">
    	<td class="column-middle"></td>
    	</tr>
    	<tr class="tab-row">
    	<td class="column-middle">合作项目类别</td>
    	<td class="column-middle">
    		<select id="appCatSelect" name="appCatSelect">
    			<option value="0">请选择</option>
				<c:forEach var="listElement" items="${info.appCats}">
				<c:choose>
				<c:when test="${courseCat.appCat == listElement['ID']}">
					<option value="${listElement['ID']}" selected="selected" >
						${listElement["CatName"]}
					</option>
					
				</c:when>	
				<c:otherwise>
					<option value="${listElement['ID']}" >
						${listElement["CatName"]}
					</option>
				</c:otherwise>
				</c:choose>
				</c:forEach>
			</select>
    	</td>
    	</tr>
    	<tr class="tab-row">
    	<td class="column-middle"></td>
    	</tr>
    	<tr class="tab-row">
    	<td class="column-middle">技术领域类别</td>
    	<td class="column-middle">
    	    <select id="techCatSelect" name="techCatSelect">
				<option value="0">请选择</option>
				<c:forEach var="listElement" items="${info.techCats}">
				<c:choose>
				<c:when test="${courseCat.techCat == listElement['ID']}">
					<option value="${listElement['ID']}" selected="selected" >
						${listElement["CatName"]}
					</option>
				</c:when>	
				<c:otherwise>
					<option value="${listElement['ID']}" >
						${listElement["CatName"]}
					</option>
				</c:otherwise>
				</c:choose>
				</c:forEach>
			</select>
    	</td>
    	</tr>
    	<tr class="tab-row">
    	<td class="column-middle"></td>
    	</tr>
    	<tr class="tab-row">
    	<td class="column-middle">行业应用类别</td>
    	<td class="column-middle">
    	    <select id="domainCatSelect" name="domainCatSelect">
				<option value="0">请选择</option>
				<c:forEach var="listElement" items="${info.domainCats}">
				<c:choose>
				<c:when test="${courseCat.domainCat == listElement['ID']}">
					<option value="${listElement['ID']}" selected="selected" >
						${listElement["CatName"]}
					</option>
				</c:when>	
				<c:otherwise>
					<option value="${listElement['ID']}" >
						${listElement["CatName"]}
					</option>
				</c:otherwise>
				</c:choose>
				</c:forEach>
			</select>
    	</td>
    	</tr>
    	<tr class="tab-row">
    		<td class="column-middle">
    		</td>
    	</tr>
    	<tr class="tab-row">
    		<td colspan="4">
    		请对资源的分类进行相应的选择，如不需要修改请点击继续，如修改则点击确定提交修改结果
    		</td>
    	</tr>
    	<tr class="tab-row">
    		<td class="column-middle">
    		</td>
    	</tr>
    	<tr class="tab-row">
    		<td colspan="3">
    		</td>
    		<td class="column-long">
    			&nbsp;&nbsp;<input id="confirmButton" type="button" value="确定"/>
    		</td>
    	</tr>
    </table>
    </form>
    </div>
  </body>
  
</html>
