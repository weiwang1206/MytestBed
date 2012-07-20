<%@ page language="java" import="java.util.*" contentType="text/html; charset=gb2312" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<title>试验床</title>
	<meta charset="gb2312">	
	
	<title>试验床</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
	
	<!-- Le styles -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 30px;
        padding-bottom: 40px;
      }
      .sidebar-nav {
        padding: 9px 0;
      }
    </style>
    <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
	
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
	<script type="text/javascript" src="scripts/js/highcharts.js"></script>
	
	<script type="text/javascript" src="scripts/my_js/data1.js"></script>
	<script type="text/javascript" src="scripts/my_js/data2.js"></script>
	<script type="text/javascript" src="scripts/my_js/data3.js"></script>
	<script type="text/javascript" src="scripts/my_js/data4.js"></script>
	<script type="text/javascript" src="scripts/my_js/data5.js"></script>
	<script type="text/javascript" src="scripts/my_js/data6.js"></script>
	<script type="text/javascript" src="scripts/my_js/data7.js"></script>
	<script type="text/javascript" src="scripts/my_js/data8.js"></script>
	
	
	<script type="text/javascript">
				
	function changeVR(obj)
	{
		
		id = obj.options[obj.selectedIndex].text.substring(6);
		window.location.href="VRDataForWebAction.action?vid="+id;
		
		//ajax(id);
		////alert(id);
	}
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
	function ajax(id) {
		createXmlHttp();
		xmlhttp.open("post","JSONRouterDataForWeb?vid="+id, true);
		xmlhttp.onreadystatechange = callback;
		xmlhttp.send(null);
	}

	//回调函数
	function callback(){
	if (xmlhttp.readyState == 4)
	{
		if (xmlhttp.status == 200)
		{
		var rs = xmlhttp.responseText;
		//使用eval方法将服务器上的json字符传转换成json对象
		var obj = eval('('+rs+')');
		
		var routertable = obj["routerTable"];
		
		var rt = document.getElementsByName("rt");
		
		
		}
	}
	}
	</script>
</head>

<body  id="body" onload="setButtonVisible();">

  <div class="navbar navbar-fixed-top">
      <div class="navbar-inner">
        <div class="container-fluid">
          <a class="btn btn-navbar" data-toggle="collapse" data-target=".nav-collapse">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </a>
          <a class="brand" href="#">TestBed</a>
		   <div class="btn-group pull-right">
            <a class="btn dropdown-toggle" data-toggle="dropdown" href="#">
              <i class="icon-user"></i> 胡志洋
              <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
              <li><a href="#">设置</a></li>
              <li class="divider"></li>
              <li><a href="#">退出</a></li>
            </ul>
          </div>
		  <div class="nav-collapse">
            <ul class="nav">
              <li><p class="navbar-text">试验系统</p></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
  </div>
  
  <div class="container-fluid">
      <div class="row-fluid">
	   
	   <div class="span2" style="margin-top:70px; font-size:18px;" align="center">
          <div class="sidebar-nav">
            <ul class="nav nav-pills nav-stacked">
              <li ><a style="text-decoration:none;" href="UserExpsAction.action">创建打开</a></li>
              <li><a style="text-decoration:none;" href="createExp.action?method=open">申请配置</a></li>
              <li><a href="">启动停止</a></li>
              <li><a style="text-decoration:none;" href="PortDataForWebAction.action">端口数据</a></li>
              <li class="active"><a style="text-decoration:none;" href="VRDataForWebAction.action?vid=101">路由表项</a></li>
              <li><a href="">数据报表</a></li>
              <li><a href="">实验工具</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->
	   
	   
  		<div class="span10">
  		  <div class="page-header">
			<h2>路由表项
			<small>路由表信息</small></h2>		
	     </div>
		  
		  
			<h1><s:property value="vr.vname"/></h1>
			<select name="routerList" onclick="changeVR(this)">  
					<s:iterator value="vrList">
  					<option>Router<s:property /></option> 
  					</s:iterator>  

  			</select>
			<table  class="table table-striped" > 
			<caption align="bottom">
				<br/>
				<p style="color:#333;">Codes: K - kernel route, C - connected, S - static, R - RIP, O - OSPF,
				I - ISIS, <br/>B - BGP,  - selected route, * - FIB route</p>
			</caption>
			<thead>
				<tr>
					<th>标志</th>
					<th>目的地</th>
					<th>下一跳</th>
					<th>接口</th>	
				</tr>
			</thead>
			<tbody name="rt">
				<s:iterator value="vr.getRouterTable()">
				<tr>
					<td name="code"><s:property value="code"/></td>
					<td name="desIP"><s:property value="desIP"/></td>  
					<td name="nextHop"><s:property value="nextHop"/></td>  
					<td name="exPort"><s:property value="exPort"/></td>
				</tr>
				</s:iterator>
			</tbody>
    		</table> 		  
		  			
		</div><!-- span9 -->
	</div><!-- row fluid -->
	  
			
	  <hr/>

      <footer>
        <p>&copy; Company 2012</p>
      </footer>
	</div><!-- container-fluid-->
	
	<script src="assets/js/jquery.js"></script>
    <script src="assets/js/bootstrap-transition.js"></script>
    <script src="assets/js/bootstrap-alert.js"></script>
    <script src="assets/js/bootstrap-modal.js"></script>
    <script src="assets/js/bootstrap-dropdown.js"></script>
    <script src="assets/js/bootstrap-scrollspy.js"></script>
    <script src="assets/js/bootstrap-tab.js"></script>
    <script src="assets/js/bootstrap-tooltip.js"></script>
    <script src="assets/js/bootstrap-popover.js"></script>
    <script src="assets/js/bootstrap-button.js"></script>
    <script src="assets/js/bootstrap-collapse.js"></script>
    <script src="assets/js/bootstrap-carousel.js"></script>
    <script src="assets/js/bootstrap-typeahead.js"></script>
