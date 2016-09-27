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
	<htm:hidden name="orgcode"/>

<table class="datatable" border="1" cellspacing="0" cellpadding="0" width="100%" align="center">
    <tbody>
        <tr>
            <td class="caption" style="width: 150px"><htm:title name="deptcode"/>
</td>
            <td><htm:text name="deptcode" title="根部门号" datatype="STRING" format="CODE" required="true" maxlength="32" width="200"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="deptname"/>
</td>
            <td><htm:text name="deptname" title="根部门名称" datatype="STRING" required="true" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="usercode"/>
</td>
            <td><htm:text name="usercode" title="管理员帐号" datatype="STRING" format="CODE" required="true" maxlength="32" width="200"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="username"/>
</td>
            <td><htm:text name="username" title="管理员名" datatype="STRING" required="true" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="pwd"/>
</td>
            <td><htm:password name="pwd" title="密码" datatype="STRING" required="true" maxlength="16"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="timeslice"/>
</td>
            <td><htm:select name="timeslice" title="时间段" dictid="timeslice"/>
</td>
        </tr>
        <tr>
            <td colspan="2" align="center"><htm:button name="init" value="初始化" type="CUSTOM" showtype="BUTTON" icon="docsubmit.gif" display="ICONTEXT" href="orginit" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="organize.cmd?$ACTION=list" target="_self"/>
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

