<%@ page language="java" import="java.util.*" contentType="text/html; charset=gb2312"  %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
	<meta charset="gb2312">	
	
	<title>试验床</title>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
	
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

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

    <!-- Le fav and touch icons -->

	<script type="text/javascript" src="scripts/my_js/num_format.js"></script>
	
	<script type="text/javascript">
	var objList=new Array();//数组
	var userID;
	var register;
	var deleteUser;
	
	var xmlhttp;
	
	var pageIndex = 0;
	var type = "all";
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

	//创建userRegisterAndDelete类有参构造器  
	function userRegisterAndDelete(userID, register, deleteUser){  
		this.userID = userID;
	    this.register = register;  
	    this.deleteUser = deleteUser;
	} 
	
				
	//主调函数,以当前页作为参数
	function ajax_userRegisterAndDelete(jsonData) {
		//alert(jsonData);
		createXmlHttp();
		xmlhttp.open("post","JSONUserInfoManageOperation?json=" + jsonData + "&type="+ type + "&pageIndex=" + pageIndex, true);
		xmlhttp.onreadystatechange = callback;
		xmlhttp.setRequestHeader("Content-Type" ,"application/x-www-form-urlencoded");
		xmlhttp.send(null);
		
	}
	
	// 提交给后台Action一份用户管理方案的list。
	function userManageButton() {
		var idTags = document.getElementsByName("id");
		var registerCheckBoxTags = document.getElementsByName("register");
		var deleteCheckBoxTags = document.getElementsByName("delete");
		//alert("in userManageButton");
		for (var i = 0; i < idTags.length; i++) {
			userID = idTags[i].innerHTML;
			if (userID == "") {
				//alert("userID undefined");
				break;
			}
			register = registerCheckBoxTags[i].checked;
			deleteUser = deleteCheckBoxTags[i].checked;	
			//alert(register);
			//alert(deleteUser);
			var userManage= new userRegisterAndDelete(userID, register, deleteUser);//对象
			objList.push(userManage);
		}
		
		//使用json.js库里的stringify()方法将objList对象转换成Json字符串   
   		var userRegisterAndDeleteAsJSON = JSON.stringify(objList);  
   		
		ajax_userRegisterAndDelete(userRegisterAndDeleteAsJSON);
	}
  
	//主调函数,以当前页作为参数
	function ajax(type, pageIndex) {
		createXmlHttp();
		xmlhttp.open("post","JSONPage?pageKind=" + "users&type="+ type + "&pageIndex=" + pageIndex, true);
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
		//alert(xmlhttp.responseText);
		//使用eval方法将服务器上的json字符传转换成json对象
		var obj = eval('('+rs+')');
		
		var items = obj["list"];
		pageCnt = obj["pageCnt"];
		//alert(items.length);
		
		var idTags = document.getElementsByName("id");
		var nameTags = document.getElementsByName("name");
		var emailTags = document.getElementsByName("email");
		var telephoneTags = document.getElementsByName("telephone");
		var cityTags = document.getElementsByName("city");
		var hrefTags = document.getElementsByName("href");
		//var registerBoxTags = document.getElementsByName("registerBox");
		//var deleteBoxTags = document.getElementsByName("deleteBox");
		//alert(idTags.length);
		//alert(items[0].id);
		for (var i = 0; i < idTags.length - items.length; i++) {
			idTags[i + items.length].innerHTML = "";
			nameTags[i + items.length].innerHTML = "";
			emailTags[i + items.length].innerHTML = "";
			telephoneTags[i + items.length].innerHTML = "";
			cityTags[i + items.length].innerHTML = "";
			hrefTags[i + items.length].innerHTML = "";
		    //registerBoxTags[i + items.length].innerHTML = "";
			//deleteBoxTags[i + items.length].innerHTML = "";
		}
		
		//alert(items[0].id);
		for(var i =0;i<items.length;i++) {
			var item=items[i];

         	idTags[i].innerHTML = item.id;
         	
			nameTags[i].innerHTML = item.name;
			emailTags[i].innerHTML = item.email;
			telephoneTags[i].innerHTML = item.telephone;
			cityTags[i].innerHTML = item.city;
			hrefTags[i].innerHTML = "<a href='UserInfoAction?userId=" + 
			 item.id + "'>详细查看</a>";
			//registerBoxTags[i].innerHTML = "<input name='register' type='checkbox'>";
			//deleteBoxTags[i].innerHTML = "<input name='delete' type='checkbox'>";
		}
		
		setButtonVisible();
		}
	}
	}
	
	//获取特定类型的user列表
	function getUser(theType) {
		pageIndex = 0;

		type = theType;
		ajax(type, pageIndex);
	}
	
	//获取下一页的user列表
	function getNextUserPage() {
	if (pageIndex>=pageCnt){
		document.all("indexPage").innerHTML=pageIndex+1;
		ajax(type, pageIndex);
	}
	else{
		pageIndex++;
		document.all("indexPage").innerHTML=pageIndex+1;
		ajax(type, pageIndex);
	}
	}
	
	//获取上一页的user列表
	function getPreUserPage() {
	if (pageIndex==0){
		document.all("indexPage").innerHTML=pageIndex+1;
		ajax(type, pageIndex);
	}
	else{   
	    pageIndex--;
	    document.all("indexPage").innerHTML=pageIndex+1;
		ajax(type, pageIndex);
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
  </head>


  <body id="body" onload="setButtonVisible();">
  
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
        <div class="span3" style="margin-top:100px; font-size:18px;">
          <div class="sidebar-nav">
            <ul class="nav nav-pills nav-stacked">
              <li><a href="PhysicalMachineListAction?pageIndex=0">物理机器查看</a></li>
              <li><a href="VirtualRouterListAction?pageIndex=0">虚拟路由器查看</a></li>
              <li><a href="ApplicationsListAction?pageIndex=0">资源申请管理</a></li>
              <li><a href="RevertListAction?pageIndex=0">资源回收管理</a></li>
              <li class="active"><a href="UserINfoManageAction?type=all&pageIndex=0">用户管理</a></li>
              <li><a href="ExperimentManageAction?type=all&pageIndex=0">试验管理</a></li>
              <li><a href="phyMachineTopologyAction">拓扑图</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->
		
		
        <div class="span9">
          <div class="page-header">
			<h2>管理员设置
			<small>设置管理员个人信息</small></h2>
	      </div>
		  <div class="row">
		    
		    <ul class="nav nav-tabs">
			  <li class="active">
			  	<a href="#">所有用户</a>
			  </li>
			  <li><a href="#">未审核用户</a></li>
			  <li><a href="#">已审核用户</a></li>
			</ul>
			<table class="table table-striped">
			  <thead>
			  	<tr>
				  <th></th>
				  <th>试验者编号</th>
				  <th>试验者姓名</th>
				  <th>邮件地址</th>
				  <th>联系方式</th>
				  <th>地址</th>
				  <th>查看试验信息</th>
				</tr>
			  </thead>
			  <tbody>
			  <s:iterator value="users">
			  	<tr>
				  <td name="registerBox"><input name="register" type="checkbox"/></td>
				  <td name="id"><s:property value="id"/></td>
				  <td name="name"><s:property value="name"/></td>
				  <td name="email"><s:property value="email"/></td>
				  <td name="telephone"><s:property value="telephone"/></td>
				  <td name="city"><s:property value="city"/></td>
				  <td name="href"><a href="<s:url action='UserInfoAction'>
								<s:param name="userId" value="id"/>
							</s:url>">详细查看</a></td>
			  	  
				</tr>
			  </s:iterator>
			 <!--<s:iterator value="appendList">
			  	<tr>
				  <td name="id"></td>
				  <td name="name"></td>
				  <td name="email"></td>
				  <td name="telephone"></td>
				  <td name="city"></td>
			  	  <td name="href"></td>
			 	  <td name="registerBox"></td>
				  <td name="deleteBox"></td>
			    </tr>
			  </s:iterator>--> 
			  </tbody>
			</table>
		  </div>
		  <div class="row">
			<div class="span2">
			  <button class="btn btn-success">审核</button>
			  <button class="btn btn-danger">删除</button>
			</div>
			<div class="span4"></div>
			<div class="span2" style="margin-top:5px;"><p class="strong" style="float:right; font-size:14px;">
			<s:set var="index" value="0"/>
			第  <sx:div id="indexPage"> </sx:div> 页，共<s:property value="pageCnt+1" />页</p></div>
			<div class="span3">
			  <div class="pager" style="float:left">
			    <li>
				  <a href="javascript:getPreUserPage()" >&larr;上一页</a>
				</li>
				<li>
				  <a href="javascript:getNextUserPage()" >下一页&rarr;</a>
				</li>
			  </div>
			</div>
			
		  </div><!-- /"" -->
        </div><!--/span-->
	  </div> <!-- /row-fluid--> 
      <hr/>

      <footer>
        <p>&copy; Company 2012</p>
      </footer>

    </div><!--/.fluid-container-->

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
				<!-- <li class="current" style=" font-size:10px"><a href="<s:url action='phyMachineList'/>"><b>登陆</b></a></li>
				<li style=" font-size:10px"><a href="<s:url action='routerList'/>"><b>注册</b></a></li> -->
		<!-- 		<li style=" font-size:10px"><a href="AdministraterInfo.jsp"><b>设置</b></a></li>
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
		<form style="margin:40px 0 0 0">
			<input type="radio" checked="checked" name="type"  onclick="getUser('all');"/>
			所有用户
			<input type="radio" name="type" onclick="getUser('unregistered');"/>
			未注册用户
			<input type="radio" name="type" onclick="getUser('registered');"/>
			已注册用户
		</form>
		<div id="content_top">
			<table  class="my_table" border="0">
				<thead>
				<tr>
				<th>试验者编号</th>
				<th>试验者姓名</th>
				<th>邮件地址</th>
				<th>联系方式</th>
				<th>地址</th>
				<th>查看试验信息</th>
				<th>注册</th>			
				<th>删除用户</th>
				</tr>
				</thead>
				<tbody>
				<s:iterator value="users">
				<tr>
				<td name="id"><s:property value="id"/></td>
				<td name="name"><s:property value="name"/></td>
				<td name="email"><s:property value="email"/></td>
				<td name="telephone"><s:property value="telephone"/></td>
				<td name="city"><s:property value="city"/></td>
				<td name="href"><a href="<s:url action='UserInfoAction'>
								<s:param name="userId" value="id"/>
							</s:url>">详细查看</a></td>
				<td name="registerBox"><input name="register" type="checkbox"></td>
				<td name="deleteBox"><input name="delete" type="checkbox"></td>
				</tr>
				</s:iterator>
				
				<s:iterator value="appendList">
				<tr>
				<td name="id"></td>
				<td name="name"></td>
				<td name="email"></td>
				<td name="telephone"></td>
				<td name="city"></td>
				<td name="href"></td>
				<td name="registerBox"></td>
				<td name="deleteBox"></td>
				</tr>
				</s:iterator>
				
				</tbody>
			</table>
			<div class="cleaner"></div>
		</div>
		<div id="page">
			<ul>
				<li><button onclick="userManageButton();">确定</button></li>
				<li><button onclick="getPreUserPage()"  id="pre_button"/>上一页</li></li>
				<li class="current"><a href="<s:url action='phyMachineList'/>">1</a></li>
				<li><a href="<s:url action='routerList'/>">2</a></li>
				<li><a href="<s:url action='routerList'/>">3</a></li>
				<li><button onclick="getNextUserPage();" id="next_button"/>下一页</li></li>
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
