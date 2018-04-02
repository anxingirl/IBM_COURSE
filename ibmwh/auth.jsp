<%@page contentType="text/html;charset=utf-8"%>
<%@page import="func.*"%>
<%@page language="java" import="javax.mail.*,java.util.*,java.net.URLEncoder,javax.mail.internet.*,com.mysql.jdbc.Driver,java.sql.*,java.io.*,javax.activation.*,java.util.Date,java.text.*"%>
<%@include file="include/common.jsp"%>

<%
	request.setCharacterEncoding("UTF-8");
	String logged=(String)session.getAttribute("login");
	String path= request.getParameter("path");
	String resourceid= request.getParameter("id");
	session.setAttribute("resource",resourceid);

	//out.print(path);
	if (path!=null) {
		session.setAttribute("path",path);
	}

	if (logged==null && path!=null) {
		response.sendRedirect("login.htm");
		return;
	}
	if (logged==null && path==null) {
		response.sendRedirect("index.jsp");
		return;
	} 
	if (logged!=null && path!=null){
		Statement stmt=conn.createStatement();
		String sql="select * from User where RegisterEmail='"+ logged +"' and Auth!='D'";
		//out.print(sql);
		ResultSet rs = stmt.executeQuery(sql); 
		if (rs.next()) {
			stmt.close();
			conn.close();
			response.sendRedirect(path+"/index.jsp");
			return;
		}
		else {
			stmt.close();
			conn.close();
	%>
			<script type="text/javascript">
			alert("受限访问用户，不能浏览全文！");
			window.location.href="index.jsp";
			</script>
	<%
			//response.sendRedirect("index.jsp");
			//return;
		}
	}

%>
