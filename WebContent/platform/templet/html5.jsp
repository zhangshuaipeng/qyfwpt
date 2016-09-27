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
<SCRIPT src="../js/grid.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/portal.js" type="text/javascript"></SCRIPT>
<script type="text/javascript" src="../plugins/fckeditor/fckeditor.js"></script>
<script Language="JavaScript">
var oFCKeditor = new FCKeditor( 'htmlcode' ) ;

function createEditor() {
	oFCKeditor.BasePath	= '<%=request.getContextPath()%>/plugins/';
	oFCKeditor.Config['system'] = document.forms[0].system.value;
	oFCKeditor.Config['module'] = document.forms[0].module.value;
	oFCKeditor.Config['templet'] = document.forms[0].templet.value;

	oFCKeditor.Config['BaseHref'] = "http://"+document.location.host + '<%=request.getContextPath()%>/' + document.forms[0].system.value;
	oFCKeditor.Config['EditorAreaCSS'] = 'css/main.css';
	oFCKeditor.Config['BasePath'] = "http://"+document.location.host + '<%=request.getContextPath()%>/plugins/fckeditor/';
	oFCKeditor.Config['PagePath'] = '/' + document.forms[0].system.value + "/";
	oFCKeditor.Height	= 600 ;
	oFCKeditor.Value	= document.forms[0].content.value ;
	oFCKeditor.ToolbarSet = 'form' ;
	oFCKeditor.Create() ;
}

function onsaveClick() {
	var oEditor = FCKeditorAPI.GetInstance('htmlcode') ;
	document.forms[0].content.value = oEditor.GetXHTML(true);
	document.forms[0].htmlcode.value = "";
        return true;
}
</script>

</HEAD>

<BODY style="margin:0px;">
<htm:tabber type="form"/>
<htm:form name="EAPForm" action=""  method="POST"> 
	<htm:button name="save" value="保存" type="CUSTOM" showtype="BUTTON" icon="save.png" display="ICONTEXT" href="savehtml5" target="_self"/>
 <htm:button name="exit" value="返回" type="URL" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="templet.cmd?$ACTION=list" args="system,module" target="_self"/>
 <htm:hidden name="system"/>
 <htm:hidden name="module"/>
 <htm:hidden name="templet"/>
 <htm:hidden name="content"/>
 <htm:javascript name="js" value="createEditor();"/>

<htm:hidden name="$SYSTEM"/>
<htm:hidden name="$MODULE"/>
<htm:hidden name="$ACTION"/>
<htm:hidden name="$BOX"/>
<htm:hidden name="$TABLE"/>
<htm:hidden name="$MESSAGE"/>
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


