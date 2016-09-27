<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<HTML>
<HEAD>
<TITLE>附件内容在线编辑</TITLE>
<meta http-equiv="content-type" content="text/html;charset=UTF-8">
<meta HTTP-EQUIV="Pragma" content="no-cache" /> 
<meta HTTP-EQUIV="Cache-Control" content="no-cache" /> 
<meta HTTP-EQUIV="Expires" content="0">
<SCRIPT LANGUAGE="JavaScript" src="ntkoocx.js"></SCRIPT>
</HEAD>
<script language="JScript">
var req;
var editable = true;
var attachId;
function onPageLoad() {
	var field = "<%=request.getParameter("field")%>";
	field = parent.document.getElementById(field);
	
	attachId = field.value;   // 附件号
	document.forms[0].action = "uploadedit.jsp?id=" + attachId;
	TANGER_OCX_OpenDoc(attachId);
	var str = field.getAttribute("editable");
	if (!str || str=="false")
		editable = false;
}

function saveToServer() {
	if (editable==false) return;
	if(!TANGER_OCX_bDocOpen)
	{
		alert("没有打开的文档。");
		return;
	}
	
	TANGER_OCX_filename = document.all.item("filename").value;
	if ( (!TANGER_OCX_filename))
	{
		TANGER_OCX_filename ="";
		return;
	}
	else if (strtrim(TANGER_OCX_filename)=="")
	{
		alert("您必须输入文件名！");
		return;
	}

	try
	{
	 	if(!TANGER_OCX_doFormOnSubmit())return;
	
		TANGER_OCX_OBJ.SaveToURL(
			TANGER_OCX_actionURL,
			TANGER_OCX_filename,
			"",
			TANGER_OCX_filename,
			0
			);
	}
	catch(err){
	}
	finally{
	}
	// 将附件设置为已修改状态
	var url = "../../UploadService?$ACTION=modifyoffice&id=" + attachId;;
	url += "&timestamp=" + (new Date()).getTime();
	if (window.XMLHttpRequest) { 
		req = new XMLHttpRequest();
	} else if (window.ActiveXObject) { 
		try {
			req = new ActiveXObject("Msxml2.XMLHTTP");
		} catch (e) {
			req = new ActiveXObject("Microsoft.XMLHTTP");
		}
	}
	req.open("GET", url, false);
	req.onreadystatechange = null;
	req.send(null);

}

</script>
<%
	com.siqiansoft.framework.model.LoginModel login = com.siqiansoft.framework.util.LoginUtil.getLoginObject(request);
	java.util.HashMap<String,String> map = com.siqiansoft.framework.attach.AttachUtil.getAttach(request);
	String filename = map.get("SAVEFILE");
%>

<BODY onLoad="onPageLoad();" style="overflow:hidden;margin:0px;padding:0px;">
<FORM id="officeForm" name="officeForm" METHOD="POST" ENCTYPE="multipart/form-data">
<input type="hidden" id="filename" name="filename" value="<%=filename%>">
<object id="TANGER_OCX" classid="clsid:C9BC4DFF-4248-4a3c-8A49-63A7D317F404" codebase="OfficeControl.cab#version=5,0,2,1" width="100%" height="100%">
        <param name="BorderStyle" value="1">
	 	<param name="BorderColor" value="14402205">        
	 	<param name="TitlebarColor" value="14402205">
        <param name="TitlebarTextColor" value="0">	 
        <param name="Caption" value="痕迹保留组件">
        <param name="MenubarColor" value="14402205">
		<param name="MenuBarStyle" value="3">
		<param name="MenuButtonStyle" value="7">
        <param name="filenew" value="0">
        <param name="IsNoCopy" value="0">
		<param name="ProductCaption" value="北京天竺综合保税区管理委员会">
		<param name="ProductKey" value="62C191D1FEDBE06C901AB5B3365BDC7DAA3FD080">
		<SPAN STYLE="color:red">不能装载文档控件。请在检查浏览器的选项中检查浏览器的安全设置。</SPAN>
</object>
<script language="JScript" for=TANGER_OCX event="OnDocumentClosed()">
TANGER_OCX_OnDocumentClosed()
</script>
<script language="JScript">
	var TANGER_OCX_str;
	var TANGER_OCX_obj;
</script>
<script language="JScript" for=TANGER_OCX event="OnDocumentOpened(TANGER_OCX_str,TANGER_OCX_obj)">
TANGER_OCX_OnDocumentOpened(TANGER_OCX_str,TANGER_OCX_obj)
TANGER_OCX_SetDocUser('<%=login.getUserName()%>');
TANGER_OCX_OBJ.FileSave = false;    // 不允许保存到本地
TANGER_OCX_OBJ.FileSaveAs = false;  // 不允许save as
TANGER_OCX_OBJ.FilePrint = false;   // 不允许打印
TANGER_OCX_OBJ.FilePrintPreview = false;  // 不允许打印预览
TANGER_OCX_OBJ.IsNoCopy = true;   // 不允许拷贝
</script>

<script language="JScript">
function TANGER_OCX_SetDocUser(cuser)
{
	with(TANGER_OCX_OBJ.ActiveDocument.Application)
	{
		UserName = cuser;
	}	
}
</script>
</FORM>
</BODY>
</HTML>