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
<div class="formarea" style="width:720px;">
  <div>
	<div class="formhead"><htm:write name="NAVIGATOR"/>
	<span id="$MESSAGE" style="color:red;float:right;"></span>
	</div>
	<div class="formbody">
	<htm:hidden name="system"/>
<htm:hidden name="module"/>

<table border="1" align="center" width="100%" cellspacing="0" cellpadding="0" class="datatable">
    <tbody>
        <tr>
            <td class="caption" style="width: 150px;"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="操作号" datatype="STRING" format="CODE" required="true" maxlength="32" width="250" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="操作名" datatype="STRING" required="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="operand"/>
</td>
            <td><htm:select name="operand" title="操作" required="true" dictid="dboperand" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="dsn"/>
</td>
            <td><htm:select name="dsn" title="数据源" dictid="dsn" expkey="true" onchange="refreshField('table');"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="table"/>
</td>
            <td><htm:select name="table" title="表" dictid="dbtables" parents="dsn" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="sql"/>
</td>
            <td><htm:textarea name="sql" title="SQL语句" datatype="STRING" height="200"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="params"/>
</td>
            <td><htm:text name="params" title="自定义参数" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="fields"/>
</td>
            <td><htm:text name="fields" title="操作的字段" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="save" target="_self"/>
<htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
<htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="dboperand.cmd?$ACTION=list" args="system,module,$TABLE" target="_self"/>
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

function onPageSubmit() {
	<htm:write name="VALUEOBJECT" property="$JSONSUBMIT"/>

	return true;
}
window.onload = onPageLoad;
</script>
</HTML>

