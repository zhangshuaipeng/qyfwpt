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
<htm:hidden name="$MOBILE"/>
<div class="formarea" style="width:720px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="pk"/>

<table class="datatable" border="1" cellspacing="0" cellpadding="0" width="100%" align="center">
    <tbody>
        <tr>
            <td class="caption" style="width: 150px"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="标识号" datatype="STRING" format="CODE" required="true" maxlength="32" width="256" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="starttime"/>
</td>
            <td><htm:readonly name="starttime" title="开始时间" datatype="STRING" required="true" maxlength="19" width="152"/>
 <htm:button name="startselect" value="有效起时选择" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="DATETIME" rets="starttime" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="endtime"/>
</td>
            <td><htm:readonly name="endtime" title="结束时间" datatype="STRING" required="true" maxlength="19" width="152"/>
 <htm:button name="endselect" value="截止时间选择" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="DATETIME" rets="endtime" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="notes"/>
</td>
            <td><htm:text name="notes" title="说明" datatype="STRING" maxlength="128" width="400"/>
</td>
        </tr>
        <tr>
            <td colspan="2" align="center"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="timeslice.cmd?$ACTION=list" target="_self"/>
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

