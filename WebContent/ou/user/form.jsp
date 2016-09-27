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
<div class="formarea" style="width:720px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="pk"/>
 <htm:hidden name="orgcode"/>
 <htm:hidden name="deptcode"/>
 <htm:hidden name="timeslice" defaultv="{TIMESLICE}"/>
 <htm:hidden name="sn" defaultv="1"/>
 <htm:hidden name="personcode"/>
 <htm:hidden name="logintime"/>
 <htm:hidden name="modifytime"/>

<table class="datatable" border="1" cellspacing="0" cellpadding="0" width="100%" align="center">
    <tbody>
        <tr>
            <td class="caption" style="width: 150px"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="编码" datatype="STRING" format="CODE" required="true" maxlength="64" width="400" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="名称" datatype="STRING" required="true" maxlength="128" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="rank"/>
</td>
            <td><htm:select name="rank" title="职务" required="true" dictid="rank"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="employeeno"/>
</td>
            <td><htm:text name="employeeno" title="工号" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="welcomepage"/>
</td>
            <td><htm:text name="welcomepage" title="当前模板" datatype="STRING" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="skinid"/>
</td>
            <td><htm:text name="skinid" title="当前皮肤" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="langid"/>
</td>
            <td><htm:text name="langid" title="默认语种" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="status"/>
</td>
            <td><htm:select name="status" title="状态" required="true" dictid="status"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="type"/>
</td>
            <td><htm:select name="type" title="帐号类型" dictid="accounttype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="personname"/>
</td>
            <td><htm:dictvalue name="personname" title="人员" dictid="person" parents="personcode"/>
 <htm:button name="personselect" value="人员选择" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="URL" url="ou/person.cmd?$ACTION=select" multi="radio" rets="personcode,personname" target="_self" width="670" height="520"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="deptname"/>
</td>
            <td><htm:dictvalue name="deptname" title="部门名称" dictid="dept" parents="deptcode"/>
 <htm:button name="dept" value="部门选择" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="DEPT" multi="radio" rets="deptcode,deptname" target="_self"/>
</td>
        </tr>
        <tr>
            <td colspan="2" align="center"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="user.cmd?$ACTION=list" args="$TABLE" target="_self"/>
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

