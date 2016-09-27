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
<div class="formarea" style="width:100%px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="pk"/>
 <htm:hidden name="system"/>
 <htm:hidden name="module"/>
 <htm:hidden name="type" defaultv="P"/>
 <htm:hidden name="actors"/>
 <htm:hidden name="cc"/>

<table class="datatable" border="1" cellspacing="0" cellpadding="0" width="100%" align="center">
    <tbody>
        <tr>
            <td class="caption" style="width: 150px"><htm:title name="nodeid"/>
</td>
            <td><htm:readonly name="nodeid" title="节点号"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="节点名称" required="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="subprocess"/>
</td>
            <td><htm:select name="subprocess" title="子流程" dictid="listflow" parents="{ORGCODE}:orgcode"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="exparams"/>
</td>
            <td><htm:textarea name="exparams" title="运行子流程初始参数" height="150"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="actorsname"/>
</td>
            <td><htm:readonly name="actorsname" title="办理人" width="340"/>
 <htm:button name="selectactors" value="选择" type="POPUP" showtype="BUTTON" icon="right.gif" display="ICONTEXT" href="RIGHT" rets="actors,actorsname" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="ccname"/>
</td>
            <td><htm:readonly name="ccname" title="抄送人" width="340"/>
 <htm:button name="selectcc" value="选择" type="POPUP" showtype="BUTTON" icon="right.gif" display="ICONTEXT" href="RIGHT" rets="cc,ccname" target="_self"/>
</td>
        </tr>
        <tr>
            <td colspan="2" align="center"><htm:button name="rights" value="表单权限" type="POPUP" showtype="BUTTON" icon="right.gif" display="ICONTEXT" href="URL" url="workflow/studio.cmd?$ACTION=right" args="pk,nodeid" target="_self" width="600" height="480"/>
 <htm:button name="event" value="事件处理" type="POPUP" showtype="BUTTON" icon="msglink.gif" display="ICONTEXT" href="URL" url="workflow/studio.cmd?$ACTION=listnodeevent" args="pk,nodeid,system,module" target="_self" width="700" height="550"/>
 <htm:button name="policy" value="路由策略" type="POPUP" showtype="BUTTON" icon="msglink.gif" display="ICONTEXT" href="URL" url="workflow/studio.cmd?$ACTION=policy" args="pk,nodeid,system,module:form" target="_self" width="720" height="480"/>
 <htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="savenode" target="_self" callback="top.window.getDialog(window).getParentWindow().flushObjectProp(document.getElementById('name').value);top.window.getDialog(window).close();" ajax="ajax"/>
 <htm:button name="exit" value="返回" type="CLOSE" showtype="BUTTON" icon="exit.gif" display="ICONTEXT" target="_self"/>
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

