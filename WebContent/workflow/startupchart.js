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
params.flashVars="type=chart";
var attributes = {};
attributes.id = "studio";
attributes.name = "studio";
attributes.align = "middle";
swfobject.embedSWF("flowchart.swf", "flashContent","100%", "100%",swfVersionStr, xiSwfUrlStr,flashvars, params, attributes);
<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
swfobject.createCSS("#flashContent", "display:block;text-align:left;");

// 节点属性维护
function openWork(wid) {
	top.window.showDialog(window,"流程表单","WorkflowAction.cmd?$WID=" + wid,"1024","600");
	
}

// 取流程流水号
function getInstanceId() {
	return document.getElementById("instanceid").value;
}
// 取组织号
function getOrgCode() {
	return document.getElementById("orgcode").value;
}
// 取流程号
function getFlowCode() {
	return document.getElementById("flowcode").value;
}
// 取流程调试状态
function getDebugState() {
	return document.getElementById("debug").value;
}
