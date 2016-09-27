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
<div class="formarea" style="width:720px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="page"/>
 <htm:hidden name="system"/>
 <htm:hidden name="module"/>
 <htm:hidden name="grid"/>

<table class="datatable" border="1" cellspacing="0" cellpadding="0" width="100%" align="center">
    <tbody>
        <tr>
            <td class="caption" style="width: 150px"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="操作号" datatype="STRING" format="CODE" required="true" maxlength="32" width="108" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="操作名" datatype="STRING" required="true" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="type"/>
</td>
            <td><htm:select name="type" title="操作类型" dictid="subtableactiontype" expkey="true" onchange="refreshField('href');"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="showtype"/>
</td>
            <td><htm:select name="showtype" title="显示类型" dictid="actionshowtype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="href"/>
</td>
            <td><htm:select name="href" title="内容" dictid="actionselect" parents="system,module,type" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="url"/>
</td>
            <td><htm:text name="url" title="URL内容" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="display"/>
</td>
            <td><htm:select name="display" title="显示方式" required="true" dictid="showbutton"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="confirm"/>
</td>
            <td><htm:checkbox name="confirm" title="运行确认" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="uncheck"/>
</td>
            <td><htm:checkbox name="uncheck" title="提交时进行有效性校验" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="params"/>
</td>
            <td><htm:text name="params" title="参数" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="args"/>
</td>
            <td><htm:text name="args" title="输入域参数值" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="rets"/>
</td>
            <td><htm:text name="rets" title="返回域" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="refs"/>
</td>
            <td><htm:text name="refs" title="刷新域" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="width"/>
</td>
            <td><htm:text name="width" title="窗口宽度" datatype="INTEGER" maxlength="4"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="height"/>
</td>
            <td><htm:text name="height" title="窗口高度" datatype="INTEGER" maxlength="4"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="operand"/>
</td>
            <td><htm:select name="operand" title="操作范围" required="true" dictid="operandscope"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="icon"/>
</td>
            <td><htm:select name="icon" title="按钮图标" dictid="ICON"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="target"/>
</td>
            <td><htm:select name="target" title="运行目标" dictid="target" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="callback"/>
</td>
            <td><htm:text name="callback" title="调用方法" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="toolbar"/>
</td>
            <td><htm:select name="toolbar" title="绑定到工具栏" dictid="bandtoolbar"/>
</td>
        </tr>
        <tr>
            <td colspan="2" align="center"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="grdaction.cmd?$ACTION=list" args="system,module,grid,$TABLE" target="_self"/>
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

