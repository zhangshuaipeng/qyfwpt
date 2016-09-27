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

function formOnLoad() {
   document.body.style.display = "none";
   var obj = document.getElementById("submitwork");
   runFormCmd(obj);
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
<div class="formarea" style="width:560px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="wid"/>
 <htm:hidden name="nextnodeid"/>
 <htm:hidden name="actor"/>

<table class="datatable" border="1" cellspacing="0" cellpadding="0" width="100%" align="center">
    <tbody>
        <tr>
            <td class="caption" style="width: 150px"><htm:title name="title"/>
</td>
            <td><htm:span name="title" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="node"/>
</td>
            <td><htm:span name="node" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="nextnodename"/>
</td>
            <td><htm:span name="nextnodename" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="actorname"/>
</td>
            <td><htm:span name="actorname" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="comment"/>
</td>
            <td><htm:span name="comment" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="result"/>
</td>
            <td style="color: red"><htm:span name="result" defaultv="您真的要提交本项工作吗?"/>
</td>
        </tr>
        <tr>
            <td colspan="2" align="center"><htm:button name="submitwork" value="提交" type="CUSTOM" showtype="BUTTON" icon="teamadd.gif" display="ICONTEXT" href="submit" target="_self"/>
 <htm:button name="exit" value="返回" type="CLOSE" showtype="BUTTON" icon="exit.gif" display="ICONTEXT" target="_self"/>
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

