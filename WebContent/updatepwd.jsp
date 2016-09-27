<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@ taglib uri="/htm" prefix="htm" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>修改密码</title>
<LINK href="css/main.css" type="text/css" rel="stylesheet">
<style>
.datatable {
	border-collapse: collapse;
	table-layout: fixed;
	width:38%;
	border:solid 1px #D6D6D6;
}

.datatable TD {
	font-size:12px;
	border:1px solid #D6D6D6;
}

.datatable .caption {
    background:#FAFAFA;
	text-align:right;
}

</style>
</head>
<script>

function updatePwd() {
	if (!document.forms[0].oldpwd.value) {
		alert("原始密码不能为空!");
		return;
	}
	if (!document.forms[0].pwd.value) {
		alert("新密码不能为空!");
		return;
	}
	if (document.forms[0].pwd.value!=document.forms[0].confirmpwd.value) {
		alert("密码和确认密码不一致!");
		return;
	}
	document.forms[0].submit();
}

</script>
<body>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<form action="<%=request.getContextPath()%>/login.cmd" method="POST">
<div class="formarea" style="width:500px;">
  <div>
	<div class="formhead" style=" text-align:center; height:22px; font-size:18px; font-weight:bold; line-height:22px">修改密码
	<span id="$MESSAGE" style="color:red;float:right;"></span>
	</div>
	<div class="formbody">


<input type="hidden" name="cmdtype" value="updatepwd"/>
<table width="40%" border="1" cellspacing="2" cellpadding="1" align="center" class="datatable">
  <tr>
    <td class="caption" style="width:150px"><div align="right">原始密码：</div></td>
    <td ><input type="password" name="oldpwd" style="width:200px;height:20px;"></td>
  </tr>
  <tr>
    <td class="caption" style="width:150px"><div align="right">新密码：</div></td>
    <td ><input type="password" name="pwd" style="width:200px;height:20px;"></td>
  </tr>
  <tr>
    <td class="caption" ><div align="right">重复密码：</div></td>
    <td><input type="password" name="confirmpwd" style="width:200px;height:20px;"></td>
  </tr>
  <tr>
    <td colspan="2"><div align="center">
		<input type="button" value="确定" onclick="updatePwd();">
		<input type="button" value="返回" onclick="javascript:history.go(-1);">
	</div></td>
  </tr>
</table>

</div>
</div>
</div>
</form>
</body>
</html>
