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
<div class="formarea" style="width:640px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="pk"/>
 <htm:hidden name="orgcode" defaultv="{ORGCODE}"/>

<table class="datatable" border="1" cellspacing="0" cellpadding="0" width="100%" align="center">
    <tbody>
        <tr>
            <td class="caption" style="width: 150px"><htm:title name="workday"/>
</td>
            <td><htm:readonly name="workday" title="日期" datatype="STRING" required="true" maxlength="10" width="108"/>
 <htm:button name="selectdate" value="选择" type="POPUP" showtype="BUTTON" icon="add.png" display="ICONTEXT" href="DATE" rets="workday" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="validtype"/>
</td>
            <td><htm:radio name="validtype" title="有效部分" required="true" defaultv="O" dictid="workday"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="type"/>
</td>
            <td><htm:radio name="type" title="类型" required="true" defaultv="H" dictid="workdaytype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="descr"/>
</td>
            <td><htm:text name="descr" title="说明" datatype="STRING" maxlength="128"/>
</td>
        </tr>
        <tr>
            <td colspan="2" align="center"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="workday.cmd?$ACTION=list" args="$TABLE" target="_self"/>
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

