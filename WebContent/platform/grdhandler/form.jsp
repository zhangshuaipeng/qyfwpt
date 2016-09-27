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
<script>
function submitForm() {
	if (!objValidator.isValid()) return;
	document.forms[0].$ACTION.value = "update";
	var form = new DHTMLSuite.form({ formRef:"EAPForm",action:'grdhandler.cmd',callbackOnComplete:'showResult'});
	form.submit();
}

function showResult(ajaxObj) {
	document.getElementById("$MESSAGE").innerHTML = "修改成功！";
//	alert(ajaxObj.module);	
}

function onChangeType() {
	if (!objValidator.isValid()) return;
	document.forms[0].$ACTION.value = "update";
	var form = new DHTMLSuite.form({ formRef:"EAPForm",action:'grdhandler.cmd',callbackOnComplete:'reload'});
	form.submit();
}

function reload() {
	document.forms[0].$ACTION.value = "read";
	document.forms[0].type.value = document.forms[0].typeselect.value;
	var form = new DHTMLSuite.form({ formRef:"EAPForm",action:'grdhandler.cmd',callbackOnComplete:'writeFields'});
	form.submit();
}

function writeFields(ajaxObj) {
	var obj;

	for (var c in ajaxObj) {
		if (c.indexOf("$")==0) continue;
		obj = document.getElementById(c);
		if (!obj) continue;
		obj.value = ajaxObj[c];
	}
}
</script>

</HEAD>

<BODY>
<htm:form name="EAPForm">
<htm:hidden name="$SYSTEM"/>
<htm:hidden name="$MODULE"/>
<htm:hidden name="$ACTION"/>
<htm:hidden name="$ID"/>
<htm:hidden name="$BOX"/>
<htm:hidden name="$TABLE"/>
<div class="formarea" style="width:640px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="system"/>
 <htm:hidden name="module"/>
 <htm:hidden name="grid"/>
 <htm:hidden name="type"/>
 <htm:hidden name="action"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="typeselect"/>
</td>
            <td><htm:select name="typeselect" title="类型选择" required="true" defaultv="R" dictid="subtablehandler" onchange="onChangeType()"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="business"/>
</td>
            <td><htm:select name="business" title="业务处理项" dictid="business" parents="system,module" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="params"/>
</td>
            <td><htm:text name="params" title="参数" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self" ajax="ajax"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="datagrid.cmd?$ACTION=list" args="system,module,$TABLE" target="_self"/>
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

