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
<div class="formarea" style="width:800px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="manager"/>
 <htm:hidden name="members"/>
 <htm:hidden name="lasttime"/>
 <htm:hidden name="lastuser"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="编号" datatype="STRING" format="CODE" required="true" maxlength="32" width="256" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="名称" datatype="STRING" required="true" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="customer"/>
</td>
            <td><htm:text name="customer" title="客户" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="addr"/>
</td>
            <td><htm:text name="addr" title="访问地址" datatype="STRING" required="true" maxlength="128"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="appdir"/>
</td>
            <td><htm:readonly name="appdir" title="应用目录" datatype="STRING" required="true" maxlength="256" width="520"/>
 <htm:button name="tree" value="目录选择" type="POPUP" showtype="BUTTON" icon="tree.png" display="ICONTEXT" href="URL" url="platform/project.cmd?$ACTION=disktree" rets="appdir" target="_self" width="500" height="550"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="space"/>
</td>
            <td><htm:text name="space" title="可用空间(MB)" datatype="INTEGER" format="INTEGER" maxlength="8" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="managername"/>
</td>
            <td><htm:dictvalue name="managername" title="项目经理" width="256" dictid="account" parents="manager"/>
 <htm:button name="seluser" value="选择" type="POPUP" showtype="BUTTON" icon="teamadd.gif" display="ICONTEXT" href="URL" url="platform/project.cmd?$ACTION=usertree" multi="radio" rets="manager,managername" target="_self" width="420" height="540"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="membersname"/>
</td>
            <td><htm:dictvalue name="membersname" title="项目成员" width="520" dictid="account" parents="members"/>
 <htm:button name="selusers" value="选择" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="URL" url="platform/project.cmd?$ACTION=usertree" multi="checkbox" rets="members,membersname" target="_self" width="420" height="540"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="begin"/>
</td>
            <td><htm:readonly name="begin" title="开始时间" datatype="STRING" required="true" maxlength="10" width="256"/>
 <htm:button name="selbegin" value="选择" type="POPUP" showtype="BUTTON" icon="date.gif" display="ICONTEXT" href="DATE" rets="begin" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="end"/>
</td>
            <td><htm:readonly name="end" title="结束时间" datatype="STRING" maxlength="10" width="256"/>
 <htm:button name="selend" value="选择" type="POPUP" showtype="BUTTON" icon="date.gif" display="ICONTEXT" href="DATE" rets="end" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="finish"/>
</td>
            <td><htm:readonly name="finish" title="完成时间" datatype="STRING" maxlength="10" width="256"/>
 <htm:button name="selfinish" value="选择" type="POPUP" showtype="BUTTON" icon="date.gif" display="ICONTEXT" href="DATE" rets="finish" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="status"/>
</td>
            <td><htm:select name="status" title="状态" required="true" width="128" dictid="projectstate"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="comments"/>
</td>
            <td><htm:textarea name="comments" title="说明" datatype="STRING" height="200"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="project.cmd?$ACTION=list" target="_self"/>
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

