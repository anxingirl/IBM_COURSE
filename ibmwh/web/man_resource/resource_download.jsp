<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>

<%
    response.setCharacterEncoding("UTF-8");
    request.setCharacterEncoding("UTF-8");
%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
		<title>My JSP 'data_init.jsp' starting page</title>

		<meta http-equiv="pragma" content="no-cache">
		<meta http-equiv="cache-control" content="no-cache">
		<meta http-equiv="expires" content="0">
		<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
		<meta http-equiv="description" content="This is my page">
		<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

		<link rel="stylesheet" type="text/css" href="style/contentFrame.css">
		<link rel="stylesheet" type="text/css" href="style/tips.css" />

		<script language="JavaScript" type="text/javascript"
			src="js/jquery-1.7.1.js"></script>

		<script language="JavaScript" type="text/javascript"
			src="js/jquery.validate.js"></script>
		<script language="JavaScript" type="text/javascript"
			src="js/jquery.metadata.js"></script>
		<script language="JavaScript" type="text/javascript"
			src="js/message_cn.js"></script>
		  <%-- 验证用户是否已经登录 --%>
	 <%@ include file="validate.jsp" %>
	<jsp:useBean id="info" class="ibm.util.resource.Info" scope="session">
	</jsp:useBean>
	<jsp:useBean id="metadata" class="ibm.util.resource.Metadata" scope="page">
    </jsp:useBean>

	<% 
		info.getDownloadCats();
		int x = info.setNameAbs().size();
		System.out.println(x);
	 %>

	</head>
	<body>

	<script language="JavaScript" type="text/javascript" 
			src="js/man_resource/resource_download.js"></script>
		<script type="text/javascript">
		var arrayObj = new Array();
		
		
		
		$(document).ready(function(){
		<c:forEach var="listElement" items="${info.nameAbs}">
		var obj = new Array(3);
			obj[0] = "${listElement['ID']}";
			obj[1] = "${listElement['ResourceName']}";
			obj[2] = "${listElement['Ab']}";
			arrayObj.push(obj);
		</c:forEach>
		$("#nameText").tips({
			value: arrayObj,
			url: "getInfo.do", // JOSN 获取URL地址
			param: "ResourceName", // 获取JOSN数据时提交的参数名			
			leftText: "ResourceName",// 提示列表左边显示文字的JSON字段
			rightText: "Ab", // 提示列表右边显示文字的JSON字段
			inputText: "ResourceName", // 点击提示列表后显示在输入框内容的JSON字段
			rightTextLength: 20, // 右边数字最长的长度
			hiddenId: "nameSelect", // 隐藏域id 可选
			hiddenText: "ID", // 隐藏域值 可选
			width: 180 // 提示列表宽度，可选
		});
		
		
			$("#submit").click(function(){
				if($("#nameSelect option:selected").text() != $("#nameText").val())
					{
					alert("请输入正确的资源名称");
					return false;
				
					}
			});


		    $("#nameText").keyup(function(){
		    	var text = $.trim($("#nameText").val());
		    	if(text=="") return;
		    });

		});
	</script>

		<div class="rightpart_main">
			<form id="theForm" action="NewMetaData.do" method="post">
				<table id="theTable" style="border-collapse:collapse;">
					<tr class="tab-row">
						<td class="column-middle">资源名称:</td>
						<td style="width:180px">
							<input id="nameText" name="nameText" type="text" maxlength="20" 
							style="float:right;width:180px;height:21px;font-size:10pt;border:1px solid  #cccccc;" />
						</td>
						<td class="noblank"><select id="nameSelect" name ="nameSelect" style="width:138px;margin-left:-120px;display:none"><c:forEach var="listElement" items="${info.nameAbs}"><option value="${listElement['ID']}">${listElement["ResourceName"]}</option></c:forEach></select> <br></td>

						<td colspan="2">
							简称:
							<b id="abbText"></b>
							<b id="idtext" style="visibility:hidden"></b>
						</td>
					</tr>
					<tr class="tab-row"><td class="column-middle"></td></tr>

					<tr class="tab-row">
						<td colspan="4">&nbsp;</td>
						<td><input type="button" id="addfile" value="新添加条目"></input></td>
						<td><input type="button" id="submit" value="确认"></input></td>
					</tr>
				</table>
			
				</form>
					
		<div>
			<p id="remind">输入资源名称，对资源的下载信息进行增删改。"<img src='image/plus_magenda_12.png' />"符号=增加，点击"<img src='image/minus_magenda_12.png' />"符号=删除，"<img src='image/tag_stroke_magenda_12.png' />"符号=修改</p>
		</div>
		</div>

	</body>
</html>
