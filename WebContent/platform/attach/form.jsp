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

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td class="caption" style="width:150px;"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="附件定义号" datatype="STRING" format="CODE" required="true" maxlength="32" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="附件定义名" datatype="STRING" required="true" maxlength="32"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="attachtype"/>
</td>
            <td><htm:select name="attachtype" title="附件类型" dictid="attachtype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="isimage"/>
</td>
            <td><htm:checkbox name="isimage" title="是否图片附件" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="maxsize"/>
</td>
            <td><htm:text name="maxsize" title="最大尺寸" datatype="INTEGER" format="INTEGER" maxlength="32"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="maxcount"/>
</td>
            <td><htm:text name="maxcount" title="最大附件个数" datatype="INTEGER" format="INTEGER" maxlength="32"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="index"/>
</td>
            <td><htm:checkbox name="index" title="全文检索索引" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="savepath"/>
</td>
            <td><htm:text name="savepath" title="附件保存目录" datatype="STRING" maxlength="128"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="encrypt"/>
</td>
            <td><htm:checkbox name="encrypt" title="是否加密" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="filetype"/>
</td>
            <td><htm:text name="filetype" title="允许上传的文件类型" datatype="STRING" maxlength="64"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="righttype"/>
</td>
            <td><htm:select name="righttype" title="下载授权类型" dictid="right"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="rights"/>
</td>
            <td><htm:text name="rights" title="授权内容" datatype="STRING" maxlength="32"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="readnum"/>
</td>
            <td><htm:checkbox name="readnum" title="是否进行下载计数" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="dsn"/>
</td>
            <td><htm:select name="dsn" title="主数据的数据源" dictid="dsn"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="table"/>
</td>
            <td><htm:select name="table" title="主数据的数据库表" dictid="dbtables"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="attach.cmd?$ACTION=list" target="_self"/>
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

