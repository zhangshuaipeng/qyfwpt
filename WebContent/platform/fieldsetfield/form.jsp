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
<htm:hidden name="page"/>
<htm:hidden name="fieldset"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width: 150px;" class="caption"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="域号" datatype="STRING" format="CODE" required="true" maxlength="32" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="域名称" datatype="STRING" required="true" width="400"/>
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
            <td><htm:select name="format" title="格式" dictid="format"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="required"/>
</td>
            <td><htm:radio name="required" title="是否必填" dictid="yesno"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="alias"/>
</td>
            <td><htm:text name="alias" title="别名" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="ctrltype"/>
</td>
            <td><htm:select name="ctrltype" title="域类型" required="true" dictid="fieldtype" expkey="true" onchange="refreshField('dict');"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="length"/>
</td>
            <td><htm:text name="length" title="长度" datatype="INTEGER" format="INTEGER"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="width"/>
</td>
            <td><htm:text name="width" title="宽度" datatype="INTEGER" maxlength="4"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="height"/>
</td>
            <td><htm:text name="height" title="高度" datatype="INTEGER" maxlength="4"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="precision"/>
</td>
            <td><htm:text name="precision" title="小数位" datatype="INTEGER" maxlength="2"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="defaults"/>
</td>
            <td><htm:text name="defaults" title="默认值" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="maxvalue"/>
</td>
            <td><htm:text name="maxvalue" title="最大值" datatype="DOUBLE"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="minvalue"/>
</td>
            <td><htm:text name="minvalue" title="最小值" datatype="DOUBLE"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="dict"/>
</td>
            <td><htm:select name="dict" title="字典" dictid="dyndict" parents="system,module,ctrltype" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="params"/>
</td>
            <td><htm:text name="params" title="字典参数域" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="expkey"/>
</td>
            <td><htm:radio name="expkey" title="显示字典键号" dictid="yesno"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="linkset"/>
</td>
            <td><htm:select name="linkset" title="关联域集合" dictid="fieldsets"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="linkfield"/>
</td>
            <td><htm:select name="linkfield" title="关联域" dictid="mainpagefield" parents="system,module,page" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="rostyle"/>
</td>
            <td><htm:text name="rostyle" title="只读时式样" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="unbitted"/>
</td>
            <td><htm:radio name="unbitted" title="不受限访问" dictid="yesno"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onblur"/>
</td>
            <td><htm:text name="onblur" title="onblur" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onchange"/>
</td>
            <td><htm:text name="onchange" title="onchange" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onclick"/>
</td>
            <td><htm:text name="onclick" title="onclick" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="ondblclick"/>
</td>
            <td><htm:text name="ondblclick" title="ondblclick" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onfocus"/>
</td>
            <td><htm:text name="onfocus" title="onfocus" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onkeydown"/>
</td>
            <td><htm:text name="onkeydown" title="onkeydown" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onkeypress"/>
</td>
            <td><htm:text name="onkeypress" title="onkeypress" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onkeyup"/>
</td>
            <td><htm:text name="onkeyup" title="onkeyup" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onmousedown"/>
</td>
            <td><htm:text name="onmousedown" title="onmousedown" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onmousemove"/>
</td>
            <td><htm:text name="onmousemove" title="onmousemove" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onmouseout"/>
</td>
            <td><htm:text name="onmouseout" title="onmouseout" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onmouseover"/>
</td>
            <td><htm:text name="onmouseover" title="onmouseover" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="onmouseup"/>
</td>
            <td><htm:text name="onmouseup" title="onmouseup" datatype="STRING" width="400"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value=" 保存" type="CUSTOM" showtype="BUTTON" icon="save.png" href="save" multi="checkbox" target="_self"/>
<htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" href="update" multi="checkbox" target="_self"/>
<htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" url="fieldset.cmd?$ACTION=list" multi="checkbox" args="system,module,page,$TABLE" target="_self"/>
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

