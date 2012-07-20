<%@ page language="java" import="java.util.*" contentType="text/html; charset=gb2312" %>
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

	<link href="css/physical_machine_list.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="scripts/my_js/num_format.js"></script>
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
		xmlhttp.open("post","JSONPage?pageKind=" + "vrs" + "&pageIndex=" + pageIndex, true);
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
		var pmCodeItems = obj["pmCodeList"];
		var portCntItems = obj["portCntList"];
		var experimenterItems = obj["experimenterList"];
		var experimentNameItems = obj["experimentNameList"];
		
		pageCnt = obj["pageCnt"];
		
		var codeTags = document.getElementsByName("code");
		var pmCodeTags = document.getElementsByName("pmCode");
		var portCntTags = document.getElementsByName("portCnt");
		var stateTags = document.getElementsByName("state");
		var experimenterTags = document.getElementsByName("experimenter");
		var experimentNameTags = document.getElementsByName("experimentName");
		var protocolTags = document.getElementsByName("protocol");
		var detailTags = document.getElementsByName("detail");
				
		for (var i = 0; i < codeTags.length - items.length; i++) {
			codeTags[i + items.length].innerHTML = "";
			pmCodeTags[i + items.length].innerHTML = "";
			portCntTags[i + items.length].innerHTML = "";
			stateTags[i + items.length].innerHTML = "";
			experimenterTags[i + items.length].innerHTML = "";
			experimentNameTags[i + items.length].innerHTML = "";
			protocolTags[i + items.length].innerHTML = "";
			detailTags[i + items.length].innerHTML = "";
		}
		
		//alert(items.length);
		for(var i =0;i<items.length;i++) {
			var item=items[i];
			//alert(item.vrCode);
         	codeTags[i].innerHTML = item.vrCode;
			pmCodeTags[i].innerHTML = pmCodeItems[i];
			portCntTags[i].innerHTML = portCntItems[i];
			if (item.runState == true) {
				stateTags[i].innerHTML = "开启";
			} else {
				stateTags[i].innerHTML = "关闭";
			}
			experimenterTags[i].innerHTML = experimenterItems[i];
			experimentNameTags[i].innerHTML = experimentNameItems[i];
			protocolTags[i].innerHTML = item.routeProtocol;
			
			detailTags[i].innerHTML = 
			"<a href='VirtualRouterAction?id=" + 
			 item.id + "'>详细查看</a>";
		}
		
		setButtonVisible();
		}
	}
    }
    
	//获取下一页的Apl列表
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
	<title>试验床</title>
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
              <li class="active"><a href="VirtualRouterListAction?pageIndex=0">虚拟路由器查看</a></li>
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
			<small>虚拟路由器</small></h2>		
	      </div>
          <div class="row">
		  <table class="table table-striped">
			<thead>
			<tr>
			<th>编号</th>
			<th>物理机</th>
			<th>端口数</th>
			<th>状态</th>
			<th>试验者</th>
			<th>试验</th>
			<th>备注</th>
			<th>详细查看</th>
			</tr>
			</thead>
			<tbody>
			<s:iterator value="%{vrList}" id="id" status="status">
			<tr>
			<td name="code"><s:property value="vrCode"/></td>
			<td name="pmCode"><s:property value="pmCodeList[#status.index]"/></td>
			<td name="portCnt"><s:property value="%{portCntList[#status.index]}"/></td>
			<td name="state">
				<s:if test="vr.state.compareTo('1') == 0">
							开启
						</s:if>
						<s:else>
							关闭
						</s:else></td>
			<td name="experimenter"><s:property value="experimenterList[#status.index]"/></td>
			<td name="experimentName"><s:property value="experimentNameList[#status.index]"/></td>
			<td name="protocol"><s:property value="routeProtocol"/></td>
			<td name="detail"><a href="<s:url action='VirtualRouterAction'>
							<s:param name="id" value="id"/>
						</s:url>
					">详细查看</a></td>
			</tr>
			</s:iterator>
			</tbody>
			</table>
			<div class="cleaner"></div>                   
          </div><!-- "row" -->
          
          
          
          <!-- 设置添加， 上、下页按钮 -->
          <div class="row">
 		    <div class="span2"></div>
			<div class="span4" style="margin-top:5px;"><p class="strong" style="float:right; font-size:14px;">第<sx:div id="indexPage"> </sx:div>页，共<s:property value="pageCnt+1"/>页</p></div>
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
         </div><!-- "span9" -->
         

      </div><!--/.row-container-->
        <hr/>
       <footer>
        	<p>&copy; Company 2012</p>
       </footer>
      
     </div><!-- container fluid -->
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
		<table class="my_table" border="0">
			<thead>
			<tr>
			<th>编号</th>
			<th>物理机</th>
			<th>端口数</th>
			<th>状态</th>
			<th>试验者</th>
			<th>试验</th>
			<th>备注</th>
			<th>详细查看</th>
			</tr>
			</thead>
			<tbody>
			<s:iterator value="%{vrList}" id="id" status="status">;
			<tr>
			<td name="code"><s:property value="vrCode"/></td>
			<td name="pmCode"><s:property value="pmCodeList[#status.index]"/></td>
			<td name="portCnt"><s:property value="%{portCntList[#status.index]}"/></td>
			<td name="state">
				<s:if test="vr.state.compareTo('1') == 0">
							开启
						</s:if>
						<s:else>
							关闭
						</s:else></td>
			<td name="experimenter"><s:property value="experimenterList[#status.index]"/></td>
			<td name="experimentName"><s:property value="experimentNameList[#status.index]"/></td>
			<td name="protocol"><s:property value="routeProtocol"/></td>
			<td name="detail"><a href="<s:url action='VirtualRouterAction'>
							<s:param name="id" value="id"/>
						</s:url>
					">详细查看</a></td>
			</tr>
			</s:iterator>
			</tbody>
			</table>
			<div class="cleaner"></div>
		</div>
		
		<div id="page">
			<ul>
				<li><button onclick=""  id="add_button">添加</button></li>
				<li><button onclick="getPrePmPage();"  id="pre_button"/>上一页</li></li>
				<li class="current"><a href="<s:url action='phyMachineList'/>">1</a></li>
				<li><a href="<s:url action='routerList'/>">2</a></li>
				<li><a href="<s:url action='routerList'/>">3</a></li>
				<li><button onclick="getNextPmPage();" id="next_button"/>下一页</li></li>
			</ul>
		</div>
		<div id="content_bottom">
			<div class="cleaner"></div>
		</div>
	</div>
</div>
<div id="footer"><p><a href="http://www.ict.ac.cn/">中国科学院计算技术研究所</a> 版权所有</p></div>
-->	
</body>
</html>
