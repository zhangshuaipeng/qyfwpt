var arrayDialogs = new Array();   // 弹出窗口数组
var maxZindex = 2000;
var globalPath = contextPath();

var browser = {
	versions:function(){
		var u = navigator.userAgent, app = navigator.appVersion;
		return {//移动终端浏览器版本信息
			trident: u.indexOf('Trident') > -1, //IE内核
			presto: u.indexOf('Presto') > -1, //opera内核
			webKit: u.indexOf('AppleWebKit') > -1, //苹果、谷歌内核
			gecko: u.indexOf('Gecko') > -1 && u.indexOf('KHTML') == -1, //火狐内核
			mobile: !!u.match(/AppleWebKit.*Mobile.*/) || !!u.match(/Mobile/), //是否为移动终端
			ios: !!u.match(/\(i[^;]+;( U;)? CPU.+Mac OS X/), //ios终端
			android: u.indexOf('Android') > -1 || u.indexOf('Linux') > -1, //android终端或者uc浏览器
			iPhone: u.indexOf('iPhone') > -1 || u.indexOf('Mac') > -1, //是否为iPhone或者QQHD浏览器
			iPad: u.indexOf('iPad') > -1, //是否iPad
			webApp: u.indexOf('Safari') == -1 //是否web应该程序，没有头部与底部
		};
	}(),
	language:(navigator.browserLanguage || navigator.language).toLowerCase()
}

function contextPath() {
	var pathName = document.location.pathname;
	var index = pathName.substr(1).indexOf("/");
	var result = pathName.substr(0,index + 1);
	return result;
}

// 弹出窗口函数,obj为window
function showDialog(obj,title,url,width,height,callback,srcObj) {
	if (url.indexOf("http://")!=0 && url.indexOf("/")!=0) {
		url = globalPath + "/" + url;
	}
	var objDialog = new Dialog(obj,title,url,width,height,callback);
	var id = objDialog.Init(srcObj);
	arrayDialogs[id] = objDialog;
}
// 子表弹出窗口函数
function showGridDialog(obj,title,url,width,height,callback,grid,rowId,fieldid) {
	if (url.indexOf("http://")!=0 && url.indexOf("/")!=0) {
		url = globalPath + "/" + url;
	}
	var objDialog = new Dialog(obj,title,url,width,height,callback);

	var id = objDialog.Init(null,grid,rowId,fieldid);
	arrayDialogs[id] = objDialog;
}
// 子表弹出窗口提交返回
function gridDialogSubmit(win,obj,value,grid,rowId,fieldid) {
	var action = grid.getActionByFieldId(fieldid);
	var rets = action.rets;
	// 没有返回接收域
	if (!rets) 
		rets = fieldid;

	var fields = rets.split(",");
	var v = null;
	if (value) {
		v = value.split("|");
	}

	for (var i=0;i<fields.length;i++) {
		if (v && v.length>i) 
			grid.setCellValueByFieldId(rowId,fields[i],v[i]);
		else
			grid.setCellValueByFieldId(rowId,fields[i],"");
	}
	// 如果存在回调方法，则运行
	if (action.callback) {
		eval(action.callback);
	}
}

// 取弹出窗口的对象，objWindow一般为window
function getDialog(objWindow) {
	if (!objWindow.frameElement)
		return null;
	return arrayDialogs[objWindow.frameElement.id];
}
// 关闭当前弹出窗口
function closeDialog(objWindow) {
	var dialog = getDialog(objWindow);
	if (dialog)
		dialog.close();
}

// 关闭弹出窗口或页签
function closeDialogOrTab(obj) {
	var dialog = top.window.getDialog(obj);
	if (dialog)
		dialog.close();
	if (top.window.tab)
		top.window.tab.closeActivePage(obj);
}

// 提交弹出窗口内容，然后关闭弹出窗口
function submitDialog(objWindow,value) {
	var dialog = getDialog(objWindow);
	dialog.submit(value);
}
// 关闭当前弹出窗口
function closePopupWindow() {
	top.window.getDialog(window).close();
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
// 取浏览器类型
function getUserAgent() {
	if(navigator.userAgent.indexOf("MSIE")>0) {  
		return "MSIE";  
	}  
	if(navigator.userAgent.indexOf("Firefox")>0){  
        return "FIREFOX";  
	}  
	if(navigator.userAgent.indexOf("Safari")>0) {  
        return "SAFARI";  
	}   
}  
// 是否存在某个CSS
function hasClass(element, className) {
	var reg = new RegExp('(\\s|^)'+className+'(\\s|$)');
	if (!element.className)
		return false;
	return element.className.match(reg);
}
// 增加CSS式样
function addClass(element, className) {
	if (!this.hasClass(element, className))
	{
		if (element.className==null || element.className=="" || element.className==" ")
			element.className = className;
		else
			element.className += " " + className;
	}
}
// 删除CSS式样
function removeClass(element, className) {
	if (hasClass(element, className)) {
		var reg = new RegExp('(\\s|^)'+className+'(\\s|$)');
		element.className = element.className.replace(reg,' ');
	}
} 

//添加事件兼容处理
function addEvent(target, type, handler) {
	if (window.addEventListener) {
		addEvent = function(target, type, handler) {
			target.addEventListener(type, handler, false);
		}
	} else {
		addEvent = function(target, type, handler) {
			target.attachEvent("on" + type, handler);
		}
	}

	addEvent(target, type, handler);
}

//删除事件兼容处理
function removeEvent(target, type, handler) {
	if (window.removeEventListener) {
		removeEvent = function(target, type, handler) {
			target.removeEventListener(type, handler, false);
		}
	} else {
		removeEvent = function(target, type, handler) {
			target.detachEvent("on" + type, handler);
		}
	}

	removeEvent(target, type, handler);
}

//阻止冒泡兼容处理
function stopPropagation(e) {
	if (e.stopPropagation) {
		e.stopPropagation();
	} else {
		e.cancelBble = true;
	}
}

//阻止默认动作兼容处理
function preventDefault(e) {
	if (e.preventDefault) {
		e.preventDefault();
	} else {
		e.returnVal = false;
	}
}
// 创建outlook文件夹内容
function createOutlookFolder(xmlNode,targetInTab) {
	var item;
	var nodes = xmlNode.childNodes;
	var root = document.createElement("div");
	root.className = "menus";
	root.setAttribute("unselectable","on");

	var div;
	var a;
	var icon;
	var title;

	for (var i=0;i<nodes.length;i++) {
		if (nodes[i].nodeType!=1) continue;
		// 表示真实的子节点
		item = nodes[i];
		div = document.createElement("div");
		div.className = "menu";
		div.setAttribute("unselectable","on");
		div.style.cursor = "pointer";
		root.appendChild(div);

		div.setAttribute("key",item.getAttribute("id"));
		div.setAttribute("text",item.getAttribute("text"));
		div.setAttribute("action",item.getAttribute("action"));
		div.setAttribute("icon",item.getAttribute("icon"));

		div.onmouseover = function () {
			addClass(this,"over");
		}

		div.onmouseout = function () {
			removeClass(this,"over");
		}

		div.onclick = function () {
			if (selected)	{
				removeClass(selected,"selected");
			}
			
			selected = this;
			addClass(selected,"selected");

			var id = this.getAttribute("key");
			var title = this.getAttribute("text");
			var url = this.getAttribute("action");
			var icon = this.getAttribute("icon");
			tab.addTab(id,title,url,icon,true);
		}
		
		icon = document.createElement("img");
		icon.src = item.getAttribute("icon");
		div.appendChild(icon);

		title = document.createElement("span");
		title.innerHTML = item.getAttribute("text");
		title.className = "text";
		div.appendChild(title);		
	}	

	return root;
}

// 刷新某个域的内容
function refreshFields(tags) {
	if (!tags) return;

	var str = tags.split(",");

	for (var i=0;i<str.length;i++) {
		refreshField(str[i]);
	}
}
// 重新载入域的内容
function refreshField(tag) {
	if (!tag) return;

	var obj = document.getElementById(tag);
	if (!obj || obj.tagName=="INPUT" && (obj.type=="checkbox" || obj.type=="radio"))
		obj = document.getElementById(tag + "_BOX");
	if (!obj) return;   // 表示不存在

	var url = "DictAction.cmd";
	var str = obj.getAttribute("dictid");
	if (!str) return;

	url += "?$dictid=" + str;
	url += "&$field=" + tag;

	if (obj.tagName=="IFRAME") {
		url = obj.getAttribute("dictid");
	}

	// 参数
	var params = obj.getAttribute("parents");
	if (params)	{
		str = params.split(",");
		for (var i=0;i<str.length;i++)	{
			var nPos = str[i].indexOf(":");
			var v = null;
			if (nPos==-1) {
				v = document.getElementById(str[i]).value;
			} else {
				v = document.getElementById(str[i].substring(0,nPos)).value;
				str[i] = str[i].substring(nPos+1);
			}
			if (!v) continue;
			if (url.indexOf("?")==-1)
				url += "?";
			else
				url += "&";
			url += str[i] + "=" + v;
		}
	}

	if (obj.tagName=="IFRAME") {
		if (url.indexOf("?")==-1)
			url += "?";
		else
			url += "&";
		url += "timestamp=" + (new Date()).getTime();
		obj.src = url;
		return;
	}

	// 刷新附件域
	var iframe = document.getElementById(tag + "_iframe");
	if (iframe) {
		iframe.src = iframe.src;
		return;
	}

	// 刷新box
	if (obj.id.indexOf("_BOX")!=-1) {
		DHTMLSuite.ajax.sendRequest(url,'','reflushBoxTagProp');
		return;
	}

	// 刷新portlet
	if (obj.getAttribute("portlet")) {
		reloadPortlet(obj.id);
		return;
	}

	DHTMLSuite.ajax.sendRequest(url,'','reflushTagProp');
}
// 重写选择框属性
function reflushBoxTagProp(ajaxObj) {
	var obj = eval("(" + ajaxObj.response + ")");
	var list = obj.data;
	var field = obj.field;
	var tag = document.getElementById(field + "_BOX");

	// 清除内容
	if (tag.tagName=="TABLE") {
		while (tag.rows.length>0) {
			tag.deleteRow(0);
		}
	} else
		tag.innerHTML = "";

	if (!list) return;

	var nCol = parseInt(tag.getAttribute("colnum"));
	var box = tag.getAttribute("box");
	var row;
	var cell;
	
	if (tag.tagName=="SPAN") {
		for (var i=0;i<list.length;i++) {
			var data = list[i];
			
			var ctl = document.createElement("INPUT");
			ctl.type = box;
			ctl.id = field;
			ctl.name = field;
			ctl.value = data.key;
			tag.appendChild(ctl);
			
			ctl = document.createElement("span");
			ctl.innerHTML = data.value;
			tag.appendChild(ctl);
			ctl.style.paddingRight = "5px";
			ctl = document.createElement("br");
			tag.appendChild(ctl);
		}

		return;
	}

	for (var i=0;i<list.length;i++) {
		var data = list[i];
		if (nCol!=0 && i%nCol==0)	{
			row = tag.insertRow(tag.rows.length);
		}
		if (nCol!=0)
			cell = row.insertCell(row.cells.length);
		cell.style.borderWidth = "0px";
		var ctl = document.createElement("INPUT");
		ctl.type = box;
		ctl.id = field;
		ctl.name = field;
		ctl.value = data.key;
		cell.appendChild(ctl);

		ctl = document.createElement("span");
		ctl.innerHTML = data.value;
		cell.appendChild(ctl);
		ctl.style.paddingRight = "5px";
	}

	for (var i=list.length;i<nCol;i++) {
		if (nCol!=0)
			cell=row.insertCell(row.cells.length);
		cell.style.borderWidth = "0px";
	}
}
// 重写域属性
function reflushTagProp(ajaxObj) {
	var obj = eval("(" + ajaxObj.response + ")");
	var list = obj.data;
	var field = obj.field;
	var tag = document.getElementById(field);
	var expKey = tag.getAttribute("expkey");

	var selV = tag.value;
	for (var i=tag.options.length-1;i>=0;i--) {
		tag.remove(i);
	}

	if (!list) return;

	var objOption = document.createElement("OPTION");
	objOption.text= " - 选择 - ";
	objOption.value = "";
	tag.options.add(objOption);

	for (var i=0;i<list.length;i++) {
		var data = list[i];
		objOption = document.createElement("OPTION");
		if (expKey && expKey=="true") {
			if (data.key.indexOf(data.value)==-1)
				objOption.text= data.key + "." + data.value;
			else
				objOption.text= data.value;
		} else
			objOption.text= data.value;
		objOption.value = data.key;
		tag.options.add(objOption);
		if (data.key==selV)
			objOption.selected = true;
	}
}
// 对于下拉域,将value值赋给某个其它域
function setValueToField(obj,fieldid) {
	var ctl = document.getElementById(fieldid);
	if (!ctl) return;

	ctl.value = obj.options[obj.options.selectedIndex].text;
}

function runFormCmd(obj) {
	obj.disabled = "true";
	runFormCommand(obj);
	obj.disabled = "";
	return false;
}

// 点击按钮
function runFormCommand(obj) {
	var cmdname = obj.getAttribute("cmdname");
	var cmdtype = obj.getAttribute("cmdtype");
	var cmd = obj.getAttribute("cmd");
	var url = obj.getAttribute("url");
	var multi = obj.getAttribute("multi");
	var args = obj.getAttribute("args");
	var rets = obj.getAttribute("rets");
	var refs = obj.getAttribute("refs");
	var cmdtarget = obj.getAttribute("cmdtarget");
	var width = obj.getAttribute("width");
	var height = obj.getAttribute("height");
	var callback = obj.getAttribute("callback");
	var ajax = obj.getAttribute("ajax");
	var title = obj.getAttribute("title");
	var conf = obj.getAttribute("confirm");
	var uncheck = obj.getAttribute("uncheck");

	if (conf=="Y") {
		if (!confirm("您真的要进行[" + title + "]操作吗?")) {
			return false;
		}
	}

	if (!width)
		width = "480";
	if (!height)
		height = "360";

	// 先运行提交判断
	if (typeof(onPageSubmit)=="function") {
		if (!uncheck || uncheck!="Y") {
			if (!onPageSubmit(obj))
				return false;
		}
	}
	// 先判断是否要运行某个操作的预操作
	var preHandler = "typeof(on" + cmdname + "Click)";
	if (eval(preHandler)=="function") {
		if (eval("on" + cmdname + "Click()")==false) {
			return false;
		}
	}
	if (cmdtype=="URL") {
		url = createUrlString(url,args);
		if (ajax && ajax=="true")
			return ajaxUrlRequest(url);
		if (cmdtarget=="_blank") {
			window.open(url);
			return false;
		}
		if (cmdtarget=="TAB") {
			top.window.tab.addTab(cmdname,title,url,"images/icon/system.png",true);
			return false;
		}
		document.location.href = url;
		return false;
	}
	if (cmdtype=="JAVASCRIPT") {
		eval(url);
		return false;
	}

	if (cmdtype=="CLOSE") {
		closeDialogOrTab(window);
		return false;
	}

	// 处理弹出窗口
	if (cmdtype=="POPUP") {
		if (cmd=="DATE") {
			top.window.showDialog(window,title,globalPath + "/common/date.html","240","210","dialogSubmit",obj);
			return false;
		}
		if (cmd=="DATETIME") {
			top.window.showDialog(window,title,globalPath + "/common/datetime.html","240","260","dialogSubmit",obj);
			return false;
		}
		if (cmd=="USER") {
			top.window.showDialog(window,title,globalPath + "/ou/user.cmd?$ACTION=deptusertree&box=" + multi,"330","410","dialogSubmit",obj);
			return false;
		}
		if (cmd=="DEPT") {
			top.window.showDialog(window,title,globalPath + "/ou/dept.cmd?$ACTION=deptselect&box=" + multi,"330","410","dialogSubmit",obj);
			return false;
		}
		if (cmd=="RIGHT") {
			top.window.showDialog(window,title,globalPath + "/ou/acl.cmd?$ACTION=main","670","484","dialogSubmit",obj);
			return false;
		}
		if (cmd=="URL")	{
			url = createUrlString(url,args);
			if (multi) {
				if (url.indexOf("?")==-1)
					url += "?";
				else
					url += "&";
				url += "$BOX=" + multi;
			}
			top.window.showDialog(window,title,url,width,height,"dialogSubmit",obj);
			return false;
		}
	}

	if (!uncheck || uncheck!="Y")
		if (!objValidator.isValid()) return false;
	document.forms[0].$ACTION.value = cmd;
	if (ajax) {
		if (args)
			return submitAjaxRequest(cmd,{args:args,rets:rets,callback:callback});
		else
			return submitAjaxForm(cmd,'',callback);
	}
	document.forms[0].submit();
	
	return false;
}

// 后台校验
function verifyForm(action,param) {
	var url = "verify.cmd?$ACTION=" + action;

	url += "&$SYSTEM=" + document.getElementById("$SYSTEM").value + "&$MODULE=" + document.getElementById("$MODULE").value;
	var params = "";
	if (param) {
		var str = param.split(",");
		for (var i=0;i<str.length;i++) {
			if (!document.getElementById(str[i])) continue;

			if (params)	
				params += "&";
			params += str[i] + "=" + document.getElementById(str[i]).value;
		}
	}
	var response = DHTMLSuite.ajax.sendRequestSync(url,params);
	var ajaxObj = eval("(" + response + ")");
	if (ajaxObj.$RESULT!="0") {
		alert(ajaxObj.$MESSAGE);
		return false;
	}

	return true;
}

// 提交请求
function submitCmd(cmd) {
	if (!objValidator.isValid()) return false;

	// 在表单提交内容时，先清除子表的查询条件
	if (window.objGrids) {
		var c;
		for (c in window.objGrids)	{
			window.objGrids[c].clearOpts();
		}
	}
	document.forms[0].$ACTION.value = cmd;
	document.forms[0].submit();
	
	return false;
}
// 将顶部页面的某个链接在TAB页签中运行
function runHrefInTab(obj,id,title) {
	var href = obj.getAttribute("href");
	if (!title)
		title = obj.getAttribute("title");

	if (!top.window.tab)
		return true;

	if (!title)
		title = "详细内容";
	if (!id)
		id = "LINK";
	var loc = document.location.pathname;
	loc = loc.substring(0,loc.lastIndexOf("/") + 1);
	top.window.tab.addTab(id,title,loc + href,"images/icon/system.png",true);

	return false;
}
// 窗口提交,value使用竖线分隔，进行返回赋值
function dialogSubmit(win,obj,value) {
	var rets = obj.getAttribute("rets");
	// 没有返回接收域
	if (rets) {
		var fields = rets.split(",");
		var v = null;
		if (value) {
			v = value.split("|");
		}

		var ctrl;
		for (var i=0;i<fields.length;i++) {
			ctrl = win.document.getElementById(fields[i]);
			if (!ctrl) continue;
			if (v && v.length>i) 
				ctrl.value = v[i];
			else
				ctrl.value = "";
		}
	}

	// 是否要刷新域
	win.refreshFields(obj.getAttribute("refs"));
	
	var callback = obj.getAttribute("callback");
	if (callback)
		eval(callback);
}
// 查询区域弹出窗口返回
function dialogClauseSubmit(win,obj,value) {
	dialogSubmit(win,obj,value);
	obj.style.color = "#000";
}
// 窗口提交后，关闭本窗口，并且刷新父页面
function dialogSubmitRefresh() {

}
// 运行AJAX URL请求
function ajaxUrlRequest(url,callback) {
	DHTMLSuite.ajax.sendRequest(url,'',(callback ? callback : 'ajaxHandler'));

	return false;
}
// 提交AJAX表单
function submitAjaxForm(act,params,callback) {
	var url = document.getElementById("$MODULE").value;
	document.getElementById("$ACTION").value = act;
	url += ".cmd";
	if (params)
		url = createUrlString(url,params);
	var form = new DHTMLSuite.form({ formRef:'EAPForm',action:url,callbackOnComplete:(callback ? callback : "ajaxHandler")});
	form.submit();
}
// 添加参数
function getUrlArgs(args) {
	if (!args)
		return "";

	var str = "";

	var keys = args.split(",");
	// 是否转义
	for (var i=0;i<keys.length;i++) {
		var nIndex = keys[i].indexOf(":");
		var param = keys[i];
		if (nIndex!=-1) {
			param = keys[i].substring(nIndex+1);
			keys[i] = keys[i].substring(0,nIndex);
		}
		var v = document.getElementById(keys[i]);
		if (!v || !v.value) continue;
		str += "&" + param + "=" + v.value;
	}
	
	return str;
}

// 表单提交AJAX请求,向当前模块以AJAX方式提交已经定义的请求,param是一个Hash对象,主要的KEY包括:args-表单上的域;rets-返回的域;callback-返回后回调的函数
function submitAjaxRequest(act,param) {
	var url = "";

	var obj = document.getElementById("$WID");
	if (obj && obj.value) {
		url = document.getElementById("$SYSTEM").value + "/";
	}

	url += document.getElementById("$MODULE").value;
	url += ".cmd?$ACTION=" + act;
	var obj = document.getElementById("$VERSION");
	if (obj && obj.value) {
		url += "&$VERSION=" + obj.value;
	}

	var data = "";
	if (param && param.rets)	{
		data += "&$RETS=" + param.rets;
	}
	if (param && param.callback)	{
		data += "$CALLBACK=" + param.callback;
	}

	if (param && param.args) {
		data += getUrlArgs(param.args);
	}
	DHTMLSuite.ajax.sendRequest(url,data,'ajaxRetHandler');
}
// AJAX请求返回处理
function ajaxRetHandler(ajax) {
	if (!ajax || !ajax['response']) return;
	var ajaxOjb = null;
	try {
		ajaxObj = eval("(" + ajax['response'] + ")");
	} catch (e) {
		printMessage("操作失败！");
		return;
	}

	var str;
	for (str in ajaxObj) {
		var ctl = document.getElementById(str);
		if (ctl) {
			if (ajaxObj[str]==null) 
				ctl.value = "";
			else
				ctl.value = ajaxObj[str];
		}
	}
	str = ajaxObj.$RESULT;
	if (str && String(str)!="0") {
		if (ajaxObj.$MESSAGE) {
			printMessage(ajaxObj.$MESSAGE);
			if (ajaxObj.$ALERT && ajaxObj.$ALERT=="Y")	{
				alert(ajaxObj.$MESSAGE);
			}
			if (ajaxObj.$FORWARD) {
				location.href = ajaxObj.$FORWARD;
				return;
			}
		} else
			printMessage("操作失败！");
		return;
	}

	if (ajaxObj.$MESSAGE) {
		printMessage(ajaxObj.$MESSAGE);
		if (ajaxObj.$ALERT && ajaxObj.$ALERT=="Y")	{
			alert(ajaxObj.$MESSAGE);
		}
	} else
		printMessage("");

	if (ajaxObj.$FORWARD) {
		location.href = ajaxObj.$FORWARD;
		return;
	}
	if (ajaxObj.$CALLBACK) {
		if (ajaxObj.$CALLBACK.indexOf("(")!=-1)	{
			eval(ajaxObj.$CALLBACK);
		} else
			eval(ajaxObj.$CALLBACK + "();");
	}
}
// 输出提示信息
function printMessage(msg) {
	var ctl = document.getElementById("$MESSAGE");
	if (!ctl || ctl.type=="hidden") return;
	ctl.innerHTML = msg;
}
// 返回处理
function ajaxHandler(ajaxObj) {
	var ret = ajaxObj.$RESULT;
	if (ret && String(ret)!="0") {
		if (!ajaxObj.$MESSAGE)
			ajaxObj.$MESSAGE = "操作失败！";
		printMessage(ajaxObj.$MESSAGE);
		if (ajaxObj.$ALERT && ajaxObj.$ALERT=="Y")	{
			alert(ajaxObj.$MESSAGE);
		}
		if (ajaxObj.$FORWARD) {
			location.href = ajaxObj.$FORWARD;
			return;
		}
		return;
	}

	if (!ajaxObj.$MESSAGE)
		ajaxObj.$MESSAGE = "操作成功！";
	printMessage(ajaxObj.$MESSAGE);
	if (ajaxObj.$ALERT && ajaxObj.$ALERT=="Y")	{
		alert(ajaxObj.$MESSAGE);
	}
	if (ajaxObj.$FORWARD) {
		location.href = ajaxObj.$FORWARD;
		return;
	}
	var btn = null;
	if (ajaxObj.$ACTIONID)
		btn = document.getElementById(ajaxObj.$ACTIONID);
	if (!btn) {
		var str;
		for (str in ajaxObj) {
			var ctl = document.getElementById(str);
			if (ctl) {
				ctl.value = ajaxObj[str];
			}
		}
	} else {
		var rets = btn.getAttribute("rets");
		if (rets) { 
			if (rets=="*" || rets.indexOf("*")!=-1)	{
				var str;
				for (str in ajaxObj) {
					var ctl = document.getElementById(str);
					if (ctl) {
						ctl.value = ajaxObj[str];
					}
				}
			} else {
				var str = rets.split(",");
				for (var i=0;i<str.length;i++) {
					var ctl = document.getElementById(str[i]);
					if (ctl) {
						ctl.value = ajaxObj[str[i]];
					}
				}
			}
		}
	}

	// 运行回调方法
	if (btn && btn.getAttribute("ajax")=="ajax") {
		var callback = btn.getAttribute("callback");
		if (callback) {
			eval(callback);
		}
	}

	var js = ajaxObj.$JSONLOAD;
	if (js) {
		eval(js);
	}
}

function createUrlString(url,args) {
	if (!args)
		return url;

	var str = url;

	var keys = args.split(",");
	// 是否转义
	for (var i=0;i<keys.length;i++) {
		var nIndex = keys[i].indexOf(":");
		var param = keys[i];
		if (nIndex!=-1) {
			param = keys[i].substring(nIndex+1);
			keys[i] = keys[i].substring(0,nIndex);
		}
		var v = document.getElementById(keys[i]);
		if (!v || !v.value) continue;
		if (str.indexOf("?")==-1)
			str += "?";
		else
			str += "&";
		str += param + "=" + v.value;
	}
	
	return str;
}

// 载入树内容
function loadTree(id,system,module,treeid) {
	var url = '../TreeAction.cmd?$ACTION=load&$SYSTEM=' + system + '&$MODULE=' + module + '&$TREEID=' + treeid + '&$id=' + id;
	var obj = document.getElementById("$" + id);
	if (obj && obj.value) {
		var keys = obj.value.split(",");
		// 是否转义
		for (var i=0;i<keys.length;i++) {
			var nIndex = keys[i].indexOf(":");
			var param = keys[i];
			if (nIndex!=-1) {
				param = keys[i].substring(nIndex+1);
				keys[i] = keys[i].substring(0,nIndex);
			}
			var v = document.getElementById(keys[i]);
			if (!v || !v.value) continue;
			var str = String(v.value);
			str = str.replace(/\&/g,"%26");
			str = str.replace(/\=/g,"%3D");
			url += "&" + param + "=" + str;
		}
	}
	DHTMLSuite.ajax.sendRequest(url,'','showXmlTree');
}

// 将多记录选择框的内容移到另一个框
function moveMultiBox(source,dest) {
	var srcField = document.getElementById(source);
	var dstField = document.getElementById(dest);

	if (!srcField || !dstField)	{
		alert("源容器或目标容器不存在！");
		return;
	}
	var selected = document.getElementsByName("__selected");
	if (!selected) return;

	var destCtrl = document.getElementById(dest + "__");
	var selObj;

	while (true) {
		for (var i=0;i<selected.length;i++) {
			if (!selected[i].checked) continue;
			selected[i].checked = false;
			if (selected[i].parentNode.parentNode.id!=source + "__") continue;
			selObj = selected[i].parentNode;
			selObj.parentNode.removeChild(selObj);
			destCtrl.appendChild(selObj);
		}
		var checked = false;
		for (var i=0;i<selected.length;i++) {
			if (selected[i].checked) {
				checked = true;
				break;
			}
		}
		if (!checked)
			break;
	}

	srcField.value = "";
	dstField.value = "";
	
	var srcText = "";
	var dstText = "";   // 键名
	selected = document.getElementsByName("__selected");
	for (var i=0;i<selected.length;i++)	{
		if (selected[i].parentNode.parentNode.id==source + "__") {
			if (srcField.value)	
				srcField.value += ",";
			if (srcText)
				srcText += ",";
			srcField.value += selected[i].value;
			srcText += getInnerText(selected[i].parentNode);
			continue;
		}

		if (dstField.value) 
			dstField.value += ",";
		if (dstText)
			dstText += ",";
		dstField.value += selected[i].value;
		dstText += getInnerText(selected[i].parentNode);
	}
	srcField.setAttribute("text",srcText);
	dstField.setAttribute("text",dstText);
}

function getInnerText(obj) {
	if (!obj) return "";
	
	return obj.textContent || obj.innerText;
}
// 显示流程表单框架
function showFlowFrame(flowPages,toolbar,infos) {
	var c;

	var nCount = 0;
	for (c in flowPages)
		nCount++;
	if (nCount>1) {  // 大于一个页签才显示
		var tab = new Tabber();
		// 初始化页签
		tab.Init("TAB");
		for (c in flowPages) {
			tab.addTabNoIframe(c,flowPages[c],"javascript:gotoPage('" + c + "');");
		}
		tab.setTagSelected(document.getElementById("$PAGEID").value);
	} else {
		document.getElementById("TAB").style.display = "none";
	}

	var div = document.getElementById("TOOLBAR");
	var btn;

	// 显示工具栏
	for (c in toolbar) {
		btn = document.createElement("button");
		btn.innerHTML = "<b style=\"background-image:url('images/flow/" + c.toLowerCase() + ".gif');\"></b>" + toolbar[c];
		btn.setAttribute("actionid",c);
		btn.onclick = runFlowAction;
		div.appendChild(btn);		
	}

	// 显示工作信息
	document.getElementById("FLOWINFO").innerHTML = infos;
	// 计算总体高度
	var content = document.getElementById("FORMCONTENT");
	var height = getClientHeight();

	if (height==0)
		height = 720;
	height = height - 25 - 26 - 5;
	if (document.getElementById("TAB").style.display!="none") {
		height -= 25;
	}
	content.style.height = height + "px";
}

// 取窗口尺寸
function getWndSize() {
	var w = 0, h = 0;
	if (window.innerWidth && window.innerHeight) {
		w = window.innerWidth;
		h = window.innerHeight;
	} else if (document.documentElement) {
		w = document.documentElement.clientWidth;
		h = document.documentElement.clientHeight;
	} else if (document.body.clientWidth && document.body.clientHeight) {
		w = document.body.clientWidth;
		h = document.body.clientHeight;
	}

	return { width: w, height: h };
}

// 运行某个流程处理功能
function runFlowAction(event) {
	var url;
	
	var e = event || window.event;
	var target = null;
	if (e)
		target = e.target || e.srcElement;
	var	actionId = null;
	if (target)
		actionId = target.getAttribute("actionid");
	if (!actionId)     // 默认为提交
		actionId = "COMMIT";

	if (actionId=="SAVE") {
		if (!objValidator.isValid()) return false;
		if (!onPageSubmit()) return false;
		if (typeof(onSAVEClick)=="function") {
			if (!onSAVEClick())
				return false;
		}
		document.forms[0].$MODULE.value = "WorkflowAction";
		submitAjaxForm("SAVE");
		return false;
	}

	if (actionId=="PRINT") {
		printTag("FORMCONTENT");
		document.location.href = document.location.href;
		return false;
	}
	if (actionId=="COMMIT")	{
		if (!objValidator.isValid()) return false;
		if (!onPageSubmit()) return false;
		if (typeof(onSAVEClick)=="function") {
			if (!onSAVEClick())
				return false;
		}
		if (typeof(onCOMMITClick)=="function") {
			if (!onSAVEClick())
				return false;
		}
		document.forms[0].$MODULE.value = "WorkflowAction";
		submitAjaxForm("SAVE",'',"flowCommit");
		return false;
	}

	if (actionId=="COMMENT") {
		top.window.showDialog(window,"流程提交",globalPath + "/workflow/process.cmd?$ACTION=readcomment&wid=" + document.getElementById("$WID").value + "&instanceid=" + document.getElementById("$INSTANCEID").value,"600","450");
		return false;
	}

	if (actionId=="ATTACH") {
		top.window.showDialog(window,"正文编辑",globalPath + "/plugins/office/wordtext.jsp?$WID=" + document.getElementById("$WID").value + "&$WORDTEXT=" + document.getElementById("$WORDTEXT").value,"1024","1600");
		return false;
	}

	if (actionId=="LOG") {
		top.window.showDialog(window,"流程过程",globalPath + "/frame.jsp?system=workflow&module=process&name=log&instanceid=" + document.getElementById("$INSTANCEID").value,"1200","640");
		return false;
	}

	if (actionId=="REDO") {
		top.window.showDialog(window,"工作重办",globalPath + "/workflow/process.cmd?$ACTION=route&mode=redo&wid=" + document.getElementById("$WID").value,"600","400");
		return false;
	}

	if (actionId=="THREAD")	{
		top.window.showDialog(window,"并发工作",globalPath + "/workflow/process.cmd?$ACTION=threads&wid=" + document.getElementById("$WID").value,"640","480");
		return false;
	}

	if (actionId=="SUBFLOW")	{
		top.window.showDialog(window,"子流程工作",globalPath + "/workflow/process.cmd?$ACTION=subflows&wid=" + document.getElementById("$WID").value,"640","480");
		return false;
	}

	if (actionId=="RETURN") {
		return exitFlowView();
	}

	if (actionId=="GOTO") {
		if (!onPageSubmit()) return false;
		document.forms[0].$MODULE.value = "WorkflowAction";
		submitAjaxForm("SAVE",'',"flowGoto");
		return false;
	}
	if (actionId=="UNTREAD") {
		if (!onPageSubmit()) return false;
		document.forms[0].$MODULE.value = "WorkflowAction";
		submitAjaxForm("SAVE",'',"flowUntread");
		return false;
	}
	if (actionId=="CHANGE") {
		if (!onPageSubmit()) return false;
		document.forms[0].$MODULE.value = "WorkflowAction";
		submitAjaxForm("SAVE",'',"flowChange");
		return false;
	}
	if (actionId=="ABORT") {
		if (!onPageSubmit()) return false;
		document.forms[0].$MODULE.value = "WorkflowAction";
		submitAjaxForm("SAVE",'',"flowAbort");
		return false;
	}
}
// 退出流程表单
function exitFlowView() {
	// 判断是否弹出来的窗口

	var dlg = top.window.getDialog(window);
	if (dlg) {
		dlg.close();
		return false;
	}
	if (window.frameElement) {
		if (location.href==window.frameElement.src || location.href.indexOf(window.frameElement.src)!=-1 || window.frameElement.src.indexOf("startup.cmd?$ACTION=begin")!=-1) {
			closeDialogOrTab(window);
			return false;
		}
		var tab = document.getElementById("$TABLE");
		var href = window.frameElement.src;
		// 清除$TABLE参数
		var nPos = href.indexOf("$TABLE");
		if (nPos!=-1) {
			href = href.substring(0,nPos);
		}
		if (tab && tab.value) {
			if (href.indexOf("?")==-1)	{
				href += "?$TABLE=";
			} else
				href += "&$TABLE=";
			href += tab.value;
		}

		window.frameElement.src = href;

		return false;
	}
	// 根据返回点返回
	var back = getCookie("BACKPOINT");
	if (back) {
		document.location.href = back;
		return false;
	}

	if (browser.versions.mobile) {
		document.location.href = globalPath + "/navigator.jsp";
		return false;
	}

	window.close();

	return false;
}

// 提交前保存内容到服务器
function flowCommit(ajaxObj) {
	ajaxHandler(ajaxObj);
	top.window.showDialog(window,"流程提交",globalPath + "/workflow/process.cmd?$ACTION=route&mode=submit&wid=" + document.getElementById("$WID").value,"600","400");
}
// 跳转
function flowGoto(ajaxObj) {
	ajaxHandler(ajaxObj);
	top.window.showDialog(window,"流程跳转",globalPath + "/workflow/process.cmd?$ACTION=route&mode=goto&wid=" + document.getElementById("$WID").value,"600","400");
}
// 退回
function flowUntread(ajaxObj) {
	ajaxHandler(ajaxObj);
	top.window.showDialog(window,"工作驳回",globalPath + "/workflow/process.cmd?$ACTION=route&mode=untread&wid=" + document.getElementById("$WID").value,"600","400");
}
// 转办
function flowChange(ajaxObj) {
	ajaxHandler(ajaxObj);
	top.window.showDialog(window,"工作转办",globalPath + "/workflow/process.cmd?$ACTION=route&mode=change&wid=" + document.getElementById("$WID").value,"600","400");
}
// 转办
function flowAbort(ajaxObj) {
	ajaxHandler(ajaxObj);
	top.window.showDialog(window,"流程终止",globalPath + "/workflow/process.cmd?$ACTION=route&mode=abort&wid=" + document.getElementById("$WID").value,"600","400");
}
// 跳转到某页
function gotoPage(pageId) {
	// alert(pageId);
	return false;
}

// 取屏幕高度
function getClientHeight() {
	var clientHeight = 0;
	if (document.body.clientHeight && document.documentElement.clientHeight) {
		clientHeight = (document.body.clientHeight < document.documentElement.clientHeight) ? document.documentElement.clientHeight : document.body.clientHeight;
	} else {
		clientHeight = (document.body.clientHeight > document.documentElement.clientHeight) ? document.body.clientHeight : document.documentElement.clientHeight;
	}

	return clientHeight;
}

function getClientWidth() {
	var clientWidth = 0;
	if (document.body.clientWidth && document.documentElement.clientWidth) {
		clientWidth = (document.body.clientWidth < document.documentElement.clientWidth) ? document.documentElement.clientWidth : document.body.clientWidth;
	} else {
		clientWidth = (document.body.clientWidth > document.documentElement.clientWidth) ? document.body.clientWidth : document.documentElement.clientWidth;
	}

	return clientWidth;
}
// 打印某个标签下的内容
function printTag(tagId) {
	var u = navigator.userAgent;
	if (u.indexOf("MSIE 9.0")>0) {
		var win = window.open(document.location,"printwindow","",false);      
		win.alert("打印任务已经提交，请选择打印机！");
		win.document.body.innerHTML = win.document.getElementById(tagId).innerHTML;
		win.print();
		win.close();
		return false;
	}

	var tagPrint = document.getElementById(tagId);
	if (!tagPrint)	{
		window.print();
		return false;
	}
	var oldstr = document.body.innerHTML;
	document.body.innerHTML = tagPrint.innerHTML;
	window.print();
	document.body.innerHTML = oldstr;

	return false;
}

// 选择框是否被选定
function isSelected(tagId) {
	if (!tagId)
		tagId = "selected";
	var selected = document.getElementsByName(tagId);
	if (!selected) return false;
	for (var i=0;i<selected.length;i++) {
		if (selected[i].checked) {
			return true;
		}
	}

	return false;
}
// 取选择的值
function getSelectedValues(tagId) {
	if (!tagId)
		tagId = "selected";
	var v = "";
	var selected = document.getElementsByName(tagId);
	if (!selected) return "";
	for (var i=0;i<selected.length;i++) {
		if (selected[i].checked) {
			if (v!="")
				v += ",";
			v += selected[i].value;
		}
	}

	return v;
}
// 运行portlet页签
function runSubModuleTab(obj) {
	var module = obj.getAttribute("modid");
	var action = obj.getAttribute("action");
	var param = obj.getAttribute("params");

	var url = module + ".cmd?$ACTION=" + action;
	if (param) {
		url += "&" + param;
	}

	document.location.href = url;
}

// 填充移动浏览器的页面头部的导航，固定左侧为返回，右侧为其他,action为操作号，pos为位置：N-导航区，A-功能操作区
function bindActiontoToolbar(action,pos,name) {
	var btn;

	if (pos=="N") {
		btn = document.getElementById("$BACK");
		if (!btn) return;
		btn.setAttribute("actionid",action);
		return;
	}

	btn = document.getElementById("$BUTTON");
	if (!btn) return;

	btn.value = name;
	btn.setAttribute("actionid",action);
	btn.style.display = "block";
}
// 运行按钮功能
function onToolbarButtonClick(obj) {
	var action = obj.getAttribute("actionid");
	var id = obj.id;
	var btn = document.getElementById(action);;

	if (id=="$BACK") {
		if (!action || !btn) {  // 返回主页面
			document.location.href = globalPath + "/navigator.jsp";
			return false;
		}
		runFormCommand(btn);
		return false;
	}

	if (!btn) {
		return false;
	}

	obj.disabled = "true";
	runFormCommand(btn);
	obj.disabled = "";

	return false;
}

// 如果是弹出窗口，则不显示导航条
function hideNavigator() {
	var dlg = top.window.getDialog(window);
	if (!dlg) return;

	var obj = document.getElementById("$BACK");
	if (!obj) return;

	obj.parentNode.parentNode.removeChild(obj.parentNode);

	obj = document.getElementById("$TOP");
	if (obj) {
		obj.parentNode.removeChild(obj);
	}
}
// 保存移动端的返回点
function saveBackPoint() {
	setCookie("BACKPOINT",document.location.href);
}

// 获得Cookie解码后的值
function getCookieValue(key) 
{
	var str = document.cookie.indexOf (";", key);
	if (str == -1)
	str = document.cookie.length;

	return unescape(document.cookie.substring(key, str));
}
//设定Cookie值
function setCookie(name, value)  
{
	var expdate = new Date();
	var argv = setCookie.arguments;
	var argc = setCookie.arguments.length;
	var expires = (argc > 2) ? argv[2] : null;
	var path = (argc > 3) ? argv[3] : null;
	var domain = (argc > 4) ? argv[4] : null;
	var secure = (argc > 5) ? argv[5] : false;
	if(expires!=null) expdate.setTime(expdate.getTime() + ( expires * 1000 ));
	document.cookie = name + "=" + escape (value) + "; path=/" +((domain == null) ? "" : ("; domain=" + domain)) +((secure == true) ? "; secure" : "");
}
//删除Cookie
function delCookie(name)
{
	var exp = new Date();
	exp.setTime (exp.getTime() - 1);
	var cval = getCookie (name);
	document.cookie = name + "=" + cval + "; expires="+ exp.toGMTString();
}
//获得Cookie的原始值
function getCookie(name)
{
	var args = name + "=";
	var nArgs = args.length;
	var nLen = document.cookie.length;
	var i = 0;
	while (i < nLen)
	{
		var j = i + nArgs;
		if (document.cookie.substring(i, j) == args)
		return getCookieValue (j);
		i = document.cookie.indexOf(" ", i) + 1;
		if (i == 0) break;
	}

	return null;
}
// 取子标签类型为xx，子标签id的标签
function getSubTag(obj,tagName,id) {
	if (!obj || !id || !tagName)
		return null;

	var elements = obj.getElementsByTagName(tagName);
	for (var i=0;i<elements.length;i++) {
		if (elements[i].id==id || elements[i].name==id)
			return elements[i];
	}

	return null;
}

// 打开一个新窗口
function popupWindow(url) {
	var obj = document.createElement("form");
	document.body.appendChild(obj);
	obj.action = url;
	obj.target = "_blank";
	obj.submit();
	document.body.removeChild(obj);
	obj = null;
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
// 清除式样为datatable表格的空行
function removeNulRow() {
	var obj = getElementByClassName(document,"datatable");
	if (!obj || obj.tagName!="TABLE") {
		// alert("不是表格标签！");
		return;
	}

	if (obj.rows.length==0) return;

	var isEmpty;
	var str;
	for (var i=obj.rows.length-1;i>=0;i--) {
		isEmpty = true;
		for (var k=0;k<obj.rows[i].cells.length;k++) {
			str = obj.rows[i].cells[k].innerHTML;
			if (!str) continue;
			str = str.replace(/(^\s*)|(\s*$)/g,"");
			if (str)	{
				isEmpty = false;
				break;
			}
		}
		
		if (isEmpty) 
			obj.deleteRow(i);
	}
}
