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
	<link href="css/calender.css" rel="stylesheet" type="text/css" />



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
    
	<link href="css/physical_machine_list.css" rel="stylesheet" type="text/css" />
	<link href="css/contents.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="scripts/my_js/num_format.js"></script>
	<title>试验床</title>
</head>
<body id="body" onload="setButtonVisible();">

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
			<h2>管理员设置</h2>
		  </div><!--"page-header"-->
		  
		    <div class="row">	
		    <div class="tabbable"> <!-- Only required for left/right tabs -->
 				<ul class="nav nav-tabs">
    				<li class="active"><a href="#tab1" data-toggle="tab">个人资料</a></li>
    				<li><a href="#tab2" data-toggle="tab">密码管理</a></li>
    				<li><a href="#tab3" data-toggle="tab">操作记录</a></li>
  				</ul>
  				<div class="tab-content">
  				
    				<div class="tab-pane active" id="tab1">
						<form action="saveUserInfoActoin" method="get">
  							<p>姓 名：<input type="text" name="name" value="<s:property value='user.name'/>"/></p>
							<p>邮 箱：<input type="text" name="email" value="<s:property value='user.email'/>"/></p>
							<p>手 机：<input type="text" name="telephone" value="<s:property value='user.telephone'/>"/></p>
							<p>省 份：<input type="text" name="province" value="<s:property value='user.province'/>"/></p>
							<p>城 市：<input type="text" name="city" value="<s:property value='user.city'/>"/></p>
			
							<input class="btn btn-primary" type="submit" value="修改" />
							<input class="btn" type="button" id="cancle" value="取消" />
						</form>
			
						<div id="content_bottom">
							<div class="cleaner"></div>
						</div>      					
   			 		</div>
   			 		
    				<div class="tab-pane" id="tab2">
						<form action="ChangePsAction" method="get">
  							<p>您的账号：<input type="text" name="name" placeholder="这里输入您的用户名"/></p>
							<p>现用密码：<input type="text" name="password" placeholder="这里输入旧的密码"/></p>
							<p>新的密码：<input type="text" name="password2" placeholder="这里输入新的密码"/></p>
							<p>再次确认：<input type="text" name="password3" placeholder="这里再次输入新的密码" /></p>			
							<input  class="btn btn-primary" type="submit" value="确定"/>
							<input class="btn" type="reset"" id="cancle" value="重填" />
						</form>	
						<div id="content_bottom">
							<div class="cleaner"></div>
						</div>
    				</div>
    				
    				<div class="tab-pane" id="tab3">
						<!-- <input type="text" name="keys"/> -->
						<input type="button" onclick="" value="搜索" />
						<input type="button"; onclick="" value="全部" />
						<br />
						使用时间区间
						<input type="checkbox" onclick="" />
						<input name="StartDate"  type="text" value="1982-1-1" size="14" readonly="readonly" onClick="showcalendar(event, this);" 
						onFocus="showcalendar(event, this);if(this.value=='0000-00-00')this.value=''" />
						至
						<input name="EndDate"  type="text" value="1982-1-1" size="14" readonly="readonly" onClick="showcalendar(event, this);" 
						onFocus="showcalendar(event, this);if(this.value=='0000-00-00')this.value=''" />
						<input type="button"; onclick="" value="确定" />
						<div class="cleaner"></div>		
						<select size="25" name="operations" style="width:600px;">
						<s:iterator  value="opers">
							<option><s:property value="opeRecord"/></option>
						</s:iterator>
						</select>
    				</div>
  				</div>				
			</div><!-- tabs-left -->
			</div><!-- row -->
			
			
			<!-- 
			<div class="row">	
			<h3 ><small>个人信息</small></h3>
			<table class="userInfo">
    			<tr>
        			<td ><a href="BasicInfoAction">个人资料</a></td>
        			<td><h5>可以点击左侧的链接查看并修改您的个人信息</h5></td>
      			</tr>
				<tr>
        			<td style="color:#000099"><a href="changePs.jsp">密码</a></td>
        			<td><h5>要设置新密码，请务必提供您目前的密码</h5></td>
      			</tr>
			</table>
		</div> 
			
		<hr style=" width:80%"/>
		<div class="row">	
			<h3 ><small>操作查询</small></h3>
			<table class="userInfo">
    			<tr>
        			<td style="color:#000099"><a href="OperationHistoryAction">操作记录</a></td>
        			<td><h5>可以点击左侧的链接查看操作的历史记录</h5></td>
      			</tr>
			</table>	
	     </div>-->
	     	     	     
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
    
    
        
<!--  
	<div id="header">
		<div id="logo">
      		<h1>TestBed</h1>
      		<h2>ICT</h2>
    	</div>
		<div id="menu">
			<ul>
				<li><a href=""><b>试验床管理系统</b></a></li>
				//<li class="current" style=" font-size:10px"><a href="<s:url action='phyMachineList'/>"><b>登陆</b></a></li>
				//<li style=" font-size:10px"><a href="<s:url action='routerList'/>"><b>注册</b></a></li> 
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
		<h2 style=" margin-left:-70%; color:#000099">管理员设置</h2>
		<hr style=" width:80%"/>
		<h3 style=" margin-left:-70%; ">个人信息</h3>
		<table class="userInfo">
    		<tr>
        		<td style="color:#000099"><a href="BasicInfoAction">个人资料</a></td>
        		<td>可以点击左侧的链接查看并修改您的个人信息</td>
      		</tr>
			<tr>
        		<td style="color:#000099"><a href="changePs.jsp">密码</a></td>
        		<td>要设置新密码，请务必提供您目前的密码</td>
      		</tr>
		</table>
		<hr style=" width:80%"/>
		<h3 style=" margin-left:-70%; ">操作记录</h3>
		<table class="userInfo">
    		<tr>
        		<td style="color:#000099"><a href="OperationHistoryAction">操作记录</a></td>
        		<td>可以点击左侧的链接查看操作的历史记录</td>
      		</tr>
		</table>
	</div>
</div>	
<div id="footer"><div class="cleaner"></div><p><a href="http://www.ict.ac.cn/">中国科学院计算技术研究所</a> 版权所有</p></div>
-->
</body>
</html>
