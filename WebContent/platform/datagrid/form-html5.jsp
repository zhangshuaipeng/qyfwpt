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
<SCRIPT src="../js/grid.js" type="text/javascript"></SCRIPT>
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
<div class="formarea" style="width:720px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="system"/>
 <htm:hidden name="module"/>
 <htm:hidden name="action"/>
 <htm:hidden name="state"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="表格号" datatype="STRING" format="CODE" required="true" maxlength="32" width="200" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="表格名" datatype="STRING" required="true" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="metadata"/>
</td>
            <td><htm:select name="metadata" title="元数据" dictid="metadata" parents="system,module" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="rowsperpage"/>
</td>
            <td><htm:text name="rowsperpage" title="每页记录数" datatype="INTEGER" width="200"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="box"/>
</td>
            <td><htm:radio name="box" title="表格选择框" dictid="subtablebox"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="index"/>
</td>
            <td><htm:radio name="index" title="显示序号列" dictid="yesno"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="pagecontrol"/>
</td>
            <td><htm:radio name="pagecontrol" title="显示翻页控制" dictid="yesno"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="aloneoptarea"/>
</td>
            <td><htm:checkbox name="aloneoptarea" title="查询区整行显示" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="view"/>
</td>
            <td><htm:select name="view" title="显示视图" dictid="recordsetview" parents="system,module"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="exportxls"/>
</td>
            <td><htm:select name="exportxls" title="导出Excel" dictid="export"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onrowchange"/>
</td>
            <td><htm:text name="onrowchange" title="行值变更处理" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onrowselected"/>
</td>
            <td><htm:text name="onrowselected" title="行选定处理" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value=" 保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="datagrid.cmd?$ACTION=list" args="system,module" target="_self"/>
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

