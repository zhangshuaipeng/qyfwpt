var appPath = getAppPath();

function getAppPath() {
	var pathName = document.location.pathname;
	var index = pathName.substr(1).indexOf("/");
	var result = pathName.substr(0,index + 1);
	return result;
}


// 设置容器的属性
function setContainerAttr(contId,attr) {
    var ctl = document.getElementById(contId);
	ctl.setAttribute("content",attr);
}
// 重新载入portlet
function reloadPortlet(pid) {
	if (!pid) {
		alert("portlet不存在！");
		return;
	}

	var obj = document.getElementById(pid);
	if (!obj) {
		alert("portlet:" + pid + "不存在！");
		return;
	}

	var portlet = obj.getAttribute("dictid");
	var moreurl = obj.getAttribute("more");
	var parents = obj.getAttribute("parents");

	loadPortlet(pid,portlet,moreurl,parents);
}
// 载入portlet
function loadPortlet(pid,portlet,moreurl,parents) {
	if (!pid) {
		alert("portlet不存在！");
		return;
	}

	var obj = document.getElementById(pid);
	if (!obj) {
		alert("portlet:" + pid + "不存在！");
		return;
	}
	
	var str = portlet.split("-");
	if (str.length<2) {
		alert("portlet:" + portlet + "不存在！");
		return;
	}

	// 保存当前的portlet号
	obj.setAttribute("dictid",portlet);
	if (!moreurl)
		moreurl = "";
	obj.setAttribute("more",moreurl);
	if (!parents)
		parents = "";
	obj.setAttribute("parents",parents);

	var paramsValue = getPortletParamsValue(parents);
	var url = appPath + "/PortletAction.cmd?$SYSTEM=" + str[0] + "&$MODULE=" + str[1];
	if (str.length>2) 
		url += "&$ACTION=" + str[2];
	url += "&$PORTLETID=" + pid;

	DHTMLSuite.ajax.sendPortletRequest(url,paramsValue,pid);
}
// 运行portlet页签
function runPortletTab(obj) {
	var pid = obj.getAttribute("pid");
	var portlet = obj.getAttribute("dictid");
	var more = obj.getAttribute("more");
	var parents = obj.getAttribute("parents");

	loadPortlet(pid,portlet,more,parents);
}
// 取参数
function getPortletParamsValue(params) {
	if (!params)	
		return "";	

	var url = "";
	var str = params.split(",");
	var obj;
	for (var i=0;i<str.length;i++)	{
		var nPos = str[i].indexOf(":");
		var v = null;
		if (nPos==-1) {
			obj = document.getElementById(str[i]);
			if (!obj) continue;
			v = obj.value;
		} else {
			obj = document.getElementById(str[i].substring(0,nPos));
			if (!obj) continue;
			v = obj.value;
			str[i] = str[i].substring(nPos+1);
		}
		if (!v) continue;
		if (url)
			url += "&";
		url += str[i] + "=" + v;
	}

	return url;
}
// 根据class取标签
function getElementsByClassName(pId,tagName,className){
	var node = pId && document.getElementById(pId) || document;
	tagName = tagName || "*";
	className = className.split(" ");
	var classNameLength = className.length;
	for(var i=0,j=classNameLength;i<j;i++){
		//创建匹配类名的正则
		className[i]= new RegExp("(^|\\s)" + className[i].replace(/\-/g, "\\-") + "(\\s|$)");
	}
	var elements = node.getElementsByTagName(tagName);
	var result = [];
	for(var i=0,j=elements.length,k=0;i<j;i++){//缓存length属性
		var element = elements[i];
		while(className[k++].test(element.className)){//优化循环
			if(k === classNameLength){
				result[result.length] = element;
				break;
			}  
		}
		k = 0;
	}

	return result;
}
// 初始化portal的内容,params:容器列表
function loadTempletPortlets() {
	var params = document.getElementById("$containter").value;
	if (!params) return;

	var str = params.split(",");

	// 取参数，是否在管理状态
	var state = getUrlVars()["$config"];
	for (var i=0;i<str.length;i++) {
		if (state && state=="true" && wc)   // 初始化容器
			wc.addContainter(str[i]);
		// 初始化已经存在的portlet
		var portlets = getPortlets(str[i]);
		for (var n=0;n<portlets.length;n++)	{
			if (state && state=="true" && wc)   // 初始化容器
				wc.addPortlet(str[i],portlets[n]);
			else // 初始化控制
				initPortletCtrlPanel(portlets[n]);
			// 载入portlet
			reloadPortlet(portlets[n]);
		}
	}

	if (state && state=="true") {
		initToolbar();
	}
}

// 初始化portlet的控制面板
function initPortletCtrlPanel(pid) {
	var portlet = document.getElementById(pid);

	// 处理关闭
	var ctrl = getElementByClassName(portlet,"xclose");

	ctrl.onclick = function () {
		portlet.parentNode.removeChild(portlet);
	}

	// 处理刷新
	ctrl = getElementByClassName(portlet,"xrefresh");
	ctrl.onclick = function () {
		reloadPortlet(pid);
	}
	
	// 处理最大最小化
	ctrl = getElementByClassName(portlet,"xreduce");
	ctrl.onclick = function () {
		ctrl = getElementByClassName(portlet,"xcontent");
		if (ctrl.style.display=="none")
			ctrl.style.display = "block";
		else
			ctrl.style.display = "none";
	}

	// 处理更多
	ctrl = getElementByClassName(portlet,"xmore");
	ctrl.onclick = function () {
		var moreUrl = portlet.getAttribute("more");
		if (moreUrl) {
			var tab = top.window.tab;
			ctrl = getElementByClassName(portlet,"xtitle");
			if (tab)
				top.window.tab.addTab(pid,ctrl.innerHTML,moreUrl,"images/icon/doclink.gif",true);
			else
				location.href = moreUrl;
		}
	}

	// 定期载入
	var interval = portlet.getAttribute("interval");
	if (interval) {
		window.setInterval(function (){reloadPortlet(pid);},parseInt(interval) * 60000);
	}
}

// 取URL参数
function getUrlVars() {
	var vars = [], hash;
	var hashes = window.location.href.slice(window.location.href.indexOf('?') + 1).split('&');
	for(var i = 0; i < hashes.length; i++) {
		hash = hashes[i].split('=');
		vars.push(hash[0]);
		vars[hash[0]] = hash[1];
	}
	return vars;
}


// 取首个特定class的标签对象
function getElementByClassName(tag,className) { 
	var children = tag.getElementsByTagName('*'); //获取页面所有元素

	//获取元素的class为className的所有元素
	for (var ii = 0; ii < children.length; ii++) { 
		var child = children[ii]; 
		var classNames = child.className.split(' '); 
		for (var j = 0; j < classNames.length; j++) { 
			if (classNames[j] == className) { 
				return child;
			} 
		} 
	} 

	return tag; 
} 

// 取容器下，属性为portlet，值为true的标签
function getPortlets(cont) {
	var tag = document.getElementById(cont);
	if (!tag) return new Array();

	var children = tag.getElementsByTagName('*'); //获取页面所有元素
	var elements = new Array(); //定义一个数组，用于存储所得到的元素
	//获取元素的class为className的所有元素
	for (var i = 0; i < children.length; i++) { 
		var child = children[i];
		var attr = child.getAttribute("portlet");
		if (attr && attr=="true") {
			if (child.id)
				elements.push(child.id); //如果存在，则存入elements
		}
	} 

	return elements; 
}

