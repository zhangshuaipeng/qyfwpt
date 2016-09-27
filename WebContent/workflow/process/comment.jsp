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

<htm:header type="form"/>

<SCRIPT src="../js/dialog.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/common.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/validator.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/ajax.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/portal.js" type="text/javascript"></SCRIPT>


</HEAD>

<BODY class="listbody">
<htm:tabber type="form"/>
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
<htm:hidden name="$MOBILE"/>
<div>
	<htm:hidden name="wid"/>
 <htm:hidden name="instanceid"/>

<table class="datatable" border="1" cellspacing="0" cellpadding="0" width="100%" align="center">
    <tbody>
        <tr>
            <td class="caption" style="width: 150px"><htm:title name="nodename"/>
</td>
            <td><htm:span name="nodename"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="comments"/>
</td>
            <td><htm:textarea name="comments" title="办理意见" height="150"/>
</td>
        </tr>
        <tr>
            <td colspan="2" align="center">&nbsp;<htm:button name="save" value="保存意见" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="savecomment" target="_self" ajax="ajax"/>
<htm:button name="exit" value="退出" type="CLOSE" showtype="BUTTON" icon="exit.gif" display="ICONTEXT" target="_self"/>
</td>
        </tr>
    </tbody>
</table>
<htm:grid id="list" name="list" title="意见列表" gridid="comment"/>


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

