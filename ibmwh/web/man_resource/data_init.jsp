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
			src="js/tips.js"></script>
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

	<% int 	x = info.setNameAbs().size();
		System.out.println(x);
	 %>

	</head>
	<body>
		<script type="text/javascript">
		var arrayObj = new Array();
		
		$.fn.clearForm = function(){
			return this.each(function(){
				var type = this.type, tag = this.tagName.toLowerCase(),name = this.name.toLowerCase();
				if(tag == 'form')
					return $(':input',this).clearForm();
				if(type == 'text'&& name != "nametext" || type == 'password')
					this.value = '';
				else if(type == 'textarea')
					$(this).text('');
				else if(type == 'checkbox' || type == 'radio')
					$(this).attr("checked",false);
			});
		};

		
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
		
		
			$(":submit").click(function(){
				if($("#nameSelect option:selected").text() != $("#nameText").val())
					{
					alert("请输入正确的资源名称");
					return false;
					}
			});
			$("#continueButton").click(function(){
				if($("#nameSelect option:selected").text() != $("#nameText").val())
					{
					alert("请输入正确的资源名称");
					return false;
				}
				if($("#newFlag").val() == "Y"){
					alert("该资源尚未建立，不能放弃修改");
					return false;
				}
 				var con = confirm("确定要放弃修改吗？");
 				if(con == true){
 				   $("#conFlag").val("Y");
 				   $(":submit").click();
 				}
 				
 			});
		    $("#theForm").validate();
		    
		    $("#nameText").keyup(function(){
		    	var text = $.trim($("#nameText").val());
		    	if(text=="") return;
		    	//$("#nameSelect option").remove();
		    	/*
		    	$.ajax({
		    		url:'getInfo.do',
					type:'POST',
					data:{ResourceName:text},
					dataType:'json',
					success:function(result){
						if(result.prompt == "Y"){
							$.each(result.value,function(i,n){
								$("#nameSelect").append("<option value='"+n.ID+"'>"+n.ResourceName+"</option>");
								
							});	
						}
					}
		    	});
		    	*/
		    	
		    });



		});
	</script>

		<div class="rightpart_main">
			<form id="theForm" action="NewMetaData.do" method="post">
				<table style="border-collapse:collapse;">
					<tr class="tab-row">
						<td class="column-middle">资源名称:</td>
						<td style="width:180px">
							<input id="nameText" name="nameText" type="text" maxlength="20" 
							style="float:right;width:180px;height:21px;font-size:10pt;border:1px solid  #cccccc;" />
						</td>
						<td class="noblank"><select id="nameSelect" name ="nameSelect" style="width:138px;margin-left:-120px;display:none"><c:forEach var="listElement" items="${info.nameAbs}"><option value="${listElement['ID']}">${listElement["ResourceName"]}</option></c:forEach></select> </td>

						<td colspan="2">
							简称:
							<b id="abbText"></b>	
						</td>
					</tr>
					<tr class="tab-row">
						<td class="column-middle"></td>
					</tr>
					<tr class="tab-row">
						<td>
						<input type="hidden" id="newFlag"   name="newFlag" value="N"/>
						<input type="hidden" id="conFlag"   name="conFlag" value="N"/>
							学校名称:
						</td>
						<td colspan="1">
							<input type="text" name="schoolName" class="required" style="width:180px;float:right;"/>
						</td>
						<td></td>
						<td class="column-short">
							含试题:
						</td>
						<td class="column-middle">
							<input type="radio" name="conExam" value="Y"/>
							是
							<input type="radio" name="conExam" value="N"/>
							否
						</td>
					</tr>
					<tr class="tab-row">
						<td class="column-middle"></td>
					</tr>
					<tr class="tab-row">
						<td class="column-middle">
							使用对象:
						</td>
						
						<td colspan="1">
							<input type="text" name="users" class="{required:true,minlength:2}" style="width:180px;float:right;"/>
						</td>
						<td></td>
						<td class="column-short">
							含实验:
						</td>
						<td class="column-middle">
							<input type="radio" name="conTest" value="Y"/>
							是
							<input type="radio" name="conTest" value="N"/>
							否
						</td>
					</tr>
					<tr class="tab-row">
						<td class="column-middle"></td>
					</tr>
					<tr class="tab-row">
						<td class="column-middle">
						授课老师:
						</td>
						<td colspan="1">
							<input type="text" name="teacher" class="{required:true,length:100}" style="width:180px;float:right;"/>
						</td>
						<td></td>
						<td class="column-short">
							含案例:
						</td>
						<td class="column-middle">
							<input type="radio" name="conCase" value="Y"/>
							是
							<input type="radio" name="conCase" value="N"/>
							否
						</td>
					</tr>
					<tr class="tab-row">
						<td class="column-middle"></td>
					</tr>
					<tr class="tab-row">
						
					</tr>
					<tr class="tab-row">
						<td class="column-middle">
							知识点:
						</td>
						
						<td class="column-middle" colspan='3'>
							<input type="text" name="knowPoints" size="45" class="{required:true,maxlengh:200}" />
						</td>
						<td class="column-short"></td>
						
					</tr>
					<tr class="tab-row">
						<td class="column-middle"></td>
					</tr>
					<tr class="tab-row">
						<td class="column-middle">
							关键字:
						</td>
						
						<td class="column-middle" colspan='3'>
							<input type="text" name="keyPoints" size="45" class="{required:true,maxLength:200}" />
						</td>
						<td class="column-short"></td>
						
					</tr>

					<tr class="tab-row">
						<td class="column-short"></td>
					</tr>

					<tr class="tab-row">
						<td class="column-short">学习建议</td>
						<td rowspan="" colspan="4">
							<textarea name="suggest" rows="3" cols="45"></textarea>
						</td>
					</tr>
					<tr class="tab-row">
						<td class="column-short"></td>
					</tr>

					<tr class="tab-row">
						<td class="column-short">教材</td>
						<td rowspan="" colspan="4">
							<textarea name="material" rows="3" cols="45" ></textarea>
						</td>
					</tr>					
					<tr class="tab-row">
						<td class="column-middle" colspan="3"></td>
						<td class="column-middle">
							<input id="continueButton" type="button" value="继续"/>
						</td>
						<td class="column-middle">
							<input type="submit" id="formSubmit" value="提交" />
						</td>
					</tr>
				</table>
			</form>
		</div>
	</body>
</html>
