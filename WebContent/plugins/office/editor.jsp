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
<style>
body {
	margin:0px;
	padding:0px;
}
button {
width:120px;
background-color:#9DC2DB;
border:1px #EEEEEE solid;
cursor: pointer;
}
</style>
<SCRIPT LANGUAGE="JavaScript" src="ntkoocx.js"></SCRIPT>
</HEAD>
<%
	java.util.HashMap<String,String> map = com.siqiansoft.framework.attach.AttachUtil.getAttach(request);
	com.siqiansoft.framework.model.LoginModel login = com.siqiansoft.framework.util.LoginUtil.getLoginObject(request);

	String filename = map.get("SAVEFILE");
%>

<script language="JScript">
var req;
var editable = "<%=request.getParameter("editable")%>";
var attachId = "<%=map.get("PK")%>";
var fileName = "<%=filename%>";
var bMarkModify = true;

function saveToServer() {
	if (!bMarkModify) 
		TANGER_OCX_OBJ.ActiveDocument.AcceptAllRevisions();
	TANGER_OCX_SaveEditToServer();

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


function closeWindow() {
	if (!document.getElementById("btnSave")) return;
	if (document.getElementById("btnSave").disabled) return;

	var url = "../../UploadService?$ACTION=exitoffice&file=" + fileName;
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
	if (req.readyState!=4) return;
	if (req.status!=200) return;
}

function onFormLoad() {
	TANGER_OCX_OpenDoc(attachId);

	// 对各项操作进行显示控制
	if (editable=="false") {
		document.getElementById("btnRemark").style.display = "none";
		document.getElementById("btnSave").style.display = "none";
		return;
	}
}
</script>


<BODY onLoad="onFormLoad();" style="overflow:hidden;" onbeforeunload="closeWindow();">

<FORM id="myForm" METHOD="POST" ENCTYPE="multipart/form-data" ACTION="uploadedit.jsp?id=<%=map.get("PK")%>" style="margin:0px;padding:0px;">
    <table width="100%" border="0">
      <tr> 
        <td ><b>文件名：</b><%=map.get("SOURCEFILE")%> <input type="hidden" id="filename2" name="filename" value="<%= filename %>"> 
        </td>
        <td align="right" nowrap>
            <input name="btnRemark" type="BUTTON" onClick="javascript:DoHandDraw();" value="手写批注">
            <input name="btnSave" id="btnSave" type="BUTTON" onClick="javascript:saveToServer();" value="保存到服务器">

            <input name="button" type="button" onClick='closeWindow();top.window.getDialog(window).close();' value="关闭窗口">
          </td>
      </tr>
    </table>
<table width=100% height=680 border=1 cellpadding=0 cellspacing=0 style="border:1px #9dc2db solid">
<tr width=100%>
<td valign=top width=100%>		
<object id="TANGER_OCX" classid="clsid:C9BC4DFF-4248-4a3c-8A49-63A7D317F404" codebase="OfficeControl.cab#version=5,0,2,1" width="100%" height="98%">
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
<script language="JScript" for="TANGER_OCX" event="AfterOpenFromURL(doc)">
if ("<%=filename%>".toLowerCase().indexOf(".doc")!=-1) {
	TANGER_OCX_SetMarkModify(true);
}
</script>
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
TANGER_OCX_OBJ.FullScreenMode = true;
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

</td>
</tr></table>	
</FORM>
</BODY>
</HTML>

