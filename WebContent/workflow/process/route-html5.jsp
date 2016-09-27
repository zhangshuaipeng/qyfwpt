<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="/htm" prefix="htm" %>

<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>列表</TITLE>
<meta HTTP-EQUIV="Pragma" content="no-cache" /> 
<meta HTTP-EQUIV="Cache-Control" content="no-cache" /> 
<meta HTTP-EQUIV="Expires" content="0">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<META http-equiv=Content-Type content="text/html; charset=UTF-8">

<style>
body{ 
	margin:0px;
	padding:0px;
}
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
  if (!document.getElementById("nextnodeid")) return true;
  var selected = document.getElementsByName("nextnodeid");
  for (var i=0;i<selected.length;i++) {
    if (selected[i].checked) {
	return true;
    }
  }

  alert("没有选择下一环节，请选择！");
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

<div class="top">
	<a href="#" class="back" id="$BACK" onclick="return onToolbarButtonClick(this);">返回</a>
	<htm:write name="NAVIGATOR"/><span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span>
	<span class="topaction" ><input id="$BUTTON" type="submit" class="topbutton" value="保存"/></span>
</div>
<div style="height:37px;" id="$TOP">
</div>

	<htm:hidden name="result"/>
 <htm:hidden name="actors"/>
 <htm:hidden name="nextnodename"/>
 <htm:hidden name="comment"/>
 <htm:hidden name="actortype"/>
 <htm:hidden name="actor"/>
 <htm:hidden name="wid"/>

<p class="detail"><span class="caption"><htm:title name="title"/>
 </span><span class="data"><htm:span name="title"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="node"/>
 </span><span class="data"><htm:span name="node"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="routes"/>
 </span><span class="data"><span id="routes">
<%@ include file="/workflow/routes.jsp"%>
</span>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="actorname"/>
 </span><span class="data"><htm:readonly name="actorname" title="办理人" required="true" width="300"/>
 <htm:button name="single" value="选择" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="USER" multi="radio" rets="actor,actorname" target="_self"/>
 </span></p>
<htm:button name="submitwork" value="提交" type="CUSTOM" showtype="BUTTON" icon="teamadd.gif" display="ICONTEXT" href="actor" args="wid,nextnodeid" target="_self"/>
 <htm:button name="exit" value="返回" type="CLOSE" showtype="BUTTON" icon="exit.gif" display="ICONTEXT" target="_self"/>


</htm:form>
</BODY>
<script>
function onPageLoad() {
	<htm:write name="VALUEOBJECT" property="$JSONLOAD"/>

	if (typeof(formOnLoad)=="function")
		formOnLoad();

	hideNavigator();
}

function onPageSubmit(obj) {
	<htm:write name="VALUEOBJECT" property="$JSONSUBMIT"/>

	return true;
}
window.onload = onPageLoad;
</script>
</HTML>

