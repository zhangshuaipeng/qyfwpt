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
<style>

.sidebar { float:left; width:200px; height:95%;border:solid 1px #cccccc;}
* html .sidebar{margin-right:-3px;}/*使用此方法解决ie 3像素bug可通过验证*/
.content { height:95%;float:left;}

</style>

<style type="text/css">
a {font-size:12px;}
img {border:0;}
td.icon {width:24px;height:24px;text-align:center;vertical-align:middle;}
td.sp {width:8px;height:24px;text-align:center;vertical-align:middle;}
td.xz {width:47px;height:24px;text-align:center;vertical-align:middle;}
td.bq {width:49px;height:24px;text-align:center;vertical-align:middle;}
div a.n {height:16px; line-height:16px; display:block; padding:2px; color:#000000; text-decoration:none;}
div a.n:hover {background:#E5E5E5;}
</style>
<style>
#magicface{}
#magicface td{ height:29px; width:29px; background-color:#F8F8F8; text-align:center;}
#magicface td onmouseover{background-Color:#FFcccc;} 
.mf_nowchose{ height:30px; background-color:#DFDFDF;border:1px solid #B5B5B5; border-left:none;}
.mf_other{ height:30px;border-left:1px solid #B5B5B5; }
.mf_otherdiv{ height:30px; width:30px;border:1px solid #FFF; border-right-color:#D6D6D6; border-bottom-color:#D6D6D6; background-color:#F8F8F8;}
.mf_otherdiv2{ height:30px; width:30px;border:1px solid #B5B5B5; border-left:none; border-top:none;}
.mf_link{ font-size:12px; color:#000000; text-decoration:none;}
.mf_link:hover{ font-size:12px; color:#000000; text-decoration:underline;}

</style>
<style type="text/css">
<!--
.ico {	height: 24px;	width: 24px; vertical-align:middle; text-align:center;
}
.ico2 {	height: 24px;	width: 27px; vertical-align:middle; text-align:center;
}
.ico3 {	height: 24px;	width: 25px; vertical-align:middle; text-align:center;
}
.ico4 {	height: 24px;	width: 8px; vertical-align:middle; text-align:center;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
.icons{ width:20px; height:20px; 
      background-image:url(images/mtoolallbg.gif); 
      background-repeat:no-repeat; margin-top:2px
}

.icoCut{ background-position:0 0}
.icoCpy{ background-position:-28px 0}
.icoPse{ background-position:-56px 0}
.icoFfm{ background-position:-82px 0}
.icoFsz{ background-position:-110px 0}
.icoWgt{ background-position:-140px 0}
.icoIta{ background-position:-168px 0}
.icoUln{ background-position:-196px 0}
.icoAgn{ background-position:-224px 0}
.icoLst{ background-position:-252px 0}
.icoLst{ background-position:-252px 0}
.icoOdt{ background-position:-280px 0}
.icoIdt{ background-position:-308px 0}
.icoFcl{ background-position:-335px 0}
.icoBcl{ background-position:-362px 0}
.icoUrl{ background-position:-392px 0}
.icoImg{ background-position:-420px 0}
.icoMfc{ background-position:-447px 0}

</style>
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="editfunc.js"></SCRIPT>
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="colorSelect.js"></SCRIPT>
<SCRIPT LANGUAGE="JAVASCRIPT" SRC="portraitSelect.js"></SCRIPT>
<script>
function formOnLoad() {
     var width = getClientWidth() - 200;
     var height = getClientHeight();

     var contentObj = document.getElementById("jsp");
     contentObj.style.width = (width - 2) + "px";
     contentObj.style.height = (height - 36) + "px";
     var iframe = document.getElementById("HtmlEditor");
     iframe.style.width = (width - 3) + "px";
     iframe.style.height = (height - 36 - 32) + "px";

     iframe.src = "../" + document.getElementById("orgcode").value + "/" + document.getElementById("code").value + ".jsp";

     gLoaded = true;
     fSetEditable();
     fSetFrmClick();
     ResetDomain();
     fSetHtmlContent();
     top.frames["jsFrame"].fHideWaiting();

}

function fontname(obj){
	format('fontname',obj.innerHTML);
	obj.parentNode.style.display='none';
}
function fontsize(size,obj){
	format('fontsize',size);
	obj.parentNode.style.display='none';
}

//LoadContent(Request('id'));

</script>

</HEAD>

<BODY style="margin:0px;">
<htm:form name="EAPForm">
<div class="navbar">
	<span id="$MESSAGE" style="color:red;float:right;"></span>
	<htm:write name="NAVIGATOR"/>	
</div>
<htm:hidden name="$ID"/>
<htm:hidden name="$SYSTEM"/>
<htm:hidden name="$MODULE"/>
<htm:hidden name="$ACTION"/>
<htm:hidden name="$BOX"/>
<htm:hidden name="$TABLE"/>
<div>
	<htm:hidden name="orgcode" defaultv="{ORGCODE}"/>
 <htm:hidden name="code"/>
 <htm:span name="name"/>
 <htm:tree id="tree" name="tree" title="树" dictid="templet" parents="orgcode,code"/>
 <div id="jsp">
<%@ include file="/portal/editor.jsp"%>
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

