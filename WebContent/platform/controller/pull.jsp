<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="/htm" prefix="htm" %>

<HTML>
<HEAD>
<TITLE>列表</TITLE>
<meta HTTP-EQUIV="Pragma" content="no-cache" /> 
<meta HTTP-EQUIV="Cache-Control" content="no-cache" /> 
<meta HTTP-EQUIV="Expires" content="0">
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<style media=print>
.nonprinting{display:none;}
button {display:none;}
</style>

<LINK href="../css/main.css" type="text/css" rel="stylesheet">

<SCRIPT src="../js/dialog.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/common.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/validator.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/ajax.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/grid.js" type="text/javascript"></SCRIPT>


</HEAD>

<BODY class="listbody">
<htm:form name="EAPForm">
<div class="navbar">
	<span id="$MESSAGE" style="color:red;float:right;"></span>
	<htm:write name="NAVIGATOR"/>	
</div>
<htm:hidden name="$ID"/>
<htm:hidden name="$SYSTEM"/>
<htm:hidden name="$MODULE"/>
<htm:hidden name="$ACTION"/>
<htm:hidden name="$BOX"/>
<htm:hidden name="$TABLE"/>
<div>
	<htm:hidden name="system"/>
 <htm:hidden name="module"/>
 <htm:hidden name="code"/>
 <htm:grid id="list" name="list" title="拉处理列表" gridid="pull"/>


</div>
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

