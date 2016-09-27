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
 <htm:hidden name="orgcode" defaultv="{ORGCODE}"/>
 <htm:hidden name="deptcode"/>
 <htm:hidden name="parentcode"/>
 <htm:hidden name="timeslice" defaultv="{TIMESLICE}"/>
 <htm:hidden name="sn"/>
 <htm:hidden name="deptseq"/>
 <htm:hidden name="modifytime"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="岗位号" datatype="STRING" format="CODE" required="true" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="岗位名称" datatype="STRING" required="true" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="personnum"/>
</td>
            <td><htm:text name="personnum" title="岗位人数" datatype="INTEGER" required="true" maxlength="22" width="176"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="status"/>
</td>
            <td><htm:select name="status" title="状态" required="true" dictid="status"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="jobcode"/>
</td>
            <td><htm:select name="jobcode" title="职务" required="true" dictid="position" parents="orgcode"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="jobrank"/>
</td>
            <td><htm:select name="jobrank" title="职等" required="true" width="128" dictid="jobgrade"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="jobgrade"/>
</td>
            <td><htm:select name="jobgrade" title="职级" required="true" width="128" dictid="joblevel"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="notes"/>
</td>
            <td><htm:text name="notes" title="岗位说明" datatype="STRING" maxlength="255" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="descr"/>
</td>
            <td><htm:textarea name="descr" title="岗位说明书" datatype="STRING" maxlength="4000"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="position.cmd?$ACTION=list" target="_self"/>
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

