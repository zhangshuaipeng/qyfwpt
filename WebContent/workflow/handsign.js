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
params.flashVars="type=log";
var attributes = {};
attributes.id = "handsign";
attributes.name = "handsign";
attributes.align = "middle";
swfobject.embedSWF("handsign.swf", "flashContent","100%", "100%",swfVersionStr, xiSwfUrlStr,flashvars, params, attributes);
<!-- JavaScript enabled so display the flashContent div in case it is not replaced with a swf object. -->
swfobject.createCSS("#flashContent", "display:block;text-align:left;");


