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
</HEAD>
<%
	String phase = com.siqiansoft.framework.attach.AttachUtil.getOfficeOcxState(request);  // phase的内容根据表单域officeocxphase的内容来定,该域的可能值为:nomark-不留痕/redhead-套红头/seal-用印/all-所有控制有效,其他值无效
	java.util.HashMap<String,String> map = com.siqiansoft.framework.attach.AttachUtil.getWordTextAttach(request);
	com.siqiansoft.framework.model.LoginModel login = com.siqiansoft.framework.util.LoginUtil.getLoginObject(request);

	String filename = map.get("SAVEFILE");
	
	System.out.println("状态:" + phase);
%>

<SCRIPT LANGUAGE="JavaScript" src="ntkoocx.js"></SCRIPT>
<script language="javascript">
var req;
var timer;
var bMarkModify = true;
var fileName = "<%=filename%>";
var attachId = "<%=map.get("PK")%>";
var editactor = "<%=login.getUserName()%>";
var phase = "<%=phase%>";

function redHead(docfile) {
	if (!docfile)
		return;

	try{
		//选择对象当前文档的所有内容
		var curSel = TANGER_OCX_OBJ.ActiveDocument.Application.Selection;
		TANGER_OCX_SetMarkModify(false);
		curSel.WholeStory();
		curSel.Cut();
		//插入模板
		TANGER_OCX_OBJ.AddTemplateFromURL(docfile);
		var BookMarkName = "zhengwen";
		if(!TANGER_OCX_OBJ.ActiveDocument.BookMarks.Exists(BookMarkName))
		{
			alert("Word 模板中不存在名称为：zhengwen的书签！请在模板中的正文开始处添加一个zhengwen的书签！");
			return;
		}
		var bkmkObj = TANGER_OCX_OBJ.ActiveDocument.BookMarks(BookMarkName);	
		var saverange = bkmkObj.Range
		saverange.Paste();
		TANGER_OCX_OBJ.ActiveDocument.Bookmarks.Add(BookMarkName,saverange);

		var data = <%=com.siqiansoft.framework.attach.AttachUtil.getFormFields(request,phase,"title,senddate,signer")%>;//最后一个参数为要动态输出表单域内容到WORD书签的域号列表
		if (!data)
			return;
		
		// 替换所有域内容的书签
		for (var c in data) {
			if (TANGER_OCX_OBJ.ActiveDocument.BookMarks.Exists(c))
				TANGER_OCX_OBJ.ActiveDocument.Bookmarks(c).Range.Text = data[c];
		}

	}
	catch(err)
	{
		//alert("错误：" + err.number + ":" + err.description);
	};
}

function addPrint(docfile) {
	if (!docfile)
		return;

	AddSignFromURL(docfile);
}

function showReservation() {
	if (fileName.toLowerCase().indexOf(".doc")==-1) return;
	bMarkModify = false;
	TANGER_OCX_OBJ.ActiveDocument.AcceptAllRevisions();
	TANGER_OCX_SetMarkModify(false);
}

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

/* 检查附件状态 */
function checkAttachState() {
	if (!document.getElementById("btnSave")) return;

	var url = "../../UploadService?$ACTION=heartbeat&file=" + fileName;
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
	req.open("GET", url, true);
	req.onreadystatechange = attachCheckResult;
	req.send(null);
}

function attachCheckResult() {
	if (req.readyState!=4) return;
	if (req.status!=200) return;
	var xmlDoc = req.responseXML;
	// 先取欢迎页面
	var state = xmlDoc.getElementsByTagName("result")[0].firstChild.nodeValue;
	if (state=="editable") {
		timer = setTimeout(checkAttachState,60 * 1000);
		return;
	}
	if (state=="readonly") {
		alert("文档正在被其他人编辑，当前文档将无法保存到服务器！");
		document.getElementById("btnSave").disabled = true;
		return;
	}
}

function closeWindow() {
	if (timer)
		clearTimeout(timer);
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
	if (phase=="none") {
		alert("您没有权限访问公文的正文或附件！");
		closeWindow();
		top.window.getDialog(window).close();
		return;
	}
	TANGER_OCX_OpenDoc(attachId);
	// 如果非只读状态,则检查是否有其他人正在使用
	if (phase!="readonly")
		checkAttachState();
	
	// 对各项操作进行显示控制
	if (phase=="readonly") {
		document.getElementById("vestige").style.display = "none";
		document.getElementById("redhead").style.display = "none";
		document.getElementById("stamp").style.display = "none";
		document.getElementById("btnRemark").style.display = "none";
		document.getElementById("btnSave").style.display = "none";
		return;
	}
	if (phase=="nomark") {
		document.getElementById("vestige").style.display = "none";
		document.getElementById("redhead").style.display = "none";
		document.getElementById("stamp").style.display = "none";
		bMarkModify = false;
		return;
	}
	if (phase=="editable") {
		document.getElementById("vestige").style.display = "none";
		document.getElementById("redhead").style.display = "none";
		document.getElementById("stamp").style.display = "none";
		return;
	}
	if (phase=="all") return;
	if (phase=="redhead") {
		document.getElementById("stamp").style.display = "none";
		return;
	}
	if (phase=="") {
		document.getElementById("redhead").style.display = "none";
		return;
	}
}


</script>


<BODY onLoad="onFormLoad();" style="overflow:hidden;margin:0px;padding:0px;" onbeforeunload="closeWindow();">
<FORM id="myForm" METHOD="POST" ENCTYPE="multipart/form-data" ACTION="uploadedit.jsp?id=<%=map.get("PK")%>" style="margin:0px;padding:0px;">
    <table width="100%" border="0">
      <tr> 
        <td ><b>文件名：</b><%=map.get("SOURCEFILE")%> <input type="hidden" id="filename2" name="filename" value="<%=filename%>"> 
        </td>
        <td align="left" nowrap id="vestige">
            <input name="checkbox" type="checkbox"  onClick="javascript:showReservation()" value="true">
            痕迹清除 
		</td>
        <td align="center" id="redhead">
            <select name="head" onChange="redHead(this.options[this.selectedIndex].value);this.blur();">
              <option selected>请选择套红式样</option>
              <option value="head/gongshiwentou1.doc">公司文头(上行文）</option>
            </select>
          </td>
        <td align="center" id="stamp">
            <select name="print" onchange="addPrint(this.options[this.selectedIndex].value);this.blur();">
              <option selected>请选择发文印章</option>
              <option value="print/tuanwei.jpg.esp">团委章</option>
            </select>
          </td>
        <td align="right" nowrap>
            <input name="btnRemark" type="BUTTON" onClick="javascript:DoHandDraw();" value="手写批注">
            <input name="btnSave" id="btnSave" type="BUTTON" onClick="javascript:saveToServer();" value="保存到服务器">

            <input name="button" type="button" onClick='closeWindow();top.window.getDialog(window).close();' value="关闭窗口">
          </td>
      </tr>
    </table>
<table width=100% height=100% border=1 cellpadding=0 cellspacing=0 style="border:1px #9dc2db solid">
<tr width=100%>
<td valign=top width=100%>		
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
<script language="JScript" for="TANGER_OCX" event="AfterOpenFromURL(doc)">

if (fileName.toLowerCase().indexOf(".doc")!=-1) {
	if (bMarkModify) {
		TANGER_OCX_SetMarkModify(true);
	} else {
		TANGER_OCX_OBJ.ActiveDocument.AcceptAllRevisions();
		TANGER_OCX_SetMarkModify(false);
	}
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
TANGER_OCX_SetDocUser(editactor);
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

