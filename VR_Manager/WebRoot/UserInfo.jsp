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
	<!-- Le styles -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 60px;
        padding-bottom: 40px;
      }
      .sidebar-nav {
        padding: 9px 0;
      }
    </style>
    <link href="assets/css/bootstrap-responsive.css" rel="stylesheet">
	<script type="text/javascript" src="scripts/my_js/num_format.js"></script>
	<title>试验床</title>
</head>
<body id="body">

<div id="my_container">
<!-- 设置上方导航栏 和右上方退出选项 -->
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
              <li><p class="navbar-text">管理系统</p></li>
            </ul>
          </div><!--/.nav-collapse -->
        </div>
      </div>
    </div>
    
    
	<div class="container-fluid">
      <div class="row-fluid">
        <!-- 设置左方导航 -->
        <div class="span3" style="margin-top:100px; font-size:18px;">
          <div class="sidebar-nav">
            <ul class="nav nav-pills nav-stacked">
              <li><a href="PhysicalMachineListAction?pageIndex=0">物理机器查看</a></li>
              <li><a href="VirtualRouterListAction?pageIndex=0">虚拟路由器查看</a></li>
              <li><a href="ApplicationsListAction?pageIndex=0">资源申请管理</a></li>
              <li><a href="RevertListAction?pageIndex=0">资源回收管理</a></li>
              <li><a href="UserINfoManageAction?type=all&pageIndex=0">用户管理</a></li>
              <li><a href="ExperimentManageAction?type=all&pageIndex=0">试验管理</a></li>
              <li><a href="phyMachineTopologyAction">拓扑图</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->
        
        <!-- 设置右方信息内容 -->     
        <div class="span9">
          <div class="page-header">
			<h2>实验者详细信息
		  </div><!--"page-header"-->
		  
		    <div class="row">	
		    <div class="tabbable"> <!-- Only required for left/right tabs -->
 				<ul class="nav nav-tabs">
    				<li ><a href="#tab1" data-toggle="tab">基本信息</a></li>
    				<li><a href="#tab2" data-toggle="tab">实验记录</a></li>
  				</ul>
  				<div class="tab-content"> 				
    				<div class="tab-pane active" id="tab1">
					<table class="userInfo">
    					<tr>
        					<td style="color:#000099">姓名</td>
        					<td><s:property value="user.name"/></td>
      					</tr>
						<tr>
        					<td style="color:#000099">邮箱</td>
        					<td><s:property value="user.email"/></td>
      					</tr>
						<tr>
        					<td style="color:#000099">手机号码</td>
        					<td><s:property value="user.telephone"/></td>
      					</tr>
						<tr>
        					<td style="color:#000099">省份/州</td>
        					<td><s:property value="user.province"/></td>
      					</tr>
						<tr>
        					<td style="color:#000099">城市</td>
        					<td><s:property value="user.city"/></td>
      					</tr>
					</table>
						<div id="content_bottom">
							<div class="cleaner"></div>
						</div>      					
   			 		</div>
   			 		
   			 		<div class="tab-pane " id="tab2">
						<select size="12" name="experiments" style="width:600px;">
							<s:iterator value="exps">
							<option>实验名:<s:property value="expName"/>&nbsp&nbsp申请于:<s:property value="expApplyTime"/>&nbsp&nbsp开始于:<s:property value="expStartTime"/>&nbsp&nbsp结束于:<s:property value="expDeadLine"/>&nbsp&nbsp实验内容:<s:property value="description"/></option>
						</s:iterator>
						</select>
						<div id="content_bottom">
							<div class="cleaner"></div>
						</div>
   			 		</div>
   			 	</div>				
			</div><!-- tabs-left -->
			</div><!-- row -->
<!--  
<div id="my_container">
	<div id="header">
		<div id="logo">
      		<h1>TestBed</h1>
      		<h2>ICT</h2>
    	</div>
		<div id="menu">
			<ul>
				<li><a href=""><b>试验床管理系统</b></a></li>
				// <li class="current" style=" font-size:10px"><a href="<s:url action='phyMachineList'/>"><b>登陆</b></a></li>
				<li style=" font-size:10px"><a href="<s:url action='routerList'/>"><b>注册</b></a></li>//
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
		//
		<div id="nav">
			<p style=" margin-left: 20px; margin-right: 20px;">您当前的位置：  </p>
			<p id="zero">物理机</p>
			
			<p id="return" style=" margin-right:20px; float:right;text-decoration:underline;color:#0099ff;"><a onclick=	
				"window.history.go(-1);" style="cursor:pointer">返回</a></p>
		</div>
		//
		<h2 style=" margin-left:-70%; color:#000099">实验者详细信息</h2>
		<hr style=" width:80%"/>
		<h3 style=" margin-left:-70%; ">基本信息</h3>
		<table class="userInfo">
    		<tr>
        		<td style="color:#000099">姓名</td>
        		<td><s:property value="user.name"/></td>
      		</tr>
			<tr>
        		<td style="color:#000099">邮箱</td>
        		<td><s:property value="user.email"/></td>
      		</tr>
			<tr>
        		<td style="color:#000099">手机号码</td>
        		<td><s:property value="user.telephone"/></td>
      		</tr>
			<tr>
        		<td style="color:#000099">省份/州</td>
        		<td><s:property value="user.province"/></td>
      		</tr>
			<tr>
        		<td style="color:#000099">城市</td>
        		<td><s:property value="user.city"/></td>
      		</tr>
		</table>
		<hr style=" width:80%"/>
		<h3 style=" margin-left:-70%; ">实验记录</h3>
		<select size="12" name="experiments" style="width:600px;">
			<s:iterator value="exps">
			<option>实验名:<s:property value="expName"/>&nbsp&nbsp申请于:<s:property value="expApplyTime"/>&nbsp&nbsp开始于:<s:property value="expStartTime"/>&nbsp&nbsp结束于:<s:property value="expDeadLine"/>&nbsp&nbsp实验内容:<s:property value="description"/></option>
			</s:iterator>
		</select>
		<div id="content_bottom">
			<div class="cleaner"></div>
		</div>
	</div>
</div>	
<div id="footer"><div class="cleaner"></div><p><a href="http://www.ict.ac.cn/">中国科学院计算技术研究所</a> 版权所有</p></div>
-->
       </div><!--/span-->  
	  </div> <!-- /row-fluid--> 
      <hr/>

      <footer>
        <p>&copy; Company 2012</p>
      </footer>

    </div><!--/.fluid-container-->
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

</body>
</html>
