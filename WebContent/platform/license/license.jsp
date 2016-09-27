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
<SCRIPT src="../js/grid.js" type="text/javascript"></SCRIPT>
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
<div class="formarea" style="width:720px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="serialno"/>
</td>
            <td><htm:text name="serialno" title="序列号" datatype="STRING" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="serverinfo"/>
</td>
            <td><htm:readonly name="serverinfo" title="服务器信息" datatype="STRING" required="true" maxlength="40" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="organize"/>
</td>
            <td><htm:text name="organize" title="组织名" datatype="STRING" required="true" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="alias"/>
</td>
            <td><htm:text name="alias" title="组织简称" datatype="STRING" required="true" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="system"/>
</td>
            <td><htm:text name="system" title="系统名称" datatype="STRING" required="true" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="version"/>
</td>
            <td><htm:select name="version" title="版本" required="true" dictid="version"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="ip"/>
</td>
            <td><htm:select name="ip" title="IP" required="true" dictid="ip"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="mac"/>
</td>
            <td><htm:select name="mac" title="MAC" required="true" dictid="mac"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="backupip"/>
</td>
            <td><htm:select name="backupip" title="备用IP" dictid="ip"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="backupmac"/>
</td>
            <td><htm:select name="backupmac" title="备用MAC" dictid="mac"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="start"/>
</td>
            <td><htm:readonly name="start" title="生效起时" datatype="STRING" required="true" maxlength="10" width="256" defaultv="{TODAY}"/>
 <htm:button name="from" value="生效起时" type="POPUP" showtype="BUTTON" icon="date.gif" display="ICONTEXT" href="DATE" rets="start" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="overdue"/>
</td>
            <td><htm:readonly name="overdue" title="截止时间" datatype="STRING" required="true" maxlength="10" width="256" defaultv="0000-00-00"/>
 <htm:button name="to" value="截止时间" type="POPUP" showtype="BUTTON" icon="date.gif" display="ICONTEXT" href="DATE" rets="overdue" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onlines"/>
</td>
            <td><htm:text name="onlines" title="在线用户数" datatype="INTEGER" format="INTEGER" required="true" maxlength="8" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="report"/>
</td>
            <td><htm:radio name="report" title="开启报表功能" required="true" dictid="yesno"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="mobile"/>
</td>
            <td><htm:radio name="mobile" title="开启移动功能" required="true" dictid="yesno"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="save" target="_self" ajax="ajax"/>
 <htm:button name="down" value="下载" type="CUSTOM" showtype="BUTTON" icon="down.gif" display="ICONTEXT" href="down" target="_self"/>
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

