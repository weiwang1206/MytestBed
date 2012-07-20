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
	<title>���鴲</title>
	<script type="text/javascript">
	
	var pageIndex = 0;
	var type="FINISHED";
	var xmlhttp;
	var pageCnt=<s:property value="pageCnt"/>;
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
	function ajax(type, pageIndex) {
		createXmlHttp();
		xmlhttp.open("post","JSONPage?pageKind=" + "exps" + "&type=" + type + "&pageIndex=" + pageIndex, true);
		xmlhttp.onreadystatechange = callback;
		xmlhttp.send(null);
	}

	//�ص�����
	function callback(){
	if (xmlhttp.readyState == 4)
	{
		if (xmlhttp.status == 200)
		{
		var rs = xmlhttp.responseText;
		//ʹ��eval�������������ϵ�json�ַ���ת����json����
		var obj = eval('('+rs+')');

		setButtonVisible();
		}
	}
	}
	

	
	//��ȡ��һҳ��Revert�б�
	function getNextRevertPage() {
		pageIndex++;
		ajax(type, pageIndex);
	}
	
	//��ȡ��һҳ��Revert�б�
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
	<!-- �����Ϸ������������Ϸ��˳� -->
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
	
	<!-- �����󷽵����� -->
	<div class="container-fluid">
      <div class="row-fluid">
        <div class="span3" style="margin-top:100px; font-size:18px;">
          <div class="sidebar-nav">
            <ul class="nav nav-pills nav-stacked">
              <li><a href="PhysicalMachineListAction?pageIndex=0">��������鿴</a></li>
              <li><a href="VirtualRouterListAction?pageIndex=0">����·�����鿴</a></li>
              <li><a href="ApplicationsListAction?pageIndex=0">��Դ�������</a></li>
              <li class="active"><a href="RevertListAction?pageIndex=0">��Դ���չ���</a></li>
              <li><a href="UserINfoManageAction?type=all&pageIndex=0">�û�����</a></li>
              <li><a href="ExperimentManageAction?type=all&pageIndex=0">�������</a></li>
              <li><a href="phyMachineTopologyAction">����ͼ</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->
        		
        <div class="span9">
          <div class="page-header">
			<h2>��Դ����	
			<small>������Դ</small></h2>		
	      </div>
		  <div class="row">
        		<table  class="table table-striped" >
				<thead>
				<tr>
				<th>��������</th>
				<th>������</th>
				<th>״̬</th>
				<th>�黹·��������</th>
				<th>��ϸ</th>
				<th>����</th>
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
							</s:url>">��ϸ�鿴</a></td>
				<td><input name="release" type="checkbox"></td>
				</tr>
				</s:iterator>
				</tbody>
			</table>
       		<div class="cleaner"></div>
       	 </div>
       	 <div class="row"> 
       	 	<div class="span2"></div>
			<div class="span3" style="margin-top:5px;"><p class="strong" style="float:right; font-size:14px;">��2ҳ����6ҳ</p></div>
			<div class="span6">
			  <div class="pager" style="float:left">
			    <li>
				  <a href="#" >&larr;��һҳ</a>
				</li>
				<li>
				  <a href="#" >��һҳ&rarr;</a>
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
				<li><a href=""><b>���鴲����ϵͳ</b></a></li>
				//<li class="current" style=" font-size:10px"><a href="<s:url action='phyMachineList'/>"><b>��½</b></a></li>
				//<li style=" font-size:10px"><a href="<s:url action='routerList'/>"><b>ע��</b></a></li>
				<li style=" font-size:10px"><a href="AdministraterInfo.jsp"><b>����</b></a></li>
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
		<div id="content_top">
			<table  class="my_table" border="0">
				<thead>
				<tr>
				<th>��������</th>
				<th>������</th>
				<th>״̬</th>
				<th>�黹·��������</th>
				<th>��ϸ</th>
				<th>����</th>
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
							</s:url>">��ϸ�鿴</a></td>
				<td><input name="release" type="checkbox"></td>
				</tr>
				</s:iterator>
				</tbody>
			</table>
			<div class="cleaner"></div>
		</div>
		<div id="page">
			<ul>
				<li><button onclick=""  id="add_button">ȷ��</button></li>
				<li><button onclick="getPreRevertPage();"  id="pre_button"/>��һҳ</li></li>
				<li class="current"><a href="<s:url action='phyMachineList'/>">1</a></li>
				<li><a href="<s:url action='routerList'/>">2</a></li>
				<li><a href="<s:url action='routerList'/>">3</a></li>
				<li><button onclick="getNextRevertPage();" id="next_button"/>��һҳ</li></li>
			</ul>
		</div>
		<div id="content_bottom">
			<div class="cleaner"></div>
		</div>
	</div>
</div>	
<div id="footer"><div class="cleaner"></div><p><a href="http://www.ict.ac.cn/">�й���ѧԺ���㼼���о���</a> ��Ȩ����</p></div>

-->

</body>
</html>
