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
 <htm:hidden name="siteid"/>
 <htm:hidden name="parentid"/>
 <htm:hidden name="sn"/>
 <htm:hidden name="writerid"/>
 <htm:hidden name="auditorid"/>
 <htm:hidden name="releaserid"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="栏目号" datatype="STRING" required="true" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="栏目名" datatype="STRING" required="true" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="catype"/>
</td>
            <td><htm:select name="catype" title="类型" required="true" dictid="catalogtype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="templet"/>
</td>
            <td><htm:text name="templet" title="内容模板" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="enableaudit"/>
</td>
            <td><htm:checkbox name="enableaudit" title="是否需要审核" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="writer"/>
</td>
            <td><htm:readonly name="writer" title="采编员" datatype="STRING" maxlength="255" width="400"/>
 <htm:button name="selwriter" value="选择人员" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="USER" multi="checkbox" rets="writerid,writer" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="auditor"/>
</td>
            <td><htm:readonly name="auditor" title="审核员" datatype="STRING" maxlength="255" width="400"/>
 <htm:button name="selauditor" value="选择人员" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="USER" multi="checkbox" rets="auditorid,auditor" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="releaser"/>
</td>
            <td><htm:readonly name="releaser" title="发布员" datatype="STRING" maxlength="255" width="400"/>
 <htm:button name="selreleaser" value="选择人员" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="USER" multi="checkbox" target="_self"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save1.gif" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="save1.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="catalog.cmd?$ACTION=list" args="siteid,parentid" target="_self"/>
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

