<%
	if (com.siqiansoft.framework.util.Utilities.isMobile(request))
		request.getRequestDispatcher("mobileindex.jsp").forward(request,response);

%>
<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="/htm" prefix="htm" %>

<%
	com.siqiansoft.framework.model.LoginModel login = (com.siqiansoft.framework.model.LoginModel)request.getSession(false).getAttribute("LOGINMODEL");
	if (login==null) {
		request.getRequestDispatcher("login.jsp").forward(request,response);
		return;
	}
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"> 
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<head>
	<title>首页</title>
	<link rel="stylesheet" type="text/css" href="css/dhtmlxlayout.css">
	<link rel="stylesheet" type="text/css" href="css/skins/dhtmlxlayout_dhx_skyblue.css">
	<link rel="stylesheet" type="text/css" href="css/skins/dhtmlxaccordion_dhx_skyblue.css">
	<link rel="stylesheet" type="text/css" href="css/main.css">

<style>
		html, body {
			width: 100%;
			height: 100%;
			margin: 0px;
			padding: 0px;
			overflow: hidden;
			font-size:12px;
		}



.menus {
	margin-top:5px;
	-moz-user-select:none;
}

.menu {
	font-size:12px;
	height:26px;
	line-height:26px;
	margin-left:4px;
	padding-top:6px;
	-moz-user-select:none;
}

.menu .text {
	line-height:20px;
	margin-left:4px;
}

.menu a img,span {
	border:0px;
}

.menu a,a:link,a.visited,a:hover,a:active {
	text-decoration: none;
	color:black;
}

.menu img {
	vertical-align:middle;
}

.menus .selected {
	background-color:#D9E8FB;
}

.menus .over {
	background-color:#eeeeee;
}



.tabheader {
	height:25px;
	border-bottom:1px solid #cccccc;
}
.tabcontainer {
	overflow:hidden;
	float:left;
	position: relative;
	height:25px;
}
.tabcontainer ul {
    list-style: none outside none;
    margin: 0;
    padding: 0;
}

.tabcontainer li span {
	margin-left:2px;
	margin-right:6px;
}

.tabcontainer li.selected {
    background: url("images/tab_selected_left.gif") no-repeat scroll 0 0 transparent;
    float: left;
    height: 26px;
    line-height: 26px;
    list-style-type: none;
    margin-right: 3px;
	padding: 0px;
	position:relative;
  }

.tabcontainer li.selected a {
    background: url("images/tab_selected_right.gif") no-repeat scroll right 0 transparent;
    display: block;
    font-size: 12px;
    line-height: 26px;
    padding: 0 4px;
}

.tabcontainer li {
    background: url("images/tab_left.gif") no-repeat scroll 0 0 transparent;
    float: left;
    height: 26px;
    line-height: 26px;
    list-style-type: none;
    margin-right: 3px;
	margin-top:1px;
	padding: 0px;
	position:relative;
  }

.tabcontainer li a {
    background: url("images/tab_right.gif") no-repeat scroll right 0 transparent;
    display: block;
    font-family: arial;
    font-size: 12px;
    line-height: 26px;
    padding: 0 4px;
}

.tabcontainer .close {
    background: url("images/tab-close.gif") no-repeat scroll 0 0 transparent;
    font-size: 0;
    height: 11px;
    line-height: 0;
    opacity: 0.6;
    position: absolute;
    right: -6px;
    text-indent: -999px;
    top: 3px;
    width: 11px;
}

.tab-toleft {
    background: url("images/tab_leftarrow.png") no-repeat scroll 1px 2px transparent;
    border: 1px solid #8DB2E3;
    cursor: pointer;
    display: block;
    font-size: 1px;
    height: 20px !important;
    left: 0;
    position: absolute;
    top: 2px;
    width: 18px;
}

.tab-toright {
    background: url("images/tab_rightarrow.png") no-repeat scroll 2px 2px transparent;
    border: 1px solid #8DB2E3;
    cursor: pointer;
    display: block;
    font-size: 1px;
    height: 20px !important;
    position: absolute;
    right: 0;
    top: 2px;
    width: 18px;
}

