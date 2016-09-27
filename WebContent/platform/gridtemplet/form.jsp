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
<htm:hidden name="$MOBILE"/>
<div class="formarea" style="width:100%px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="system"/>
 <htm:hidden name="module"/>
 <htm:hidden name="gridid"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td class="caption" style="width:150px;"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="模板号" datatype="STRING" format="CODE" required="true" maxlength="16" width="256" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="模板名" datatype="STRING" required="true" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="mode"/>
</td>
            <td><htm:radio name="mode" title="运行模式" required="true" dictid="gridtempletmode"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="type"/>
</td>
            <td><htm:select name="type" title="类型" required="true" dictid="recordsetstyle" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="style"/>
</td>
            <td><htm:text name="style" title="标签扩展属性" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="width"/>
</td>
            <td><htm:text name="width" title="宽度" datatype="INTEGER" format="INTEGER" maxlength="4" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="height"/>
</td>
            <td><htm:text name="height" title="高度" datatype="INTEGER" format="INTEGER" maxlength="4" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="maxrows"/>
</td>
            <td><htm:text name="maxrows" title="最多显示条数" datatype="INTEGER" format="INTEGER" maxlength="4" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="pagerows"/>
</td>
            <td><htm:text name="pagerows" title="每页记录数" datatype="INTEGER" format="INTEGER" maxlength="4" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="pagectrl"/>
</td>
            <td><htm:select name="pagectrl" title="翻页控制" required="true" dictid="pagecontrol"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="colsnum"/>
</td>
            <td><htm:text name="colsnum" title="表格列数" datatype="INTEGER" format="INTEGER" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="columns"/>
</td>
            <td><htm:checkbox name="columns" title="隐藏列" dictid="visibilecolumns" parents="system,module,gridid"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="showtitle"/>
</td>
            <td><htm:checkbox name="showtitle" title="显示标题" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="titlearea"/>
</td>
            <td><htm:textarea name="titlearea" title="标题模板" datatype="STRING" height="200"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="showquery"/>
</td>
            <td><htm:checkbox name="showquery" title="显示查询区" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="queryopts"/>
</td>
            <td><htm:checkbox name="queryopts" title="隐藏的查询项" dictid="listqueryopts" parents="system,module,gridid"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="queryarea"/>
</td>
            <td><htm:textarea name="queryarea" title="查询区模板" datatype="STRING" height="200"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="showaction"/>
</td>
            <td><htm:checkbox name="showaction" title="显示操作区" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="actions"/>
</td>
            <td><htm:checkbox name="actions" title="隐藏的操作" dictid="tableactions" parents="system,module,gridid"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="actionarea"/>
</td>
            <td><htm:textarea name="actionarea" title="操作区模板" datatype="STRING" height="200"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="attachtitle"/>
</td>
            <td><htm:checkbox name="attachtitle" title="列内容隐藏列标题" dictid="visibilecolumns" parents="system,module,gridid"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="rowarea"/>
</td>
            <td><htm:textarea name="rowarea" title="数据行模板" datatype="STRING" height="200"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="gridtemplet.cmd?$ACTION=list" args="system,module,gridid" target="_self"/>
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

