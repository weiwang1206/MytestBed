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
	<link href="css/contents.css" rel="stylesheet" type="text/css" />
	<link href="css/table.css" rel="stylesheet" type="text/css" />
	<link href="css/physical_machine_list.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="scripts/my_js/num_format.js"></script>
	<title>试验床</title>
	<script type="text/javascript">
	
	var xmlhttp;
  	//创建XMLHttpRequest对象
	function createXmlHttp(){
		// 判断游览器
		if (window.XMLHttpRequest)
		{// code for IE7+, Firefox, Chrome, Opera, Safari
		  	xmlhttp=new XMLHttpRequest();
		}
		else
		{// code for IE6, IE5
		  	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}	
	}
				
	//主调函数,以当前页作为参数
	function ajax() {
		createXmlHttp();
		//xmlhttp.open("post","JSONPhyMachineInfo.action?query=phyMacine_list",true);
		xmlhttp.onreadystatechange = callback;
		xmlhttp.send(null);
		/*this.display = function() {
			var update = new ajax();
			window.setTimeout(function() {update.display();}, 3000);
		};*/
	}

	//回调函数
	function callback(){
		var rs = xmlhttp.responseText;
		//使用eval方法将服务器上的json字符传转换成json对象
		var obj = eval('('+rs+')');
		
		
		var cpuUsages = document.getElementsByName("cpuUsage");
		var memUsages = document.getElementsByName("memUsage");
		var flows = document.getElementsByName("flow");
		
		var i;
		var parname, parname2;
		
		for (i = 0; i < cpuUsages.length; i++)
		{
			parname = "CPUUseage"+ i;
			cpuUsages[i].innerHTML = obj[parname] + "%";
		}
		for (i = 0; i < memUsages.length; i++)
		{
			parname = "MemUseage"+ i;
			memUsages[i].innerHTML = obj[parname] + "%";
		}
		for (i = 0; i < flows.length; i++)
		{
			parname = "Send"+ i;
			parname2 = "Recv" + i;
			var tmp = (obj[parname] + obj[parname2]) * 8 ;
			var unit = "bps";
			if (tmp > 1024)
			{
				if (tmp < 1024 * 1024)
				{
					tmp = adv_format(tmp / 1024, 1);
					unit = "K" + unit;
				}
				else if (tmp < 1024 * 1024 * 1024)
				{	
					tmp = adv_format(tmp / (1024 * 1024), 1);
					unit = "M" + unit;
				}
				else
				{
					tmp = adv_format(tmp / (1024 * 1024 * 1024), 1);
					unit = "G" + unit; 
				}
				
			}
			
			flows[i].innerHTML = tmp + unit;
		}
	}
	
	var update = new ajax();
	update.display();
	
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
				<!-- <li class="current" style=" font-size:10px"><a href="<s:url action='phyMachineList'/>"><b>登陆</b></a></li>
				<li style=" font-size:10px"><a href="<s:url action='routerList'/>"><b>注册</b></a></li> -->
				<li style=" font-size:10px"><a href="AdministraterInfo.jsp"><b>设置</b></a></li>
			</ul>
		</div>
		<div class="cleaner"></div>
	</div>
	
	<div id="left">
		<div class="leftset">
	
	<div class="left-content">
		<ul>
			<li class="item"><b class="item1"></b><a style="text-decoration:none;" href="#">资源查看</a></li>
			<li class="sepra">
				<ul>
					<li class="sepra-list first current"><a style="text-decoration:none;" href="PhysicalMachineListAction?pageIndex=0">物理机器</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="VirtualRouterListAction?pageIndex=0">虚拟路由器</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item2"></b><a style="text-decoration:none;" href="#">资源管理</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="ApplicationsListAction?pageIndex=0">申请资源</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="RevertListAction?pageIndex=0">回收资源</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item3"></b><a style="text-decoration:none;" href="UserINfoManageAction?type=all&pageIndex=0">用户管理</a></li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item4"></b><a style="text-decoration:none;" href="ExperimentManageAction?type=all&pageIndex=0">实验管理</a></li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item5"></b><a style="text-decoration:none;" href="phyMachineTopologyAction">拓&nbsp;扑&nbsp;图&nbsp;</a></li>
		</ul>
		
		
		
	</div>
	</div>
	</div>
	<div id="right">
		<!-- 
		<div id="nav">
			<p style=" margin-left: 20px; margin-right: 20px;">您当前的位置：  </p>
			<p id="zero">物理机</p>
			
			<p id="return" style=" margin-right:20px; float:right;text-decoration:underline;color:#0099ff;"><a onclick=	
				"window.history.go(-1);" style="cursor:pointer">返回</a></p>
		</div>
		-->
		<p>试验名：xxxx</p>
		<p>试验编号：xxxxx</p>
		<div id="content_top">
			<table  class="my_table" border="0">
				<thead>
				<tr>
				<th>行号</th>
				<th>路由器编号</th>
				<th>所在物理机编号</th>
				</tr>
				</thead>
				<tbody>
				<s:iterator value="pmList">
				<tr>
				<td><s:property value="dir"/></td>
				<td><s:property value="IP"/></td>
				<td name="flow"></td>
				</tr>
				</s:iterator>
				</tbody>
			</table>
			<div class="cleaner"></div>
		</div>
		<div id="page">
			<ul>
				<li><button onclick=""  id="add_button">添加</button></li>
				<li><button onclick=""  id="pre_button"/>上一页</li></li>
				<li class="current"><a href="<s:url action='phyMachineList'/>">1</a></li>
				<li><a href="<s:url action='routerList'/>">2</a></li>
				<li><a href="<s:url action='routerList'/>">3</a></li>
				<li><button onclick="" id="pre_button"/>下一页</li></li>
			</ul>
		</div>
		<div id="content_bottom">
			<div class="cleaner"></div>
		</div>
	</div>
</div>	
<div id="footer"><div class="cleaner"></div><p><a href="http://www.ict.ac.cn/">中国科学院计算技术研究所</a> 版权所有</p></div>

</body>
</html>
