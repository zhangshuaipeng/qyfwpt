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
	overflow:hidden;
}
</style>
<style media=print>
.nonprinting{display:none;}
button {display:none;}
input {border:0px;}
textarea {border:0px;overflow:hidden;}
select {border:0px;overflow:hidden;}
body {font-size:14px;}
</style>
<htm:header type="flow"/>

<SCRIPT src="js/tabber.js" type="text/javascript"></SCRIPT>
<SCRIPT src="js/dialog.js" type="text/javascript"></SCRIPT>
<SCRIPT src="js/common.js" type="text/javascript"></SCRIPT>
<script src="js/xtree.js" type="text/javascript"></script>
<script src="js/xmlextras.js" type="text/javascript"></script>
<script src="js/xloadtree.js" type="text/javascript"></script>
<SCRIPT src="js/validator.js" type="text/javascript"></SCRIPT>
<SCRIPT src="js/ajax.js" type="text/javascript"></SCRIPT>
<SCRIPT src="js/portal.js" type="text/javascript"></SCRIPT>
JAVASCRIPT-TAG
</HEAD>

<BODY>
<div id="TAB" style="text-align:left;height:25px;">
</div>
<div id="TOOLBAR" class="toolbar">
</div>
<div style="text-align:left;height:26px;" class="navbar">
	<span id="$MESSAGE" style="color:red;float:right;"></span>
	<span id="FLOWINFO"></span>
</div>
<div class="formarea" id="FORMCONTENT" style="overflow:auto;margin:0px;">
	<div class="flowformbody">
<htm:form name="EAPForm">
<htm:hidden name="$SYSTEM"/>
<htm:hidden name="$MODULE"/>
<htm:hidden name="$ACTION"/>
<htm:hidden name="$MOBILE"/>
<htm:hidden name="$ID"/>
<htm:hidden name="$WID"/>
<htm:hidden name="$INSTANCEID"/>
<htm:hidden name="$NODEID"/>
<htm:hidden name="$NEXTNODES"/>
<htm:hidden name="$NEXTACTORS"/>
<htm:hidden name="$FLOWDATA"/>
<htm:hidden name="$WORKDATA"/>
<htm:hidden name="$CC"/>
<htm:hidden name="$NODEADM"/>
<htm:hidden name="$SUBACTORS"/>
<htm:hidden name="$TABLE"/>
<htm:hidden name="$PAGEID"/>
<htm:hidden name="$VERSION"/>
<htm:hidden name="$WORDTEXT"/>
	PAGE-CONTENT
</htm:form>
	</div>
</div>
</BODY>
<script>
function onPageLoad() {
	<htm:write name="VALUEOBJECT" property="$JSONLOAD"/>

	if (typeof(formOnLoad)=="function")
		formOnLoad();
	removeNulRow();
}

function onPageSubmit(obj) {
	<htm:write name="VALUEOBJECT" property="$JSONSUBMIT"/>

	return true;
}
window.onload = onPageLoad;
</script>
</HTML>
