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
	<link rel="stylesheet" type="text/css" href="style/pager.css">
	<script language="JavaScript" type="text/javascript"
			src="js/jquery-1.7.1.js"></script>
	  <%-- 验证用户是否已经登录 --%>
	  <%@ include file="validate.jsp" %>
	<jsp:useBean id="info" class="ibm.util.resource.Info" scope="session">
	
	</jsp:useBean>	
	<%
		info.getUserDownload();
	 %>  
	 <script language="JavaScript" type="text/javascript" src="js/jQuery.page.js"></script>
	  <script type="text/javascript">
	   var mount = ${fn:length(info.userDownload)};
	   var pagesize = 2;
	   var pagecount = mount/pagesize;
	   if(mount%2>0) pagecount = pagecount+1;
		PageClick = function(pageclickednumber) {  
            $("#pager").pager({ pagenumber: pageclickednumber, pagecount: pagecount, buttonClickCallback: PageClick });  
           // alert(pageclickednumber);
             $("table").find('tbody tr').hide()
            		.slice((pageclickednumber-1) * pagesize, pageclickednumber * pagesize).show();
        }
	$(document).ready(function(){
	    $("table").find('tbody tr').hide()
            		.slice(0, 2).show();
	    $("#pager").pager({ pagenumber: 1, pagecount: pagecount, buttonClickCallback: PageClick });  
  
 	 //capture click events on the body and then work out if the target was then menu div. If it wasn't, 
	//then the user has clicked elsewhere and the div needs to be hidden.
	    $("body").click(function(e) {
	     var x = e.target;
	     if($(x).attr("class") == "floatLink"){
	     

    		$.post("getMoreInfo.do",{UserID:$.trim($(x).text()),Type:"user"},function(result){

    			$("#floatTable tbody").html("");

    			$.each(result, function(i,n){

    				$("#floatTable tbody").append("<tr class='tab-row' bgcolor='#FFFFFF'><td>"+n.DownloadID+"</td><td>"+ n.Counts + "</td><td>" +n.LastDate + "</td></tr>");

    			});
    			   	$(".floatUp").animate({left:e.pageX - 80,top:e.pageY});

    				$(".floatUp").show();
    		});
	     } 
	     //判断当前元素师否是被筛选元素的子元素或者本身
	     else if($(x).closest(".floatUp").length <= 0){

       		 $(".floatUp").hide();
	     	
	     }
  
    });

	});

	</script>
	

  </head>
  
  <body>
    	<h3>用户下载情况 </h3>
    	 <div class="floatUp">
    		<table id="floatTable" class="smallTable" border="0" bordercolor="#FFFFFF" bgcolor="#64B1C6">
    			<thead>
    			<tr class="tab-head" bgcolor="#7ABECC">
    				<td class="column-short">下载ID</td>
    				<td class="column-short">次数</td>
    				<td class="column-middle">最近一次下载时间</td>
    			</tr>
    			</thead>
    			<tbody>
    			</tbody>
    		</table>
    	</div>
    	<table class="bigTable" border="0" bordercolor="#FFFFFF" bgcolor="#6c6c6c">
    		<thead>
    			<tr class="tab-head" bgcolor="#c6c6c6">
    				<td class="column-short">用户ID</td><td class="column-middle">用户名称</td><td class="column-middle">用户注册邮箱</td><td class="column-middle">下载资源次数</td>
    			</tr>
    		</thead>
    		<tbody>
    		<c:forEach var="listElement" items="${info.userDownload}">
    		    <tr class="tab-row" bgcolor="#FFFFFF">
    		   		 <td class="column-short">
    		   		 		<A class="floatLink" title="点击查看详情">${listElement['UserID']}&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</A>
    		   		 </td>
    				<td>
    					${listElement['Name']}
    				</td>
    				<td>
    					${listElement['RegisterEmail']}
    				</td>
    				<td>
    					${listElement['SUM']}
    				</td>
    		
    			</tr>
    		</c:forEach>

    		</tbody>
    	</table>
    	<div id="pager" ></div> 
  </body>
</html>
