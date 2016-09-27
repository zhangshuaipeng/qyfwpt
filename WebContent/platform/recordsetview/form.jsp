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
<div class="formarea" style="width:100%px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="system"/>
 <htm:hidden name="module"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="编号" datatype="STRING" format="CODE" required="true" maxlength="32" width="200" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="名称" datatype="STRING" required="true" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="grid"/>
</td>
            <td><htm:select name="grid" title="记录集" required="true" dictid="grids" parents="system,module" onchange="refreshField('queryopts');"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="queryopts"/>
</td>
            <td><htm:checkbox name="queryopts" title="显示查询项" dictid="queryopts" parents="system,module,grid"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="pagectl"/>
</td>
            <td><htm:select name="pagectl" title="翻页控制" dictid="pagectrl"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="count"/>
</td>
            <td><htm:text name="count" title="显示记录数" datatype="INTEGER" format="INTEGER" maxlength="32" width="96"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="nulltips"/>
</td>
            <td><htm:text name="nulltips" title="空记录提示内容" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="frametag"/>
</td>
            <td><htm:select name="frametag" title="框架结构标签" required="true" dictid="recordviewtag" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="frameattr"/>
</td>
            <td><htm:text name="frameattr" title="框架总标签属性" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="border"/>
</td>
            <td><htm:textarea name="border" title="外框标签" datatype="STRING" height="150"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="endtag"/>
</td>
            <td><htm:textarea name="endtag" title="外框结束标签" datatype="STRING" height="60"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="queryarea"/>
</td>
            <td><htm:textarea name="queryarea" title="查询区" datatype="STRING" height="64"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="actionarea"/>
</td>
            <td><htm:textarea name="actionarea" title="操作区" datatype="STRING" height="64"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="header"/>
</td>
            <td><htm:textarea name="header" title="标题头标签" datatype="STRING" height="150"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="group"/>
</td>
            <td><htm:textarea name="group" title="分组标签" datatype="STRING" height="150"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="grpendtag"/>
</td>
            <td><htm:textarea name="grpendtag" title="分组结束标签" datatype="STRING" height="60"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="oddrows"/>
</td>
            <td><htm:textarea name="oddrows" title="奇数行标签" datatype="STRING" required="true" height="150"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="evenrows"/>
</td>
            <td><htm:textarea name="evenrows" title="偶数行标签" datatype="STRING" height="150"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="recordsetview.cmd?$ACTION=list" args="system,module" target="_self"/>
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

