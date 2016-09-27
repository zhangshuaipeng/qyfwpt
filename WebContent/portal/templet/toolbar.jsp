<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="/htm" prefix="htm" %>
<LINK href="../css/xtree.css" type="text/css" rel="stylesheet">
<style>
.CDrag_temp_div {
	border:#CCCCCC 1px dashed;
	margin-top:5px;
	margin-bottom:5px;
}

a#DEL_CDrag, a#ADD_CDrag {
	color:#6699CC;
	text-decoration:none;
}

a#DEL_CDrag:hover, a#ADD_CDrag:hover {
	color:#FF0000;
}
dt {
	cursor: move;
}
</style>
<script src="../js/xtree.js"></script>
<script src="../js/xloadtree.js"></script>
<script src="../js/xmlextras.js"></script>
<script src="../js/common.js"></script>
<script src="../js/toolbar.js"></script>

<div style='z-index:999999;width:200px;left:100px;top:100px;cursor:default;border:1px solid #cccccc;position:absolute;font-size:12px;' id="toolbar">
	<div style='overflow:hidden;background:#A51597;height:20;-moz-user-select:none;-webkit-user-select:none;padding-left:5px;font-weight:bold;color:#ffffff' unselectable="on" id="toolbar-header">
		portlet面板
	</div>
	<DIV style="height:250px;background:white;overflow:auto;">

	<%
	String templet = (String)request.getAttribute("$templet");
	%>
	<htm:declare system="portal" module="templet"/>
	<htm:assign name="$templet" value="<%=templet%>"/>
	<htm:tree id="$toolbar" name="portlet工具栏" title="portlet工具栏" dictid="portlets" parents="$templet" unbitted="true"/>
	
	</DIV>
	<div align="center" style='background:white;'>
          <input name="submit342" type="button" class="button" value="保存" onclick="saveTempletConfig();">
          <input name="submit42" type="button" class="button" value="恢复默认" onclick="initDefault()">
	</div>
</div>

<script>
function initToolbar() {
	drag();
	<htm:write name="VALUEOBJECT" property="$JSONLOAD"/>
}

function drag(){
	var o = document.getElementById("toolbar");
	var header = document.getElementById("toolbar-header");
	header.onmousedown=function(a){
		var d=document;
		if(!a)a=window.event;
		var x=a.layerX ? a.layerX : a.offsetX, y=a.layerY ? a.layerY : a.offsetY;
		if(o.setCapture)
			o.setCapture();
		else if(window.captureEvents)
			window.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);
		
		d.onmousemove=function(a){
			if(!a)a=window.event;
			if(!a.pageX)a.pageX=a.clientX;
			if(!a.pageY)a.pageY=a.clientY;
			var tx=a.pageX-x,ty=a.pageY-y;
			o.style.left = tx + "px";
			o.style.top = ty + "px";
		};

		d.onmouseup=function(){
			if(o.releaseCapture)
				o.releaseCapture();
			else if(window.releaseEvents)
				window.releaseEvents(Event.MOUSEMOVE|Event.MOUSEUP);
			d.onmousemove=null;
			d.onmouseup=null;
		};
	};
}

// 取portlet容器的内容
function getPortletsData() {
	var conts = document.getElementById("$containter").value;
	if (!conts) return "";
	
	var conf = "";
	var str = conts.split(",");
	for (var i=0;i<str.length;i++) {
		if (conf)
			conf += ";";
		conf += str[i];
		var portlets = getPortlets(str[i]);
		var p = "";
		for (var n=0;n<portlets.length;n++)	{
			if (p!="")
				p += ",";
			p += portlets[n];
		}
		if (p)
			conf += ":" + p;
	}

	return conf;
}


initToolbar();
</script>