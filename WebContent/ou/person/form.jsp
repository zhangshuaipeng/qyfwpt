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
	<htm:hidden name="pk" unbitted="true"/>
 <htm:hidden name="pwd" defaultv="123456"/>
 <htm:hidden name="sn"/>
 <htm:hidden name="createtime" defaultv="{NOW}"/>

<table width="100%" cellspacing="0" cellpadding="0" border="1" align="center" class="datatable">
    <tbody>
        <tr>
            <td class="caption" style="width:150px;"><htm:title name="code"/>
</td>
            <td><htm:text name="code" title="人员编码" datatype="STRING" format="CODE" required="true" maxlength="64" width="400" unbitted="true"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="name"/>
</td>
            <td><htm:text name="name" title="姓名" datatype="STRING" required="true" maxlength="128" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="type"/>
</td>
            <td><htm:select name="type" title="类型" required="true" width="256" dictid="persontype"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="orgcode"/>
</td>
            <td><htm:readonly name="orgcode" title="默认组织号" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="ca"/>
</td>
            <td><htm:text name="ca" title="数字证书" datatype="STRING" maxlength="4000" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="langid"/>
</td>
            <td><htm:text name="langid" title="使用的语种" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="status"/>
</td>
            <td><htm:select name="status" title="状态" required="true" dictid="status"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="email"/>
</td>
            <td><htm:text name="email" title="电子邮件" datatype="STRING" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="firstname"/>
</td>
            <td><htm:text name="firstname" title="名" datatype="STRING" maxlength="128" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="lastname"/>
</td>
            <td><htm:text name="lastname" title="姓" datatype="STRING" maxlength="128" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="nickname"/>
</td>
            <td><htm:text name="nickname" title="昵称" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="sextype"/>
</td>
            <td><htm:text name="sextype" title="性别" datatype="STRING" maxlength="1"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="birthday"/>
</td>
            <td><htm:text name="birthday" title="生日" datatype="STRING" maxlength="10"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="idt"/>
</td>
            <td><htm:text name="idt" title="证件类型" datatype="STRING" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="idno"/>
</td>
            <td><htm:text name="idno" title="证件号码" datatype="STRING" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="country"/>
</td>
            <td><htm:text name="country" title="所在国家" datatype="STRING" maxlength="64" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="address"/>
</td>
            <td><htm:text name="address" title="通讯地址" datatype="STRING" maxlength="128" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="postcode"/>
</td>
            <td><htm:text name="postcode" title="邮政编码" datatype="STRING" maxlength="6"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="mphone"/>
</td>
            <td><htm:text name="mphone" title="手机" datatype="STRING" maxlength="16" width="128"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="tel"/>
</td>
            <td><htm:text name="tel" title="电话号码" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="office"/>
</td>
            <td><htm:text name="office" title="办公地点" datatype="STRING" maxlength="128" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="job"/>
</td>
            <td><htm:text name="job" title="职业" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="company"/>
</td>
            <td><htm:text name="company" title="工作单位" datatype="STRING" maxlength="128" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="signtime"/>
</td>
            <td><htm:readonly name="signtime" title="最近登陆时间" datatype="STRING" maxlength="19" width="152"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="signip"/>
</td>
            <td><htm:readonly name="signip" title="最近登陆IP" datatype="STRING" maxlength="32" width="256"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="nextpwdtime"/>
</td>
            <td><htm:readonly name="nextpwdtime" title="下次修改密码时间" datatype="STRING" maxlength="19" width="152"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="pwdtips"/>
</td>
            <td><htm:readonly name="pwdtips" title="密码提问" datatype="STRING" maxlength="255" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="pwdanswer"/>
</td>
            <td><htm:readonly name="pwdanswer" title="密码答案" datatype="STRING" maxlength="128" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="notes"/>
</td>
            <td><htm:text name="notes" title="说明" datatype="STRING" maxlength="255" width="400"/>
</td>
        </tr>
        <tr>
            <td class="caption"><htm:title name="modifytime"/>
</td>
            <td><htm:readonly name="modifytime" title="修改时间" datatype="STRING" maxlength="19" width="152" defaultv="{NOW}"/>
</td>
        </tr>
        <tr>
            <td align="center" colspan="2"><htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="save" target="_self"/>
 <htm:button name="update" value="修改" type="CUSTOM" showtype="BUTTON" icon="update.gif" display="ICONTEXT" href="update" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="person.cmd?$ACTION=list" target="_self"/>
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

