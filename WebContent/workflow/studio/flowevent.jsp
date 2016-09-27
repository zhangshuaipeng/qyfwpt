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

<LINK href="../css/xtree.css" type="text/css" rel="stylesheet">
<LINK href="../css/main.css" type="text/css" rel="stylesheet">

<SCRIPT src="../js/dialog.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/common.js" type="text/javascript"></SCRIPT>
<script src="../js/xtree.js" type="text/javascript"></script>
<script src="../js/xmlextras.js" type="text/javascript"></script>
<script src="../js/xloadtree.js" type="text/javascript"></script>
<SCRIPT src="../js/validator.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/ajax.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/grid.js" type="text/javascript"></SCRIPT>
<script>

function formOnLoad() {
    document.getElementById("eventid").value = document.getElementById("event").value;
}
</script>

</HEAD>

<BODY style="margin:0px;">
<htm:form name="EAPForm" action=""  method="POST"> 
	<htm:hidden name="pk"/>
 <htm:hidden name="eventid" defaultv="onInit"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td class="caption" style="width:150px;"><htm:title name="event"/>
</td>
            <td><htm:select name="event" title="选择事件" required="true" defaultv="onInit" dictid="flowevent" onchange="submitAjaxForm('saveflowevent');"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="type"/>
</td>
            <td><htm:select name="type" title="处理方式" dictid="eventtype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="classname"/>
</td>
            <td><htm:text name="classname" title="类名" datatype="STRING" maxlength="128" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="methodname"/>
</td>
            <td><htm:text name="methodname" title="类方法" datatype="STRING" maxlength="64" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="script"/>
</td>
            <td><htm:textarea name="script" title="脚本" datatype="STRING" height="300"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="uri"/>
</td>
            <td><htm:text name="uri" title="服务uri" datatype="STRING" maxlength="128" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="service"/>
</td>
            <td><htm:text name="service" title="服务名称" datatype="STRING" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="params"/>
</td>
            <td><htm:text name="params" title="调用参数" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="saveflowevent" target="_self" ajax="ajax"/>
 <htm:button name="exit" value="返回" type="CLOSE" showtype="BUTTON" icon="exit.gif" display="ICONTEXT" target="_self"/>
</td>
        </tr>
    </tbody>
</table>
<htm:hidden name="$SYSTEM"/>
<htm:hidden name="$MODULE"/>
<htm:hidden name="$ACTION"/>
<htm:hidden name="$BOX"/>
<htm:hidden name="$TABLE"/>
<htm:hidden name="$MESSAGE"/>
</htm:form>
</BODY>
<script>

function onPageLoad() {
	<htm:write name="VALUEOBJECT" property="$JSONLOAD"/>

	if (typeof(formOnLoad)=="function")
		formOnLoad();
}
function onPageSubmit() {
	<htm:write name="VALUEOBJECT" property="$JSONSUBMIT"/>

	return true;
}

window.onload = onPageLoad;
</script>
</HTML>


