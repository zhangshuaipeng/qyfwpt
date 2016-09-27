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

// 设置选择的节点
function setSelectNodes() {
    var dlg = top.window.getDialog(window);
    if (!dlg) return;
    var grid = dlg.getParentWindow().gridlist;
    if (!grid) return;
    
    var obj = document.getElementById("selected");
    grid.setFieldValue(grid.getSelectedRow(),"nodes",obj.value);
    var name = obj.getAttribute("text");
    if (name)     grid.setFieldValue(grid.getSelectedRow(),"nodesname",obj.getAttribute("text"));
     grid.rowChange(grid.getSelectedRow());

    dlg.close();
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
<div class="formarea" style="width:100%px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="pk"/>

<table border="0" cellspacing="0" cellpadding="0" width="100%" align="center" style="border-bottom: 0px; border-left: 0px; border-top: 0px; border-right: 0px">
    <tbody>
        <tr>
            <td align="left" style="border-bottom: 0px; border-left: 0px; width: 45%; border-top: 0px; border-right: 0px"><htm:title name="unselected"/>
<htm:multibox name="unselected" title="可选节点" height="300" dictid="flownodes" parents="pk"/>
</td>
            <td align="center" style="border-bottom: 0px; border-left: 0px; width: 10%; border-top: 0px; border-right: 0px"><htm:button name="check" value="〉〉" type="JAVASCRIPT" showtype="BUTTON" icon="add.gif" display="TEXT" url="moveMultiBox('unselected','selected');" target="_self"/>
 <htm:button name="uncheck" value="〈〈" type="JAVASCRIPT" showtype="BUTTON" icon="add.gif" display="TEXT" url="moveMultiBox('selected','unselected');" target="_self"/>
</td>
            <td align="left" style="border-bottom: 0px; border-left: 0px; width: 45%; border-top: 0px; border-right: 0px"><htm:title name="selected"/>
<htm:multibox name="selected" title="已选节点" height="300" dictid="flownodes" parents="pk"/>
</td>
        </tr>
        <tr>
            <td colspan="3" align="center" style="border-bottom: 0px; border-left: 0px; border-top: 0px; border-right: 0px"><htm:button name="select" value="确定" type="JAVASCRIPT" showtype="BUTTON" icon="save.png" display="ICONTEXT" url="setSelectNodes();" target="_self"/>
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

