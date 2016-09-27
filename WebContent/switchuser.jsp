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

body {
	font-size:14px;
}

</style>
</head>

<script src="js/ajax.js"></script>

<script>

function switchUser(userCode) {
	var url = "login.cmd?cmdtype=switch&account=" + userCode;
	DHTMLSuite.ajax.sendRequest(url,null,'switchResult');
}

function switchResult() {
	alert("账号切换成功！");
	top.window.document.location.href = "index.jsp";
}
</script>
<body>

<%
	ArrayList<HashMap<String,String>> rs = com.siqiansoft.framework.util.LoginUtil.getRelatedAccount(request);
%>

<form action="<%=request.getContextPath()%>/login.cmd" method="POST">
<div class="formarea" style="width:450px;">
  <div>
	<div class="formhead" style="height:22px;font-weight:bold; line-height:22px">请选择需要切换的账号
	<span id="$MESSAGE" style="color:red;float:right;"></span>
	</div>
	<div class="formbody">

	<table width="100%" border="1" cellspacing="2" cellpadding="1" align="center" class="datatable" style="text-align:center">
	  <tr>
		<td class="caption" style="text-align:center" width="50%">所属部门</td>
		<td class="caption" style="text-align:center" width="35%">用户名</td>
		<td class="caption" style="text-align:center" width="15%">操作</td>
	  </tr>
<%
	for (int i=0;i<rs.size();i++) {
		HashMap<String,String> map = rs.get(i);
%>
	  <tr>
		<td><%=map.get("DEPTNAME")%></td>
		<td><%=map.get("NAME")%></td>
		<td><a href="#" onclick="switchUser('<%=map.get("CODE")%>');"><font color=red>切换到</font></a></td>
	  </tr>
<%	}%>
	  <tr>
		<td colspan="3"><div align="center">
			<input type="button" value="返回" onclick="top.window.getDialog(window).close();">
		</div></td>
	  </tr>
	</table>

	</div>
  </div>
</div>
</form>
</body>
</html>