<!-- 
<div id="my_container">

	<div id="header">
		<div id="logo">
      		<h1>TestBed</h1>
      		<h2>ICT</h2>
    	</div>
		<div id="menu">
			<ul>
				<li ><a href=""><b>实验床管理系统</b></a></li>
				{ 
				<li class="current" style=" font-size:10px; "><a href=""><b>登陆</b></a></li>
				<li style=" font-size:10px; "><a href=""><b>注册</b></a></li>
				}
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
	<div class="box">
			<h1><s:property value="vr.vname"/>路由表信息</h1>
			<select name="routerList" style="margin: 0 0 0 10px;" onclick="changeVR(this)">  
					<s:iterator value="vrList">
  					<option>Router<s:property /></option> 
  					</s:iterator>  

  			</select>
			<table  class="inner" style="margin: auto; width:500px; background: #dbdbdb;"> 
			<caption align="bottom">
				<br/>
				<p style="color:#ffffff;">Codes: K - kernel route, C - connected, S - static, R - RIP, O - OSPF,
				I - ISIS, <br/>B - BGP, > - selected route, * - FIB route</p>
			</caption>
			<thead>
				<tr>
					<th>标志</th>
					<th>目的地</th>
					<th>下一跳</th>
					<th>接口</th>	
				</tr>
			</thead>
			<tbody name="rt" style="width:125px">
				<s:iterator value="vr.getRouterTable()">
				<tr>
					<td name="code"><s:property value="code"/></td>
					<td name="desIP"><s:property value="desIP"/></td>  
					<td name="nextHop"><s:property value="nextHop"/></td>  
					<td name="exPort"><s:property value="exPort"/></td>
				</tr>
				</s:iterator>
			</tbody>
    		</table> 
		</div>
	
	</div>
	
</div>

	<div id="footer"><div class="cleaner"></div><p><a id="foot_a" href="http://www.ict.ac.cn/">中国科学院计算技术研究所</a> 版权所有</p>
	</div>
	
	<script type="text/javascript">
	ajax();
	</script> -->
		<script type="text/javascript">
	var update = new ajax();
	update.display();
	</script>
</body>
</html>