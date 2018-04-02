<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="myFunc" uri="myFunctions"%>
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
			
<%@ include file="validate.jsp" %>
	</head>

	<body>
	<c:set var="randomString" scope="request">
  	${myFunc:getRandomStr(12)} 
  </c:set>


		<div class="rightpart_main">
			<form id="theForm" action="" method="post" name="uploadform"
				enctype="multipart/form-data">
				<input type="hidden" name="tmpName" value=${randomString } />
				<table id="theTable" border="0" style="width:625px">
					<tr class="tab-head">
						<td height="43" class="column-middle">
							资源名称:
						</td>
						<td class="column-long">
							<input name="wholename" type="text" />
						</td>
						<td class="column-short">
							简称:
						</td>
						<td colspan="1">
							<input name="shortname" type="text" style="width: 60px"/>
						</td>
						<td colspan="3">
							时间：
							<select name="year" style="width: 80px"/>
								<option value="">不确定</option>
							</select>
						</td>
					
					</tr>
					<tr class="tab-row">
						<td></td>
						<td colspan="4">
						<span id="remind"></span>
						</td>
							
					</tr>

					<tr class="tab-row">
						<td class="file-row column-middle">
							文件1:
						</td>
						<td class="column-long">
							<input type="file" class="file" id="uploadfile1" name="uploadfile1"
								class="file-form"  />
							<input type="text" class="txt" name="path1" readonly  />
							<input class="small-button sel" type="button" name="select"
								value="浏览文件">
						</td>

						<td class="form-button">
						</td>
						<td class="column-short form-button">
							<input class="uploadbutton small-button" type="button" name="up" value="上传">
						</td>
						<td class="column-long pic"></td>
					</tr>
					<tr class="tab-row">
						<td colspan="4"></td>
						<td class="progressText"></td>
					</tr>


					<tr class="tab-row">
						<td class="column-middle"></td>
						
						<td class="column-short">
							仅有一个用于下载的文件：<input id="cof" type="checkbox"/>
						</td>
						<td ><br></td>
						<td class="column-short">
							<input id="insertButton" type="button" class="small-button" disabled="disabled"
								value="添加" />
						</td>
						<td class="column-short">
							<input id="finalConfirmButton" type="button" class="small-button"
								value="确认提交" />
						</td>
					</tr>
					
				</table>
			</form>
		</div>
	</body>
</html>
