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
	<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td class="caption" style="width:150px;"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="机构号" datatype="STRING" format="CODE" required="true" maxlength="32" width="256" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="机构名" datatype="STRING" required="true" maxlength="32" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="addr"/>
</td>
            <td><htm:text name="addr" title="地址" datatype="STRING" required="true" maxlength="32"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="status"/>
</td>
            <td><htm:select name="status" title="状态" required="true" dictid="state"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="begin"/>
</td>
            <td><htm:readonly name="begin" title="有效起时" datatype="STRING" maxlength="32" width="256"/>
 <htm:button name="from" value="选择" type="POPUP" showtype="BUTTON" icon="date.gif" display="ICONTEXT" href="DATE" rets="begin" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="end"/>
</td>
            <td><htm:readonly name="end" title="有效止时" datatype="STRING" maxlength="32" width="256"/>
 <htm:button name="to" value="选择" type="POPUP" showtype="BUTTON" icon="date.gif" display="ICONTEXT" href="DATE" rets="end" target="_self"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="agent"/>
</td>
            <td><htm:text name="agent" title="联系人" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="telephone"/>
</td>
            <td><htm:text name="telephone" title="电话" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="email"/>
</td>
            <td><htm:text name="email" title="邮箱" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="contractid"/>
</td>
            <td><htm:text name="contractid" title="合同号" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="comments"/>
</td>
            <td><htm:textarea name="comments" title="说明" datatype="STRING" maxlength="32"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="organize.cmd?$ACTION=list" target="_self"/>
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

