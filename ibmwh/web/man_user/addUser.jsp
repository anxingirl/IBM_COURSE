<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
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
	  <%-- 验证用户是否已经登录 --%>
	 <%@ include file="validate.jsp" %>
	</head>
	<jsp:useBean id="info" class="ibm.util.resource.Info" scope="session">
	</jsp:useBean>	
	<jsp:useBean id="user" class="ibm.util.user.User" scope="request" />
	 
		
	<script language="JavaScript" type="text/javascript">
			
			function checkValue(){
				var res = true;
				var email = $.trim($("#email").val());
				var name = $.trim($("#name").val());
				var password = $("#password").val();
				var again = $("#again").val();
				if(email == "" || name == "" || password == "" || again == ""){
					$("#remind").html("<div class='input_tip_wrong'>带'*'号的项为必填</div>");
					return false;
				}
				//电子邮件格式
				var pattern = new RegExp(/^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]+$/);
				if(!pattern.test(email)){
					$("#remind").html("<div class='input_tip_wrong'>请输入正确的电子邮件格式</div>");
					return false;
				}
				//验证密码是否已经超过六位,只包含数字 字母
				pattern = new RegExp(/^[a-zA-Z0-9_@]{6,16}/);
			
				if(!pattern.test(password)){
					$("#remind").html("<div class='input_tip_wrong'>请输入正确的密码格式</div>");
					return false;
				}
				
				//验证两次输入的密码是否相同
				if(again != password){
					$("#remind").html("<div class='input_tip_wrong'>两次输入的密码不同！</div>");
					return false;
				}
				
				
				//验证是否已经有该用户email
				$.ajax({
					url: "getUsedEmail.do",
					type: "GET",
					dataType: "text",
					data: "email=" + email,
					async: false,
					success: function(data){
						//alert(data);
						if(data == 'true'){
							$("#remind").html('<div class="input_tip_wrong">该Email已经注册</div>');
							res = false;
						}
					}
				});
				return res;
			}
			
			function uploadUser(){
				if(!checkValue())
					return false;
				var auth = $("#auth").val();
				var email = $.trim($("#email").val());
				var name = $.trim($("#name").val());
				var university = $.trim($("#university").val());
				var education = $("#education option:selected").val();
				var school = $.trim($("#school").val());
				var n = $("input[name='admin']:checked").length;
				var admin = $("input[name='admin']:checked");
				var password = $("#password").val();
				var adminval = "";
				admin.each(function(){
					adminval += $(this).val() + ",";
				});
				var n = adminval.length-1;
				adminval = adminval.substr(0,adminval.length-1);
				alert(auth + "||" + adminval );
				$.post("uploadUser.do",
				{type:1,password:password,admin:adminval,name:name,education:education, auth:auth, university:university, school:school, email:email},
				function(result){
					alert(result);
				});
			}
	</script> 
<body>
<h3>新建用户</h3>
<p id="remind"></p>
<DIV	
style="overflow: scroll; OVERFLOW-Y: auto; OVERFLOW-X: auto; MARGIN: 10px auto; WIDTH:700px; HEIGHT: 600px;scrollbar-face-color: #889B9F;
scrollbar-shadow-color: #3D5054;
scrollbar-highlight-color: #C3D6DA;
scrollbar-3dlight-color: #3D5054;
scrollbar-darkshadow-color: #85989C;
scrollbar-track-color: #95A6AA;
scrollbar-arrow-color: #FFD6DA;
">
<sql:setDataSource dataSource="jdbc/ibmcourse"/>
<!--将数据库某查询的结果申明为一个变量 -->
<sql:query var="authRs">
	select AuthName, Type from Auth 
</sql:query>
<sql:query var="adminRs">
    select Level,Descrip from AdminLevel
</sql:query>
<form action="uploadUser.do" method="post">

<table>

	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-middle">电子邮件</td>
	   <td>
	   		<input id="email" name="email" type="text"/>  &nbsp;&nbsp;&nbsp;*
	   </td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-short">姓名</td>
		<td>
			<input id="name" name="name" type="text"/>  &nbsp;&nbsp;&nbsp;*
		</td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-short">密码</td>
		<td>
			<input id="password" name="password" type="password"/>  &nbsp;&nbsp;&nbsp;* 请输入6-16位密码，可使用数字、 字母（分大小写）、“_”和"@"符号
		</td>
	</tr>
		<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-short">再次输入密码</td>
		<td>
			<input id="again" name="again" type="password"/>  &nbsp;&nbsp;&nbsp;*
		</td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-short">权限</td>
		<td>
		<select id="auth">
		<c:forEach var="row" items="${authRs.rows}">
			<option value="${row.Type}">${row.AuthName}</option>
		</c:forEach> 
		</select>
		</td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-middle">大学</td>
		<td>
			<input id="university" name="university" type="text"/>
		</td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-middle">学院</td>
		<td>
			<input id="school" name="school" type="text"/>
		</td>
	</tr>
	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-short">教育程度</td>
		<td>
		<select id="education">
			<c:forEach var="education" items="${info.education}" >
			<option value="${education['Level']}"> ${education['Descript']}</option>
			</c:forEach>
		</select>
		</td>
	</tr>

	<tr class="tab-row"  bgcolor="#FFFFFF">
		<td class="column-short">管理员权限</td>
		<td>
		<c:forEach var="row" items="${adminRs.rows}">
			${row.Descrip}
			 <input type="checkbox" name="admin" value="${row.Level}"/> 
		</c:forEach>
		 </td>
	</tr>
	
</table>
<p style="float:right; margin-right:100px"><input type="button" onclick="uploadUser()" value="确认添加此用户"/></p>
</form>
</DIV>


</body>
</html>