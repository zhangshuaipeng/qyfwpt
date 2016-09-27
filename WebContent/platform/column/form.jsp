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
	<htm:hidden name="system"/>
 <htm:hidden name="module"/>
 <htm:hidden name="grid"/>

<table class="datatable" border="1" cellspacing="0" cellpadding="0" width="100%" align="center">
    <tbody>
        <tr>
            <td class="caption" style="width: 150px"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="列号" datatype="STRING" format="CODE" required="true" maxlength="32" width="200" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="title"/>
</td>
            <td><htm:text name="title" title="列名" datatype="STRING" required="true" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="showtype"/>
</td>
            <td><htm:select name="showtype" title="显示类型" required="true" dictid="showtype" onchange="refreshField('dictid')"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="showspec"/>
</td>
            <td><htm:select name="showspec" title="显示转换格式" dictid="showspec"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="boxvalue"/>
</td>
            <td><htm:checkbox name="boxvalue" title="输出为记录号" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="isnotnull"/>
</td>
            <td><htm:checkbox name="isnotnull" title="必填项" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="datatype"/>
</td>
            <td><htm:select name="datatype" title="数据类型" dictid="datatype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="format"/>
</td>
            <td><htm:select name="format" title="数据格式" dictid="format"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="align"/>
</td>
            <td><htm:select name="align" title="对齐" dictid="align"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="width"/>
</td>
            <td><htm:text name="width" title="列宽" datatype="STRING" format="INTEGER" maxlength="4" width="200"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="ptitle"/>
</td>
            <td><htm:text name="ptitle" title="父标题" datatype="STRING" width="200"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="actionid"/>
</td>
            <td><htm:select name="actionid" title="绑定的操作" dictid="tabactions" parents="system,module,grid" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="dicttype"/>
</td>
            <td><htm:select name="dicttype" title="字典类型" dictid="dicttype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="dictid"/>
</td>
            <td><htm:select name="dictid" title="字典" dictid="columndict" parents="system,showtype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="linkfields"/>
</td>
            <td><htm:text name="linkfields" title="字典关联域" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="length"/>
</td>
            <td><htm:text name="length" title="长度" datatype="STRING" format="INTEGER" width="200"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="precision"/>
</td>
            <td><htm:text name="precision" title="小数位" datatype="STRING" format="INTEGER" maxlength="2" width="200"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="defaultvalue"/>
</td>
            <td><htm:text name="defaultvalue" title="默认值" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="summary"/>
</td>
            <td><htm:select name="summary" title="汇总方式" dictid="summary"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onchangemethod"/>
</td>
            <td><htm:text name="onchangemethod" title="值变更运行方法" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="tipshtml"/>
</td>
            <td><htm:textarea name="tipshtml" title="弹出提示HTML" datatype="STRING" height="100"/>
</td>
        </tr>
        <tr>
            <td colspan="2" align="center"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="column.cmd?$ACTION=list" args="system,module,grid,$TABLE" target="_self"/>
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

