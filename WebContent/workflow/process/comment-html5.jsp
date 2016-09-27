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

<div class="top">
	<div class="topzhong">
		<a href="#" class="back" id="$BACK" onclick="return onToolbarButtonClick(this);">返回</a>
		<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
		<span class="topaction" ><input id="$BUTTON" type="submit" class="topbutton" value="保存"/></span>
	</div>
</div>
<div style="height:37px;">
</div>

	<htm:hidden name="instanceid"/>
 <htm:hidden name="wid"/>
 <htm:title name="nodename"/>
 <htm:span name="nodename"/>
 <htm:title name="comments"/>
 <htm:textarea name="comments" title="办理意见" height="150"/>
 <htm:grid id="list" name="list" title="意见列表" gridid="comment"/>
 <htm:button name="save" value="保存意见" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="savecomment" target="_self" ajax="ajax"/>
 <htm:button name="exit" value="退出" type="CLOSE" showtype="BUTTON" icon="exit.gif" display="ICONTEXT" target="_self"/>


</htm:form>
</BODY>
<script>
function onPageLoad() {
	<htm:write name="VALUEOBJECT" property="$JSONLOAD"/>

	if (typeof(formOnLoad)=="function")
		formOnLoad();
}

function onPageSubmit(obj) {
	<htm:write name="VALUEOBJECT" property="$JSONSUBMIT"/>

	return true;
}
window.onload = onPageLoad;
</script>
</HTML>

