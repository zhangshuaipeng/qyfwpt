<%
	com.siqiansoft.framework.model.LoginModel login = (com.siqiansoft.framework.model.LoginModel)request.getSession(false).getAttribute("LOGINMODEL");
	if (login==null) {
		request.getRequestDispatcher("mobilelogin.jsp").forward(request,response);
		return;
	}
%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@ taglib uri="/htm" prefix="htm" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta HTTP-EQUIV="Pragma" content="no-cache" /> 
<meta HTTP-EQUIV="Cache-Control" content="no-cache" /> 
<meta HTTP-EQUIV="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<title>首页</title>
<link href="css/mobile.css" type="text/css" rel="stylesheet" />
</head>
<script src="js/common.js"></script>
<script src="js/ajax.js"></script>
<script type="text/javascript"> 


function loadMenu() {

	// 设置高度
	var obj = document.getElementById("menu");
	var height = 0;
	if (document.body.clientHeight && document.documentElement.clientHeight) {
		height = (document.body.clientHeight < document.documentElement.clientHeight) ? document.documentElement.clientHeight : document.body.clientHeight;
	} else {
		height = (document.body.clientHeight > document.documentElement.clientHeight) ? document.body.clientHeight : document.documentElement.clientHeight;
	}

	height = height - 32 - 60;
	obj.style.height = height + "px";
	obj = obj.getElementsByTagName("div");
	for (var i=0;i<obj.length;i++) {
		obj[i].style.height = height + "px";
	}
	var sub = document.getElementById("sub");
	sub.parentNode.style.width = (document.body.clientWidth - 140) + "px";
	var url = 'TreeAction.cmd?$ACTION=system'; // 'platform/TreeAction.cmd?$MODULE=bizmodel&$ACTION=load&$TREEID=tree&$SYSTEM=platform'
	DHTMLSuite.ajax.sendRequest(url,'','showMenu');
}

function showMenu(ajaxObj) {
	var root = ajaxObj.responseXML.documentElement; 
	var nodes = root.childNodes;

	var isFirstSub = true;
	var item;
	var main = document.getElementById("main");
	var sub = document.getElementById("sub");
	// 填充第一级
	for (var i=0;i<nodes.length;i++) {
		item = nodes[i];
		if (item.nodeType!=1) continue;   // 表示真实的子节点

		var li = document.createElement("li");
		main.appendChild(li);
		li.innerHTML = item.getAttribute("text");
		li.nodes = item.childNodes;
		li.onclick = menuSelected;
		
		if (isFirstSub) {
			li.className = "selected";
			isFirstSub = false;
			// 填充第一级子菜单
			for (var n=0;n<item.childNodes.length;n++) {
				var itemSub = item.childNodes[n];
				if (itemSub.nodeType!=1) continue;
				li = document.createElement("li");
				var a = document.createElement("a");
				li.appendChild(a);
				a.innerHTML = itemSub.getAttribute("text");
				a.href = itemSub.getAttribute("action");
				sub.appendChild(li);
			}
		}
	}

	window.scrollTo(0, 0);
}

function menuSelected() {
	// 先清除选定标志
	var menu = document.getElementById("main").getElementsByTagName("li");
	for (var i=0;i<menu.length;i++) {
		var item = menu[i];
		item.className = "";
	}
	this.className = "selected";

	var nodes = this.nodes;
	var sub = document.getElementById("sub");
	sub.innerHTML = "";
	sub.scrollTop = 0;
	for (var n=0;n<nodes.length;n++) {
		var itemSub = nodes[n];
		if (itemSub.nodeType!=1) continue;
		var li = document.createElement("li");
		var a = document.createElement("a");
		li.appendChild(a);
		a.innerHTML = itemSub.getAttribute("text");
		a.href = itemSub.getAttribute("action");
		sub.appendChild(li);
	}
}

</script> 

<body onload="loadMenu();">
<div class="navbar" style="height:32px;text-align:center;"><a href="mobileindex.jsp" class="back">返回</a><span style="font-size:20px;line-height:30px;">协同办公系统</span></div>
<div class="center" id="menu">
  <div class="menu">
   <div class="menu1" style="overflow:auto;">
     <ul id="main">
     </ul>
   </div>
    <div class="menu2" style="overflow:auto;">
    <ul id="sub">
     </ul>
   </div>       
  </div>
</div>
<div style="height:39px;">
</div>
<div class="bottom">
		<a href="mobileindex.jsp"><img src="images/mobile/system.png" style="vertical-align:middle;"/>首页</a>
		<a href="#"><img src="images/mobile/todo.png" style="vertical-align:middle;"/>待办工作</a>
		<a href="#"><img src="images/mobile/notify.png" style="vertical-align:middle;"/>通知通告</a>
		<a href="#"><img src="images/mobile/schedule.png" style="vertical-align:middle;"/>日程安排</a>
</div>
</body>
</html>
