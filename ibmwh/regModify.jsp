<%@page contentType="text/html;charset=utf-8"%>
<%@page import="func.*"%>
<%@page language="java" import="javax.mail.*,java.util.*,java.net.URLEncoder,javax.mail.internet.*,com.mysql.jdbc.Driver,java.sql.*,java.io.*,javax.activation.*,java.util.Date,java.text.*"%>
<%@include file="include/common.jsp"%>

<!--<link rel="Shortcut Icon" href="favicon.ico">-->

<%
	request.setCharacterEncoding("utf-8");
	//String email= request.getParameter("email");
	String email=(String)session.getAttribute("login");
	String post= request.getParameter("post");
	String edu1= request.getParameter("edu1");
	String edu2= request.getParameter("edu2");
	String edu="";
	if (post.equals("S")) 
	{
		edu=edu1; 
	}else {
		edu=edu2;
	}
	String school= request.getParameter("school");
	String name= request.getParameter("name");
	String tel= request.getParameter("tel");
	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date today = new Date();

	String newpwd= request.getParameter("newpwd");
	String newpwd1= request.getParameter("newpwd1");
	String oldpwd= request.getParameter("oldpwd");
	String oldpwdMD5=CommonEncrypt.transMD5(oldpwd);
	String message="";
	//out.print(newpwd+":"+newpwd1+":"+oldpwd);

	if (!newpwd.equals(newpwd1)) {
		message="新密码两次输入不一致，请重新输入！";
		message=URLEncoder.encode(message, "utf-8");
		message="email="+email+"&message="+message;
		//out.print(message);
		response.sendRedirect("user.jsp?"+message);
		return;
	}
	
	if (!oldpwd.equals("") && newpwd.equals("")) {	
		message="新密码不能为空，请输入！";
		message=URLEncoder.encode(message, "utf-8");
		message="email="+email+"&message="+message;
		response.sendRedirect("user.jsp?"+message);
		return;
	}

	Statement stmt=conn.createStatement();
	String sql="select * from User where RegisterEmail='"+email+"' and PassWord='"+oldpwdMD5+"'";
	//out.print(sql);
	
	//不修改密码
	if (newpwd.equals("") && newpwd1.equals("") && oldpwd.equals("")) {
		sql="update User set LastDate='"+formatter.format(today) + "', School='"+school+"', Post='" + post + "', Education='"+edu+"', Name='"+name+"', Tel='"+tel+"' where RegisterEmail='"+email+"'";
		//out.print(sql);
	}
	else {
		ResultSet rs = stmt.executeQuery(sql); 
		if (!rs.next()) {
			stmt.close();   
			conn.close(); 
			message="旧密码输入错误，请重新输入！";
			message=URLEncoder.encode(message, "utf-8");
			message="email="+email+"&message="+message;
			response.sendRedirect("user.jsp?"+message);
			return;
		}
		else {
			String pwdMD5=CommonEncrypt.transMD5(newpwd);
			sql="update User set LastDate='"+formatter.format(today) + "', PassWord='"+pwdMD5+"', School='"+school+"', Post='" + post + "', Education='"+edu+"', Name='"+name+"', Tel='"+tel+"' where RegisterEmail='"+email+"'";
		}
	}
	//out.print(sql);
	stmt.executeUpdate(sql);	
		
	stmt.close();   
	conn.close(); 
	response.sendRedirect("index.jsp");
	return;
%>