<%@ page language="java" import="java.util.*" contentType="text/html; charset=gb2312" %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="en">
<head>
    <meta charset="gb2312">	
	
	<title>���鴲</title>
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
	<!-- 1. Add these JavaScript inclusions in the head of your page -->
	<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/1.6.1/jquery.min.js"></script>
	<script type="text/javascript" src="scripts/js/highcharts.js"></script>
	
	<!-- 1a) Optional: add a theme file -->
	
	<!-- 1b) Optional: the exporting module -->
	<script type="text/javascript" src="scripts/js/modules/exporting.js"></script>
	
	
	<!-- 2. Add the JavaScript to initialize the chart on document ready -->
	<script type="text/javascript" src="scripts/my_js/cpu_info.js"></script>
	<script type="text/javascript" src="scripts/my_js/mem_info.js"></script>
	<script type="text/javascript">

	var xmlhttp;
  	//����XMLHttpRequest����
	function createXmlHttp(){
		// �ж�������
		if (window.XMLHttpRequest)
		{// code for IE7+, Firefox, Chrome, Opera, Safari
		  	xmlhttp=new XMLHttpRequest();
		}
		else
		{// code for IE6, IE5
		  	xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}	
	}
				
	//��������,�Ե�ǰҳ��Ϊ����
	function ajax() {
		createXmlHttp();
		xmlhttp.open("post",actions[segment] + "?id=" + <s:property value="id"/> ,true);
		xmlhttp.onreadystatechange = callback;
		xmlhttp.send(null);
		this.display = function() {
			if (segment != 1) {
				var update = new ajax(segment);
				window.setTimeout(function() {update.display();}, 3000);
			}
			
		};
	}

	//�ص�����
	function callback(){
		var rs = xmlhttp.responseText;
		//ʹ��eval�������������ϵ�json�ַ���ת����json����
		var obj = eval('('+rs+')');

		if (segment == 0) {
			data_cpu = obj.CPUUseage;
			data_mem = obj.MemUseage;
		} else if (segment == 2) {
			var states = document.getElementsByName("state");
			var i;
			var parname;
			for (i = 0; i < states.length; i++)
			{
				parname = "vm_state"+ i;
				states[i].innerHTML = obj[parname];
			}
		} else {
			//alert("berzinga!");
		}
	}
	</script>
