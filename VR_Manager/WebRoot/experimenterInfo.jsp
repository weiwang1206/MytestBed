<%@ page language="java" import="java.util.*" contentType="text/html; charset=gb2312"  %>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	
	
	<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
	<link href="css/nav.css" rel="stylesheet" type="text/css" />
	<link href="css/page.css" rel="stylesheet" type="text/css" />
	<link href="css/table.css" rel="stylesheet" type="text/css" />
	<link href="css/contents.css" rel="stylesheet" type="text/css" />
	<link href="css/physical_machine_list.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="scripts/my_js/num_format.js"></script>
	<title>试验床</title>
	<script type="text/javascript">
	</script>
</head>
<body id="body">
<div id="my_container">
	<div id="header">
		<div id="logo">
      		<h1>TestBed</h1>
      		<h2>ICT</h2>
    	</div>
		<div id="menu">
			<ul>
				<li><a href=""><b>试验床管理系统</b></a></li>
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
			<li class="item"><b class="item1"></b><a style="text-decoration:none;" href="create_experiment.jsp">创建实验</a></li>
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
		<h2 style=" margin-left:-70%; color:#000099">管理员设置</h2>
		<hr style=" width:80%"/>
		<h3 style=" margin-left:-70%; ">个人信息</h3>
		<table class="userInfo">
    		<tr>
        		<td style="color:#000099"><a href="BasicInfoAction">个人资料</td>
        		<td>可以点击左侧的链接查看并修改您的个人信息</td>
      		</tr>
			<tr>
        		<td style="color:#000099"><a href="experimenterchangePs.jsp">密码</td>
        		<td>要设置新密码，请务必提供您目前的密码</td>
      		</tr>
		</table>
		<hr style=" width:80%"/>
		<h3 style=" margin-left:-70%; ">操作记录</h3>
		<table class="userInfo">
    		<tr>
        		<td style="color:#000099"><a href="OperationHistoryAction">操作记录</td>
        		<td>可以点击左侧的链接查看操作的历史记录</td>
      		</tr>
		</table>
		<hr style=" width:80%"/>
		<h3 style=" margin-left:-70%; ">实验列表</h3>
		<table class="userInfo">
    		<tr>
        		<td style="color:#000099"><a href="ExperimentorExpsAction">实验列表</td>
        		<td>可以点击左侧的链接查看实验列表</td>
      		</tr>
		</table>
	</div>
</div>	
<div id="footer"><div class="cleaner"></div><p><a href="http://www.ict.ac.cn/">中国科学院计算技术研究所</a> 版权所有</p></div>

</body>
</html>