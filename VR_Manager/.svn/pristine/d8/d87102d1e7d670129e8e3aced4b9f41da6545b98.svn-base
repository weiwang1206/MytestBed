<%@ page language="java" import="java.util.*" contentType="text/html; charset=gb2312" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html lang="en">
<head>
	<title>试验床</title>

	<meta charset="gb2312">	

	
	<!-- Le styles -->
    <link href="assets/css/bootstrap.css" rel="stylesheet">
    <style type="text/css">
      body {
        padding-top: 30px;
        padding-bottom: 20px;
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
	
		var i;
		var vid="", port="";
		
		for ( i =1 ; i < 9 ; i++)
		{
			var obj = document.getElementById('VR'+i);
			var obj1 = document.getElementById('Port'+i);
			////alert(obj.id);
			if (i !=8 )
			{
			vid =vid+obj.options[obj.selectedIndex].text.substring(6)+',';
			port=port+obj1.options[obj1.selectedIndex].text.substring(4)+',';
			}
			else
			{
			vid =vid+obj.options[obj.selectedIndex].text.substring(6);
			port=port+obj1.options[obj1.selectedIndex].text.substring(4);
			}
			////alert(vid);
		}
		//alert(vid);
		//alert(port);
		createXmlHttp();
		xmlhttp.open("post","JSONPortDataForWebAction.action?cases=exp&vid="+vid+"&port="+port,true);
		xmlhttp.onreadystatechange = callback;
		xmlhttp.send(null);
		this.display = function() {
			
			var update = new ajax();
			window.setTimeout(function() {update.display();}, 3000);
		};
	}

	//回调函数
	function callback(){
		var rs = xmlhttp.responseText;
		//使用eval方法将服务器上的json字符传转换成json对象
		var obj = eval('('+rs+')');

		flow1 = obj["VR1"];
		flow2 = obj["VR2"];
		flow3 = obj["VR3"];
		flow4 = obj["VR4"];
		flow5 = obj["VR5"];
		flow6 = obj["VR6"];
		flow7 = obj["VR7"];
		flow8 = obj["VR8"];
		
	}
	
	
	</script>
</head>


