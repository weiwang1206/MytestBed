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
	<link href="css/nav.css" rel="stylesheet" type="text/css" />
	<link href="css/page.css" rel="stylesheet" type="text/css" />
	<link href="css/table.css" rel="stylesheet" type="text/css" />
	<link href="css/contents.css" rel="stylesheet" type="text/css" />
	<link href="css/physical_machine_list.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="scripts/my_js/num_format.js"></script>
	<title>���鴲</title>
</head>
<body id="body">
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
		<form action="ChangePsAction" method="get">
  			<p>�����˺ţ�<input type="text" name="name" /></p>
			<p>�������룺<input type="text" name="password" /></p>
			<p>�����룺<input type="text" name="password2" /></p>
			<p>��һ�����������룺<input type="text" name="password3" /></p>
			
			<input type="submit" value="ȷ��" />
			<input type="reset"" id="cancle" value="����" />
		</form>
		
		
		<div id="content_bottom">
			<div class="cleaner"></div>
		</div>
	</div>
</div>	
<div id="footer"><div class="cleaner"></div><p><a href="http://www.ict.ac.cn/">�й���ѧԺ���㼼���о���</a> ��Ȩ����</p></div>

</body>
</html>
