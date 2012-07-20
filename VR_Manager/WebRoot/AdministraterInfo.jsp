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
	<title>���鴲</title>
</head>
<body id="body" onload="setButtonVisible();">

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
			<h2>����Ա����</h2>
		  </div><!--"page-header"-->
		  
		    <div class="row">	
		    <div class="tabbable"> <!-- Only required for left/right tabs -->
 				<ul class="nav nav-tabs">
    				<li class="active"><a href="#tab1" data-toggle="tab">��������</a></li>
    				<li><a href="#tab2" data-toggle="tab">�������</a></li>
    				<li><a href="#tab3" data-toggle="tab">������¼</a></li>
  				</ul>
  				<div class="tab-content">
  				
    				<div class="tab-pane active" id="tab1">
						<form action="saveUserInfoActoin" method="get">
  							<p>�� ����<input type="text" name="name" value="<s:property value='user.name'/>"/></p>
							<p>�� �䣺<input type="text" name="email" value="<s:property value='user.email'/>"/></p>
							<p>�� ����<input type="text" name="telephone" value="<s:property value='user.telephone'/>"/></p>
							<p>ʡ �ݣ�<input type="text" name="province" value="<s:property value='user.province'/>"/></p>
							<p>�� �У�<input type="text" name="city" value="<s:property value='user.city'/>"/></p>
			
							<input class="btn btn-primary" type="submit" value="�޸�" />
							<input class="btn" type="button" id="cancle" value="ȡ��" />
						</form>
			
						<div id="content_bottom">
							<div class="cleaner"></div>
						</div>      					
   			 		</div>
   			 		
    				<div class="tab-pane" id="tab2">
						<form action="ChangePsAction" method="get">
  							<p>�����˺ţ�<input type="text" name="name" placeholder="�������������û���"/></p>
							<p>�������룺<input type="text" name="password" placeholder="��������ɵ�����"/></p>
							<p>�µ����룺<input type="text" name="password2" placeholder="���������µ�����"/></p>
							<p>�ٴ�ȷ�ϣ�<input type="text" name="password3" placeholder="�����ٴ������µ�����" /></p>			
							<input  class="btn btn-primary" type="submit" value="ȷ��"/>
							<input class="btn" type="reset"" id="cancle" value="����" />
						</form>	
						<div id="content_bottom">
							<div class="cleaner"></div>
						</div>
    				</div>
    				
    				<div class="tab-pane" id="tab3">
						<!-- <input type="text" name="keys"/> -->
						<input type="button" onclick="" value="����" />
						<input type="button"; onclick="" value="ȫ��" />
						<br />
						ʹ��ʱ������
						<input type="checkbox" onclick="" />
						<input name="StartDate"  type="text" value="1982-1-1" size="14" readonly="readonly" onClick="showcalendar(event, this);" 
						onFocus="showcalendar(event, this);if(this.value=='0000-00-00')this.value=''" />
						��
						<input name="EndDate"  type="text" value="1982-1-1" size="14" readonly="readonly" onClick="showcalendar(event, this);" 
						onFocus="showcalendar(event, this);if(this.value=='0000-00-00')this.value=''" />
						<input type="button"; onclick="" value="ȷ��" />
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
			<h3 ><small>������Ϣ</small></h3>
			<table class="userInfo">
    			<tr>
        			<td ><a href="BasicInfoAction">��������</a></td>
        			<td><h5>���Ե���������Ӳ鿴���޸����ĸ�����Ϣ</h5></td>
      			</tr>
				<tr>
        			<td style="color:#000099"><a href="changePs.jsp">����</a></td>
        			<td><h5>Ҫ���������룬������ṩ��Ŀǰ������</h5></td>
      			</tr>
			</table>
		</div> 
			
		<hr style=" width:80%"/>
		<div class="row">	
			<h3 ><small>������ѯ</small></h3>
			<table class="userInfo">
    			<tr>
        			<td style="color:#000099"><a href="OperationHistoryAction">������¼</a></td>
        			<td><h5>���Ե���������Ӳ鿴��������ʷ��¼</h5></td>
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
		<h2 style=" margin-left:-70%; color:#000099">����Ա����</h2>
		<hr style=" width:80%"/>
		<h3 style=" margin-left:-70%; ">������Ϣ</h3>
		<table class="userInfo">
    		<tr>
        		<td style="color:#000099"><a href="BasicInfoAction">��������</a></td>
        		<td>���Ե���������Ӳ鿴���޸����ĸ�����Ϣ</td>
      		</tr>
			<tr>
        		<td style="color:#000099"><a href="changePs.jsp">����</a></td>
        		<td>Ҫ���������룬������ṩ��Ŀǰ������</td>
      		</tr>
		</table>
		<hr style=" width:80%"/>
		<h3 style=" margin-left:-70%; ">������¼</h3>
		<table class="userInfo">
    		<tr>
        		<td style="color:#000099"><a href="OperationHistoryAction">������¼</a></td>
        		<td>���Ե���������Ӳ鿴��������ʷ��¼</td>
      		</tr>
		</table>
	</div>
</div>	
<div id="footer"><div class="cleaner"></div><p><a href="http://www.ict.ac.cn/">�й���ѧԺ���㼼���о���</a> ��Ȩ����</p></div>
-->
</body>
</html>
