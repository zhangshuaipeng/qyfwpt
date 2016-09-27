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

<style>
body{ 
	TEXT-ALIGN: center; 
	margin:0px;
	padding:0px;
}
</style>
<style media=print>
.nonprinting{display:none;}
button {display:none;}
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
<div class="formarea" style="width:500px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="nextnode"/>
 <htm:hidden name="pk"/>
 <htm:hidden name="system"/>
 <htm:hidden name="module"/>

<table class="datatable" border="1" cellspacing="0" cellpadding="0" width="100%" align="center">
    <tbody>
        <tr>
            <td class="caption" style="width: 150px"><htm:title name="code"/>
</td>
            <td><htm:readonly name="code" title="路由号" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="路由名" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="map"/>
</td>
            <td><htm:checkbox name="map" title="是否执行推处理" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="rule"/>
</td>
            <td><htm:select name="rule" title="办理人规则" dictid="rules"/>
</td>
        </tr>
        <tr>
            <td colspan="2" align="center"><htm:button name="event" value="路由事件" type="POPUP" showtype="BUTTON" icon="date.gif" display="ICONTEXT" href="URL" url="workflow/studio.cmd?$ACTION=listrouteevent" args="pk,code:routeid,system,module" target="_self" width="700" height="550"/>
 <htm:button name="save" value="确定" type="CUSTOM" showtype="BUTTON" icon="save1.gif" display="ICONTEXT" href="saveroute" target="_self" callback="top.window.getDialog(window).getParentWindow().flushObjectProp(document.getElementById('name').value);top.window.getDialog(window).close();" ajax="ajax"/>
 <htm:button name="exit" value="返回" type="JAVASCRIPT" showtype="BUTTON" icon="exit.gif" display="ICONTEXT" url="top.window.getDialog(window).close();" target="_self"/>
</td>
        </tr>
    </tbody>
</table>
	</div>
  </div>
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

