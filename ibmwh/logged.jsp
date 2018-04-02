<%@page contentType="text/html;charset=utf-8"%>
<%@page import="func.*"%>
<%@page language="java" import="javax.mail.*,java.util.*,java.net.URLEncoder,javax.mail.internet.*,com.mysql.jdbc.Driver,java.sql.*,java.io.*,javax.activation.*,java.util.Date,java.text.*"%>
<%@include file="include/common.jsp"%>

<!--<link rel="Shortcut Icon" href="favicon.ico">-->

<%
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date today = new Date();
	
	//获取参数
	request.setCharacterEncoding("UTF-8");
	String para= request.getParameter("para");

	String email= request.getParameter("email");
	String pwd= request.getParameter("passwd");
	String pwdMD5=CommonEncrypt.transMD5(pwd);
	//out.print(pwd+":"+pwdMD5);

	String path=(String)session.getAttribute("path");

	Statement stmt=conn.createStatement();
	String sql="select * from User where RegisterEmail='"+email+"' and (Active is NULL or Active='')";
	ResultSet rs = stmt.executeQuery(sql); 
	if (!rs.next())
	{
		stmt.close();   
		conn.close();
%>
		<script type="text/javascript">
		alert("该用户尚未激活，请查收注册邮箱进行账户激活！");
		window.location.href="index.jsp";
		</script>
<%
		return;
	}

	sql="select * from User where RegisterEmail='"+email+"' and PassWord='"+pwdMD5+"'";
	//out.print(sql);

	rs = stmt.executeQuery(sql); 
	if (!rs.next()) {
		stmt.close();   
		conn.close(); 
%>
	<script type="text/javascript">
	alert("用户名/密码错误，请重新确认！");
<%
	if (para==null) {
%>
	window.location.href="index.jsp";
<%
	} else {
%>
	window.location.href="login.htm";
<%
	}
%>
	</script>
<%
	}
	else 
	{
		session.setAttribute("login",email);
		int id=rs.getInt("UserID");
		String auth=rs.getString("Auth");

		sql="update User set LastDate='"+formatter.format(today) + "' where RegisterEmail='"+email+"'";
		//out.print(sql);
		stmt.executeUpdate(sql);

		stmt.close();   
		conn.close(); 
		if (auth.equals("D")) {
%>
		<script type="text/javascript">
		alert("用户无查看全文与下载权限！");
		window.location.href="index.jsp";
		</script>
<%
		} 
		else {
			session.setAttribute("user",""+id);
			if (path==null) {
				response.sendRedirect("index.jsp");
				return;
			} else {
				response.sendRedirect(path+"/index.jsp");
				return;
			}
		}
	}
%>