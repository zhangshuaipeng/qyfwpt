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
<SCRIPT src="ou.js" type="text/javascript"></SCRIPT>

<script>
function setSrc(obj) {
   var iframe = document.getElementById("list");
   if (obj.value=="user")
       iframe.src = "acl.cmd?$ACTION=depttree";
   else if (obj.value=="dept")
       iframe.src = "acl.cmd?$ACTION=orgdept";
   else if (obj.value=="list") {
       query();
   }
}
function query() {
   var iframe = document.getElementById("list");
   var name = document.getElementById("name").value;
   var type = document.getElementById("listitem").value;
   var url = "acl.cmd?$ACTION=";
   if (type=="" || type=="user")
      url += "listusers";
   else if (type=="dept")
      url += "listdepts";
   else if (type=="role")
      url += "listroles";
   else if (type=="group")
      url += "listgroups";
   else
      url += "listusers";
   iframe.src = url + "&name=" + name + "&$BOX=radio";
}

</script>

</HEAD>

<BODY style="margin:0px;">
<htm:tabber type="form"/>
<htm:form name="EAPForm" action=""  method="POST"> 
	<table class="datatable" border="1" cellspacing="0" cellpadding="0" width="100%" align="center" style="width: 100%">
    <tbody>
        <tr>
            <td class="caption" style="width: 72px"><htm:title name="type"/>
</td>
            <td style="width: 210px"><htm:radio name="type" title="内容类别" defaultv="user" dictid="rightselect" onclick="setSrc(this);"/>
</td>
            <td><htm:select name="listitem" title="选择列表" defaultv="user" dictid="rightlisttype"/>
<htm:title name="name"/>
<htm:text name="name" title="名称" width="80"/>
<htm:button name="query" value="查询" type="JAVASCRIPT" showtype="BUTTON" icon="queryopt.gif" display="ICONTEXT" url="query();" target="_self"/>
 <htm:hidden name="selectedid"/>
<htm:hidden name="selectedvalue"/>
</td>
        </tr>
        <tr>
            <td colspan="3">
            <table border="0" cellspacing="0" cellpadding="0" align="center" style="width: 100%">
                <tbody>
                    <tr>
                        <td width="60%" style="border-bottom: 0px; border-left: 0px; border-top: 0px; border-right: 0px"><iframe id="list" height="380" border="0" src="acl.cmd?$ACTION=depttree" frameborder="no" width="100%"></iframe></td>
                        <td width="40%" style="border-bottom: #d6d6d6 0px solid; border-left: #d6d6d6 1px solid; border-top: #d6d6d6 0px solid; border-right: #d6d6d6 0px solid"><select id="selected" multiple="multiple" size="24" style="width: 100%; height: 350px"></select> <htm:button name="delete" value="清除" type="JAVASCRIPT" showtype="BUTTON" icon="del.png" display="ICONTEXT" url="delSelected();" target="_self"/>
<htm:button name="selectedusers" value="授权用户" type="JAVASCRIPT" showtype="BUTTON" icon="teamadd.gif" display="ICONTEXT" target="_self"/>
</td>
                    </tr>
                </tbody>
            </table>
            </td>
        </tr>
        <tr>
            <td colspan="3" style="text-align: center">&nbsp;<htm:button name="submit" value="确定" type="JAVASCRIPT" showtype="BUTTON" icon="save.png" display="ICONTEXT" url="submit();" target="_self"/>
<htm:button name="exit" value="返回" type="JAVASCRIPT" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="top.window.getDialog(window).close();" target="_self"/>
</td>
        </tr>
    </tbody>
</table>
<htm:hidden name="$SYSTEM"/>
<htm:hidden name="$MODULE"/>
<htm:hidden name="$ACTION"/>
<htm:hidden name="$BOX"/>
<htm:hidden name="$TABLE"/>
<htm:hidden name="$MESSAGE"/>
<htm:hidden name="$MOBILE"/>
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


