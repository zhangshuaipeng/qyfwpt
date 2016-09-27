<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="/htm" prefix="htm" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
<meta HTTP-EQUIV="Pragma" content="no-cache" /> 
<meta HTTP-EQUIV="Cache-Control" content="no-cache" /> 
<meta HTTP-EQUIV="Expires" content="0">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<META http-equiv=Content-Type content="text/html; charset=UTF-8">

<title>框架</title>

<link rel="stylesheet" type="text/css" href="css/dhtmlxlayout.css">
<link rel="stylesheet" type="text/css" href="css/skins/dhtmlxlayout_dhx_skyblue.css">
<link rel="stylesheet" type="text/css" href="css/skins/dhtmlxaccordion_dhx_skyblue.css">
<link rel="stylesheet" type="text/css" href="css/main.css">

<style>
		html, body {
			width: 100%;
			height: 100%;
			margin: 0px;
			padding: 0px;
			overflow: hidden;
			font-size:12px;
		}



.menus {
	margin-top:5px;
	-moz-user-select:none;
}

	
	</style>
</head>

<script src="js/common.js"></script>
<script src="js/ajax.js"></script>
<script src="js/dhtmlxcommon.js"></script>
<script src="js/dhtmlxlayout.js"></script>
<script src="js/dhtmlxaccordion.js"></script>
<script src="js/dhtmlxcontainer.js"></script>
<script>
var dhxLayout;
var frame;

function doOnLoad() {
	frame = <htm:layout />
	if (frame.items==null) return;
	if (browser.versions.mobile) {
		var url = frame.items[0].url;
		if (frame.items[0].params) {
			var str = frame.items[0].params.split(",");
			for (var n=0;n<str.length;n++) {
				var key = str[n];
				var nPos = str[n].indexOf(":");
				if (nPos!=-1) {
					key = str[n].substring(nPos + 1);
					str[n] = str[n].substring(0,nPos);
				}
				var v = getUrlVars()[str[n]];
				if (!v) continue;
				if (url.indexOf("?")==-1)
					url += "?";
				else
					url += "&";
				url += key + "=" + v;
			}
		}

		document.location = url;
		return;
	}

	dhxLayout = new dhtmlXLayoutObject(document.body, frame.style);

	var url;
	var nIndex = parseInt(frame.style);
	if (nIndex!=frame.items.length) {
		alert("框架式样与实际定义的数量不一致!");
		return;
	}
	for (var i=0;i<frame.items.length;i++) {
		if (i>=nIndex) break;
		if (frame.items[i].index>=nIndex) continue;
		if (frame.items[i].width>100)
			dhxLayout.items[frame.items[i].index].setWidth(frame.items[i].width);
		dhxLayout.items[frame.items[i].index].setText(frame.items[i].title);
		if (browser.versions.mobile || frame.items[i].showHeader!="Y")
			dhxLayout.items[frame.items[i].index].hideHeader();
		url = frame.items[i].url;
		if (!url) continue;
		if (frame.items[i].params) {
			var str = frame.items[i].params.split(",");
			for (var n=0;n<str.length;n++) {
				var key = str[n];
				var nPos = str[n].indexOf(":");
				if (nPos!=-1) {
					key = str[n].substring(nPos + 1);
					str[n] = str[n].substring(0,nPos);
				}
				var v = getUrlVars()[str[n]];
				if (!v) continue;
				if (url.indexOf("?")==-1)
					url += "?";
				else
					url += "&";
				url += key + "=" + v;
			}
		}
		dhxLayout.items[frame.items[i].index].attachURL(url);
	}

}

// 刷新某个框架 , nIndex为框架的序号，从0开始
function refreshFrame(nIndex) {
	if (!frame) {
		alert("框架内容不存在！");
		return false;
	}

	if (nIndex>=frame.items.length) {
		alert("序号超过内容范围！");
		return false;
	}
	if (nIndex>=dhxLayout.items.length) {
		alert("框架序号超过范围！");
		return false;
	}
	if (!frame.items[nIndex].url) {
		alert("框架原请求为空！无需刷新");
		return false;
	}

	for (var i=0;i<frame.items.length;i++) {
		if (nIndex==frame.items[i].index) {
			url = frame.items[i].url;
			if (frame.items[i].params) {
				var str = frame.items[i].params.split(",");
				for (var n=0;n<str.length;n++) {
					var key = str[n];
					var nPos = str[n].indexOf(":");
					if (nPos!=-1) {
						key = str[n].substring(nPos + 1);
						str[n] = str[n].substring(0,nPos);
					}
					var v = getUrlVars()[str[n]];
					if (!v) continue;
					if (url.indexOf("?")==-1)
						url += "?";
					else
						url += "&";
					url += key + "=" + v;
				}
			}
			dhxLayout.items[frame.items[i].index].attachURL(url);
		}
	}

	return false;
}

</script>


<body onload="doOnLoad();">

</body>
</html>