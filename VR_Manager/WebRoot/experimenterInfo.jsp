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
	<script type="text/javascript">
	</script>
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
				<!-- 
				<li class="current" style=" font-size:10px; "><a href=""><b>��½</b></a></li>
				<li style=" font-size:10px; "><a href=""><b>ע��</b></a></li>
				 -->
				<li style=" font-size:10px; "><a href="experimenterInfo.jsp"><b>����</b></a></li>
			</ul>
		</div>
		<div class="cleaner"></div>
	</div>
	
	<div id="left">
		<div class="leftset">
	
	<div class="left-content">
		<ul>
			<li class="item"><b class="item1"></b><a style="text-decoration:none;" href="create_experiment.jsp">����ʵ��</a></li>
			<li class="sepra">
				<ul>
					<li class="sepra-list first current"><a style="text-decoration:none;" href="experiment_system.jsp">�����ͷ�</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="experiment_system.jsp">����·��</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item2"></b><a style="text-decoration:none;" href="#">ʵ�����</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="#">����ֹͣ</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item3"></b><a style="text-decoration:none;" href="#">ʵ������</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="PortDataForWebAction.action">�˿�����</a></li>
					<li class="sepra-list first"><a style="text-decoration:none;" href="VRDataForWebAction.action?vid=101">·�ɱ���</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item4"></b><a style="text-decoration:none;" href="#">ʵ�鱨��</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="#">���ݱ���</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="#">����ģ��</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item5"></b><a style="text-decoration:none;" href="#">ʵ�鹤��</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="#">��������</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="#">��̹���</a></li>
				</ul>
			</li>
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
        		<td style="color:#000099"><a href="BasicInfoAction">��������</td>
        		<td>���Ե���������Ӳ鿴���޸����ĸ�����Ϣ</td>
      		</tr>
			<tr>
        		<td style="color:#000099"><a href="experimenterchangePs.jsp">����</td>
        		<td>Ҫ���������룬������ṩ��Ŀǰ������</td>
      		</tr>
		</table>
		<hr style=" width:80%"/>
		<h3 style=" margin-left:-70%; ">������¼</h3>
		<table class="userInfo">
    		<tr>
        		<td style="color:#000099"><a href="OperationHistoryAction">������¼</td>
        		<td>���Ե���������Ӳ鿴��������ʷ��¼</td>
      		</tr>
		</table>
		<hr style=" width:80%"/>
		<h3 style=" margin-left:-70%; ">ʵ���б�</h3>
		<table class="userInfo">
    		<tr>
        		<td style="color:#000099"><a href="ExperimentorExpsAction">ʵ���б�</td>
        		<td>���Ե���������Ӳ鿴ʵ���б�</td>
      		</tr>
		</table>
	</div>
</div>	
<div id="footer"><div class="cleaner"></div><p><a href="http://www.ict.ac.cn/">�й���ѧԺ���㼼���о���</a> ��Ȩ����</p></div>

</body>
</html>