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
<script>


function refresh() {
	var v = document.getElementById("type").value;
	if (v=="fieldset") {
		document.getElementById("fieldset").parentNode.parentNode.style.display = "";
		document.getElementById("classname").parentNode.parentNode.style.display = "none";
		document.getElementById("dsn").parentNode.parentNode.style.display = "none";
		document.getElementById("table").parentNode.parentNode.style.display = "none";
		return;
	}
	if (v=="class") {
		document.getElementById("fieldset").parentNode.parentNode.style.display = "none";
		document.getElementById("classname").parentNode.parentNode.style.display = "";
		document.getElementById("dsn").parentNode.parentNode.style.display = "none";
		document.getElementById("table").parentNode.parentNode.style.display = "none";
		return;
	}
	if (v=="table") {
		document.getElementById("fieldset").parentNode.parentNode.style.display = "none";
		document.getElementById("classname").parentNode.parentNode.style.display = "none";
		document.getElementById("dsn").parentNode.parentNode.style.display = "";
		document.getElementById("table").parentNode.parentNode.style.display = "";
		return;
	}

}

</script>

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
<div class="formarea" style="width:600px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="system"/>
<htm:hidden name="module"/>
<htm:hidden name="grid"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width: 150px;" class="caption"><htm:title name="type"/>
</td>
            <td><htm:select name="type" title="类型" required="true" dictid="impcolumntype" onchange="refresh();"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="fieldset"/>
</td>
            <td><htm:select name="fieldset" title="域集合" dictid="fieldsets" parents="system,module" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="classname"/>
</td>
            <td><htm:text name="classname" title="POJO类" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="dsn"/>
</td>
            <td><htm:select name="dsn" title="数据源" dictid="dsn" expkey="true" onchange="refreshField('table');"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="table"/>
</td>
            <td><htm:select name="table" title="数据库表" dictid="dbtables" parents="dsn" expkey="true"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="import" value="导入域" type="CUSTOM" showtype="BUTTON" icon="dbexp.gif" display="ICONTEXT" href="import" target="_self" ajax="ajax"/>
<htm:button name="exit" value="返回" type="JAVASCRIPT" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="var doc = top.window.getDialog(window).getParentDocument();doc.forms[0].$ACTION.value='list';doc.forms[0].submit();top.window.getDialog(window).close();" target="_self"/>
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

