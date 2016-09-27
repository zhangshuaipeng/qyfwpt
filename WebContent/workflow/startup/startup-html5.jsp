<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="/htm" prefix="htm" %>

<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>列表</TITLE>
<meta HTTP-EQUIV="Pragma" content="no-cache" /> 
<meta HTTP-EQUIV="Cache-Control" content="no-cache" /> 
<meta HTTP-EQUIV="Expires" content="0">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<META http-equiv=Content-Type content="text/html; charset=UTF-8">

<style>
body{ 
	margin:0px;
	padding:0px;
}
</style>
<htm:header type="form"/>

<SCRIPT src="../js/dialog.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/common.js" type="text/javascript"></SCRIPT>
<script src="../js/xtree.js" type="text/javascript"></script>
<script src="../js/xmlextras.js" type="text/javascript"></script>
<script src="../js/xloadtree.js" type="text/javascript"></script>
<SCRIPT src="../js/validator.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/ajax.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/portal.js" type="text/javascript"></SCRIPT>
<style type="text/css" media="screen"> 
			html, body	{ height:100%; }
			body { margin:0; padding:0; overflow:auto; text-align:center; 
			       background-color: #ffffff; }   
			#flashContent { display:none; }
        </style>
		
		<!-- Enable Browser History by replacing useBrowserHistory tokens with two hyphens -->
        <!-- BEGIN Browser History required section -->
        <link rel="stylesheet" type="text/css" href="../css/history.css" />
        <!-- END Browser History required section -->  
        <script type="text/javascript" src="history.js"></script>
        <!-- END Browser History required section -->  
		    
        <script type="text/javascript" src="swfobject.js"></script>
<script type="text/javascript" src="startupchart.js"></script>
</HEAD>

<BODY>
<htm:tabber type="form"/>
<htm:form name="EAPForm">
<htm:hidden name="$SYSTEM"/>
<htm:hidden name="$MODULE"/>
<htm:hidden name="$ACTION"/>
<htm:hidden name="$ID"/>
<htm:hidden name="$BOX"/>
<htm:hidden name="$TABLE"/>
<htm:hidden name="$MOBILE"/>

<div class="top">
	<a href="#" class="back" id="$BACK" onclick="return onToolbarButtonClick(this);">返回</a>
	<htm:write name="NAVIGATOR"/><span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span>
	<span class="topaction" ><input id="$BUTTON" type="submit" class="topbutton" value="保存"/></span>
</div>
<div style="height:37px;" id="$TOP">
</div>

	<htm:hidden name="debug"/>
 <htm:hidden name="wid"/>
 <htm:hidden name="instanceid"/>
 <htm:hidden name="params"/>
 <htm:hidden name="orgcode" defaultv="{ORGCODE}"/>
 <htm:hidden name="enablenav" defaultv="true"/>
 <htm:hidden name="flowcode"/>

<p class="detail"><span class="caption"><htm:title name="title"/>
 </span><span class="data"><htm:text name="title" title="工作名称" datatype="STRING" required="true" maxlength="255"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="msgsend"/>
 </span><span class="data"><htm:checkbox name="msgsend" title="消息通知方式" dictid="msgtype"/>
 </span></p>
<p class="action"><htm:button name="startup" value="启动流程" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="startup" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="exit.gif" display="ICONTEXT" url="startup.cmd?$ACTION=flows" target="_self"/>
</p>

</htm:form>
</BODY>
<script>
function onPageLoad() {
	<htm:write name="VALUEOBJECT" property="$JSONLOAD"/>

	if (typeof(formOnLoad)=="function")
		formOnLoad();

	hideNavigator();
}

function onPageSubmit(obj) {
	<htm:write name="VALUEOBJECT" property="$JSONSUBMIT"/>

	return true;
}
window.onload = onPageLoad;
</script>
</HTML>

