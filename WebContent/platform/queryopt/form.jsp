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
            <td class="caption" style="width: 150px"><htm:title name="id"/>
</td>
            <td><htm:text name="id" title="条件号" datatype="STRING" format="CODE" required="true" width="400" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="title"/>
</td>
            <td><htm:text name="title" title="条件名称" datatype="STRING" required="true" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="field"/>
</td>
            <td><htm:select name="field" title="表格列" required="true" dictid="gridcolumn" parents="system,module,grid" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="type"/>
</td>
            <td><htm:select name="type" title="条件类型" required="true" dictid="optype" onchange="refreshField('dictid')"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="alias"/>
</td>
            <td><htm:text name="alias" title="别名" datatype="STRING" width="300"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="option"/>
</td>
            <td><htm:select name="option" title="条件" required="true" dictid="clause"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="isql"/>
</td>
            <td><htm:text name="isql" title="指定查询条件" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="required"/>
</td>
            <td><htm:radio name="required" title="是否必填" dictid="clausetype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="value"/>
</td>
            <td><htm:text name="value" title="默认值" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="display"/>
</td>
            <td><htm:select name="display" title="显示方式" dictid="clauseshowtype" onchange="refreshField('dictid')"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="dictid"/>
</td>
            <td><htm:select name="dictid" title="关联域/字典" dictid="subtableoptdict" parents="system,module,type,display" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="parents"/>
</td>
            <td><htm:text name="parents" title="字典条件域" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="url"/>
</td>
            <td><htm:text name="url" title="弹出URL" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="hidefield"/>
</td>
            <td><htm:radio name="hidefield" title="实际值转换" dictid="yesno"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="refreshs"/>
</td>
            <td><htm:text name="refreshs" title="值变更刷新的域" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="width"/>
</td>
            <td><htm:text name="width" title="宽度" datatype="INTEGER"/>
</td>
        </tr>
        <tr>
            <td colspan="2" align="center"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="queryopt.cmd?$ACTION=list" args="system,module,grid,$TABLE" target="_self"/>
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

