var req;
var reqResponse;
var reqAction;

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

function AttachUpload(list_target,filetype,max){
	var self = this;
	this.list_target = list_target;
	this.filetype = filetype ? filetype.toLowerCase() : ""; // 格式为gif,jpg，多类型使用逗号隔开
	this.count = 0;
	this.id = 0;
	if( max ){
		this.max = max;
	} else {
		this.max = -1;
	};
	this.uploading = false;    // 是否正在上传附件
	this.progressBar;
	this.attachField;
	this.recordno = "0";      // 主记录号
	this.isImage;    // 附件类型
	this.attach;
	this.editable;      // 是否可以编辑附件
	this.formType = "FORM";      // 表单类型
	this.system = "";
	this.dictid = "";
	this.flag = "";
	this.wid = "";
	this.wordtext = "";
	this.param = "";

	this.getValue = function (key) {
		var v = self.attachField.getAttribute(key);
		if (!v || v==null) return '';
		return v;
	};
	this.init = function () {
		var editable = self.getValue("editable");
		if (!editable || editable!="true") {
			document.getElementById("btnFile").style.display = "none";
			self.editable = false;
		} else
			self.editable = true;
		self.isImage = self.getValue("isimage");
		self.formType = self.getValue("formtype");
		self.attach = self.getValue("attach");
		self.dictid = self.getValue("dictid");
		self.param = self.getValue("parents");
		self.flag = self.getValue("flag");
		self.recordno = self.getValue("parentpk");
		self.system = self.getValue("system");
		self.wid = self.getValue("wid");
		self.wordtext = self.getValue("wordtext");
		if (self.isImage=="true") { // 图片附件，只能为一个附件
			self.max = 1;
			self.filetype = "gif,jpg,png";
		} else {
			var v = self.getValue("maxamount");
			if (v) 
				self.max = Number(v);
			v = self.getValue("filetype");
			if (v)
				self.filetype = v;
		}

		document.getElementById("frupload").onload = function() {
			self.uploading = false;
			//alert(this.contentWindow.body.innerHTML);
			var retValue = this.contentWindow.document.body.innerHTML;
			retValue = retValue.replace(/\s/g, "");
			retValue = retValue.replace(/\r/g, "");
			retValue = retValue.replace(/\n/g, "");
			self.onFinishUpload(retValue);
			self.progressBar.parentNode.removeChild(self.progressBar);
			self.upload();
		};
		document.getElementById("frupload").onreadystatechange = function() {
			if(this.readyState=="complete"){
				self.uploading = false;
				//alert(document.getElementById("frupload").contentWindow.document.body.innerHTML);
				var retValue = document.getElementById("frupload").contentWindow.document.body.innerHTML;
				retValue = retValue.replace(/\s/g, "");
				retValue = retValue.replace(/\r/g, "");
				retValue = retValue.replace(/\n/g, "");
				self.onFinishUpload(retValue);
				self.progressBar.parentNode.removeChild(self.progressBar);
				self.upload();
			}
		};
		// 创建进度条
		self.progressBar = document.createElement("span");
		var span = document.createElement("span");
		span.style.cssFloat = "left";
		span.innerHTML = "&nbsp;&nbsp;进度";
		self.progressBar.appendChild(span);
		var progress = document.createElement("span");
		progress.style.cssFloat = "left";
		progress.className = "progressbar";
		span = document.createElement("span");
		span.style.width = "0px";
		span.id = "pBar";
		progress.appendChild(span);
		self.progressBar.appendChild(progress);
		span = document.createElement("span");
		span.className = "text";
		span.id = "percentComplete";
		self.progressBar.appendChild(span);
		span = document.createElement("span");
		span.className = "text";
		span.id = "bytesRead";
		self.progressBar.appendChild(span);
	};
	this.setAttachField = function (field) {
		self.attachField = field;
	};

	this.readProgress = function () {
		window.setTimeout(self.loadProgress, 1000);
	};

	this.loadProgress = function() {
		var url = "../../UploadService?$ACTION=progress&timestamp=" + (new Date()).getTime();
		if (window.XMLHttpRequest) { 
			req = new XMLHttpRequest();
		} else if (window.ActiveXObject) { 
			try {
				req = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				req = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		req.open("GET", url, true);
		req.onreadystatechange = self.processStateChange;
		req.send();
	};
	this.cancelUpload = function()	{
		var target = document.getElementById("frupload");

		target.src = "";
		self.uploading = false;
		self.onFinishUpload("fail");
		self.progressBar.parentNode.removeChild(self.progressBar);
		self.upload();
		var url = "../../UploadService?$ACTION=cancel&timestamp=" + (new Date()).getTime();
		if (window.XMLHttpRequest) { 
			reqResponse = new XMLHttpRequest();
		} else if (window.ActiveXObject) { 
			try {
				reqResponse = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				reqResponse = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		reqResponse.open("GET", url, true);
		reqResponse.onreadystatechange = self.cancelHandle;
		reqResponse.send();
	};
	this.delAttach = function(attachid) {
		var url = "../../UploadService?$ACTION=delete&id=" + attachid + "&timestamp=" + (new Date()).getTime();
		if (window.XMLHttpRequest) { 
			reqAction = new XMLHttpRequest();
		} else if (window.ActiveXObject) { 
			try {
				reqAction = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				reqAction = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		reqAction.open("GET", url, true);
		reqAction.send();
	};
	// 显示附件
	this.loadAttach = function(attachs) {
		if (!attachs) return;
		var url = "../../UploadService?$ACTION=attach&attachs=" + attachs + "&timestamp=" + (new Date()).getTime();
		if (window.XMLHttpRequest) { 
			reqAction = new XMLHttpRequest();
		} else if (window.ActiveXObject) { 
			try {
				reqAction = new ActiveXObject("Msxml2.XMLHTTP");
			} catch (e) {
				reqAction = new ActiveXObject("Microsoft.XMLHTTP");
			}
		}
		reqAction.open("GET", url, true);
		reqAction.onreadystatechange = self.showAttachs;
		reqAction.send();
	};
	// 处理附件返回结果
	this.showAttachs = function() {
		if (reqAction.readyState!=4) return;
		if (reqAction.status!=200) return;
		var xml = reqAction.responseXML;
		if (!xml.getElementsByTagName("attach") || xml.getElementsByTagName("attach").length==0) return;
		xml = xml.getElementsByTagName("attach");
		var no;
		var id;   // 附件号
		var file; // 附件文件名
		var size; // 附件大小
		var owner; // 是否所有者
		for (no=0;no<xml.length ;no++ )	{
			var attach = xml[no];
			id = attach.getElementsByTagName("id")[0].firstChild.data;
			file = attach.getElementsByTagName("file")[0].firstChild.data;
			size = attach.getElementsByTagName("size")[0].firstChild.data;
			owner = attach.getElementsByTagName("owner")[0].firstChild.data;
			self.showAttach(id,file,size,owner);
		}
		// 校对附件个数，是否让再进行上传
		if (self.count>self.max) {
			document.getElementById("btnFile").style.display = "none";
		}
		// 显示图片附件
		if (self.isImage=="true" && xml.length>0) {
			self.current_element.disabled = true;
			document.getElementById("btnFile").style.display = "none";
			var img = document.getElementById("imga");
			img.src = "../../UploadService?$ACTION=image&id=" + xml[0].getElementsByTagName("id")[0].firstChild.data;
			document.getElementById("attachsarea").style.display = "none";
			img.style.display = "block";
			img.style.width = self.attachField.style.width;
			img.style.height = self.attachField.style.height;
			img.onclick = function() {
				// 是否为只读
				if (!self.editable) return false;
				this.style.display = "none";
				document.getElementById("attachsarea").style.display = "block";
			};
			return;
		}
		if (window.frameElement && self.isImage!="true")
			window.frameElement.style.height = document.body.scrollHeight + "px";
	};

	this.cancelHandle = function() {
		if (reqResponse.readyState == 4 && reqResponse.status == 200) { // OK response
			self.onFinishUpload("fail");
		}
	};
	this.processStateChange = function() {
		if (req.readyState!=4) return;
		if (req.status!=200) return;

		var xml = req.responseXML;

		var uploading = null;
		if (xml.getElementsByTagName("finished") && xml.getElementsByTagName("finished").length>0)
			uploading = xml.getElementsByTagName("finished")[0];
		var isFail = null;
		if (xml.getElementsByTagName("exception") && xml.getElementsByTagName("exception").length>0)
			isFail = xml.getElementsByTagName("exception")[0];
		var myBytesRead = null;
		if (xml.getElementsByTagName("read") && xml.getElementsByTagName("read").length>0)
			myBytesRead = xml.getElementsByTagName("read")[0];
		var myContentLength = null;
		if (xml.getElementsByTagName("length") || xml.getElementsByTagName("length").length>0)
			myContentLength = xml.getElementsByTagName("length")[0];
		var myPercent = null;
		if (xml.getElementsByTagName("percent") || xml.getElementsByTagName("percent").length>0)
			myPercent = xml.getElementsByTagName("percent")[0];
		if ((uploading==null || (typeof uploading)=="undefined") && (myPercent==null || (typeof myPercent)=="undefined")) {
			return;
		}
		if (isFail)
			isFail = isFail.firstChild.data;
		if (isFail) {
			document.getElementById("percentComplete").innerHTML = "Fail!";
			self.uploading = false;
			self.upload();
			return;
		}
		
		myBytesRead = myBytesRead.firstChild.data;
		myContentLength = myContentLength.firstChild.data;
		if (((typeof uploading)=="undefined") || uploading==null) // It's started, get the status of the upload
		{
			myPercent = myPercent.firstChild.data;
			if (document.getElementById("pBar"))
				document.getElementById("pBar").style.width = myPercent + "%";
			if (document.getElementById("bytesRead"))
				document.getElementById("bytesRead").innerHTML = "已上传:" + myBytesRead + "K," + "总共:" + myContentLength + "K";
			if (document.getElementById("percentComplete"))
				document.getElementById("percentComplete").innerHTML = myPercent + "%";
			self.readProgress();
		}
		else {
			if (document.getElementById("pBar"))
				document.getElementById("pBar").style.width = "100%";
			if (document.getElementById("bytesRead"))
				document.getElementById("bytesRead").innerHTML = "";
			if (document.getElementById("percentComplete"))
				document.getElementById("percentComplete").innerHTML = "100% " + "已上传," + "大小:" + myContentLength + "K";
		}
	};

	this.upload = function () {
		if (self.uploading) return;
		var curIndex = -1;
		var i = 0;
		var state;
		for (i=0;i<=self.id ;i++) {
			state = document.getElementById('state' + i);
			if (state && state.value=='wait') {
				curIndex = i;
				break;
			}
		}
		if (curIndex==-1) return;
		self.uploading = true;
		// 设置状态
		state = document.getElementById('state' + curIndex);
		state.value = 'uploading';
		var form = document.getElementById('form' + curIndex);
		form.appendChild(self.progressBar);
		document.getElementById("pBar").style.width = '0%';
		form.submit();
		window.setTimeout(self.loadProgress, 1000);
	};

	/**
	 * 添加新按钮
	 */
	this.addElement = function(element){
		if( element.tagName!= 'INPUT' || element.type!='file'){
			alert( 'Error: not a file input element' );
			return;
		}
		element.name = 'file_' + self.id;
		element.id = 'file_' + self.id;
		element.multi_selector = this;
		element.onchange = function(){
			if (self.filetype)	{ // 判断选择的文件类型是否正确
				if (self.filetype.indexOf(",")==-1)	{
					if (this.value.substring(this.value.length-self.filetype.length).toLowerCase()!=self.filetype) {
						alert("您所选择的文件类型必须是" + self.filetype + "类型的文件！");
						return;
					}
				} else {
					var str = self.filetype.split(",");
					var isOK = false;
					for (var i=0;i<str.length ;i++ ) {
						if (this.value.substring(this.value.length-str[i].length).toLowerCase()==str[i]) {
							isOK = true;
							break;
						}
					}
					if (!isOK)	{
						alert("您所选择的文件类型必须是" + self.filetype + "类型的文件！");
						return;
					}
				}
			}
			var new_element = document.createElement('input');
			new_element.type = 'file';
			new_element.name = 'file_' + (self.id + 1);
			new_element.id = 'file_' + (self.id + 1);
			this.parentNode.insertBefore( new_element, this );
			this.multi_selector.addElement( new_element );
			var form = this.multi_selector.addListRow( this );
			this.style.position = 'absolute';
			this.style.left = '-1000px';
			this.parentNode.removeChild(this);
			form.appendChild(this);
			if (window.frameElement && self.isImage!="true")
				window.frameElement.style.height = document.body.scrollHeight + "px";
			self.upload();
		};
		if( this.max != -1 && this.count >= this.max ){
			document.getElementById("btnFile").style.display = "none";
			element.disabled = true;
		};
		this.count++;
		this.current_element = element;
	};
	/**
	 * 添加新列表
	 */
	this.addListRow = function(element){
		var form = document.createElement('form');
		form.method = 'post';
		form.action = '../../UploadService?attach=' + self.attach;
		if (self.param)	{
			var params = self.param.split(",");
			var param = "";
			for (var i=0;i<params.length;i++) {
				if (!window.parent.document.getElementById(params[i])) continue;
				if (param) {
					param += ",";
				}
				param += window.parent.document.getElementById(params[i]).value;
			}
			form.action += "&param=" + param;
		}
		form.enctype = 'multipart/form-data';
		form.encoding = 'multipart/form-data';
		form.target = 'frupload';
		form.id = 'form' + self.id;
		form.name = 'form' + self.id;
		form.style.margin = '0px';
		form.style.padding = '0px';
		form.style.height = "24px";

		var state = document.createElement('input');
		state.type = 'hidden';
		state.id = 'state' + self.id;
		state.value = 'wait';

		var attachid = document.createElement('input');
		attachid.type = 'hidden';
		attachid.id = 'attach' + self.id;

		var action = document.createElement('a');
		action.id = 'del' + self.id;
		action.href = '#';
		action.innerHTML = "取消";

		// 设置主记录号
		var wid = document.createElement('input');
		wid.type = 'hidden';
		wid.id = 'wid';
		wid.name = 'wid';
		wid.value = self.recordno;
		// 设置附件类型
		var atype = document.createElement('input');
		atype.type = 'hidden';
		atype.id = 'attachtype';
		atype.name = 'attachtype';
		atype.value = self.isImage;
		// 记录域号
		var field = document.createElement('input');
		field.type = 'hidden';
		field.id = 'field';
		field.name = 'field';
		field.value = self.attachField.id;

		var system = document.createElement("input");
		system.type = "hidden";
		system.id = "system";
		system.name = "system";
		system.value = self.system;

		var dict = document.createElement("input");
		dict.type = "hidden";
		dict.id = "dictid";
		dict.name = "dictid";
		dict.value = self.dictid;

		var flag = document.createElement("input");
		flag.type = "hidden";
		flag.id = "flag";
		flag.name = "flag";
		flag.value = self.flag;

		var ftype = document.createElement("input");
		ftype.type = "hidden";
		ftype.id = "formtype";
		ftype.name = "formtype";
		ftype.value = self.formType;

		var attach = document.createElement("input");
		attach.type = "hidden";
		attach.id = "attach";
		attach.name = "attach";
		attach.value = self.attach;

		form.element = element;

		action.onclick= function(){
			var index = action.id.substring(3);
			// 如果未上传
			var obj = document.getElementById('state' + index);
			// 如果在上传中
			if (obj.value=='uploading')	{
				self.cancelUpload();
				return false;
			}
			self.delRow(this);
			return false;
		};
		var span = document.createElement('span');
		span.style.cssFloat = "left";
		span.innerHTML = this.getUploadFile(element.value);
		span.appendChild( action);
		form.appendChild(span);
		form.appendChild(state);
		form.appendChild(attachid);
		form.appendChild(wid);
		form.appendChild(atype);
		form.appendChild(field);
		form.appendChild(ftype);
		form.appendChild(attach);
		form.appendChild(system);
		form.appendChild(dict);
		form.appendChild(flag);
		this.list_target.appendChild(form);
		self.id++;
		return form;
	};
	// 处理文件名，将文件夹去除，显示文件图标
	this.getUploadFile = function (file) {
		if (!file) return null;
		var nPos = file.lastIndexOf("\\");
		if (nPos==-1)
			nPos = file.lastIndexOf("/");
		var str = file;
		if (nPos!=-1)
			str = file.substring(nPos+1);
		// 取文件的扩展名
		nPos = str.lastIndexOf(".");
		var ext = "";
		if (nPos!=-1)
			ext = str.substring(nPos+1);
		ext = ext.toLowerCase();
		if (ext=="doc")
			ext += ".gif";
		else if (ext=="docx")
			ext += ".gif";
		else if (ext=="htm" || ext=="html")
			ext = "htm.gif";
		else if (ext=="pdf")
			ext += ".gif";
		else if (ext=="ppt")
			ext += ".gif";
		else if (ext=="pptx")
			ext += ".gif";
		else if (ext=="rar")
			ext += ".gif";
		else if (ext=="txt")
			ext += ".gif";
		else if (ext=="xls")
			ext += ".gif";
		else if (ext=="xlsx")
			ext += ".gif";
		else if (ext=="zip")
			ext += ".gif";
		else
			ext = "attach.gif";

		return "<img src=\"" + ext + "\" align=absmiddle border=0>&nbsp;<span id=\"name" + self.id + "\">" + str + "</span>&nbsp;"; 
	};
	// 操作父级页面的附件域的内容
	this.writeAttachValue = function () {
		var i = 0;
		var attach;
		var file;
		var value = '';
		var name = '';
		for (i=0;i<=this.id ;i++) {
			attach = document.getElementById('attach' + i);
			if (!attach || isNaN(attach.value)) continue;
			if (value!='')
				value += ',';
			value += attach.value;
			file = document.getElementById('name' + i);
			if (!file) continue;
			file = file.innerHTML;
			var nPos = file.lastIndexOf("\\");
			if (nPos==-1)
				nPos = file.lastIndexOf("/");
			var str = file;
			if (nPos!=-1)
				str = file.substring(nPos+1);
			if (name!='')
				name += '\2';
			name += str;		
		}
		self.attachField.value = value;
		self.attachField.setAttribute('attachname',name);
	};
	// 显示一个附件到列表
	this.showAttach = function (attachid,file,size,owner) {
		var div = document.createElement('div');
		div.style.width = '100%';
		div.element = this;

		var span = document.createElement('span');
		span.innerHTML = self.getUploadFile(file);
		div.appendChild(span);

		if (self.editable) {
			// 加删除按钮
			if (owner=="true" && !self.wordtext) {
				var action = document.createElement('a');
				action.className = "text";
				action.id = 'del' + self.id;
				action.href = '#';
				action.innerHTML = "删除";
				action.onclick= function(){
					self.delAttach(attachid);
					this.parentNode.parentNode.parentNode.removeChild( this.parentNode.parentNode);
					self.count--;
					self.current_element.disabled = false;
					document.getElementById("btnFile").style.display = "block";
					if (window.frameElement && self.isImage!="true")
						window.frameElement.style.height = document.body.scrollHeight + "px";
					self.writeAttachValue();
					return false;
				};
				span.appendChild(action);
			}
		}
		// 加在线编辑和下载
		self.addAttachAction(span,file,attachid);
		
		var attach = document.createElement('input');
		attach.type = 'hidden';
		attach.id = 'attach' + self.id;
		attach.name = 'attach' + self.id;
		attach.value = attachid;
		div.appendChild(attach);

		self.count++;
		self.id++;
		self.list_target.appendChild(div);
	};

	this.addAttachAction = function(span,file,attachid) {
		if (browser.versions.mobile) {
			// 加下载
			var action = document.createElement('a');
			action.className = "text";
			action.href = '../../UploadService?$ACTION=down&id=' + attachid ;
			action.innerHTML = "下载";
			action.target = '_blank';
			span.appendChild(action);
			return false;
		}
		// 加在线编辑
		var ext = file.substring(file.lastIndexOf('.')+1).toLowerCase();
		if (ext=='doc' || ext=='docx' || ext=='xls' || ext=='xlsx' || ext=='ppt' || ext=='pptx')	{
			var action = document.createElement('a');
			action.className = "text";
			action.href = '#';
			if (self.editable) 
				action.innerHTML = "编辑";
			else
				action.innerHTML = "打开";
			action.onclick= function(){
				if (navigator.appName!="Microsoft Internet Explorer") {
					alert("本功能只能在IE浏览器下使用！");
					return;
				}
				var uri = "plugins/office/editor.jsp?id=" + attachid + "&editable=" + (self.editable ? "true" : "false");
				if (self.wordtext) {
					uri = "plugins/office/wordtext.jsp?$WID=" + self.wid + "&$WORDTEXT=" + self.wordtext;
				}
				top.window.showDialog(window,"在线OFFICE文件编辑",uri,"1024","768");

				//if (navigator.userAgent.indexOf("MSIE 8.0")!=-1) {
				//	window.open(uri,"附件内容","height=768,width=1024,top=0,left=0,toolbar=no,menubar=no,scrollbars=no,resizable=yes,location=no,status=no");
				//	return;
				//}

				//window.showModalDialog(uri, "在线编辑", "dialogHeight: 768px; dialogWidth: 1024px; dialogTop: "+(event.clientY-window.height)+"px;dialogLeft: "+(event.clientX-window.width)+"px; center: Yes; help: Yes; resizable:No; status: No; Scroll:Yes");

				return false;
			};
			span.appendChild(action);
		}
		// 加下载
		var action = document.createElement('a');
		action.className = "text";
		action.href = '../../UploadService?$ACTION=down&id=' + attachid ;
		if (ext=='gif' || ext=='jpg' || ext=='png' || ext=='tiff' || ext=='tif' || ext=='bmp')
			action.innerHTML = "打开";
		else
			action.innerHTML = "下载";
		action.target = '_blank';
		span.appendChild(action);
	};
	// 删除列表
	this.delRow = function (delAction) {
		if (!delAction.parentNode.parentNode.element) return false;
		
		// 后台打删除标志
		var attachid = "attach" + delAction.id.substring(3);
		attachid = document.getElementById(attachid).value;
		if (attachid)
			self.delAttach(attachid);

		delAction.parentNode.parentNode.element.parentNode.removeChild( delAction.parentNode.parentNode.element );
		delAction.parentNode.parentNode.parentNode.removeChild( delAction.parentNode.parentNode);
		delAction.parentNode.parentNode.element.multi_selector.count--;
		delAction.parentNode.parentNode.element.multi_selector.current_element.disabled = false;
		document.getElementById("btnFile").style.display = "block";
		if (window.frameElement && self.isImage!="true")
			window.frameElement.style.height = document.body.scrollHeight + "px";
		self.writeAttachValue();
	};
	// 附件传送完毕，修改状态
	this.onFinishUpload = function (result) {
		// 查找哪个文件是正在上传状态
		var i = 0;
		var obj;
		for (i=0;i<=self.id ;i++) {
			obj = document.getElementById('state' + i);
			if (!obj) continue;
			if (obj.value=='uploading')	{
				obj.value = 'uploaded';
				// 设置“取消”为删除
				obj = document.getElementById('del' + i);
				obj.innerHTML = "删除";
				if (result=='fail') {
					obj.innerHTML = "删除 [上传失败]";;
					break;
				}
				if (result=='exceed') {
					obj.innerHTML = "删除 [附件大小超过限制]";
					break;
				}
				// 取当前标签的父标签
				var objParent = obj.parentNode;
				obj = document.getElementById('attach' + i);
				obj.value = result;
				obj = document.getElementById('name' + i);
				var file = obj.innerHTML;
				// 加在线编辑和下载
				self.addAttachAction(objParent,file,result);
				break;
			}
		}
		self.writeAttachValue();
		if (result=='fail') return;
		if (result=='exceed') return;

		if (self.isImage=="true") { // 图片附件，显示为图片
			var img = document.getElementById("imga");
			img.src = "../../UploadService?$ACTION=image&id=" + result;
			img.onclick = function () {
				this.style.display = "none";
				document.getElementById("attachsarea").style.display = "block";
			};
			document.getElementById("attachsarea").style.display = "none";
			img.style.display = "block";
			img.style.width = self.attachField.style.width;
			img.style.height = self.attachField.style.height;
			return;
		}
		if (window.frameElement && self.isImage!="true")
			window.frameElement.style.height = document.body.scrollHeight + "px";
	};
}