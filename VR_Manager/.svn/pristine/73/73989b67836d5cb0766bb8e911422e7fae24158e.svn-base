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
	<link href="css/contents.css" rel="stylesheet" type="text/css" />
	<link href="css/page.css" rel="stylesheet" type="text/css" />
	<link href="css/table.css" rel="stylesheet" type="text/css" />
	<link href="css/calender.css" rel="stylesheet" type="text/css" />
	<link href="css/physical_machine_list.css" rel="stylesheet" type="text/css" />
	<script type="text/javascript" src="scripts/my_js/num_format.js"></script>
	
	<title>试验床</title>
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
		createXmlHttp();
		//xmlhttp.open("post","JSONPhyMachineInfo.action?query=phyMacine_list",true);
		xmlhttp.onreadystatechange = callback;
		xmlhttp.send(null);
		/*this.display = function() {
			var update = new ajax();
			window.setTimeout(function() {update.display();}, 3000);
		};*/
	}

	//回调函数
	function callback(){
		var rs = xmlhttp.responseText;
		//使用eval方法将服务器上的json字符传转换成json对象
		var obj = eval('('+rs+')');
		
		
		var cpuUsages = document.getElementsByName("cpuUsage");
		var memUsages = document.getElementsByName("memUsage");
		var flows = document.getElementsByName("flow");
		
		var i;
		var parname, parname2;
		
		for (i = 0; i < cpuUsages.length; i++)
		{
			parname = "CPUUseage"+ i;
			cpuUsages[i].innerHTML = obj[parname] + "%";
		}
		for (i = 0; i < memUsages.length; i++)
		{
			parname = "MemUseage"+ i;
			memUsages[i].innerHTML = obj[parname] + "%";
		}
		for (i = 0; i < flows.length; i++)
		{
			parname = "Send"+ i;
			parname2 = "Recv" + i;
			var tmp = (obj[parname] + obj[parname2]) * 8 ;
			var unit = "bps";
			if (tmp > 1024)
			{
				if (tmp < 1024 * 1024)
				{
					tmp = adv_format(tmp / 1024, 1);
					unit = "K" + unit;
				}
				else if (tmp < 1024 * 1024 * 1024)
				{	
					tmp = adv_format(tmp / (1024 * 1024), 1);
					unit = "M" + unit;
				}
				else
				{
					tmp = adv_format(tmp / (1024 * 1024 * 1024), 1);
					unit = "G" + unit; 
				}
				
			}
			
			flows[i].innerHTML = tmp + unit;
		}
	}
	
	var update = new ajax();
	update.display();
	
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
				<li><a href=""><b>试验床管理系统</b></a></li>
				<!-- <li class="current" style=" font-size:10px"><a href="<s:url action='phyMachineList'/>"><b>登陆</b></a></li>
				<li style=" font-size:10px"><a href="<s:url action='routerList'/>"><b>注册</b></a></li> -->
				<li style=" font-size:10px"><a href="experimenterInfo.jsp"><b>设置</b></a></li>
			</ul>
		</div>
		<div class="cleaner"></div>
	</div>
	
	<div id="left">
		<div class="leftset">
	
	<div class="left-content">
		<ul>
			<li class="item"><b class="item1"></b><a style="text-decoration:none;" href="create_experiment.jsp">创建实验</a></li>
			<li class="sepra">
				<ul>
					<li class="sepra-list first current"><a style="text-decoration:none;" href="experiment_system.jsp">申请释放</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="experiment_system.jsp">配置路由</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item2"></b><a style="text-decoration:none;" href="#">实验控制</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="#">启动停止</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item3"></b><a style="text-decoration:none;" href="#">实验数据</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="PortDataForWebAction.action">端口数据</a></li>
					<li class="sepra-list first"><a style="text-decoration:none;" href="VRDataForWebAction.action?vid=101">路由表项</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item4"></b><a style="text-decoration:none;" href="#">实验报表</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="#">数据报表</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="#">评价模型</a></li>
				</ul>
			</li>
		</ul>
		
		
		<ul>
			<li class="item"><b class="item5"></b><a style="text-decoration:none;" href="#">实验工具</a></li>
			<li class="sepra" style="display:block;">
				<ul>
					<li class="sepra-list first"><a style="text-decoration:none;" href="#">背景流量</a></li>
					<li class="sepra-list"><a style="text-decoration:none;" href="#">编程工具</a></li>
				</ul>
			</li>
		</ul>
		
		
		
	</div>
