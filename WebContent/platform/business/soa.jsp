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
<div class="formarea" style="width:720px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="type" defaultv="soa"/>
 <htm:hidden name="operand"/>
 <htm:hidden name="script"/>
 <htm:hidden name="lastwriter"/>
 <htm:hidden name="modifytime"/>
 <htm:hidden name="system"/>
 <htm:hidden name="module"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="业务号" datatype="STRING" format="CODE" required="true" maxlength="32" width="256" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="业务名" datatype="STRING" required="true" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="catalog"/>
</td>
            <td><htm:text name="catalog" title="服务地址uri" datatype="STRING" required="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="item"/>
</td>
            <td><htm:text name="item" title="服务名称" datatype="STRING" required="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="params"/>
</td>
            <td><htm:text name="params" title="调用参数" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="metadata"/>
</td>
            <td><htm:select name="metadata" title="元数据" dictid="metadata"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="scope"/>
</td>
            <td><htm:text name="scope" title="操作域" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="biztype"/>
</td>
            <td><htm:select name="biztype" title="业务类别" required="true" dictid="biztype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onbefore"/>
</td>
            <td><htm:text name="onbefore" title="前置规则" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onafter"/>
</td>
            <td><htm:text name="onafter" title="后置规则" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="remark"/>
</td>
            <td><htm:text name="remark" title="说明" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="savesoa" target="_self"/>
 <htm:button name="update1" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="updatesoa" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="business.cmd?$ACTION=listsoa" target="_self"/>
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

