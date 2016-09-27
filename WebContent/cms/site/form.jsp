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
<script>

function switchButton() {
    var obj =  document.getElementById("sitetype");
    if (!obj.value || obj.value=="O") {
        document.getElementById("seldept").style.display = "none";
        document.getElementById("seluser").style.display = "none";
        return;
    }
    if (obj.value=="D") {
        document.getElementById("seldept").style.display = "";
        document.getElementById("seluser").style.display = "none";
        return;
    }
    if (obj.value=="P") {
        document.getElementById("seldept").style.display = "none";
        document.getElementById("seluser").style.display = "";
        return;
    }
}

function formOnLoad() {
    switchButton();
}
</script>
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
	<htm:hidden name="pk" unbitted="true"/>
 <htm:hidden name="orgcode" defaultv="{ORGCODE}"/>
 <htm:hidden name="ownerid"/>
 <htm:hidden name="admid"/>
 <htm:hidden name="remarkadmid"/>
 <htm:hidden name="creatime"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="站点号" datatype="STRING" format="CODE" required="true" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="站点名" datatype="STRING" required="true" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="sitetype"/>
</td>
            <td><htm:select name="sitetype" title="站点类型" dictid="sitetype" onchange="switchButton();"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="ownername"/>
</td>
            <td><htm:readonly name="ownername" title="所有者名" datatype="STRING" maxlength="64" width="256"/>
 <htm:button name="seldept" value="选择部门" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="DEPT" multi="radio" rets="ownerid,ownername" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="lanaddr"/>
</td>
            <td><htm:text name="lanaddr" title="内网访问地址" datatype="STRING" required="true" maxlength="64"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="internetaddr"/>
</td>
            <td><htm:text name="internetaddr" title="外网访问地址" datatype="STRING" maxlength="64"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="sitepath"/>
</td>
            <td><htm:text name="sitepath" title="存储目录" datatype="STRING" required="true" maxlength="128"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="queryaddr"/>
</td>
            <td><htm:text name="queryaddr" title="动态信息服务地址" datatype="STRING" required="true" maxlength="64"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="admname"/>
</td>
            <td><htm:readonly name="admname" title="管理员名" datatype="STRING" required="true" maxlength="64" width="256"/>
 <htm:button name="seladm" value="选择管理员" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="USER" multi="radio" rets="admid,admname" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="remarkadm"/>
</td>
            <td><htm:readonly name="remarkadm" title="评论管理员" datatype="STRING" maxlength="64" width="256"/>
 <htm:button name="selremark" value="选择评论管理员" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="USER" multi="radio" rets="remarkadmid,remarkadm" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="sitespace"/>
</td>
            <td><htm:text name="sitespace" title="网站空间" datatype="INTEGER" format="INTEGER" maxlength="22" width="176"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="invalidate"/>
</td>
            <td><htm:readonly name="invalidate" title="有效截止日期" datatype="STRING" maxlength="19" width="152"/>
 <htm:button name="seldate" value="选择日期" type="POPUP" showtype="BUTTON" icon="clock.gif" display="ICONTEXT" href="DATETIME" rets="invalidate" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="notes"/>
</td>
            <td><htm:textarea name="notes" title="说明" datatype="STRING" maxlength="255"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save1.gif" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="site.cmd?$ACTION=list" target="_self"/>
 <htm:button name="seluser" value="选择人员" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="USER" multi="radio" rets="ownerid,ownername" target="_self"/>
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

