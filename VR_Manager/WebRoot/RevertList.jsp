<%@ page language="java" import="java.util.*" contentType="text/html; charset=gb2312"  %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <!--
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
	-->
	
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
	<script type="text/javascript">
	
	var pageIndex = 0;
	var type="FINISHED";
	var xmlhttp;
	var pageCnt=<s:property value="pageCnt"/>;
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
	function ajax(type, pageIndex) {
		createXmlHttp();
		xmlhttp.open("post","JSONPage?pageKind=" + "exps" + "&type=" + type + "&pageIndex=" + pageIndex, true);
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

		setButtonVisible();
		}
	}
	}
	

	
	//获取下一页的Revert列表
	function getNextRevertPage() {
		pageIndex++;
		ajax(type, pageIndex);
	}
	
	//获取上一页的Revert列表
	function getPreRevertPage() {
		pageIndex--;
		ajax(type, pageIndex);
	}
	
	function setButtonVisible() {
		if (pageIndex <= 0) {
			document.getElementById("pre_button").style.visibility="hidden";
		} else {
			document.getElementById("pre_button").style.visibility="visible";
		}
		if (pageIndex >= pageCnt) {
			document.getElementById("next_button").style.visibility="hidden";
		} else {
			document.getElementById("next_button").style.visibility="visible";
		}
	}
	
	</script>
</head>
<body id="body" onload="setButtonVisible();">
	<!-- 设置上方导航栏及右上方退出 -->
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
	
	<!-- 设置左方导航栏 -->
	<div class="container-fluid">
      <div class="row-fluid">
        <div class="span3" style="margin-top:100px; font-size:18px;">
          <div class="sidebar-nav">
            <ul class="nav nav-pills nav-stacked">
              <li><a href="PhysicalMachineListAction?pageIndex=0">物理机器查看</a></li>
              <li><a href="VirtualRouterListAction?pageIndex=0">虚拟路由器查看</a></li>
              <li><a href="ApplicationsListAction?pageIndex=0">资源申请管理</a></li>
              <li class="active"><a href="RevertListAction?pageIndex=0">资源回收管理</a></li>
              <li><a href="UserINfoManageAction?type=all&pageIndex=0">用户管理</a></li>
              <li><a href="ExperimentManageAction?type=all&pageIndex=0">试验管理</a></li>
              <li><a href="phyMachineTopologyAction">拓扑图</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->
        		
        <div class="span9">
          <div class="page-header">
			<h2>资源管理	
			<small>回收资源</small></h2>		
	      </div>
		  <div class="row">
        		<table  class="table table-striped" >
				<thead>
				<tr>
				<th>试验名称</th>
				<th>申请人</th>
				<th>状态</th>
				<th>归还路由器数量</th>
				<th>详细</th>
				<th>回收</th>
				</tr>
				</thead>
				<tbody>
				<s:iterator value="exps">
				<tr>
				<td><s:property value="expName"/></td>
				<td><s:property value="getUser().getName()"/></td>
				<td>
					<s:if test="expState == 0">
						APPLYING
					</s:if>
					<s:elseif test="expState == 1">
						EXPERIMENTING
					</s:elseif>
					<s:elseif test="expState == 2">
						REJECTED
					</s:elseif>
					<s:elseif test="expState == 3">
						FINISHED
					</s:elseif>
					<s:elseif test="expState == 4">
						RELEASEED
					</s:elseif>
				</td>
				<td><s:property value="vrNumHigh"/> / <s:property value="vrNumLow"/></td>
				<td><a href="<s:url action='RouterSInfoAction'>
								<s:param name="id" value="id"/>
							</s:url>">详细查看</a></td>
				<td><input name="release" type="checkbox"></td>
				</tr>
				</s:iterator>
				</tbody>
			</table>
       		<div class="cleaner"></div>
       	 </div>
       	 <div class="row"> 
       	 	<div class="span2"></div>
			<div class="span3" style="margin-top:5px;"><p class="strong" style="float:right; font-size:14px;">第2页，共6页</p></div>
			<div class="span6">
			  <div class="pager" style="float:left">
			    <li>
				  <a href="#" >&larr;上一页</a>
				</li>
				<li>
				  <a href="#" >下一页&rarr;</a>
				</li>
			  </div><!-- "page" -->
			</div>      	 
       	  </div><!-- "row2" -->       	        	 
       </div><!-- "span9" -->  
      </div> <!-- /row-fluid-->        
       <hr/>
       <footer>
        	<p>&copy; Company 2012</p>
       </footer>
      </div><!--/.-container-->


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
		<div id="content_top">
			<table  class="my_table" border="0">
				<thead>
				<tr>
				<th>试验名称</th>
				<th>申请人</th>
				<th>状态</th>
				<th>归还路由器数量</th>
				<th>详细</th>
				<th>回收</th>
				</tr>
				</thead>
				<tbody>
				<s:iterator value="exps">
				<tr>
				<td><s:property value="expName"/></td>
				<td><s:property value="getUser().getName()"/></td>
				<td>
					<s:if test="expState == 0">
						APPLYING
					</s:if>
					<s:elseif test="expState == 1">
						EXPERIMENTING
					</s:elseif>
					<s:elseif test="expState == 2">
						REJECTED
					</s:elseif>
					<s:elseif test="expState == 3">
						FINISHED
					</s:elseif>
					<s:elseif test="expState == 4">
						RELEASEED
					</s:elseif>
				</td>
				<td><s:property value="vrNumHigh"/> / <s:property value="vrNumLow"/></td>
				<td><a href="<s:url action='RouterSInfoAction'>
								<s:param name="id" value="id"/>
							</s:url>">详细查看</a></td>
				<td><input name="release" type="checkbox"></td>
				</tr>
				</s:iterator>
				</tbody>
			</table>
			<div class="cleaner"></div>
		</div>
		<div id="page">
			<ul>
				<li><button onclick=""  id="add_button">确定</button></li>
				<li><button onclick="getPreRevertPage();"  id="pre_button"/>上一页</li></li>
				<li class="current"><a href="<s:url action='phyMachineList'/>">1</a></li>
				<li><a href="<s:url action='routerList'/>">2</a></li>
				<li><a href="<s:url action='routerList'/>">3</a></li>
				<li><button onclick="getNextRevertPage();" id="next_button"/>下一页</li></li>
			</ul>
		</div>
		<div id="content_bottom">
			<div class="cleaner"></div>
		</div>
	</div>
</div>	
<div id="footer"><div class="cleaner"></div><p><a href="http://www.ict.ac.cn/">中国科学院计算技术研究所</a> 版权所有</p></div>

-->

</body>
</html>
