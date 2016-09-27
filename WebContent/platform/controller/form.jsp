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
<div class="formarea" style="width:100%px;">
  <div>
	<div class="formhead">
	<span id="$MESSAGE" style="color:red;float:right;line-height:27px;"></span><htm:write name="NAVIGATOR"/>
	</div>
	<div class="formbody">
	<htm:hidden name="system"/>
 <htm:hidden name="module"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td style="width:150px;" class="caption"><htm:title name="action"/>
</td>
            <td><htm:text name="action" title="请求" datatype="STRING" format="CODE" required="true" maxlength="32" width="168" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="请求名称" datatype="STRING" required="true" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="roles"/>
</td>
            <td><htm:checkbox name="roles" title="授权角色" required="true" dictid="role" parents="system"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="importpage"/>
</td>
            <td><htm:select name="importpage" title="提交页面" dictid="templet" parents="system,module" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="exportpage"/>
</td>
            <td><htm:select name="exportpage" title="返回页面" dictid="templet" parents="system,module" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="backpoint"/>
</td>
            <td><htm:checkbox name="backpoint" title="移动端返回点" width="344" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="mobilepage"/>
</td>
            <td><htm:select name="mobilepage" title="移动端的返回页面" dictid="templet" parents="system,module" expkey="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="encode"/>
</td>
            <td><htm:checkbox name="encode" title="请求参数编码转换" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="submitfields"/>
</td>
            <td><htm:text name="submitfields" title="操作的域" datatype="STRING" maxlength="32"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="params"/>
</td>
            <td><htm:text name="params" title="参数" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="mode"/>
</td>
            <td><htm:select name="mode" title="请求交互模式" required="true" dictid="requestmode"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="rets"/>
</td>
            <td><htm:text name="rets" title="返回到表单的域" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="reloads"/>
</td>
            <td><htm:text name="reloads" title="需要重载的域" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="jsonsubmit"/>
</td>
            <td><htm:textarea name="jsonsubmit" title="提交前运行的页面JS" datatype="STRING" height="300"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="message"/>
</td>
            <td><htm:text name="message" title="处理成功提示" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="alert"/>
</td>
            <td><htm:checkbox name="alert" title="弹出AJAX执行结果" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="jsonload"/>
</td>
            <td><htm:textarea name="jsonload" title="请求完成运行的JS" datatype="STRING" height="300"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="display"/>
</td>
            <td><htm:textarea name="display" title="显示预控制脚本" datatype="STRING" height="200"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="enabletransact"/>
</td>
            <td><htm:checkbox name="enabletransact" title="开启容器事务" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="enabletab"/>
</td>
            <td><htm:checkbox name="enabletab" title="页签显示" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="enablelog"/>
</td>
            <td><htm:checkbox name="enablelog" title="开启日志记录" dictid="yes"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="moreurl"/>
</td>
            <td><htm:text name="moreurl" title="portlet更多URL" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="vrolebiz"/>
</td>
            <td><htm:select name="vrolebiz" title="载入动态角色业务处理项" dictid="business" parents="system,module"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="vroleparam"/>
</td>
            <td><htm:text name="vroleparam" title="载入动态角色处理参数" datatype="STRING"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.gif" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="controller.cmd?$ACTION=list" args="system,module,$TABLE" target="_self"/>
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

