<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<script language="JavaScript" type="text/javascript">
	function fclick(obj){
   with(obj){
     style.posTop=event.srcElement.offsetTop //设置透明上传框的Y坐标跟模拟按钮的Y坐标对齐
     style.posLeft=event.x-offsetWidth/2   //设置透明上传框的X坐标为鼠标在X轴上的坐标加上它的宽的一半(确保点击时能点中透明上传框的按钮控件)，这里只是提供一种思路，其实还可以更精确的控制它的X坐标范围
   }
}
</script>
<title>input file的另类做法</title>
<style type="text/css">
.input{border:1px solid #f60;color:#666666;font:normal 12px Tahoma;height:18px}
.submit{background:#b1df27;color:#fff;border:1px #7ca700 solid}
</style>
</head>
<body>
<form method="post" action="" >
<table>
<tr>
<td>
<input id="f_file" class="input" value="选择上传文件" > 
<input type="button" onmouseover="fclick(t_file)" value="浏 览" class="submit">
<input name="upload" type="file" style="position:absolute;filter:alpha(opacity=0);opacity:10;width:30px;" id="t_file" onchange="f_file.value=this.value" hidefocus>
<input type="submit" value="确 定"  class="submit"></td></tr></table>

</form>
</body>
</html>
