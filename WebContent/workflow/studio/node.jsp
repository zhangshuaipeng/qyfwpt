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
<div class="formarea" style="width:100%px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="actors"/>
 <htm:hidden name="cc"/>
 <htm:hidden name="routes"/>
 <htm:hidden name="pk"/>
 <htm:hidden name="system"/>
 <htm:hidden name="module"/>

<table class="datatable" border="1" cellspacing="0" cellpadding="0" width="100%" align="center">
    <tbody>
        <tr>
            <td class="caption" style="width: 150px"><htm:title name="nodeid"/>
</td>
            <td><htm:readonly name="nodeid" title="节点号" datatype="STRING" required="true" maxlength="32" width="80"/>
</td>
            <td class="caption" style="width: 150px"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="节点名" datatype="STRING" required="true" maxlength="32"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="type"/>
</td>
            <td><htm:select name="type" title="节点类型" dictid="nodetype" unbitted="true"/>
</td>
            <td class="caption"><htm:title name="multitype"/>
</td>
            <td><htm:select name="multitype" title="多人办理模式" dictid="multitype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="vote"/>
</td>
            <td><htm:text name="vote" title="投票率" datatype="DOUBLE" maxlength="32"/>
</td>
            <td class="caption"><htm:title name="multiadm"/>
</td>
            <td><htm:select name="multiadm" title="节点管理员" dictid="multiadm"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="reader"/>
</td>
            <td><htm:select name="reader" title="工作读者类型" dictid="reader"/>
</td>
            <td class="caption"><htm:title name="enableaid"/>
</td>
            <td><htm:checkbox name="enableaid" title="允许协助" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="enablefree"/>
</td>
            <td><htm:checkbox name="enablefree" title="允许自由流" dictid="yes"/>
</td>
            <td class="caption"><htm:title name="enableagent"/>
</td>
            <td><htm:checkbox name="enableagent" title="允许代办" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="enableredo"/>
</td>
            <td><htm:checkbox name="enableredo" title="允许重办" dictid="yes"/>
</td>
            <td class="caption"><htm:title name="enablechange"/>
</td>
            <td><htm:checkbox name="enablechange" title="允许转送" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="enableuntread"/>
</td>
            <td><htm:checkbox name="enableuntread" title="允许驳回" dictid="yes"/>
</td>
            <td class="caption"><htm:title name="enableurge"/>
</td>
            <td><htm:checkbox name="enableurge" title="允许催办" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="enableabort"/>
</td>
            <td><htm:checkbox name="enableabort" title="允许终止" dictid="yes"/>
</td>
            <td class="caption"><htm:title name="enablegoto"/>
</td>
            <td><htm:checkbox name="enablegoto" title="允许跳转" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="enableaddactor"/>
</td>
            <td><htm:checkbox name="enableaddactor" title="允许加办" dictid="yes"/>
</td>
            <td class="caption"><htm:title name="enablecomment"/>
</td>
            <td><htm:select name="enablecomment" title="意见项" dictid="comment"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="enableasync"/>
</td>
            <td><htm:checkbox name="enableasync" title="允许异步提交" dictid="yes"/>
</td>
            <td class="caption"><htm:title name="enablesupply"/>
</td>
            <td><htm:checkbox name="enablesupply" title="允许补办" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="timelimit"/>
</td>
            <td><htm:text name="timelimit" title="办理时限" datatype="STRING" maxlength="32"/>
</td>
            <td class="caption"><htm:title name="weight"/>
</td>
            <td><htm:text name="weight" title="考核系数" datatype="DOUBLE" maxlength="32"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="notify"/>
</td>
            <td><htm:checkbox name="notify" title="消息通知" dictid="todonotify"/>
</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="msgformat"/>
</td>
            <td colspan="3"><htm:text name="msgformat" title="提示信息" datatype="STRING" maxlength="256" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="actorrule"/>
</td>
            <td><htm:select name="actorrule" title="办理人规则" dictid="rules"/>
</td>
            <td class="caption"><htm:title name="orgcode"/>
</td>
            <td><htm:text name="orgcode" title="绑定组织号" datatype="STRING" maxlength="32"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="actorsname"/>
</td>
            <td><htm:readonly name="actorsname" title="办理人" datatype="STRING" width="80"/>
 <htm:button name="selectactors" value="选择" type="POPUP" showtype="BUTTON" icon="teamadd.gif" display="ICONTEXT" href="RIGHT" rets="actors,actorsname" target="_self"/>
</td>
            <td class="caption"><htm:title name="selectall"/>
</td>
            <td><htm:checkbox name="selectall" title="多办理人选择" dictid="selecttype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="noself"/>
</td>
            <td><htm:checkbox name="noself" title="办理人过滤本人" dictid="yes"/>
</td>
            <td class="caption"><htm:title name="ccname"/>
</td>
            <td><htm:readonly name="ccname" title="抄送人" datatype="STRING" width="80"/>
 <htm:button name="selectcc" value="选择" type="POPUP" showtype="BUTTON" icon="msg1.gif" display="ICONTEXT" href="RIGHT" rets="cc,ccname" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="map"/>
</td>
            <td><htm:checkbox name="map" title="是否执行推处理" dictid="yes"/>
</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="4" align="center"><htm:button name="right" value="表单权限" type="POPUP" showtype="BUTTON" icon="msgsend.gif" display="ICONTEXT" href="URL" url="workflow/studio.cmd?$ACTION=right" args="pk,nodeid" target="_self" width="600" height="480"/>
 <htm:button name="event" value="事件处理" type="POPUP" showtype="BUTTON" icon="date.gif" display="ICONTEXT" href="URL" url="workflow/studio.cmd?$ACTION=listnodeevent" args="pk,nodeid,system,module" target="_self" width="700" height="550"/>
 <htm:button name="policy" value="路由策略" type="POPUP" showtype="BUTTON" icon="add.gif" display="ICONTEXT" href="URL" url="workflow/studio.cmd?$ACTION=policy" args="pk,nodeid,system,module:form" target="_self" width="720" height="480"/>
 <htm:button name="savenode" value="确定" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="savenode" target="_self" callback="top.window.getDialog(window).getParentWindow().flushObjectProp(document.getElementById('name').value);top.window.getDialog(window).close();" ajax="ajax"/>
 <htm:button name="exit" value="返回" type="JAVASCRIPT" showtype="BUTTON" icon="exit.gif" display="ICONTEXT" url="top.window.getDialog(window).close();" target="_self"/>
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