</div>
	</div>
	<div id="right">
		<h2 style=" margin-left:-70%; color:#000099">操作历史</h2>
		<hr style=" width:80%"/>
		<input type="text" name="keys"/>
		<input type="button" onclick="" value="搜索" />
		<input type="button"; onclick="" value="全部" />
		<br />
		使用时间区间
		<input type="checkbox" onclick="" />
		<input name="StartDate"  type="text" value="1982-1-1" size="14" readonly="readonly" onClick="showcalendar(event, this);" 
		onFocus="showcalendar(event, this);if(this.value=='0000-00-00')this.value=''" />
		至
		<input name="EndDate"  type="text" value="1982-1-1" size="14" readonly="readonly" onClick="showcalendar(event, this);" 
		onFocus="showcalendar(event, this);if(this.value=='0000-00-00')this.value=''" />
		<input type="button"; onclick="" value="确定" />
		<div class="cleaner"></div>
		
		<!-- 
		<select size="25" name="operations" style="width:600px;">
			<option value="1"> test1 已结束 资源已回收</option>
			<option value="1"> test2 正在进行中</option>
			<option value="1"> test3 申请中</option>
		</select> -->
		<select size="25" name="operations" style="width:600px;">
			<s:iterator  value="opers">
				<option><s:property value="opeRecord"/></option>
			</s:iterator>
		</select>
	</div>
</div>	
<div id="footer"><div class="cleaner"></div><p><a href="http://www.ict.ac.cn/">中国科学院计算技术研究所</a>版权所有</p></div>
<script>
var ie =navigator.appName=="Microsoft Internet Explorer"?true:false;

function $(objID){
 return document.getElementById(objID);
}

var controlid = null;

var currdate = null;

var startdate = null;

var enddate  = null;

var yy = null;

var mm = null;

var hh = null;

var ii = null;

var currday = null;

var addtime = false;

var today = new Date();

var lastcheckedyear = false;

var lastcheckedmonth = false;

function _cancelBubble(event) {

 e = event ? event : window.event ;

 if(ie) {

  e.cancelBubble = true;

 } else {

  e.stopPropagation();

 }

}

function getposition(obj) {

 var r = new Array();

 r['x'] = obj.offsetLeft;

 r['y'] = obj.offsetTop;

 while(obj = obj.offsetParent) {

  r['x'] += obj.offsetLeft;

  r['y'] += obj.offsetTop;

 }

 return r;

}

