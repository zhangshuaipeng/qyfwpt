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
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="pk"/>
 <htm:hidden name="msgtype" defaultv="APP"/>
 <htm:hidden name="wid" defaultv="0"/>
 <htm:hidden name="orgcode" defaultv="{ORGCODE}"/>
 <htm:hidden name="recipient"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="name"/>
</td>
            <td><htm:dictvalue name="name" title="接收人" width="200" dictid="useraccount" parents="recipient"/>
 <htm:button name="select" value="选择" type="POPUP" showtype="BUTTON" icon="add.png" display="ICONTEXT" href="USER" multi="radio" rets="recipient,name" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="content"/>
</td>
            <td><htm:textarea name="content" title="发送内容" datatype="STRING" required="true" maxlength="1024" height="100"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="sender"/>
</td>
            <td><htm:readonly name="sender" title="发送人" datatype="STRING" required="true" maxlength="32" width="256" defaultv="{USERCODE}"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="method"/>
</td>
            <td><htm:select name="method" title="发送方式" required="true" width="128" dictid="msgsendmethod"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="addr"/>
</td>
            <td><htm:readonly name="addr" title="发送地址" datatype="STRING" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="result"/>
</td>
            <td><htm:select name="result" title="发送结果" required="true" defaultv="T" dictid="msgsendresult" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="reasons"/>
</td>
            <td><htm:readonly name="reasons" title="失败原因" datatype="STRING" maxlength="256" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="createtime"/>
</td>
            <td><htm:readonly name="createtime" title="提交时间" datatype="STRING" maxlength="19" width="152" defaultv="{NOW}"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="sendtime"/>
</td>
            <td><htm:readonly name="sendtime" title="发送成功时间" datatype="STRING" maxlength="19" width="152"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="exit" value="返回" type="CLOSE" showtype="BUTTON" icon="exit.gif" display="ICONTEXT" target="_self"/>
 <htm:button name="ret" value="返回" type="URL" showtype="BUTTON" icon="exit.gif" display="ICONTEXT" url="msgqueue.cmd?$ACTION=list" target="_self"/>
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

