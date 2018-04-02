<%@page contentType="text/html;charset=UTF-8"%>
<%@page import="func.*"%>
<%@page language="java" import="javax.mail.*,java.util.*,java.net.URLEncoder,com.mysql.jdbc.Driver,java.sql.*,java.io.*,javax.activation.*,java.util.Date,java.text.*,java.util.Random"%>
<%@page import="org.jfree.chart.ChartFactory,org.jfree.chart.JFreeChart,org.jfree.chart.plot.*,org.jfree.chart.servlet.ServletUtilities,org.jfree.data.category.*,org.jfree.chart.axis.*,org.jfree.data.general.DefaultPieDataset,org.jfree.util.Rotation,org.jfree.chart.labels.StandardPieSectionLabelGenerator,java.text.NumberFormat"%>    
<%@include file="include/common.jsp"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"   
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">  
<html>  
<head>  
<meta http-equiv="Content-type" content="text/html; charset=UTF-8" />  
<title>IBM-高校合作资料中心 访问与下载统计</title>  
<link href="css/default.css" rel="stylesheet" type="text/css" />
</head>  
<%   
	request.setCharacterEncoding("UTF-8");
	String logged=(String)session.getAttribute("login");
	if (logged==null)  logged="";

	String flag =request.getParameter("flag");
	if (flag==null) flag="";

	Statement stmt=conn.createStatement();
	String sql="";
	String graphURL="",filename="";
	int access=0,counts=0;
	ResultSet rs;

	if (!flag.equals("Y")) {
		//柱状图
		DefaultCategoryDataset dataset = new DefaultCategoryDataset();    
		sql="select count(*) from Counts WHERE Date BETWEEN '2012-03-01' and '2012-03-31'";
		rs=stmt.executeQuery(sql);
		if (rs.next()){
			access=rs.getInt(1);
		}
		dataset.addValue(access, "access", "Mar"); 

		sql="select count(*) from Counts WHERE Date BETWEEN '2012-04-01' and '2012-04-30'";
		rs=stmt.executeQuery(sql);
		if (rs.next()){
			access=rs.getInt(1);
		}
		dataset.addValue(access, "access", "Apr");

		sql="select count(*) from Counts WHERE Date BETWEEN '2012-05-01' and '2012-05-31'";
		rs=stmt.executeQuery(sql);
		if (rs.next()){
			access=rs.getInt(1);
		}
		dataset.addValue(access, "access", "May");    

		sql="select count(*) from Counts WHERE Date BETWEEN '2012-06-01' and '2012-06-30'";
		rs=stmt.executeQuery(sql);
		if (rs.next()){
			access=rs.getInt(1);
		}
		dataset.addValue(access, "access", "Jun"); 

		sql="select count(*) from Counts WHERE Date BETWEEN '2012-07-01' and '2012-07-31'";
		rs=stmt.executeQuery(sql);
		if (rs.next()){
			access=rs.getInt(1);
		}
		dataset.addValue(access, "access", "Jul"); 

		sql="select count(*) from Counts WHERE Date BETWEEN '2012-08-01' and '2012-08-31'";
		rs=stmt.executeQuery(sql);
		if (rs.next()){
			access=rs.getInt(1);
		}
		dataset.addValue(access, "access", "Aug");

		sql="select count(*) from Counts WHERE Date BETWEEN '2012-09-01' and '2012-09-30'";
		rs=stmt.executeQuery(sql);
		if (rs.next()){
			access=rs.getInt(1);
		}
		dataset.addValue(access, "access", "Sep");
		
		sql="select count(*) from Counts WHERE Date BETWEEN '2012-10-01' and '2012-10-31'";
		rs=stmt.executeQuery(sql);
		if (rs.next()){
			access=rs.getInt(1);
		}
		dataset.addValue(access, "access", "Oct");
		
		sql="select count(*) from Counts WHERE Date BETWEEN '2012-11-01' and '2012-11-30'";
		rs=stmt.executeQuery(sql);
		if (rs.next()){
			access=rs.getInt(1);
		}
		dataset.addValue(access, "access", "Nov"); 
		
		sql="select count(*) from Counts WHERE Date BETWEEN '2012-12-01' and '2012-12-31'";
		rs=stmt.executeQuery(sql);
		if (rs.next()){
			access=rs.getInt(1);
		}
		dataset.addValue(access, "access", "Dec");    

		JFreeChart chart = ChartFactory.createBarChart3D("","2012","Access",dataset,PlotOrientation.VERTICAL, false, false, false);    

		//整数显示
		CategoryPlot plotBar =  chart.getCategoryPlot();   
		NumberAxis na= (NumberAxis)plotBar.getRangeAxis();   
		na.setStandardTickUnits(NumberAxis.createIntegerTickUnits());   

		
		filename = ServletUtilities.saveChartAsPNG(chart, 600, 300, null, session);    
		graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename;  
	}
	else {
		//饼图
		DefaultPieDataset dataset1 = new DefaultPieDataset(); 
		sql="select Counts from DownloadCount";
		int c=0,cc=0;
		rs=stmt.executeQuery(sql);
		while (rs.next()){
			c=rs.getInt("Counts");
			counts=counts+c;
		}
		//out.print(counts);
		
		cc=0;
		sql="select a.Counts from DownloadCount a,ResourceDownload b,ResourceSummary c where a.DownloadID=b.ID and b.ResourceID=c.ID and c.Year='2012'";
		rs=stmt.executeQuery(sql);
		while (rs.next())
		{
			c=rs.getInt("Counts");
			cc=cc+c;
		}		
		dataset1.setValue("2012", cc); 

		cc=0;
		sql="select a.Counts from DownloadCount a,ResourceDownload b,ResourceSummary c where a.DownloadID=b.ID and b.ResourceID=c.ID and c.Year='2011'";
		rs=stmt.executeQuery(sql);
		while (rs.next())
		{
			c=rs.getInt("Counts");
			cc=cc+c;
		}		
		dataset1.setValue("2011", cc); 

		cc=0;
		sql="select a.Counts from DownloadCount a,ResourceDownload b,ResourceSummary c where a.DownloadID=b.ID and b.ResourceID=c.ID and c.Year='2010'";
		rs=stmt.executeQuery(sql);
		while (rs.next())
		{
			c=rs.getInt("Counts");
			cc=cc+c;
		}
		dataset1.setValue("2010", cc); 
		
		cc=0;
		sql="select a.Counts from DownloadCount a,ResourceDownload b,ResourceSummary c where a.DownloadID=b.ID and b.ResourceID=c.ID and c.Year='2009'";
		rs=stmt.executeQuery(sql);
		while (rs.next())
		{
			c=rs.getInt("Counts");
			cc=cc+c;
		}		
		dataset1.setValue("2009", cc); 
		
		cc=0;
		sql="select a.Counts from DownloadCount a,ResourceDownload b,ResourceSummary c where a.DownloadID=b.ID and b.ResourceID=c.ID and c.Year='2008'";
		rs=stmt.executeQuery(sql);
		while (rs.next())
		{
			c=rs.getInt("Counts");
			cc=cc+c;
		}
		dataset1.setValue("2008", cc);

		//通过工厂类生成JFreeChart对象 
		JFreeChart chart1 = ChartFactory.createPieChart3D("", dataset1, true, true, false); 
		//获得3D的水晶饼图对象 
		PiePlot3D pieplot3d = (PiePlot3D) chart1.getPlot(); 
		//设置开始角度 
		pieplot3d.setStartAngle(150D); 
		//设置方向为”顺时针方向“ 
		pieplot3d.setDirection(Rotation.CLOCKWISE); 
		//设置透明度，0.5F为半透明，1为不透明，0为全透明 
		pieplot3d.setForegroundAlpha(0.5F); 
		pieplot3d.setNoDataMessage("无数据显示"); 
		//("{0}: ({1}，{2})")是生成的格式，{0}表示section名，{1}表示section的值，{2}表示百分比。可以自定义。而new DecimalFormat("0.00%")表示小数点后保留两位。
		StandardPieSectionLabelGenerator generator = new StandardPieSectionLabelGenerator(("{0}={1}({2})"), NumberFormat.getNumberInstance(),new DecimalFormat("0.00%"));
		pieplot3d.setLabelGenerator(generator);

		//通过工厂类生成JFreeChart对象 
		/*JFreeChart chart1 = ChartFactory.createPieChart3D("", dataset1, true, false, false); 
		PiePlot pieplot = (PiePlot) chart1.getPlot(); 
		//pieplot.setLabelFont(new Font("宋体", 0, 12)); 
		//没有数据的时候显示的内容 
		pieplot.setNoDataMessage("无数据显示"); 
		pieplot.setCircular(false); 
		//("{0}: ({1}，{2})")是生成的格式，{0}表示section名，{1}表示section的值，{2}表示百分比。可以自定义。而new DecimalFormat("0.00%")表示小数点后保留两位。
		StandardPieSectionLabelGenerator generator = new StandardPieSectionLabelGenerator(("{0}={1}({2})"), NumberFormat.getNumberInstance(),new DecimalFormat("0.00%"));
		pieplot.setLabelGenerator(generator);*/

			   
		filename = ServletUtilities.saveChartAsPNG(chart1, 500, 300, null, session); 
		graphURL = request.getContextPath() + "/DisplayChart?filename=" + filename; 
	}
	stmt.close();
	conn.close();
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
			<li><a href="chart.jsp">访问/下载统计</a></li>
		</ul>
		</div>
	</div>
	<div id="main-template"><br><br>
		<div id="headline"><table width="658" border="0">
						  <tr>
						    <td width="53">&nbsp;</td>
							<td width="141"><a href="chart.jsp">最近网站访问量统计</a></td>
							<td width="286"><a href="chart.jsp?flag=Y">下载量出版年统计</a></td>
							<td width="160">&nbsp;</td>
						  </tr>
						</table>
</div>
		<div id="chart">
		<%
		if (!flag.equals("Y")) {
		%>
		<h3>2012年度点击率统计</h3>
		<%
		} else{
		%>
		<h3>根据资料出版年份统计实际下载量&nbsp;&nbsp;&nbsp;&nbsp;总下载量<%=counts%></h3>
		<%
		}
		%>
		<img src="<%=graphURL%>" height=300 border=0 usemap="#<%=filename%>">
		</div>
	</div>
	<div id="footer">Footer</div>  
</div>  
  
</body>  
</html>     
