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
 <htm:hidden name="siteid"/>
 <htm:hidden name="catalogid"/>
 <htm:hidden name="writer" defaultv="{USERCODE}"/>
 <htm:hidden name="creatime" defaultv="{NOW}"/>
 <htm:hidden name="auditor"/>
 <htm:hidden name="auditortime"/>
 <htm:hidden name="comments"/>
 <htm:hidden name="releaser"/>
 <htm:hidden name="releasetime"/>
 <htm:hidden name="templet"/>
 <htm:hidden name="uri"/>
 <htm:hidden name="readnum"/>
 <htm:hidden name="status"/>
 <htm:hidden name="sn"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="title"/>
</td>
            <td><htm:text name="title" title="标题" datatype="STRING" required="true" maxlength="128" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="ctype"/>
</td>
            <td><htm:select name="ctype" title="类型" required="true" dictid="contenttype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="linkid"/>
</td>
            <td><htm:attach name="linkid" title="附件" width="400" dictid="image"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="keys"/>
</td>
            <td><htm:textarea name="keys" title="关键字" datatype="STRING" maxlength="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="content"/>
</td>
            <td><htm:editor name="content"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save1.gif" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="content.cmd?$ACTION=list" args="siteid,catalogid" target="_self"/>
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

