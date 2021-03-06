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
	<htm:hidden name="orgcode" defaultv="{ORGCODE}"/>
 <htm:hidden name="position"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td><htm:title name="selected"/>
<htm:multibox name="selected" title="在岗用户" height="400" defaultv="123" dictid="postusers" parents="orgcode,position"/>
</td>
            <td width="64px" align="center"><htm:button name="del" value="〉〉" type="JAVASCRIPT" showtype="BUTTON" icon="del.gif" display="TEXT" url="moveMultiBox('selected','unselected');" target="_self"/>
 <htm:button name="add" value="〈〈" type="JAVASCRIPT" showtype="BUTTON" icon="add.gif" display="TEXT" url="moveMultiBox('unselected','selected');" target="_self"/>
</td>
            <td><htm:title name="unselected"/>
<htm:multibox name="unselected" title="可选择用户" height="400" defaultv="123" dictid="postselectuser" parents="orgcode,position"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="3"><htm:button name="saveuserpost" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="saveuserpost" target="_self" ajax="ajax"/>
 <htm:button name="exit" value="返回" type="CLOSE" showtype="BUTTON" icon="return.gif" display="ICONTEXT" target="_self"/>
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

