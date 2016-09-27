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

</HEAD>

<BODY>
<htm:form name="EAPForm">
<htm:hidden name="$SYSTEM"/>
<htm:hidden name="$MODULE"/>
<htm:hidden name="$ACTION"/>
<htm:hidden name="$ID"/>
<htm:hidden name="$BOX"/>
<htm:hidden name="$TABLE"/>
<div class="formarea" style="width:640px;">
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
            <td class="caption" style="width:150px;"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="树编号" datatype="STRING" format="CODE" required="true" maxlength="32" width="200" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="树名称" datatype="STRING" required="true" width="300"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="box"/>
</td>
            <td><htm:select name="box" title="选择框" dictid="boxtype" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="expvalue"/>
</td>
            <td><htm:checkbox name="expvalue" title="导出值对到选择框" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="rooturl"/>
</td>
            <td><htm:text name="rooturl" title="根URL" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="async"/>
</td>
            <td><htm:checkbox name="async" title="是否异步树" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="imgpath"/>
</td>
            <td><htm:text name="imgpath" title="图标路径" datatype="STRING" width="200"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="target"/>
</td>
            <td><htm:select name="target" title="运行目标" dictid="treetarget" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="runurl"/>
</td>
            <td><htm:checkbox name="runurl" title="运行首个URL请求" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="expandall"/>
</td>
            <td><htm:checkbox name="expandall" title="展开所有节点" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="tree.cmd?$ACTION=list" args="system,module,$TABLE" target="_self"/>
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

