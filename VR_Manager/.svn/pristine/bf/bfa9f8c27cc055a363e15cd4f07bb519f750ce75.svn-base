
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
	var type;
	var xmlhttp;
	var pageCnt = <s:property value="pageCnt"/>;
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
	function ajax_page(pageIndex) {
		createXmlHttp();
		xmlhttp.open("post","JSONPage?pageKind=" + "pms" + "&pageIndex=" + pageIndex, true);
		xmlhttp.onreadystatechange = callback_page;
		xmlhttp.send(null);
	}

	//回调函数
	function callback_page(){
	if (xmlhttp.readyState == 4)
	{
		if (xmlhttp.status == 200)
		{
		var rs = xmlhttp.responseText;
		//alert(xmlhttp.responseText);
		//使用eval方法将服务器上的json字符传转换成json对象
		var obj = eval('('+rs+')');
		
		var items = obj["list"];
		pageCnt = obj["pageCnt"];
		
		var codeTags = document.getElementsByName("code");
		var ipTags = document.getElementsByName("ip");
		var cpuUsageTags = document.getElementsByName("cpuUsage");
		var memUsageTags = document.getElementsByName("memUsage");
		var VRNumTags = document.getElementsByName("VRNum");
		var descriptionTags = document.getElementsByName("description");
		var opeTags = document.getElementsByName("ope");
		var detailTags = document.getElementsByName("detail");	
		
		for (var i = 0; i < codeTags.length - items.length; i++) {
			codeTags[i + items.length].innerHTML = "";
			ipTags[i + items.length].innerHTML = "";
			cpuUsageTags[i + items.length].innerHTML = "";
			memUsageTags[i + items.length].innerHTML = "";
			VRNumTags[i + items.length].innerHTML = "";			
			descriptionTags[i + items.length].innerHTML = "";
			opeTags[i + items.length].innerHTML = "";
			detailTags[i + items.length].innerHTML = "";
		}
		
		
		for(var i =0;i<items.length;i++) {
			var item=items[i];
			//alert(item.code);
         	codeTags[i].innerHTML = item.code;
			ipTags[i].innerHTML = item.ip;
			cpuUsageTags[i].innerHTML = item.cpuUsage;
			memUsageTags[i].innerHTML = item.memUsage;
			VRNumTags[i].innerHTML = item.HVRCount+"/"+item.LVRCount;
			descriptionTags[i].innerHTML = item.description;
			opeTags[i].innerHTML = "";			
			detailTags[i].innerHTML = 
			"<a href='PhysicalMachineAction?id=" + 
			 item.id + "'>详细查看</a>";
			
		}
		
		setButtonVisible();
		}
	}
    }
	
	
	function getNextAplPage() {
	if (pageIndex>=pageCnt){
		document.all("indexPage").innerHTML=pageIndex+1;
		ajax_page(pageIndex);
	}
	else{
		pageIndex++;
		document.all("indexPage").innerHTML=pageIndex+1;
		ajax_page(pageIndex);
		}
	}
	
	//获取上一页的Apl列表
	function getPreAplPage() {
	if (pageIndex==0){
		document.all("indexPage").innerHTML=pageIndex+1;
		ajax_page(pageIndex);
	}
	else{
		pageIndex--;
		document.all("indexPage").innerHTML=pageIndex+1;
		ajax_page(pageIndex);
		}
	}
	
	
	
	function setButtonVisible() {
		//alert(pageCnt);
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
				
	//主调函数,以当前页作为参数
	function ajax_realData() {
		createXmlHttp();
		xmlhttp.open("post","JSONPhyMachineListInfo?" + "pageIndex=" + pageIndex, true);
		xmlhttp.onreadystatechange = callback_realData;
		xmlhttp.send(null);
		this.display = function() {
			var update = new ajax_realData();
			window.setTimeout(function() {update.display();}, 3000);
		};
	}

	//回调函数
	function callback_realData(){
		var rs = xmlhttp.responseText;
		//使用eval方法将服务器上的json字符传转换成json对象
		var obj = eval('('+rs+')');
		
		
		var cpuUsages = document.getElementsByName("cpuUsage");
		var memUsages = document.getElementsByName("memUsage");
		
		var i;
		var parname, parname2;
		
		for (i = 0; i < cpuUsages.length; i++)
		{
			parname = "CPUUseage"+ i;
			var tmp = obj[parname] ;
			tmp = adv_format(tmp, 2);
			cpuUsages[i].innerHTML = tmp + "%";
		}
		for (i = 0; i < memUsages.length; i++)
		{
			parname = "MemUseage"+ i;
			var tmp = obj[parname] ;
			tmp = adv_format(tmp, 2);
			memUsages[i].innerHTML = tmp + "%";
		}
	}
	
	var update = new ajax_realData();
	update.display();
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

	<div class="container-fluid">
      <div class="row-fluid">    	
	  <!-- 设置左方导航栏 -->
        <div class="span3" style="margin-top:100px; font-size:18px;">
          <div class="sidebar-nav">
            <ul class="nav nav-pills nav-stacked">
              <li class="active"><a href="PhysicalMachineListAction?pageIndex=0">物理机器查看</a></li>
              <li><a href="VirtualRouterListAction?pageIndex=0">虚拟路由器查看</a></li>
              <li><a href="ApplicationsListAction?pageIndex=0">资源申请管理</a></li>
              <li><a href="RevertListAction?pageIndex=0">资源回收管理</a></li>
              <li><a href="UserINfoManageAction?type=all&pageIndex=0">用户管理</a></li>
              <li><a href="ExperimentManageAction?type=all&pageIndex=0">试验管理</a></li>
              <li><a href="phyMachineTopologyAction">拓扑图</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->

        <div class="span9">
          <div class="page-header">
			<h2>资源查看	
			<small>物理机器</small></h2>		
	      </div>
          <div class="row">
		  <table class="table table-striped">
				<thead>
				<tr>
				<th>编号</th>
				<th>IP地址</th>
				<th>CPU使用率</th>
				<th>内存使用率</th>
				<th>路由器数量</th>
				<th>备注</th>
				<th>操作</th>
				<th>查看</th>
				</tr>
				</thead>
				<tbody>
				<s:iterator value="pms">
				<tr>
				<td name="code"><s:property value="code"/></td>
				<td name="ip"><s:property value="ip"/></td>
				<td name="cpuUsage"></td>
				<td name="memUsage"></td>
				<td name="VRNum"><s:property value="HVRCount"/>/<s:property value="LVRCount"/></td>
				<td name="description"><s:property value="description"/></td>
				<td name="ope">ope</td>
				<td name="detail"><a href="<s:url action='PhysicalMachineAction'>
								<s:param name="id" value="id"/>
							</s:url>">详细查看</a></td>
				</tr>
				</s:iterator>
				</tbody>
			</table>
			<div class="cleaner"></div>
		  </div><!-- "row" -->	
		  <div class="row">
		    <div class="span2"></div>
			<div class="span4" style="margin-top:5px;">
			<p class="strong" style="float:right; font-size:14px;">
			第<sx:div id="indexPage" ></sx:div>页，共<s:property value="pageCnt+1"/>页</p></div>
			<div class="span6">
			  <div class="pager" style="float:left">
			  	<li>
				  <a href="#" >添加</a>
				</li>
			    <li>
				  <a href="javascript:getPreAplPage()" >&larr;上一页</a>
				</li>
				<li>
				  <a href="javascript:getNextAplPage()" >下一页&rarr;</a>
				</li>
			  </div><!-- "page" -->
			</div>      
		  
		  </div><!-- "row2" -->
		 </div><!-- "span9"-->
	 </div><!-- row-fluid -->	
	<hr/>

      <footer>
        <p>&copy; Company 2012</p>
      </footer>
	</div><!-- "container-fluid" -->		
		<script type="">
		document.all("indexPage").innerHTML=1;
	</script>
	
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
				// <li class="current" style=" font-size:10px"><a href="<s:url action='phyMachineList'/>"><b>登陆</b></a></li>
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
				<th>编号</th>
				<th>IP地址</th>
				<th>CPU使用率</th>
				<th>内存使用率</th>
				<th>路由器数量</th>
				<th>备注</th>
				<th>操作</th>
				<th>查看</th>
				</tr>
				</thead>
				<tbody>
				<s:iterator value="pms">
				<tr>
				<td name="code"><s:property value="code"/></td>
				<td name="ip"><s:property value="ip"/></td>
				<td name="cpuUsage"></td>
				<td name="memUsage"></td>
				<td name="VRNum"><s:property value="HVRCount"/>/<s:property value="LVRCount"/></td>
				<td name="description"><s:property value="description"/></td>
				<td name="ope">ope</td>
				<td name="detail"><a href="<s:url action='PhysicalMachineAction'>
								<s:param name="id" value="id"/>
							</s:url>">详细查看</a></td>
				</tr>
				</s:iterator>
				</tbody>
			</table>
			<div class="cleaner"></div>
		</div>
		<div id="page">
			<ul>
				<li><button onclick=""  id="add_button">添加</button></li>
				<li><button onclick="getPrePmPage();"  id="pre_button"/>上一页</li>
				<li class="current"><a href="<s:url action='phyMachineList'/>">1</a></li>
				<li><a href="<s:url action='routerList'/>">2</a></li>
				<li><a href="<s:url action='routerList'/>">3</a></li>
				<li><button onclick="getNextPmPage();" id="next_button"/>下一页</li>
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