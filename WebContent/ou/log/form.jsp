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
<div class="formarea" style="width:100%px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="pk"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="type"/>
</td>
            <td><htm:text name="type" title="类别" datatype="STRING" required="true" maxlength="16" width="128"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="systemid"/>
</td>
            <td><htm:text name="systemid" title="系统名" datatype="STRING" required="true" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="moduleid"/>
</td>
            <td><htm:text name="moduleid" title="模块名" datatype="STRING" required="true" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="actionid"/>
</td>
            <td><htm:text name="actionid" title="操作名" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="reqtime"/>
</td>
            <td><htm:text name="reqtime" title="操作时间" datatype="STRING" required="true" maxlength="19" width="152"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="duration"/>
</td>
            <td><htm:text name="duration" title="操作运行时长" datatype="INTEGER" maxlength="22" width="176"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="ipaddr"/>
</td>
            <td><htm:text name="ipaddr" title="操作人IP" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="orgcode"/>
</td>
            <td><htm:text name="orgcode" title="组织号" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="userid"/>
</td>
            <td><htm:text name="userid" title="操作员" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="results"/>
</td>
            <td><htm:text name="results" title="操作结果" datatype="STRING" required="true" maxlength="16" width="128"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="impdata"/>
</td>
            <td><htm:text name="impdata" title="操作参数" datatype="STRING" maxlength="4000" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="expdata"/>
</td>
            <td><htm:text name="expdata" title="返回数据" datatype="STRING" maxlength="4000" width="400"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="log.cmd?$ACTION=list" target="_self"/>
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

