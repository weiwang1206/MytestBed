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
	<title>���鴲</title>
	<script type="text/javascript">
	
	
	
	</script>
</head>
<body id="body">
<div id="my_container">
<!-- �����Ϸ������� �����Ϸ��˳�ѡ�� -->
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
        <!-- �����󷽵��� -->
        <div class="span3" style="margin-top:100px; font-size:18px;">
          <div class="sidebar-nav">
            <ul class="nav nav-pills nav-stacked">
              <li><a href="PhysicalMachineListAction?pageIndex=0">��������鿴</a></li>
              <li><a href="VirtualRouterListAction?pageIndex=0">����·�����鿴</a></li>
              <li><a href="ApplicationsListAction?pageIndex=0">��Դ�������</a></li>
              <li><a href="RevertListAction?pageIndex=0">��Դ���չ���</a></li>
              <li><a href="UserINfoManageAction?type=all&pageIndex=0">�û�����</a></li>
              <li><a href="ExperimentManageAction?type=all&pageIndex=0">�������</a></li>
              <li><a href="phyMachineTopologyAction">����ͼ</a></li>
            </ul>
          </div><!--/.well -->
        </div><!--/span-->
        
        <!-- �����ҷ���Ϣ���� -->     
        <div class="span9">
          <div class="page-header">
			<h2>·����Ϣ
		  </div><!--"page-header"-->
		  
		    <div class="row">	
		    <div class="tabbable"> <!-- Only required for left/right tabs -->
 				<ul class="nav nav-tabs">
    				<li ><a href="#tab1" data-toggle="tab">������Ϣ</a></li>
  				</ul>
  				<div class="tab-content"> 				
    				<div class="tab-pane active" id="tab1">
    					<p>��������<s:property value="expName"/></p>
						<p>�����ţ�<s:property value="expID"/></p>
						<select size="12" name="vrs" style="width:600px;">
							<option>�к�           ·�������          ������������</option>
								<s:iterator value="vrs">
								<option><s:property value="#status.index"/>          
								<s:property value="vrCode"/>          
								<s:property value="getPM().getCode()"/></option>
								</s:iterator>
						</select>
    				</div>
    			</div>
    		</div>
    		</div><!-- row -->
    	</div><!-- span9 -->
    </div><!-- row-fluid -->
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
		{
		<div id="nav">
			<p style=" margin-left: 20px; margin-right: 20px;">����ǰ��λ�ã�  </p>
			<p id="zero">�����</p>
			
			<p id="return" style=" margin-right:20px; float:right;text-decoration:underline;color:#0099ff;"><a onclick=	
				"window.history.go(-1);" style="cursor:pointer">����</a></p>
		</div>
		}
		<p>��������<s:property value="expName"/></p>
		<p>�����ţ�<s:property value="expID"/></p>
			<select size="12" name="vrs" style="width:600px;">
				<option>�к�           ·�������          ������������</option>
				<s:iterator value="vrs">
				<option><s:property value="#status.index"/>          
				<s:property value="vrCode"/>          
				<s:property value="getPM().getCode()"/></option>
				</s:iterator>
			</select>
			{
			<table  class="my_table" border="0">
				<thead>
				<tr>
				<th>�к�</th>
				<th>·�������</th>
				<th>������������</th>
				</tr>
				</thead>
				<tbody>
				<s:iterator value="vrs" status="status">
				<tr>
				<td><s:property value="#status.index"/></td>
				<td><s:property value="vrCode"/></td>
				<td></td>
				</tr>
				</s:iterator>
				</tbody>
			</table>
			<div class="cleaner"></div>
		</div>
		<div id="page">
			<ul>
				<li><button onclick=""  id="add_button">���</button></li>
				<li><button onclick=""  id="pre_button"/>��һҳ</li></li>
				<li class="current"><a href="<s:url action='phyMachineList'/>">1</a></li>
				<li><a href="<s:url action='routerList'/>">2</a></li>
				<li><a href="<s:url action='routerList'/>">3</a></li>
				<li><button onclick="" id="pre_button"/>��һҳ</li></li>
			</ul>}
			<div class="cleaner"></div>
	</div>
</div>	
<div id="footer"><div class="cleaner"></div><p><a href="http://www.ict.ac.cn/">�й���ѧԺ���㼼���о���</a> ��Ȩ����</p></div>
 -->
 
 
 
</body>
</html>