</head>
<body id="body" onload="setSegment(0);">
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
              <i class="icon-user"></i> ��־��
              <span class="caret"></span>
            </a>
            <ul class="dropdown-menu">
              <li><a href="#">����</a></li>
              <li class="divider"></li>
              <li><a href="#">�˳�</a></li>
            </ul>
          </div>
		  <div class="nav-collapse">
            <ul class="nav">
              <li><p class="navbar-text">����ϵͳ</p></li>
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
              <li><a href="PhysicalMachineListAction?pageIndex=0">��������鿴</a></li>
              <li><a href="VirtualRouterListAction?pageIndex=0">����·�����鿴</a></li>
              <li><a href="ApplicationsListAction?pageIndex=0">��Դ�������</a></li>
              <li><a href="RevertListAction?pageIndex=0">��Դ���չ���</a></li>
              <li class="active"><a href="UserINfoManageAction?type=all&pageIndex=0">�û�����</a></li>
              <li><a href="ExperimentManageAction?type=all&pageIndex=0">�������</a></li>
              <li><a href="phyMachineTopologyAction">����ͼ</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->
		
		
		<div class="span9">
          <div class="page-header">
			<h2>���������Ϣ�鿴
			<small></small></h2>
	      </div>
	      <div class="row">	
	      <div class="tabbable">
		 <ul class="nav nav-tabs">
		  	<li class="active"><a href="#tab1" data-toggle="tab">�����ʵʱ��Ϣ���</a></li>
		    <li><a href="#tab2" data-toggle="tab">�����������Ϣ</a></li>
		    <li><a href="#tab3" data-toggle="tab">����·������Ϣ</a></li>
		  </ul>
		  <div class="tab-content">
		    <div class="tab-pane fade in active" id="tab1">
			  <ul class="thumbnails">
			    <li class="span5">
				  <div class="thumbnail" style="margin-left:26px; margin-right:-26px;">
			        <div id="container1" style="width: 100%; height: 200px;"></div>
			        <div class="caption">
					  <h5 align="center"></h5>
				    </div>
				  </div>
				</li>
				<li  class="span5">
				  <div class="thumbnail" style="margin-left:26px; margin-right:-26px;">
			        <div id="container2" style="width: 100%; height: 200px;"></div>
			        <div class="caption">
			          <h5 align="center"></h5>
				    </div>
				  </div>
				</li>
			  </ul>
			</div><!--tab1 -->
			<div class="tab-pane fade" id="tab2">
			  <table class="table table-striped">
			 	<thead>
				<tr>
					<th>��������</th>
					<th>IP��ַ</th>
					<th>CPU</th>
					<th>�ڴ�����</th>
				</tr>
				</thead>
				<tbody>
				<tr>  
					<td><s:property value="pm.code" /></td>  
					<td><s:property value="pm.ip" /></td>
					<td><s:property value="pm.CPU" /></td>
					<td><s:property value="pm.memory" />G</td>
				</tr>  
				</tbody>
			  </table>
			</div><!--tab2 -->
			<div class="tab-pane fade" id="tab3">
			  <table class="table table-striped"> 
				<thead>
				<tr>
					<th>���</th>
					<th>״̬</th>
					<th>����</th>
				</tr>
				</thead>
				<tbody>
				<s:iterator value="vrs">
				<tr>  
					<td><a href="<s:url action='VirtualRouterAction'>
						<s:param name="id" value="id"/>
					</s:url>">
					<s:property value="vrCode"/></a></td>  
					<td name="state">
						<s:if test="state.compareTo('1') == 0">
							����
						</s:if>
						<s:else>
							�ر�
						</s:else>				
					</td> 
					<td>
						<s:if test="type == true">
							��
						</s:if>
						<s:else>
							��
						</s:else>	
					</td>
				</tr>  
				</s:iterator>
				</tbody>
			  </table>  
			</div><!-- tab3 -->
		  </div><!-- tab-content -->
			  
		  
		  </div><!-- tabbable -->
		  </div>
		</div><!-- span9 -->
 	  </div><!-- row-fluid -->
	  
	  <footer>
        <p>&copy; Company 2012</p>
      </footer>
	  
 	</div><!-- container-fluid -->
	  
	  
	  
    
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
				<li><a href=""><b>���鴲����ϵͳ</b></a></li>
				<!-- <li class="current" style=" font-size:10px"><a href="<s:url action='phyMachineList'/>"><b>��½</b></a></li>
				<li style=" font-size:10px"><a href="<s:url action='routerList'/>"><b>ע��</b></a></li> -->
			<!--	<li style=" font-size:10px"><a href="AdministraterInfo.jsp"><b>����</b></a></li>
			</ul>
		</div>
		<div class="cleaner"></div>
	</div>
	<div id="left">
		<div class="leftset">
	
	<div class="left-content">
		<ul>
			<li class="item"><b class="item1"></b><a style="text-decoration:none;" href="#">��Դ�鿴</a></li>
			<li class="sepra">
				<ul>
					<li class="sepra-list first current"><a style="text-decoration:none;" href="PhysicalMachineListAction?pageIndex=0">�������</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="VirtualRouterListAction?pageIndex=0">����·����</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item2"></b><a style="text-decoration:none;" href="#">��Դ����</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="ApplicationsListAction?pageIndex=0">������Դ</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="RevertListAction?pageIndex=0">������Դ</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item3"></b><a style="text-decoration:none;" href="UserINfoManageAction?type=all&pageIndex=0">�û�����</a></li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item4"></b><a style="text-decoration:none;" href="ExperimentManageAction?type=all&pageIndex=0">ʵ�����</a></li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item5"></b><a style="text-decoration:none;" href="phyMachineTopologyAction">��&nbsp;��&nbsp;ͼ&nbsp;</a></li>
		</ul>
		
		
		
	</div>
	</div>
	</div>
	<div id="right">
		<ul class="botLink" style="margin: 15px 0 10px 300px;">
        	<li onclick="setSegment(0);">�����ʵʱ��Ϣ���</li>
            <li onclick="setSegment(1);">�����������Ϣ</li>
            <li onclick="setSegment(2);" class="noMargin2">����·������Ϣ</li>
        </ul>
		
		<div class="cleaner"></div>
		
		<div name="tag" class="box_top" style="margin: 15px 0 10px 200px; visibility:visible; position: absolute; left: 180px; top: 150px;" >
			<h1 style="margin-top: 10px">�����<s:property value="pm.code"/>ʵʱ��Ϣ</h1>
			<div id="container1" style="width: 240px; height: 200px; margin: 0 10px 0 50px; float:left"></div>
			<div id="container2" style="width: 240px; height: 200px; margin: 0 10px 0 100px; float:left"></div>
		</div>
		<div name="tag" class="box" style="margin: 15px 0 10px 200px; visibility:hidden;  position: absolute; left: 180px; top: 150px;">
			<h1 style="margin-top: 10px">�����<s:property value="pm.code"/>������Ϣ</h1>
			<table class="my_table" style="margin: 50px auto; width:550px; background: #dbdbdb;">
			<thead>
				<tr>
					<th>��������</th>
					<th>IP��ַ</th>
					<th>CPU</th>
					<th>�ڴ�����</th>
				</tr>
			</thead>
			<tbody>
				<tr>  
					<td><s:property value="pm.code" /></td>  
					<td><s:property value="pm.ip" /></td>
					<td><s:property value="pm.CPU" /></td>
					<td><s:property value="pm.memory" />G</td>
				</tr>  
			</tbody>
			</table>
		</div>
		<div name="tag" class="box_top" style="margin: 15px 0 10px 260px;visibility:hidden; position: absolute; left: 180px; top: 150px;">
			<h1 style="margin-top: 10px"><s:property value="vr.vname"/>����·������Ϣ</h1>
			<table class="my_table" style="margin: 50px, auto; width:400px; background: #dbdbdb;"> 
			<thead>
				<tr>
					<th>���</th>
					<th>״̬</th>
					<th>����</th>
				</tr>
			</thead>
			<tbody>
				<s:iterator value="vrs">
				<tr>  
					<td><a href="<s:url action='VirtualRouterAction'>
						<s:param name="id" value="id"/>
					</s:url>">
					<s:property value="vrCode"/></a></td>  
					<td name="state">
						<s:if test="state.compareTo('1') == 0">
							����
						</s:if>
						<s:else>
							�ر�
						</s:else>				
					</td> 
					<td>
						<s:if test="type == true">
							��
						</s:if>
						<s:else>
							��
						</s:else>	
					</td>
				</tr>  
				</s:iterator>
			</tbody>
			</table>  
		</div>
		<div id="content_bottom">
			<div class="cleaner"></div>
		</div>
	</div>
</div>
<div id="footer"><p><a href="http://www.ict.ac.cn/">�й���ѧԺ���㼼���о���</a> ��Ȩ����</p></div>
var tags = document.getElementsByName("tag");
	tags[1].style.visibility = "hidden";
	tags[2].style.visibility = "hidden";	-->
</body>

</html>
