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

function onsubmitworkClick() {
    var type = document.forms[0].actortype.value;
    if (type=="radio" || type=="checkbox" || type=="right" || type=="lists") {
      if (!document.getElementById("actor").value) {
         alert("请选择办理人!");
         return false;
      }
      return true;
    }

    var selected = document.getElementsByName("actor");
    for (var i=0;i<selected.length;i++) {
      if (selected[i].checked) {
	return true;
      }
    }

    alert("没有选择下一环节办理人，请选择！");
    return false;
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
 <htm:hidden name="actortype"/>
 <htm:hidden name="comment"/>
 <htm:hidden name="result"/>

<table class="datatable" border="1" cellspacing="0" cellpadding="0" width="100%" align="center">
    <tbody>
        <tr>
            <td class="caption" style="width: 150px"><htm:title name="title"/>
</td>
            <td><htm:span name="title"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="node"/>
</td>
            <td><htm:span name="node"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="nextnodename"/>
</td>
            <td><htm:span name="nextnodename"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="actorname"/>
</td>
            <td><htm:textarea name="actorname" title="办理人" required="true" width="360"/>
 <htm:button name="single" value="选择" type="POPUP" showtype="BUTTON" icon="teamadd.gif" display="ICONTEXT" href="USER" multi="radio" rets="actor,actorname" target="_self"/>
<htm:button name="multi" value="选择" type="POPUP" showtype="BUTTON" icon="teamadd.gif" display="ICONTEXT" href="USER" multi="checkbox" rets="actor,actorname" target="_self"/>
<htm:button name="compete" value="选择" type="POPUP" showtype="BUTTON" icon="teamadd.gif" display="ICONTEXT" href="RIGHT" rets="actor,actorname" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="actors"/>
</td>
            <td><span id="actors">
<%@ include file="/workflow/actors.jsp"%>
</span>
</td>
        </tr>
        <tr>
            <td colspan="2" align="center"><htm:button name="submitwork" value="提交" type="CUSTOM" showtype="BUTTON" icon="teamadd.gif" display="ICONTEXT" href="confirm" target="_self"/>
 <htm:button name="exit" value="返回" type="CLOSE" showtype="BUTTON" icon="exit.gif" display="ICONTEXT" target="_self"/>
&nbsp;&nbsp;&nbsp;</td>
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

