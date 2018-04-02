<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="myFunc" uri="myFunctions"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
<%@ include file="validate.jsp" %>
	</head>
  
  <body>
  <jsp:useBean id="metadata" class="ibm.util.resource.Metadata"></jsp:useBean>
  
    <div class="pathinfo">当前处理的资源名称：</div>
    <div class="pathinfo">简称：</div>
    <div class="rightpart_main">
    <form>
    	<table>
    		<tr>
    			<td>资源名称:</td> <td><input type="text" name="name"/></td>
    			<td>简称:</td> <td><input type="text" name="ab"/></td>
    		</tr>
    		<tr>
    			<td>学校名称:</td> <td><input type="text" name="schoolName"/></td>
    			<td rowspan="3">学习建议:</td> <td rowspan="3"><input type="text" name="suggest"/></td>
    		</tr>
    		<tr>
    			<td>授课老师:</td> <td><input type="text" name="teacher"/></td>
    			<td>课程类别:</td> <td><input type="text" name="dataType"/></td>
    		</tr>
    		<tr>
    			<td>参考资料:</td> <td><input type="text" name="refference"/></td>
    		</tr>
    		<tr>
    			<td>知识点:</td> <td><input type="text" name="knowPoints"/></td>
    			<td>含试题:</td> <td><input type="radio" name="conExam"/>是<input type="radio"/>否</td>
    		</tr>
    		<tr>
    			<td>关键字:</td> <td><input type="text" name="keyPoints"/></td>
    			<td>含实验:</td> <td><input type="radio" name="conTest"/>是<input type="radio"/>否</td>
    		</tr>
    		<tr>
    			<td>使用对象:</td> <td><input type="text" name="users"/></td>
    			<td>含案例:</td> <td><input type="radio" name="conCase"/>是<input type="radio"/>否</td>
    		</tr>
    		<tr>
    			<td colspan="3"></td>
    			<td><input type="button" value="提交" /></td>
    		</tr>
    	</table>
    </form>
    </div>
  </body>
</html>
