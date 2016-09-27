<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="/htm" prefix="htm" %>

<!DOCTYPE html>
<HTML>
<HEAD>
<TITLE>列表</TITLE>
<meta HTTP-EQUIV="Pragma" content="no-cache" /> 
<meta HTTP-EQUIV="Cache-Control" content="no-cache" /> 
<meta HTTP-EQUIV="Expires" content="0">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<META http-equiv=Content-Type content="text/html; charset=UTF-8">

<style>
body{ 
	margin:0px;
	padding:0px;
}
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

<div class="top">
	<a href="#" class="back" id="$BACK" onclick="return onToolbarButtonClick(this);">返回</a>
	<htm:write name="NAVIGATOR"/><span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span>
	<span class="topaction" ><input id="$BUTTON" type="submit" class="topbutton" value="保存"/></span>
</div>
<div style="height:37px;" id="$TOP">
</div>

	<htm:hidden name="gridid"/>
 <htm:hidden name="module"/>
 <htm:hidden name="system"/>
 <htm:hidden name="rowarea"/>
 <htm:hidden name="actionarea"/>
 <htm:hidden name="queryarea"/>
 <htm:hidden name="titlearea"/>

<p class="detail"><span class="caption"><htm:title name="code"/>
 </span><span class="data"><htm:text name="code" title="模板号" datatype="STRING" format="CODE" required="true" maxlength="16" width="256" unbitted="true"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="name"/>
 </span><span class="data"><htm:text name="name" title="模板名" datatype="STRING" required="true" maxlength="32" width="256"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="type"/>
 </span><span class="data"><htm:select name="type" title="类型" required="true" dictid="recordsetstyle" expkey="true"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="style"/>
 </span><span class="data"><htm:text name="style" title="标签扩展属性" datatype="STRING"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="width"/>
 </span><span class="data"><htm:text name="width" title="宽度" datatype="INTEGER" format="INTEGER" maxlength="4" width="256"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="height"/>
 </span><span class="data"><htm:text name="height" title="高度" datatype="INTEGER" format="INTEGER" maxlength="4" width="256"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="maxrows"/>
 </span><span class="data"><htm:text name="maxrows" title="最多显示条数" datatype="INTEGER" format="INTEGER" maxlength="4" width="256"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="pagerows"/>
 </span><span class="data"><htm:text name="pagerows" title="每页记录数" datatype="INTEGER" format="INTEGER" maxlength="4" width="256"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="pagectrl"/>
 </span><span class="data"><htm:select name="pagectrl" title="翻页控制" required="true" dictid="pagecontrol"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="colsnum"/>
 </span><span class="data"><htm:text name="colsnum" title="表格列数" datatype="INTEGER" format="INTEGER" maxlength="32" width="256"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="columns"/>
 </span><span class="data"><htm:checkbox name="columns" title="隐藏列" dictid="visibilecolumns" parents="system,module,gridid"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="showtitle"/>
 </span><span class="data"><htm:checkbox name="showtitle" title="显示标题" dictid="yes"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="showquery"/>
 </span><span class="data"><htm:checkbox name="showquery" title="显示查询区" dictid="yes"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="queryopts"/>
 </span><span class="data"><htm:checkbox name="queryopts" title="隐藏的查询项" dictid="listqueryopts" parents="system,module,gridid"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="showaction"/>
 </span><span class="data"><htm:checkbox name="showaction" title="显示操作区" dictid="yes"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="actions"/>
 </span><span class="data"><htm:checkbox name="actions" title="隐藏的操作" dictid="tableactions" parents="system,module,gridid"/>
 </span></p>
<p class="detail"><span class="caption"><htm:title name="attachtitle"/>
 </span><span class="data"><htm:checkbox name="attachtitle" title="列内容隐藏列标题" dictid="visibilecolumns" parents="system,module,gridid"/>
 </span></p>
<p class="action"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="gridtemplet.cmd?$ACTION=list" args="system,module,gridid" target="_self"/>
</p>

</htm:form>
</BODY>
<script>
function onPageLoad() {
	<htm:write name="VALUEOBJECT" property="$JSONLOAD"/>

	if (typeof(formOnLoad)=="function")
		formOnLoad();

	hideNavigator();
}

function onPageSubmit(obj) {
	<htm:write name="VALUEOBJECT" property="$JSONSUBMIT"/>

	return true;
}
window.onload = onPageLoad;
</script>
</HTML>

