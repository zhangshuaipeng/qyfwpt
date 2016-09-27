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
<div class="formarea" style="width:100%px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="服务号" datatype="STRING" format="CODE" required="true" maxlength="32" width="256" unbitted="true"/>
</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td colspan="3"><htm:text name="name" title="服务名" datatype="STRING" required="true" maxlength="32" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="cycle"/>
</td>
            <td><htm:select name="cycle" title="运行周期" required="true" dictid="cycle"/>
</td>
            <td class="caption"><htm:title name="status"/>
</td>
            <td><htm:select name="status" title="状态" required="true" dictid="status"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="starttime"/>
</td>
            <td><htm:readonly name="starttime" title="有效起时" datatype="STRING" maxlength="32" width="200"/>
 <htm:button name="selectstart" value="选择" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="DATETIME" rets="starttime" target="_self"/>
</td>
            <td class="caption"><htm:title name="endtime"/>
</td>
            <td><htm:readonly name="endtime" title="有效止时" datatype="STRING" maxlength="32" width="200"/>
 <htm:button name="selectend" value="选择" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="DATETIME" rets="endtime" target="_self"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="4"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="debug" value="调试脚本" type="CUSTOM" showtype="BUTTON" icon="filesubmit.gif" display="ICONTEXT" href="debug" target="_self" ajax="ajax"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="exit.gif" display="ICONTEXT" url="schedule.cmd?$ACTION=list" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="script"/>
</td>
            <td colspan="3"><htm:textarea name="script" title="运行脚本" datatype="STRING" height="400"/>
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

