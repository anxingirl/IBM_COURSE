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
	<script type="text/javascript">
		$(document).ready(function(){
		 $("input").focus(function(e){
  			  $(e.target).css("background-color","#FFFFFF");
  		});
  		$("input").blur(function(e){
   			 $(e.target).css("background-color","#FFD2D2");
  		});
			$(".showUp").click(function(e){
				var z = $(e.target).closest("tr").nextAll(".addOn").get(0);
				$(z).slideToggle("slow");
			});
			
			$(".upload").click(function(e){
				
				var type = $(e.target).closest("td").prev("td").prev("td").children("input").val();
				var text1 = $.trim($(e.target).closest("td").prev("td").children("input").val());
				var text2 = $.trim($(e.target).closest("td").children("input").val());
				
				if(text1 == "" || text2 == "")
					{alert("必填项请填写");
						return false;
					}
				$.post("catUpload.do",{type:type,CatName:text2,CatType:text1},function(result){
					
				   alert(result);
				   location.reload();
				});
			});
		});
		
	</script>
	  <%-- 验证用户是否已经登录 --%>
	<%@ include file="validate.jsp" %>
	
	<jsp:useBean id="info" class="ibm.util.resource.Info" scope="session">
	</jsp:useBean>	
	<%

		info.getDownloadCats();
	 %>
  </head>
  
  <body>
    	<h3>设置下载分类 </h3>
    	<table class="bigTable" border="0" bordercolor="#FFFFFF" bgcolor="#6c6c6c">
    		<thead>
    			<tr bgcolor="#c6c6c6" class="tab-head">
    				<td class="column-middle">下载类型</td><td class="column-short">分类</td><td class="column-long">类型</td>
    			</tr>
    		</thead>
    		<tbody>
    		<c:set var="tag" value="1"/>
    		<c:forEach var="listElement" items="${info.downloadCats}">
    		    <tr bgcolor="#FFFFFF" class="tab-row">
    		    	<td class="showTd">
    		    		<c:if test="${tag == '1'}">
    		    			下载类型&nbsp;&nbsp;<A class="showUp" title="新建下载类型">&nbsp;&nbsp;&nbsp;&nbsp;</A>
    		    			<c:set var="tag" value="2"/>
    		    		</c:if>
    		    	</td>
    		   		 <td>
    		   		 	${listElement['Type']}
    		   		 </td>
    				<td>
    					${listElement['DownloadCatName']}
    				</td>
    			</tr>
    		</c:forEach>
    		<tr class="tab-row addOn"  bgcolor="#FFFFFF">
    			<td><input type="hidden" value="DownloadCat"/></td>
    			<td><input type="text" name="text1" size=5 style={background-color:#FFD2D2} /></td>
    			<td><input type="text" name="text2" size=25 style={background-color:#FFD2D2} />
    			<a class="upload">确定添加</a>
    			</td>
    		</tr>

    		</tbody>
    	</table>
  </body>
</html>
