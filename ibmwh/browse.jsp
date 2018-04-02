<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="func.*"%>
<%@page language="java" import="javax.mail.*,java.net.URLEncoder,java.util.*,javax.mail.internet.*,com.mysql.jdbc.Driver,java.sql.*,java.io.*,javax.activation.*,java.util.Date,java.text.*,java.util.Random"%>
<%@include file="include/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html>  
<head>  
<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />  
<title>IBM-高校合作资料中心</title>  
<link href="css/default.css" rel="stylesheet" type="text/css" />
</head>  
<%
	request.setCharacterEncoding("UTF-8");
	String cat= request.getParameter("cat");
	String id= request.getParameter("id");
	String logged=(String)session.getAttribute("login");

%>

<body>  
<div id="container">  
	<div id="header">
		<div id="logo"></div>
		<div id="banner"></div>
	</div> 
	<div id="nav">
		<div id="menu">
		<ul>
			<li><a href="index.jsp">首页</a></li>
			<%
			if (logged==null) {
			%>
			<li><a href="reg.htm">注册</a>&nbsp;/&nbsp;<a href="login.htm">登录</a></li>
			<%
			} else {
			%>
			<li><a href="reg.htm">注册</a>&nbsp;/&nbsp;<a href="user.jsp"><%=logged%></a>&nbsp;<a href="logout.jsp">退出</a></li>
			<%
			}
			%>			
			<li><a href="#">访问/下载统计</a></li>
		</ul>
		</div>
	</div>
	<div id="main-template">
		<%
			Statement stmt=conn.createStatement();
			Statement stmt1=conn.createStatement();
			ResultSet rs,rs1;
			String sql="",title="",year="";
			if (cat.equals("A")) {
				sql="select * from Cat where ID="+id;
				rs = stmt.executeQuery(sql); 
				if (rs.next()) {
					title=rs.getString("CatName");
				}
				sql="select * from ResourceAppCat where Cat="+id;
			}

			if (cat.equals("T")) {
				sql="select * from TechCat where ID="+id;
				rs = stmt.executeQuery(sql); 
				if (rs.next()) {
					title=rs.getString("TechCatName");
				}
				sql="select * from ResourceTechCat where Cat="+id;
			}
			if (cat.equals("Y")) {
				title=id;
				sql="select * from ResourceSummary where Year='"+id+"'";
			}
			if (cat.equals("D")) {
				sql="select * from DomainCat where ID="+id;
				rs = stmt.executeQuery(sql); 
				if (rs.next()) {
					title=rs.getString("DomainName");
				}
				sql="select * from ResourceDomainCat where ID="+id;
			}

			String ResourceName="",ResourceNameUTF8="",ResourceAb="",filename="",filenameUTF8="";
			int Resourceid;
		%>
		<div id="headline"><h2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=title%></h2></div>
		<div id="classification">
		  <table width="100%" border="0" cellpadding="2" cellspacing="15">
		<%
			rs = stmt.executeQuery(sql); 
			while (rs.next())
			{
		%>
			<tr>
		<%
				if (cat.equals("Y")) 
				{
					Resourceid=rs.getInt("ID");
					ResourceName=rs.getString("ResourceName");
					ResourceNameUTF8=URLEncoder.encode(ResourceName,"UTF-8");
					ResourceAb=rs.getString("Ab");
					year=rs.getString("Year");
					
					filename=rs.getString("filename");
					if (filename == null || filename =="")
					{
		%>
                <td height="35" width="33%"><a href="metadata.jsp?ab=<%=ResourceAb%>&id=<%=Resourceid%>&name=<%=ResourceNameUTF8%>"><%=ResourceName%>(<%=year%>)</a></td>

		<%
					}
					else
					{
						String route=rs.getString("Route");
		%>
 				<td height="60" width="33%"><a href="down.jsp?path=<%=route%>&name=<%=filename%>&id=<%=Resourceid%>"><%=ResourceName%>(<%=year%>)<br>:<%=filename%></a></td>
		<%
					}
				}
				else
				{
					Resourceid=rs.getInt("ResourceID");
					sql="select * from ResourceSummary where id="+Resourceid;

					rs1 = stmt1.executeQuery(sql); 
					if (rs1.next()) {
						ResourceName=rs1.getString("ResourceName");
						ResourceNameUTF8=URLEncoder.encode(ResourceName,"UTF-8");
						ResourceAb=rs1.getString("Ab");
						year=rs1.getString("Year");

						filename=rs1.getString("filename");
						if (filename == null || filename == "")
						{
		%>
         <!--     <td height="35"><a href="auth.jsp?path=courses/<%=ResourceAb%>&id=<%=Resourceid%>"><%=ResourceName%>(<%=year%>)</a></td> -->
 				<td height="35" width="33%"><a href="metadata.jsp?ab=<%=ResourceAb%>&id=<%=Resourceid%>&name=<%=ResourceNameUTF8%>"><%=ResourceName%>(<%=year%>)</a></td>

		<%
						}
					else
						{
							String route=rs1.getString("Route");
		%>
				<td height="60" width="33%"><a href="down.jsp?path=<%=route%>&name=<%=filename%>&id=<%=Resourceid%>"><%=ResourceName%>(<%=year%>)<br>:<%=filename%></a></td>
 		<!--		<td height="60" width="33%"><a href="down.jsp?path=<%=route%>&name=<%=filename%>&id=<%=Resourceid%>"><%=ResourceName%>(<%=year%>)<br>:<%=filename%></a></td> -->
		<%
						}
					}
				}

				if (rs.next()) {
					if (cat.equals("Y")) 
					{
						ResourceName=rs.getString("ResourceName");
						ResourceNameUTF8=URLEncoder.encode(ResourceName,"UTF-8");
						ResourceAb=rs.getString("Ab");
						year=rs.getString("Year");
	
						filename=rs.getString("filename");
						if (filename == null || filename =="")
						{
		%>
				<td height="35" width="33%"><a href="metadata.jsp?ab=<%=ResourceAb%>&id=<%=Resourceid%>&name=<%=ResourceNameUTF8%>"><%=ResourceName%>(<%=year%>)</a></td>

		<%
						}
						else
						{
							String route=rs.getString("Route");
		%>
				<td height="60" width="33%"><a href="down.jsp?path=<%=route%>&name=<%=filename%>&id=<%=Resourceid%>"><%=ResourceName%>(<%=year%>)<br>:<%=filename%></a></td>
 		<!--		<td height="60" width="33%"><a href="down.jsp?path=<%=route%>&name=<%=filename%>&id=<%=Resourceid%>"><%=ResourceName%>(<%=year%>)<br>:<%=filename%></a></td> -->
		<%
						}
					}
					else
					{
						Resourceid=rs.getInt("ResourceID");
						sql="select * from ResourceSummary where id="+Resourceid;

						rs1 = stmt1.executeQuery(sql); 
						if (rs1.next()) {
							ResourceName=rs1.getString("ResourceName");
							ResourceNameUTF8=URLEncoder.encode(ResourceName,"UTF-8");
							ResourceAb=rs1.getString("Ab");

							filename=rs1.getString("filename");
							//
							if (filename == null || filename =="")
							{
		%>
			  <td height="35" width="33%"><a href="metadata.jsp?ab=<%=ResourceAb%>&id=<%=Resourceid%>&name=<%=ResourceNameUTF8%>"><%=ResourceName%>(<%=year%>)</a></td>
		<%
							}
							else
							{
								String route=rs1.getString("Route");
		%>
				<td height="60" width="33%"><a href="down.jsp?path=<%=route%>&name=<%=filename%>&id=<%=Resourceid%>"><%=ResourceName%>(<%=year%>)<br>:<%=filename%></a></td>
 		<!--		<td height="60" width="33%"><a href="down.jsp?path=<%=route%>&name=<%=filename%>&id=<%=Resourceid%>"><%=ResourceName%>(<%=year%>)<br>:<%=filename%></a></td> -->
		<%
							}
						}
					}
				}
				else {
		%>
			 <td>&nbsp;</td>
		<%
				}

				if (rs.next()) {
					if (cat.equals("Y")) 
					{
						ResourceName=rs.getString("ResourceName");
						ResourceNameUTF8=URLEncoder.encode(ResourceName,"UTF-8");
						ResourceAb=rs.getString("Ab");
						year=rs.getString("Year");
						
						filename=rs.getString("filename");
						if (filename == null || filename =="")
						{
		%>
			  <td height="35" width="33%"><a href="metadata.jsp?ab=<%=ResourceAb%>&id=<%=Resourceid%>&name=<%=ResourceNameUTF8%>"><%=ResourceName%>(<%=year%>)</a></td>

		<%
						}
						else
						{
							String route=rs.getString("Route");
		%>
				<td height="60" width="33%"><a href="down.jsp?path=<%=route%>&name=<%=filename%>&id=<%=Resourceid%>"><%=ResourceName%>(<%=year%>)<br>:<%=filename%></a></td>
 		<!--		<td height="60" width="33%"><a href="down.jsp?path=<%=route%>&name=<%=filename%>&id=<%=Resourceid%>"><%=ResourceName%>(<%=year%>)<br>:<%=filename%></a></td> -->
		<%
						}
					}
					else
					{
						Resourceid=rs.getInt("ResourceID");
						sql="select * from ResourceSummary where id="+Resourceid;

						rs1 = stmt1.executeQuery(sql); 
						if (rs1.next()) {
							ResourceName=rs1.getString("ResourceName");
							ResourceNameUTF8=URLEncoder.encode(ResourceName,"UTF-8");
							ResourceAb=rs1.getString("Ab");

							filename=rs1.getString("filename");
							if (filename == null || filename =="")
							{
		%>
			  <td height="35" width="33%"><a href="metadata.jsp?ab=<%=ResourceAb%>&id=<%=Resourceid%>&name=<%=ResourceNameUTF8%>"><%=ResourceName%>(<%=year%>)</a></td>

		<%
							}
							else
							{
								String route=rs1.getString("Route");
		%>
				<td height="60" width="33%"><a href="down.jsp?path=<%=route%>&name=<%=filename%>&id=<%=Resourceid%>"><%=ResourceName%>(<%=year%>)<br>:<%=filename%></a></td>
 		<!--		<td height="60" width="33%"><a href="down.jsp?path=<%=route%>&name=<%=filename%>&id=<%=Resourceid%>"><%=ResourceName%>(<%=year%>)<br>:<%=filename%></a></td> -->
		<%
							}
						}
					}
				}
				else {
		%>
			 <td>&nbsp;</td>
		<%
				}
		%>
			</tr>
			<%
			}
			%>
          </table>
		<%
			stmt1.close();
			stmt.close();
			conn.close();
		%>
		</div>
	</div>
	<div id="footer">Footer</div>  
</div>  
  
</body>  
</html>     
