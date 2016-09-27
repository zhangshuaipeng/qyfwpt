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
}
</style>
<style media=print>
.nonprinting{display:none;}
button {display:none;}
</style>
<LINK href="../css/xtree.css" type="text/css" rel="stylesheet">
<LINK href="../css/main.css" type="text/css" rel="stylesheet">

<SCRIPT src="../js/dialog.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/common.js" type="text/javascript"></SCRIPT>
<script src="../js/xtree.js" type="text/javascript"></script>
<script src="../js/xmlextras.js" type="text/javascript"></script>
<script src="../js/xloadtree.js" type="text/javascript"></script>
<SCRIPT src="../js/validator.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/ajax.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/grid.js" type="text/javascript"></SCRIPT>

</HEAD>

<BODY>
<htm:form name="EAPForm">
<htm:hidden name="$SYSTEM"/>
<htm:hidden name="$MODULE"/>
<htm:hidden name="$ACTION"/>
<htm:hidden name="$ID"/>
<htm:hidden name="$BOX"/>
<htm:hidden name="$TABLE"/>
<div class="formarea" style="width:1024px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="cntcode"/>
 <htm:hidden name="orgcode" defaultv="{ORGCODE}"/>
 <htm:hidden name="templet"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td class="caption" style="width:150px;"><htm:title name="css"/>
</td>
            <td><htm:textarea name="css" title="css式样" datatype="STRING" height="100"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onload"/>
</td>
            <td><htm:textarea name="onload" title="js脚本" datatype="STRING" height="100"/>
</td>
        </tr>
        <tr>
            <td colspan="2"><htm:editor name="html" height="400"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="updatehtml" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="templet.cmd?$ACTION=listcontent" args="templet" target="_self"/>
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

