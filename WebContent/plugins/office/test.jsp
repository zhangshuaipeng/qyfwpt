<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" import="java.sql.*,java.util.*" %>
<HTML>
<HEAD>
<TITLE>附件内容在线编辑</TITLE>
<meta http-equiv="content-type" content="text/html;charset=UTF-8">
<SCRIPT LANGUAGE="JavaScript" src="ntkoocx.js"></SCRIPT>
</HEAD>

<script language="JScript">
function redHead(docfile) {
	if (docfile==null)
	{
		return;
	}

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
			alert("Word 模板中不存在名称为：zhengwen的书签！");
			return;
		}
		var bkmkObj = TANGER_OCX_OBJ.ActiveDocument.BookMarks(BookMarkName);	
		var saverange = bkmkObj.Range
		saverange.Paste();
		TANGER_OCX_OBJ.ActiveDocument.Bookmarks.Add(BookMarkName,saverange);
		// 替换所有域内容的书签

		TANGER_OCX_SetMarkModify(true);
	}
	catch(err)
	{
		//alert("错误：" + err.number + ":" + err.description);
	};

}

function addPrint(docfile) {
	if (docfile=="")
	{
		return;
	}
	AddSignFromURL(docfile);
}

function showReservation() {
	TANGER_OCX_OBJ.ActiveDocument.AcceptAllRevisions();
	TANGER_OCX_SetMarkModify(false);
}

function saveToServer() {
	TANGER_OCX_SaveEditToServer();
}



</script>


<BODY onLoad='javascript:TANGER_OCX_OpenDoc("")'>
<center>

<FORM id="myForm" METHOD="POST" ENCTYPE="multipart/form-data" ACTION="uploadedit.jsp">
    <table width="100%" border="0">
      <tr> 
        <td width="31%"> 
        </td>
        <td width="13%"> <div align="left">
            <input name="checkbox" type="checkbox"  onClick="javascript:showReservation()" value="true">
            痕迹清除 

	</div></td>
        <td width="16%"><div align="center">
            <select name="head" onChange="javascript:redHead(this.options[this.selectedIndex].value)">
              <option selected>请选择套红式样</option>
              <option value="head/partmeeting.doc">党委文头红头文件</option>
              <option value="head/part.doc">党委文头</option>
              <option value="head/dongshi.doc">董事会文头</option>
              <option value="head/gonghui.doc">工会文头</option>
              <option value="head/gongshibianhan.doc">公司便函</option>
              <option value="head/gongshiwentou1.doc">公司文头(上行文）</option>
              <option value="head/gongshiwentou2.doc">公司文头(下行文）</option>
              <option value="head/gudong.doc">股东会文头</option>
              <option value="head/jiwei.doc">纪委文头</option>
              <option value="head/tuanwei.doc">团委文头</option>
            </select>
          </div></td>
        <td width="17%"><div align="center">
            <select name="print" onchange="javascript:addPrint(this.options[this.selectedIndex].value)">
              <option selected>请选择发文印章</option>
              <option value="print/danwei.jpg.esp">党委章</option>
              <option value="print/dongshi.jpg.esp">董事会章</option>
              <option value="print/gonghui.jpg.esp">工会章</option>
              <option value="print/gongshixing.jpg.esp">公司新印章</option>
              <option value="print/gudonghui.jpg.esp">股东会章</option>
              <option value="print/jiwei.jpg.esp">纪委章</option>
              <option value="print/tuanwei.jpg.esp">团委章</option>
            </select>
          </div></td>
        <td width="23%"><div align="right">
            <input name="BUTTON" type=BUTTON class="button" onClick="javascript:writeDocumentNo();" value="写文号">
            <input name="BUTTON" type=BUTTON class="button" onClick="javascript:saveToServer();" value="保存到服务器">
            <input name="button" type=button class="button" onClick='javascript:window.close()' value="关闭窗口">
          </div></td>
      </tr>
    </table>
    <style>
button.op{
width:120px;
background-color:#9DC2DB;
border:1px #EEEEEE solid;
cursor: pointer;
}
</style>
<table width=100% height=680 border=1 cellpadding=0 cellspacing=0 style="border:1px #9dc2db solid">
<tr width=100%>
<td valign=top width=100%>		
<object id="TANGER_OCX" classid="clsid:C9BC4DFF-4248-4a3c-8A49-63A7D317F404" 
codebase="OfficeControl.cab#version=4,0,1,0" width="100%" height="100%">
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
		<param name="MakerCaption" value="创恒信软件有限公司">
		<param name="MakerKey" value="6632A46FA0AE03B5044C6120CBD315C6E75DF434">
		<param name="ProductCaption" value="中国出版集团">
		<param name="ProductKey" value="958FF061AE0CF14E19AEF8D75D849E15A77D978A">
		<SPAN STYLE="color:red">不能装载文档控件。请在检查浏览器的选项中检查浏览器的安全设置。</SPAN>
</object>
<script language="JScript" for="TANGER_OCX" event="AfterOpenFromURL(doc)">
	TANGER_OCX_OBJ.ActiveDocument.AcceptAllRevisions();
	TANGER_OCX_SetMarkModify(false);
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

</script>

<script language="JScript">
var i=0;
function bShow()
{
  if(i++%2==0)
  	TANGER_OCX_OBJ.TitleBar = false;
  else
        TANGER_OCX_OBJ.TitleBar = true;
        

}
function TANGER_OCX_SetDocUser(cuser)
{
	with(TANGER_OCX_OBJ.ActiveDocument.Application)
	{
		UserName = cuser;
	}	
}

function writeDocumentNo() {
	TANGER_OCX_OBJ.ActiveDocument.Bookmarks("documentid").Range.Text = "石电8";
}
</script>

</td>
</tr></table>	
</FORM>
</center>
</BODY>
</HTML>

