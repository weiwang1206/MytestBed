<%@ page language="java" import="java.util.*" contentType="text/html; charset=gb2312" pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
	<title>试验床</title>
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
	
	
	<script type="text/javascript">
	function table_autoIncrease()
	{
		var oTable = document.getElementById("expTable");
		for(var i=0;i<oTable.rows.length;i++){
			oTable.rows[i].cells[0].innerHTML = (i+1);
			}
	}
	</script>
</head>

<body  id="body" onload="table_autoIncrease()">
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
              <i class="icon-user"></i> weiwang
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
              <li class="active"><a style="text-decoration:none;" href="UserExpsAction.action">创建打开</a></li>
              <li><a style="text-decoration:none;" href="createExp.action?method=open">申请配置</a></li>
              <li><a href="">启动停止</a></li>
              <li ><a style="text-decoration:none;" href="PortDataForWebAction.action">端口数据</a></li>
              <li ><a style="text-decoration:none;" href="VRDataForWebAction.action?vid=101">路由表项</a></li>
              <li><a href="">数据报表</a></li>
              <li><a href="">实验工具</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->
        
        
        
        <div class="span10">
        
        <div class="tabbable" style="margin-top:30px;">
        	<ul class="nav nav-tabs">
        	<li class="active"><a href="#tab1" data-toggle="tab"><h2>创建实验</h2></a></li>
        	<li ><a href="#tab2" data-toggle="tab"><h2>我的实验</h2></a></li>
        	</ul>
        	<div class="tab-content">
        		<div class="tab-pane active" id="tab1">
	        		 	
						<form class="well "action="createExp.action?method=create" method="post">
						<input class="span3" style="width:280px" placeholder="输入实验名称" type="text" name="expName" />
						<textarea class="input-xlarge" placeholder="输入实验描述" rows="5" name="expDescription" /></textarea><br/>
						<button class="btn btn-success" type="submit" />创建实验</button>
						</form>
			        		
        		</div>
        		<div class="tab-pane "  id="tab2">
				        
						<table class="table table-striped" >
							<thead>
								<tr>
									<th>#</th>
									<th><h4>实验编号</h4></th>
									<th><h4>实验名称</h4></th>
									<th><h4>实验描述</h4></th>
									<th><h4>创建时间</h4></th>
									<th><h4>操作</h4></th>
								</tr>
							</thead>
							<tbody id="expTable">
								<s:iterator value="exps">
								<tr>
								<td name="id"></td>
								<td name="expid"><s:property value="id"/></td>
								<td name="name"><s:property value="expName"/></td>
								<td name="des"><s:property value="description"/></td>
								<td name="time"><s:property value="expApplyTime"/></td>
								<td name="opt"><a href="createExp.action?method=open&expID=<s:property value="id"/>">打开</a></td>
								</tr>
								</s:iterator>
							</tbody>
						</table>
        		</div>
        		
        	</div>
        	
        </div>
        
         
		</div>
		
		
		<!-- 
		<form action="createExp.action?method=open" method="post">
		实验ID <input type="text" name="expID" /><br />
		<input type="submit" value="打开实验" />
		</form> -->
		
		
		
		</div><!--span10 -->
	  
	  
	  </div><!--row-fluid -->
	  
			
	  <hr/>
		
     
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
	
	<script type="text/javascript">
	
	</script>

</body>
</html>