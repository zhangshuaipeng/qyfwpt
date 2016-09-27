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
	<htm:hidden name="pk"/>
 <htm:hidden name="orgcode" defaultv="{ORGCODE}"/>
 <htm:hidden name="sysname"/>
 <htm:hidden name="formname"/>
 <htm:hidden name="sn"/>
 <htm:hidden name="startupid"/>
 <htm:hidden name="admid"/>
 <htm:hidden name="readerid"/>

<table class="datatable" border="1" cellspacing="0" cellpadding="0" width="100%" align="center">
    <tbody>
        <tr>
            <td class="caption" style="width: 150px"><htm:title name="flowcode"/>
</td>
            <td><htm:text name="flowcode" title="流程号" datatype="STRING" required="true" maxlength="32" width="256" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="flowname"/>
</td>
            <td><htm:text name="flowname" title="流程名称" datatype="STRING" required="true" maxlength="64"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="type"/>
</td>
            <td><htm:select name="type" title="类别" required="true" width="128" dictid="flowtype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="systemid"/>
</td>
            <td><htm:select name="systemid" title="表单所在系统" required="true" dictid="system" onchange="setValueToField(this,'sysname');refreshField('formid');"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="formid"/>
</td>
            <td><htm:select name="formid" title="表单的模块" required="true" dictid="form" parents="systemid:system" onchange="setValueToField(this,'formname');"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="formver"/>
</td>
            <td><htm:readonly name="formver" title="表单版本" datatype="INTEGER" maxlength="22" width="176"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="icon"/>
</td>
            <td><htm:select name="icon" title="图标" dictid="ICON"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="timelimit"/>
</td>
            <td><htm:text name="timelimit" title="时限" datatype="STRING" maxlength="16" width="128"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="attach"/>
</td>
            <td><htm:checkbox name="attach" title="是否带正文" required="true" defaultv="Y" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="status"/>
</td>
            <td><htm:select name="status" title="流程状态" required="true" defaultv="A" dictid="status"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="ver"/>
</td>
            <td><htm:readonly name="ver" title="当前发布版本" datatype="INTEGER" required="true" maxlength="22" width="176" defaultv="0"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="starttime"/>
</td>
            <td><htm:readonly name="starttime" title="生效起时" datatype="STRING" required="true" maxlength="19" width="148"/>
 <htm:button name="selectstartdata" value="选择" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="DATETIME" rets="starttime" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="endtime"/>
</td>
            <td><htm:readonly name="endtime" title="截止时间" datatype="STRING" required="true" maxlength="19" width="148"/>
 <htm:button name="selectenddate" value="选择" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="DATETIME" rets="endtime" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="startupname"/>
</td>
            <td><htm:readonly name="startupname" title="启动者" datatype="STRING" maxlength="512" width="400"/>
 <htm:button name="selectstartup" value="选择" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="RIGHT" rets="startupid,startupname" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="admname"/>
</td>
            <td><htm:readonly name="admname" title="管理者" datatype="STRING" required="true" maxlength="512" width="400"/>
 <htm:button name="selectadm" value="选择" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="RIGHT" rets="admid,admname" target="_self" width="700" height="500"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="readername"/>
</td>
            <td><htm:readonly name="readername" title="读者" datatype="STRING" maxlength="512" width="400"/>
 <htm:button name="selectreader" value="选择" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="RIGHT" rets="readerid,readername" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="notes"/>
</td>
            <td><htm:text name="notes" title="流程备注" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="defaulttitle"/>
</td>
            <td><htm:text name="defaulttitle" title="默认标题" datatype="STRING" maxlength="128"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="enablenav"/>
</td>
            <td><htm:radio name="enablenav" title="导航引导启动" required="true" dictid="yesno"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="msgmode"/>
</td>
            <td><htm:checkbox name="msgmode" title="默认通知方式" dictid="msgtype"/>
</td>
        </tr>
        <tr>
            <td colspan="2" align="center"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="studio.cmd?$ACTION=list" args="$TABLE" target="_self"/>
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

