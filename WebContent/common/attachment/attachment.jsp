<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<html>
<head>
<title>文件上传</title>
<meta HTTP-EQUIV="Pragma" content="no-cache" /> 
<meta HTTP-EQUIV="Cache-Control" content="no-cache" /> 
<meta HTTP-EQUIV="Expires" content="0">
<META http-equiv=Content-Type content="text/html; charset=UTF-8">
<style media=print>
	.Noprint{display:none;}
</style>
<style>
body div {font-size:12px;}
.progressbar  {
	background:none repeat scroll 0 0 #FFFFFF;
	border:1px solid #CCCCCC;
	height:10px;
	overflow:hidden;
	position:relative;
	width:92px;
	margin-top:2px;
}
.progressbar span {
	background-image:url("progress.gif");
	background-repeat:repeat-x;
	border:1px solid #FFFFFF;
	font-size:0;
	height:8px;
	left:0;
	position:absolute;
	top:0;
}

.text {
	margin-left:8px;
}

a.files {
	width:70px;
	height:18px;
	overflow:hidden;
	display:block;
	border:0px solid #BEBEBE;
	background:url("btnselect.gif") left top no-repeat;
	text-decoration:none;
}
a.files:hover {
	background-color:#FFFFEE;
	background-position:0 -18px;
}

a.files input {
	margin-left:-150px;
	font-size:13px;
	cursor:pointer;
	filter:progid:DXImageTransform.Microsoft.Alpha(opacity=0);
	opacity:0;
}

a.files, a.files input {
	outline:none;
	hide-focus:expression(this.hideFocus=true);
}
</style> 

<script language="javascript" src="attachment.js"></script>

<script language="javascript">

function onLoad() {
	// 取附件操作权限
	var field = document.getElementById("field");
	field = parent.document.getElementById(field.value);
	var upload = new AttachUpload(document.getElementById('files_list'),field.getAttribute("filetype"),field.getAttribute("maxcount"));
	upload.addElement(document.getElementById('file_0'));
	upload.setAttachField(field);
	upload.init();

	// 显示初始附件
	upload.loadAttach(field.value);
	var height = document.body.scrollHeight;
	if (height<=20)
		height = 20;
	if (window.frameElement && field.getAttribute("isimage")!="true")
		window.frameElement.style.height = height + "px";
	var img = document.getElementById("imga");
	img.style.width = field.getAttribute("imgwidth");
	img.style.height = field.getAttribute("imgheight");
}

function onResize() {
	var field = document.getElementById("field");
	field = parent.document.getElementById(field.value);
	if (field.getAttribute("isimage")=="true") return;
	
	if (window.frameElement)
		window.frameElement.style.height = document.body.scrollHeight + "px";
}

</script>
</head>

<body onload="onLoad();" margin="0px" padding="0px" style="overflow:hidden;">
	<input type="hidden" id="field" value="<%=request.getParameter("field")%>">
	<iframe id="frupload" name="frupload" height="0" width="0" frameborder="0" style="display:none;"></iframe>  
	<img id="imga" name="imga" style="display:none;" onload="onResize();">
	<table width="100%" border="0" cellspacing="0" cellpadding="0" id="attachsarea">
	  <tr>
		<td width="99%">
			<div id="files_list" style="padding-top:5px;"></div>
		</td>
		<td id="btnFile">
		  <a class="files" href="javascript:void(0);">
			<input id="file_0" type="file" name="file_0" class="Noprint">
		  </a>
		</td>
	  </tr>
	</table>
</body>
</html>