.top{ height:72px; background:url(image/top.gif) repeat-x; margin-bottom:1px;} 
.top-left{ font-size:32px; font-family:"微软雅黑"; height:72px; line-height:72px; float:left; padding-left:20px; color:#f3740a;}
.top-right{ height:52px; float:right; padding-top:20px; padding-right:10px;}
.top-right1{ width:7px; height:30px; float:left;}
.top-right2{ height:30px;line-height:20px; float:left;background:url(image/zz.jpg) repeat-x;}
.top-right2 a{ height:30px; display:block; float:left; padding:5px 3px 0 3px;}
.top-right2 a img{ vertical-align:middle; margin-right:5px;}
.top-right3{ width:7px; height:30px; float:left;}

	</style>
</head>

<script src="js/common.js"></script>
<script src="js/dialog.js"></script>
<script src="js/tabber.js"></script>
<script src="js/ajax.js"></script>
<script src="js/dhtmlxcommon.js"></script>
<script src="js/dhtmlxlayout.js"></script>
<script src="js/dhtmlxaccordion.js"></script>
<script src="js/dhtmlxcontainer.js"></script>
<script>
var dhxLayout;
var statusBar;
var selected;
var tab = new Tabber();
var timer;
function popTips(ajaxObj){
	var msg = ajaxObj.response; 
	if (!msg) {
		setTimeout(loadPollTips,60000);
		return;
	}
	document.getElementById("tipscontent").innerHTML = msg;

	var MsgPop=document.getElementById("tipswindow");
	MsgPop.style.height='0px';
	MsgPop.style.display="block";//显示隐藏的窗口
	timer=setInterval("popTipsWindow()",50);
}

function popTipsWindow() {
	var MsgPop = document.getElementById("tipswindow");
	var popH=parseInt(MsgPop.style.height);
	if (popH<=240){
		MsgPop.style.height=(popH+4).toString()+"px";
	} else{  
		MsgPop.style.height= "240px";
		clearInterval(timer);
		setTimeout(hideTips,10000);
		setTimeout(loadPollTips,57000);
	}
}

function hideTips() {
	var MsgPop = document.getElementById("tipswindow");
	MsgPop.style.height='0px';
	MsgPop.style.display = "none";
}

function loadPollTips() {
	clearInterval(timer);
	document.getElementById("tipswindow").style.display='none';
	document.getElementById("tipswindow").style.height='0px';
	DHTMLSuite.ajax.sendRequest("message.cmd?$ACTION=poll",'','popTips');
}


function getTipsMessage() {
	var url = "message.cmd?$ACTION=welcome";
	DHTMLSuite.ajax.sendRequest(url,'','popTips');
}

function doOnLoad() {
	dhxLayout = new dhtmlXLayoutObject(document.body, "2U");
	dhxLayout.attachHeader("my_logo");
	dhxLayout.attachFooter("my_copy");
	dhxLayout.cells("a").setWidth("200");
	dhxLayout.cells("a").setText("<img src='css/imgs/dhxlayout_dhx_skyblue/dhxlayout_cpanel_btn_dock.gif'>系统导航树");
	//dhxLayout.cells("b").setWidth("200");
	dhxLayout.cells("a").attachObject("outlook");
	dhxLayout.cells("a").attachURL("tree.jsp");

	dhxLayout.cells("b").attachObject("EAP_CONTENT");
	//dhxLayout.cells("a").hideHeader();
	dhxLayout.cells("b").hideHeader();
	//statusBar = dhxLayout.attachStatusBar();
	//statusBar.setText("Simple Status Bar");

	tab.Init("EAP_TABBER");
	
	// 如果是在框架内运行外部URL时,带参数system和action,则直接在内容区运行URL,否则,运行默认url
	var action = <%=com.siqiansoft.framework.util.NavigatorUtil.getAction(request)%>;

	if (action) {
		tab.addTab(action.id,action.title,action.url,action.icon,true);
	} else 
		tab.addTab("MAIN","应用桌面","main.jsp","images/icon/system.png");
	

	getTipsMessage();
}


</script>


<body onload="doOnLoad();">
<div style="border: 1px solid #aaaaaa;z-index: 99999; width: 300px; position: absolute;height:0px; position:absolute; right:2px; bottom:2px; overflow:hidden; display:none;background:white;"  id="tipswindow">
<table width="100%" height="240px" cellspacing="0" cellpadding="0" border="0">
	<tr style="BACKGROUND-IMAGE:url(images/tipstopbg.gif);">
		<td width="100%" valign="middle" style="border-bottom:solid 1px #aaaaaa;height:27px;font-size:12px;padding-left:5px;"><img src="images/message.gif" align="absmiddle">&nbsp;信息提示</td>
		<td width="19px" valign="middle" align="right" style="PADDING-TOP:2px;border-bottom:solid 1px #aaaaaa;"><img hspace="3" title="关闭" onclick="hideTips()" style="CURSOR:pointer" src="images/tipsclose.gif"></td>
	</tr>
	<tr>
		<td style="height:210px;" colspan="2">
		<div style="height:210px;overflow:auto;line-height:210px;padding:5px;" id="tipscontent">
		</div>
		</td>
	</tr>
</table>
</div>

<div id="my_logo" class="top">
	<div class="top-left">
	 <htm:configitem catalog="license" property="system-name"/>
	</div>

	<div class="top-right">
	 <div class="top-right1">
	 <img src="image/ll.jpg"/>
	 </div>
	 <div class="top-right2">
	 <a href="#"><img src="image/gr.gif" border="0"/>您好！<font color=red><%=login.getUserName()%></font>&nbsp;</a> 
<%
	if (com.siqiansoft.framework.util.LoginUtil.existRelatedAccount(request)) {
%>
	 <a href="#" onclick="showDialog(window,'账号切换','switchuser.jsp','480','360','');"><img src="image/mm.gif" border="0"/>账号切换</a>
<%	}%>
	 <a href="updatepwd.jsp"><img src="image/mm.gif" border="0"/>修改密码</a>
	 <a href="login.cmd?cmdtype=logout"><img src="image/zx.gif" border="0"/>注销</a>
	 </div>
	 <div class="top-right3">
	 <img src="image/rr.jpg"/>
	 </div>
	</div>
</div>

<div id="outlook" style="width:100%;height:100%;overflow:hidden;margin-top:3px;" >

</div>

<div style="width:100%;height:100%;" id="EAP_CONTENT">
	<div id="EAP_TABBER">
	</div>
</div>

<div id="my_copy" style="height: 20px;line-height:16px;position:absolute;top:6px;">All copyright &copy; reserved!</div>
</body>
</html>