<body  id="body">

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
              <li class="active"><a style="text-decoration:none;" href="PortDataForWebAction.action">端口数据</a></li>
              <li ><a style="text-decoration:none;" href="VRDataForWebAction.action?vid=101">路由表项</a></li>
              <li><a href="">数据报表</a></li>
              <li><a href="">实验工具</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->
        <div class="span10">
          <div class="page-header" style="padding-bottom:0px">
			<h2>端口数据
			<small>实验  <s:property value="expName"/></small></h2>
	      </div>
  		<div class="span10">
		  <div class="row">
		  <ul class="thumbnails" style="width:1100px">
			<li class="span3" >
			  <div class="thumbnail" style="margin-left:2px; margin-right:-2px;">
			  	<div id="container1" style="width: 100%; height: 200px;"></div>
				<div class="caption">
				  <h5 align="center"></h5>
				  <select id="VR1" style="width:49%;">   
					<option>NULL</option>
					<s:iterator value="vrList">
					  <option>Router<s:property /></option> 
					</s:iterator>  
				  </select>
				  <select id="Port1" style="width:49%;">   
  					<option>Port0</option>   
  					<option>Port1</option>   
 					<option>Port2</option>   
  					<option>Port3</option> 
  				  </select>
				</div>
			  </div>
			</li>
			<li class="span3">
			
			  <div class="thumbnail" style="margin-left:2px; margin-right:-2px;">
			  	<div id="container2" style="width: 100%; height: 200px;"></div>
				<div class="caption">
				  <h5 align="center"></h5>
				  <select id="VR2" style="width:49%;">   
  					<option>NULL</option>
  					<s:iterator value="vrList">
  					<option>Router<s:property /></option> 
  					</s:iterator>  
  			</select>
  			<select id="Port2" style="width:49%;">   
  					<option>Port0</option>   
  					<option>Port1</option>   
 					<option>Port2</option>   
  					<option>Port3</option>  
  			</select>
				</div>
			  </div>
			</li>
			<li class="span3">
			  <div class="thumbnail" style="margin-left:2px; margin-right:-2px;">
			  	<div id="container3" style="width: 100%; height: 200px;"></div>
				<div class="caption">
				  <h5 align="center"></h5>
				  <select id="VR3" style="width:49%;">   
  					<option>NULL</option>
  					<s:iterator value="vrList">
  					<option>Router<s:property /></option> 
  					</s:iterator>  
  			</select>
  			<select id="Port3" style="width:49%;">   
  					<option>Port0</option>   
  					<option>Port1</option>   
 					<option>Port2</option>   
  					<option>Port3</option>  
  			</select>
				</div>
			  </div>
			</li>
			<li class="span3 ">
			 <div class="thumbnail" style="margin-left:2px; margin-right:-2px;">
			  	<div id="container4" style="width: 100%; height: 200px;"></div>
				<div class="caption">
				  <h5 align="center"></h5>
				  <select id="VR4" style="width:49%;">   
  					<option>NULL</option>
  					<s:iterator value="vrList">
  					<option>Router<s:property /></option> 
  					</s:iterator>  
  			</select>
  			<select id="Port4" style="width:49%;">   
  					<option>Port0</option>   
  					<option>Port1</option>   
 					<option>Port2</option>   
  					<option>Port3</option>  
  			</select>
				</div>
			  </div>
			</li>
		</ul>
		</div>
		
		<div class="row">
		  <ul class="thumbnails" style="width:1100px;">
			<li class="span3">
			  <div class="thumbnail" style="margin-left:2px; margin-right:-2px;">
			  	<div id="container5" style="width: 100%; height: 200px;"></div>
				<div class="caption">
				  <h5 align="center"></h5>
				  <select id="VR5" style="width:49%;">   
					<option>NULL</option>
					<s:iterator value="vrList">
					  <option>Router<s:property /></option> 
					</s:iterator>  
				  </select>
				  <select id="Port5" style="width:49%;">   
  					<option>Port0</option>   
  					<option>Port1</option>   
 					<option>Port2</option>   
  					<option>Port3</option> 
  				  </select>
				</div>
			  </div>
			</li>
			<li class="span3">
			
			  <div class="thumbnail" style="margin-left:2px; margin-right:-2px;">
			  	<div id="container6" style="width: 100%; height: 200px;"></div>
				<div class="caption">
				  <h5 align="center"></h5>
				  <select id="VR6" style="width:49%;">   
  					<option>NULL</option>
  					<s:iterator value="vrList">
  					<option>Router<s:property /></option> 
  					</s:iterator>  
  			</select>
  			<select id="Port6" style="width:49%;">   
  					<option>Port0</option>   
  					<option>Port1</option>   
 					<option>Port2</option>   
  					<option>Port3</option>  
  			</select>
				</div>
			  </div>
			</li>
			<li class="span3">
			  <div class="thumbnail" style="margin-left:2px; margin-right:-2px;">
			  	<div id="container7" style="width: 100%; height: 200px;"></div>
				<div class="caption">
				  <h5 align="center"></h5>
				  <select id="VR7" style="width:49%;">   
  					<option>NULL</option>
  					<s:iterator value="vrList">
  					<option>Router<s:property /></option> 
  					</s:iterator>  
  			</select>
  			<select id="Port7" style="width:49%;">   
  					<option>Port0</option>   
  					<option>Port1</option>   
 					<option>Port2</option>   
  					<option>Port3</option>  
  			</select>
				</div>
			  </div>
			</li>
			<li class="span3 ">
			 <div class="thumbnail" style="margin-left:2px; margin-right:-2px;">
			  	<div id="container8" style="width: 100%; height: 200px;"></div>
				<div class="caption">
				  <h5 align="center"></h5>
				  <select id="VR8" style="width:49%;">   
  					<option>NULL</option>
  					<s:iterator value="vrList">
  					<option>Router<s:property /></option> 
  					</s:iterator>  
  			</select>
  			<select id="Port8" style="width:49%;">   
  					<option>Port0</option>   
  					<option>Port1</option>   
 					<option>Port2</option>   
  					<option>Port3</option>  
  			</select>
				</div>
			  </div>
			</li>
		</ul>
		</div>
		
		</div><!--span9 -->
	  </div><!--row-fluid -->
	  
			
	  <hr/>

      <!--  <footer>
        <p>&copy; Company 2012</p>
      </footer>-->
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
				<!-- 
				<li class="current" style=" font-size:10px; "><a href=""><b>登陆</b></a></li>
				<li style=" font-size:10px; "><a href=""><b>注册</b></a></li>
				 -->
	<!--			<li style=" font-size:10px; "><a href="experimenterInfo.jsp"><b>设置</b></a></li>
			</ul>
		</div>
		<div class="cleaner"></div>
	</div>


	<div id="left">
	<div class="leftset">
>>>>>>> .r171
	
	
	<div class="container-fluid">
      <div class="row-fluid">
        <div class="span2" style="margin-top:70px; font-size:18px;" align="center">
          <div class="sidebar-nav">
            <ul class="nav nav-pills nav-stacked">
              <li class="active"><a style="text-decoration:none;" href="experiment_system.jsp">申请实验</a></li>
              <li><a style="text-decoration:none;" href="experiment_system.jsp">配置实验</a></li>
              <li><a href="">启动停止</a></li>
              <li><a style="text-decoration:none;" href="PortDataForWebAction.action">端口数据</a></li>
              <li ><a style="text-decoration:none;" href="VRDataForWebAction.action?vid=101">路由表项</a></li>
              <li><a href="">数据报表</a></li>
              <li><a href="">实验工具</a></li>
            </ul>
      
			
	
	
	
			
	

	<div id="footer"><div class="cleaner"></div><p><a id="foot_a" href="http://www.ict.ac.cn/">中国科学院计算技术研究所</a> 版权所有</p>
	</div>-->
	
	<script type="text/javascript">
	var update = new ajax();
	update.display();
	</script>
</body>
</html>