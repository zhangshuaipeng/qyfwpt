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
	<htm:hidden name="id"/>
 <htm:hidden name="sys"/>
 <htm:hidden name="type" defaultv="S"/>
 <htm:hidden name="url"/>
 <htm:hidden name="roles"/>
 <htm:hidden name="system"/>
 <htm:hidden name="module"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width: 150px" class="caption"><htm:title name="code"/>
</td>
            <td><htm:select name="code" title="模块" required="true" dictid="systemmodule" parents="sys:system" expkey="true" unbitted="true" onclick="refreshField('action');"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="模块名" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="action"/>
</td>
            <td><htm:select name="action" title="请求" required="true" dictid="controls" parents="sys:system,code:module" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="params"/>
</td>
            <td><htm:text name="params" title="请求参数" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="icon"/>
</td>
            <td><htm:select name="icon" title="图标" dictid="ICON"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="client"/>
</td>
            <td><htm:checkbox name="client" title="运行运行客户端" required="true" dictid="clienttype"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="savesubmod" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="exit.gif" display="ICONTEXT" url="modulenav.cmd?$ACTION=listsub" args="system,module,sys" target="_self"/>
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