function loadcalendar() {

 s = '';

 s += '<div id="calendar" style="display:none; position:absolute; z-index:9;" onclick="_cancelBubble(event)">';

 if (ie)

 {

  s += '<iframe width="200" height="160" src="about:blank" style="position: absolute;z-index:-1;"></iframe>';

 }

 s += '<div style="width: 200px;"><table class="tableborder" cellspacing="0" cellpadding="0" width="100%" style="text-align: center">';

 s += '<tr align="center" class="header"><td class="header"><a href="#" onclick="refreshcalendar(yy, mm-1);return false" title="上一月"><<</a></td><td colspan="5" style="text-align: center" class="header"><a href="#" onclick="showdiv(\'year\');_cancelBubble(event);return false" title="点击选择年份" id="year"></a>  -  <a id="month" title="点击选择月份" href="#" onclick="showdiv(\'month\');_cancelBubble(event);return false"></a></td><td class="header"><A href="#" onclick="refreshcalendar(yy, mm+1);return false" title="下一月">>></A></td></tr>';

 s += '<tr class="category"><td>日</td><td>一</td><td>二</td><td>三</td><td>四</td><td>五</td><td>六</td></tr>';

 for(var i = 0; i < 6; i++) {

  s += '<tr class="altbg2">';

  for(var j = 1; j <= 7; j++)

   s += "<td id=d" + (i * 7 + j) + " height=\"19\">0</td>";

  s += "</tr>";

 }

 s += '<tr id="hourminute"><td colspan="7" align="center"><input type="text" size="1" value="" id="hour" onKeyUp=\'this.value=this.value > 23 ? 23 : zerofill(this.value);controlid.value=controlid.value.replace(/\\d+(\:\\d+)/ig, this.value+"$1")\'> 点 <input type="text" size="1" value="" id="minute" onKeyUp=\'this.value=this.value > 59 ? 59 : zerofill(this.value);controlid.value=controlid.value.replace(/(\\d+\:)\\d+/ig, "$1"+this.value)\'> 分</td></tr>';

 s += '</table></div></div>';

 s += '<div id="calendar_year" onclick="_cancelBubble(event)"><div class="col">';

 for(var k = 1930; k <= 2019; k++) {

  s += k != 1930  &&  k % 10 == 0 ? '</div><div class="col">' : '';

  s += '<a href="#" onclick="refreshcalendar(' + k + ', mm);$(\'calendar_year\').style.display=\'none\';return false"><span' + (today.getFullYear() == k ? ' class="today"' : '') + ' id="calendar_year_' + k + '">' + k + '</span></a><br />';

 }

 s += '</div></div>';

 s += '<div id="calendar_month" onclick="_cancelBubble(event)">';

 for(var k = 1; k <= 12; k++) {

  s += '<a href="#" onclick="refreshcalendar(yy, ' + (k - 1) + ');$(\'calendar_month\').style.display=\'none\';return false"><span' + (today.getMonth()+1 == k ? ' class="today"' : '') + ' id="calendar_month_' + k + '">' + k + ( k < 10 ? ' ' : '') + ' 月</span></a><br />';

 }

 s += '</div>';

 var nElement = document.createElement("div");

 nElement.innerHTML=s;

 document.getElementsByTagName("body")[0].appendChild(nElement);

// document.write(s);

 document.onclick = function(event) {

  $('calendar').style.display = 'none';

  $('calendar_year').style.display = 'none';

  $('calendar_month').style.display = 'none';

 }

 $('calendar').onclick = function(event) {

  _cancelBubble(event);

  $('calendar_year').style.display = 'none';

  $('calendar_month').style.display = 'none';

 }

}

function parsedate(s) {

 /(\d+)\-(\d+)\-(\d+)\s*(\d*):?(\d*)/.exec(s);

 var m1 = (RegExp.$1  &&  RegExp.$1 > 1899  &&  RegExp.$1 < 2101) ? parseFloat(RegExp.$1) : today.getFullYear();

 var m2 = (RegExp.$2  &&  (RegExp.$2 > 0  &&  RegExp.$2 < 13)) ? parseFloat(RegExp.$2) : today.getMonth() + 1;

 var m3 = (RegExp.$3  &&  (RegExp.$3 > 0  &&  RegExp.$3 < 32)) ? parseFloat(RegExp.$3) : today.getDate();

 var m4 = (RegExp.$4  &&  (RegExp.$4 > -1  &&  RegExp.$4 < 24)) ? parseFloat(RegExp.$4) : 0;

 var m5 = (RegExp.$5  &&  (RegExp.$5 > -1  &&  RegExp.$5 < 60)) ? parseFloat(RegExp.$5) : 0;

 /(\d+)\-(\d+)\-(\d+)\s*(\d*):?(\d*)/.exec("0000-00-00 00\:00");

 return new Date(m1, m2 - 1, m3, m4, m5);

}

