<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@ taglib uri="/htm" prefix="htm" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<title>登录</title>
<link href="css/mobile.css" type="text/css" rel="stylesheet" />
</head>

<script>


function login() {
	var obj = document.getElementById("usercode");
	if (obj.value==obj.title) {
		alert("请输入登陆用户名称！");
		return;
	}
	obj = document.getElementById("pwd");
	if (obj.value==obj.title) {
		alert("请输入登陆密码！");
		return;
	}

	document.forms[0].submit();
}
</script>
<body >
<div class="top">开发平台</div>
<div style="height:37px;">
</div>
 <p class="logintitle"><img src="images/mobile/loginicon.jpg"/>系统登录 <br/></p>
<form action="<%=request.getContextPath()%>/login.cmd" method="POST" style="width:285px; margin:0 auto;">
  <p align="left" style="padding-left:12px;"><br/>用户名</p>
  <p><input id="usercode" name="usercode" type="text" class="text" placeholder="请输入用户名"/></p>

  <p align="left" style="padding-left:12px;">密　码</p>
  <p><input id="pwd" name="pwd" type="password" class="text" placeholder="请输入登陆密码"/>
	<br/><span><input name="" type="checkbox" value="" />记住登录密码</span></p>
</form>
  <p align="center"><br/><input name="" type="button" class="login" onclick="login();"/></p>
</body>
</html>
