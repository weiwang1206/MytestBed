<%@ page language="java" import="java.util.*" contentType="text/html; charset=gb2312" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<title>PEARL</title>
	<style type="text/css" media="screen">
		BODY {
			font-family: Arial;
		}
		H1 {
			font-size: 18px;
		}
		H2 {
			font-size: 16px;
		}
	</style>
	
	<link href="css/nav.css" rel="stylesheet" type="text/css" />
	<link href="css/table.css" rel="stylesheet" type="text/css" />
	<link href="css/contents.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript">
	

	</script>
</head>

<body  id="body">
<div id="my_container">

	<div id="header">
		<div id="logo">
      		<h1>PEARL</h1>
      		<h2>ICT</h2>
    	</div>
		<div id="menu">
			<ul>
				<li ><a href=""><b>实验床管理系统</b></a></li>
				<!-- 
				<li class="current" style=" font-size:10px; "><a href=""><b>登陆</b></a></li>
				<li style=" font-size:10px; "><a href=""><b>注册</b></a></li>
				 -->
				<li style=" font-size:10px; "><a href="experimenterInfo.jsp"><b>设置</b></a></li>
			</ul>
		</div>
		<div class="cleaner"></div>
	</div>
	

	<div id="left">
	<div class="leftset">
	
	<div class="left-content">
		<ul>
			<li class="item"><b class="item1"></b><a style="text-decoration:none;" href="#">创建实验</a></li>
			<li class="sepra">
				<ul>
					<li class="sepra-list first current"><a style="text-decoration:none;" href="experiment_system.jsp">申请释放</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="experiment_system.jsp">配置路由</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item2"></b><a style="text-decoration:none;" href="#">实验控制</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="#">启动停止</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item3"></b><a style="text-decoration:none;" href="#">实验数据</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="PortDataForWebAction.action">端口数据</a></li>
					<li class="sepra-list first"><a style="text-decoration:none;" href="VRDataForWebAction.action?vid=101">路由表项</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item4"></b><a style="text-decoration:none;" href="#">实验报表</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="#">数据报表</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="#">评价模型</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item5"></b><a style="text-decoration:none;" href="#">实验工具</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="#">背景流量</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="#">编程工具</a></li>
				</ul>
			</li>
		</ul>
		
		
		
	</div>
</div>
	</div>
	
	<div id="right">
	
	
	</div>
	
</div>

	<div id="footer"><div class="cleaner"></div><p><a id="foot_a" href="http://www.ict.ac.cn/">中国科学院计算技术研究所</a> 版权所有</p>
	</div>
	
	<script type="text/javascript">
	
	</script>
</body>
</html>