function settime(d) {

 $('calendar').style.display = 'none';

 controlid.value = yy + "-" + zerofill(mm + 1) + "-" + zerofill(d) + (addtime ? ' ' + zerofill($('hour').value) + ':' + zerofill($('minute').value) : '');

}

function showcalendar(event, controlid1, addtime1, startdate1, enddate1) {

 controlid = controlid1;

 addtime = addtime1;

 startdate = startdate1 ? parsedate(startdate1) : false;

 enddate = enddate1 ? parsedate(enddate1) : false;

 currday = controlid.value ? parsedate(controlid.value) : today;

 hh = currday.getHours();

 ii = currday.getMinutes();

 var p = getposition(controlid);

 $('calendar').style.display = 'block';

 $('calendar').style.left = p['x']+'px';

 $('calendar').style.top = (p['y'] + 20)+'px';

 _cancelBubble(event);

 refreshcalendar(currday.getFullYear(), currday.getMonth());

 if(lastcheckedyear != false) {

  $('calendar_year_' + lastcheckedyear).className = 'default';

  $('calendar_year_' + today.getFullYear()).className = 'today';

 }

 if(lastcheckedmonth != false) {

  $('calendar_month_' + lastcheckedmonth).className = 'default';

  $('calendar_month_' + (today.getMonth() + 1)).className = 'today';

 }

 $('calendar_year_' + currday.getFullYear()).className = 'checked';

 $('calendar_month_' + (currday.getMonth() + 1)).className = 'checked';

 $('hourminute').style.display = addtime ? '' : 'none';

 lastcheckedyear = currday.getFullYear();

 lastcheckedmonth = currday.getMonth() + 1;

}

function refreshcalendar(y, m) {

 var x = new Date(y, m, 1);

 var mv = x.getDay();

 var d = x.getDate();

 var dd = null;

 yy = x.getFullYear();

 mm = x.getMonth();

 $("year").innerHTML = yy;

 $("month").innerHTML = mm + 1 > 9  ? (mm + 1) : '0' + (mm + 1);

 for(var i = 1; i <= mv; i++) {

  dd = $("d" + i);

  dd.innerHTML = " ";

  dd.className = "";

 }

 while(x.getMonth() == mm) {

  dd = $("d" + (d + mv));

  dd.innerHTML = '<a href="###" onclick="settime(' + d + ');return false">' + d + '</a>';

  if(x.getTime() < today.getTime() || (enddate  &&  x.getTime() > enddate.getTime()) || (startdate  &&  x.getTime() < startdate.getTime())) {

   dd.className = 'expire';

  } else {

   dd.className = 'default';

  }

  if(x.getFullYear() == today.getFullYear()  &&  x.getMonth() == today.getMonth()  &&  x.getDate() == today.getDate()) {

   dd.className = 'today';

   dd.firstChild.title = '今天';

  }

  if(x.getFullYear() == currday.getFullYear()  &&  x.getMonth() == currday.getMonth()  &&  x.getDate() == currday.getDate()) {

   dd.className = 'checked';

  }

  x.setDate(++d);

 }

 while(d + mv <= 42) {

  dd = $("d" + (d + mv));

  dd.innerHTML = " ";

  d++;

 }

 if(addtime) {

  $('hour').value = zerofill(hh);

  $('minute').value = zerofill(ii);

 }

}

function showdiv(id) {

 var p = getposition($(id));

 $('calendar_' + id).style.left = p['x']+'px';

 $('calendar_' + id).style.top = (p['y'] + 16)+'px';

 $('calendar_' + id).style.display = 'block';

}

function zerofill(s) {

 var s = parseFloat(s.toString().replace(/(^[\s0]+)|(\s+$)/g, ''));

 s = isNaN(s) ? 0 : s;

 return (s < 10 ? '0' : '') + s.toString();

}

loadcalendar();

</script>
</body>
</html>
