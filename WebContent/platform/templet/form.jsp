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
	<htm:hidden name="height"/>
 <htm:hidden name="system"/>
 <htm:hidden name="module"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="templet"/>
</td>
            <td><htm:text name="templet" title="模板号" datatype="STRING" format="CODE" required="true" maxlength="32" unbitted="true"/>
</td>
            <td style="width:150px;" class="caption"><htm:title name="templetname"/>
</td>
            <td><htm:text name="templetname" title="模板名称" datatype="STRING" required="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="page"/>
</td>
            <td><htm:select name="page" title="表单" required="true" dictid="page" parents="system,module"/>
</td>
            <td class="caption"><htm:title name="cols"/>
</td>
            <td><htm:select name="cols" title="页分栏" dictid="pagecolumn"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="style"/>
</td>
            <td><htm:select name="style" title="式样类型" dictid="pagestyle"/>
</td>
            <td class="caption"><htm:title name="width"/>
</td>
            <td><htm:text name="width" title="模板宽度" datatype="INTEGER" format="INTEGER" maxlength="32" width="108"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="html5"/>
</td>
            <td><htm:checkbox name="html5" title="html5模板" dictid="enable"/>
</td>
            <td class="caption"><htm:title name="app"/>
</td>
            <td><htm:checkbox name="app" title="APP模板" dictid="enable"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="jsfile"/>
</td>
            <td colspan="3"><htm:textarea name="jsfile" title="附加JAVASCRIPT内容" datatype="STRING" height="400"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="4"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="templet.cmd?$ACTION=list" args="system,module,$TABLE" target="_self"/>
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

