<%@ page language="java" import="java.util.*" contentType="text/html; charset=gb2312"  %>
<%@ taglib prefix="s" uri="/struts-tags" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312" />
<style type="text/css">

#inf{position: absolute; left: 300px; width:691px; height:38px; background:url(images/login_18.gif) no-repeat; margin-top: 10px;}
.inf_text{display:block; width:100px; height:20px; font-size:24px; font-weight:bolder; color:#fff; margin-left:6px; margin-top:6px; float:left;}
.copyright{display:block; float:left; margin-left:200px; margin-top:6px; font-size:24px;}

form{
	position: absolute;
  	left: 420px;
  	top: 100px;
}

input{
	margin-top: -15px;
}
dfn {
color: red;
padding-right: 5px;
font-style: normal;
}

.note {
	font-size:12px; 
	color:#666666;
	margin-top: 1px;
}

</style>
</head>
<body>
<div id="inf">
   <span class="inf_text">TESTBED</span>
   <span class="copyright">用户注册</span>
</div>
<form action="RegisterAction">
	<p><dfn>*</dfn>用户名：</p>
	<input type="text" name="userName" />
	<p class="note">不超过7个汉字，或14个字节(数字，字母和下划线)。</p>
	<p><dfn>*</dfn>密码:</p>
	<input type="password" name="password" />
	<p class="note">密码长度6～14位，字母区分大小写。</p>
	<p><dfn>*</dfn>再次输入密码：</p>
	<input type="password" name="password2" />
	<p class="note">确保密码输入正确。</p>
	<p><dfn>*</dfn>邮箱：</p>
	<input type="text" name="email" />
	<p class="note">激活码将会发到您的邮箱中，只有激活帐户才可以使用！</p>
	<p>手机号码：</p>
	<input type="text" name="phoneNumber" />
	<p>省份/州：</p>
	<input type="text" name="province" />
	<p>城市：</p>
	<input type="text" name="city" />
	
	
	
	<p><input style="margin-top: 20px;" id="submit" type="submit" value="注册" /></p>
</form>

</body>
</html>