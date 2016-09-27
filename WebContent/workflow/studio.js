<!-- For version detection, set to min. required Flash Player version, or 0 (or 0.0.0), for no version detection. --> 
var swfVersionStr = "10.0.0";
<!-- To use express install, set to playerProductInstall.swf, otherwise the empty string. -->
var xiSwfUrlStr = "playerProductInstall.swf";
var flashvars = {};
var params = {};
params.quality = "high";
params.bgcolor = "#ffffff";
params.allowscriptaccess = "alway";
params.allowfullscreen = "true";
params.wmode="transparent";
var attributes = {};
attributes.id = "studio";
attributes.name = "studio";
attributes.align = "middle";
swfobject.embedSWF("studio.swf", "flashContent","100%", "100%",swfVersionStr, xiSwfUrlStr,flashvars, params, attributes);
<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
swfobject.createCSS("#flashContent", "display:block;text-align:left;");

// 节点属性维护
function nodeProp(nodeId,nodeType,nodeName) {
	if (nodeType=="P")	{
		top.window.showDialog(window,"[" + nodeName + "]节点属性","workflow/studio.cmd?$ACTION=subflow&nodeid=" + nodeId + "&type=" + nodeType + "&pk=" + document.getElementById("pk").value + "&system=" + document.getElementById("systemid").value + "&module=" + document.getElementById("formid").value,"640","420");
		return;
	}
	top.window.showDialog(window,"[" + nodeName + "]节点属性","workflow/studio.cmd?$ACTION=node&nodeid=" + nodeId + "&type=" + nodeType + "&pk=" + document.getElementById("pk").value + "&system=" + document.getElementById("systemid").value + "&module=" + document.getElementById("formid").value,"690","590");
	
}

// 路由属性维护
function routeProp(routeId,routeName) {
	top.window.showDialog(window,"[" + routeName + "]路由属性","workflow/studio.cmd?$ACTION=route&code=" + routeId + "&pk=" + document.getElementById("pk").value + "&system=" + document.getElementById("systemid").value + "&module=" + document.getElementById("formid").value,"550","250");
	
}

// 回写属性给节点或路由
function flushObjectProp(name) {
	document.getElementById("studio").setNodeRouteName(name);
}

// 取流程流水号
function getFlowPK() {

	return document.getElementById("pk").value;
}

// 取流程状态
function getFlowStatus() {
	return document.getElementById("status").value;
}