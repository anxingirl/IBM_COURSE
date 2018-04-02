<%@page contentType="text/html;charset=utf-8"%>
<%@page import="func.*"%>
<%@page language="java" import="javax.mail.*,java.util.*,javax.mail.internet.*,com.mysql.jdbc.Driver,java.sql.*,java.io.*,javax.activation.*,java.util.Date,java.text.*"%>
<%@include file="include/common.jsp"%>

<!--<link rel="Shortcut Icon" href="favicon.ico">-->

<%
	request.setCharacterEncoding("UTF-8");
	String emailto= request.getParameter("email");
	String name= request.getParameter("name");
	String tel= request.getParameter("tel");
	String emailMD5= CommonEncrypt.transMD5(emailto);
	String passwd= request.getParameter("pwd");
	String pwMD5=CommonEncrypt.transMD5(passwd);
	String edu= request.getParameter("edu");
	String university= request.getParameter("university");
	String remarks= request.getParameter("remarks");
	if (university.equals("其他")) university=remarks;
	String school= request.getParameter("school");

	SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	Date today = new Date();
	Statement stmt=conn.createStatement();
	String sql="select * from User where RegisterEmail='"+emailto+"'";
	//out.print(sql);

	ResultSet rs = stmt.executeQuery(sql); 
	if (rs.next())
	{
		stmt.close();   
		conn.close();
	%>
		<script type="text/javascript">
		alert("该邮箱已注册！");
		window.location.href="reg.jsp";
		</script>
	<%
	}
	else
	{
		String insertsql="insert into User(RegisterDate,RegisterEmail,Name,Tel,PassWord,Auth,University,School,Education,LastDate,Active) values('"+ formatter.format(today) + "','" + emailto + "','" +name+ "','" + tel + "','" + pwMD5 + "','D','" + university + "','" + school +"','" + edu +"','" + formatter.format(today) + "','"+ emailMD5+pwMD5 + "')";
		//out.print(insertsql);
		stmt.executeUpdate(insertsql);	
		
		stmt.close();   
		conn.close(); 
		response.sendRedirect("ok.htm");
		return;
	}

	//发送激活邮件
	String text="为保证正常使用IBM高校资料中心的资源，请使用学校邮箱注册！使用非学校邮箱注册仅能浏览资源目录，谢谢大家理解！<br><br>请点击链接激活注册！<br><br> http://219.224.28.180:8080/ibm/regactive.jsp?active="+emailMD5+pwMD5;
	

	try{

	Properties props=System.getProperties();
    props.setProperty("mail.transport.protocol","smtp");    //smtp协议
    props.setProperty("mail.smtp.host","202.112.82.35");   //服务器地址
    props.setProperty("mail.smtp.port","25");  //端口号
	props.setProperty("mail.smtp.auth","true");

	Session sendMailSession = Session.getDefaultInstance(props, null);

	MimeMessage newMessage = new MimeMessage(sendMailSession);
	newMessage.setFrom(new InternetAddress("wap@lib.bnu.edu.cn"));
	newMessage.setRecipients(Message.RecipientType.TO,InternetAddress.parse(emailto));
	//设置邮件标题
	String subject="IBM资料中心用户注册激活邮件！  "+formatter.format(today);
	sun.misc.BASE64Encoder base64encoder = new sun.misc.BASE64Encoder();
	newMessage.setSubject("=?GB2312?B?" + base64encoder.encode(subject.getBytes("gb2312")) + "?=");
	newMessage.setSentDate(new Date());
	MimeMultipart mm=new MimeMultipart();
	MimeBodyPart mbp=new MimeBodyPart();

	mbp.setText(text);
    mbp.setHeader("Content-Type","text/html");
	mbp.setContent(text,"text/html; charset=gb2312");//指定文件编码
	mm.addBodyPart(mbp);

	newMessage.setContent(mm);
	newMessage.saveChanges();

	Transport trans=sendMailSession.getTransport();
	trans.connect("202.112.82.35","wap","paw");
    trans.sendMessage(newMessage,InternetAddress.parse(emailto));
	trans.close(); 
	%>

	<script type="text/javascript">
	alert("激活邮件已发送，请登录邮箱查收！");
	window.location.href="reg.jsp";
	</script>
<%
	} 
	catch(MessagingException m) 
	{ 
		String prompt="发送失败，请重试！("+m.toString()+")";
		out.print(prompt);
	}
%>