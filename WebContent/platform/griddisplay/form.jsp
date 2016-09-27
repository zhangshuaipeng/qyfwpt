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
<SCRIPT src="../js/portal.js" type="text/javascript"></SCRIPT>

</HEAD>

<BODY>
<htm:form name="EAPForm">
<htm:hidden name="$SYSTEM"/>
<htm:hidden name="$MODULE"/>
<htm:hidden name="$ACTION"/>
<htm:hidden name="$ID"/>
<htm:hidden name="$BOX"/>
<htm:hidden name="$TABLE"/>
<div class="formarea" style="width:720px;">
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
            <td style="width:150px;" class="caption"><htm:title name="id"/>
</td>
            <td><htm:text name="id" title="识别号" datatype="STRING" required="true" maxlength="32" width="200" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="col"/>
</td>
            <td><htm:select name="col" title="列" required="true" dictid="gridcolumn" parents="system,module,grid" expkey="true" onchange="refreshField('value');"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="value"/>
</td>
            <td><htm:select name="value" title="列值" required="true" dictid="gridcoldictvalue" parents="system,module,grid,col" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="hidecols"/>
</td>
            <td><htm:checkbox name="hidecols" title="隐藏的列" dictid="gridcolumn" parents="system,module,grid"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="cell"/>
</td>
            <td><htm:select name="cell" title="单元格" dictid="gridcolumn" parents="system,module,grid" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="cellcolor"/>
</td>
            <td><htm:text name="cellcolor" title="单元格颜色" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="cellbgcolor"/>
</td>
            <td><htm:text name="cellbgcolor" title="单元格背景" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="rowcolor"/>
</td>
            <td><htm:text name="rowcolor" title="行颜色" datatype="STRING" maxlength="32" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="rowbgcolor"/>
</td>
            <td><htm:text name="rowbgcolor" title="行背景" datatype="STRING" maxlength="32" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="rowbold"/>
</td>
            <td><htm:checkbox name="rowbold" title="行内容加粗" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="url"/>
</td>
            <td><htm:text name="url" title="动态url" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="disablebox"/>
</td>
            <td><htm:checkbox name="disablebox" title="选择框不可选" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="griddisplay.cmd?$ACTION=list" args="system,module,grid" target="_self"/>
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

