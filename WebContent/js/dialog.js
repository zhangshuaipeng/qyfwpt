function Dialog(obj,title,url,width,height,callback) {
	var self = this;

	this.parentWindow = obj;   // 实际的父窗口
	this.divDialog;
	this.divMask;
	this.title = title;
	this.url = url;
	this.width = width;
	this.height = height;
	this.divWait;
	this.callback = callback;    // 回调函数
	this.commited = false;
	this.srcTarget = null;
	this.grid = null;
	this.rowId = null;
	this.fieldid = null;
	this.Id = null;
	this.scrollTop = document.body.scrollTop;


	this.Init = function (obj,grid,rowId,fieldid) {
		self.srcTarget = obj;
		self.grid = grid;
		self.rowId = rowId;
		self.fieldid = fieldid;
		if (!self.width)
			self.width = "400";
		if (!self.height)
			self.height = "300";
		// 对于超宽,则取窗口
		if (self.width>=self.getClientWidth() - 20)
			self.width = self.getClientWidth() - 20;
		if (self.height>=self.getClientHeight() - 20)
			self.height = self.getClientHeight() - 20;

		var id = "dialog-" + (new Date()).getTime();
		self.Id = id;
		var mobile = document.getElementById("$MOBILE");
		if (!mobile)
			mobile = "N";
		else {
			mobile = mobile.value;
			if (!mobile)
				mobile = "N";
		}
		if (browser.versions.mobile || mobile=="Y") {
			self.createMobileDialg(id);
			return id;
		}


		//self.divMask = document.createElement("div");
		//self.divMask.className = "window-mask";
		//self.divMask.style.zIndex = self.getzIndex();
		//document.body.appendChild(self.divMask);
		self.divMask = document.createElement("iframe");
		self.divMask.className = "window-mask";
		self.divMask.style.zIndex = self.getzIndex();
		document.body.appendChild(self.divMask);
		// self.showProgress();
		self.recalc();
		self.divDialog = document.createElement("div");
		self.divDialog.className = "window";
		self.divDialog.style.width = self.width + "px";
		self.divDialog.style.height = self.height + "px";
		// self.divDialog.style.display = "none";
		self.divDialog.style.zIndex = self.getzIndex();
		// 计算起始位置
		self.divDialog.style.left = (document.body.clientWidth - self.width)/2 + "px";
		self.divDialog.style.top = ((document.body.clientHeight - self.height)/2) + "px";
		
		var frame = document.createElement("div");
		frame.className = "shadow";
		self.divDialog.appendChild(frame);

		var div = document.createElement("div");
		div.className = "tl";
		var t = document.createElement("div");
		t.className = "tr";
		div.appendChild(t);
		frame.appendChild(div);

		div = document.createElement("div");
		self.attachEvent(div);
		div.className = "hl";
		frame.appendChild(div);
		t = document.createElement("div");
		t.className = "hr";
		div.appendChild(t);
		div = document.createElement("div");
		div.className = "hm";
		t.appendChild(div);
		t = document.createElement("div");
		t.className = "header header-move";
		div.appendChild(t);
		div = document.createElement("div");
		div.className = "icon close";
		div.onmousedown = self.close;
		t.appendChild(div);
		div = document.createElement("h1");
		div.innerHTML = self.title;
		div.className = "titleleft";
		t.appendChild(div);
		div = document.createElement("h1");
		div.innerHTML = "&nbsp;";
		div.className = "titleright";
		t.appendChild(div);

		div = document.createElement("div");
		div.className = "cl";
		frame.appendChild(div);
		t = document.createElement("div");
		t.className = "cr";
		div.appendChild(t);
		div = document.createElement("div");
		div.className = "cm";
		t.appendChild(div);
		t = document.createElement("div");
		t.className = "cnt";
		div.appendChild(t);
		div = document.createElement("iframe");
		div.style.width = "100%";
		div.style.height = (self.height - 30 - 6) + "px";
		div.style.border = "0px";
		div.frameBorder = "no";
		div.src = self.url;
		div.id = id;
		// self.setIframeEvt(div);
		t.appendChild(div);

		div = document.createElement("div");
		div.style.clear = "both";
		frame.appendChild(div);

		div = document.createElement("div");
		div.className = "bl";
		frame.appendChild(div);
		t = document.createElement("div");
		t.className = "br";
		div.appendChild(t);
		
		document.body.appendChild(self.divDialog);

		return id;
	}
	
	this.createMobileDialg = function (id) {
		self.recalc();
		self.divDialog = document.createElement("div");
		self.divDialog.className = "dialog";
		self.divDialog.style.width = "100%";
		self.divDialog.style.height = "100%";
		self.divDialog.style.zIndex = self.getzIndex();
		// 计算起始位置
		self.divDialog.style.left = "0px";
		self.divDialog.style.top = "0px";
		self.divDialog.style.background = "#ffffff";
		document.body.scrollTop = 0;
		
		var div = document.createElement("div");
		div.style.height = "36px";
		div.className = "dlgtitle";
		var t = document.createElement("span");
		t.innerHTML = self.title;
		t.style.fontWeight = "bold";
		div.appendChild(t);
		t = document.createElement("a");
		t.className = "dlgclose";
		t.innerHTML = "关闭";
		t.onclick = self.close;
		div.appendChild(t);
		self.divDialog.appendChild(div);

		div = document.createElement("iframe");
		div.style.width = "100%";
		div.style.height = (self.getClientHeight() - 38) + "px";
		div.style.border = "0px";
		div.frameBorder = "no";
		div.src = self.url;
		div.id = id;
		// self.setIframeEvt(div);
		self.divDialog.appendChild(div);

		document.body.appendChild(self.divDialog);
	}
	this.getzIndex = function () {
		top.window.maxZindex++;

		return top.window.maxZindex;
	}
	this.recalc = function () {
		self.width = parseInt(self.width);
		self.height = parseInt(self.height);
		if (!self.title)
			self.title = "Untitled";
		if (self.width>document.body.clientWidth-20)
			self.width = document.body.clientWidth - 20;
		if (self.height>document.body.clientHeight-30)
			self.height = document.body.clientHeight - 30;
	}

	this.attachEvent = function (obj) {
		obj.onmousedown = function(e){
			if(!e) e = window.event;
			var x = e.layerX ? e.layerX : e.offsetX, y=e.layerY ? e.layerY : e.offsetY;
			if(self.divDialog.setCapture)
				self.divDialog.setCapture();
			else if(window.captureEvents)
				window.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);
			
			document.onmousemove = function(e){
				if(!e)e = window.event;
				if(!e.pageX)e.pageX = e.clientX;
				if(!e.pageY)e.pageY = e.clientY;
				var tx = e.pageX-x,ty=e.pageY-y;
				self.divDialog.style.left = tx + "px";
				self.divDialog.style.top = ty + "px";
			}

			document.onmouseup=function(){
				if(self.divDialog.releaseCapture)
					self.divDialog.releaseCapture();
				else if(window.releaseEvents)
					window.releaseEvents(Event.MOUSEMOVE|Event.MOUSEUP);
				document.onmousemove=null;
				document.onmouseup=null;
			}
		}
	}

	this.setIframeEvt = function (iframe) {
		iframe.onload=function(){
			self.HideProgress();
			self.divDialog.style.display = "block";
			if (!self.divWait)
				self.commited = true;
		}   
		iframe.onreadystatechange=function(){
			if(this.readyState=="complete"){
				self.HideProgress();
				self.divDialog.style.display = "block";
				if (!self.divWait)
					self.commited = true;
				
			}
		}
	}

	this.showProgress = function () {
		var x,y;
		var obj = document.body;
		x = obj.clientWidth;
		y = obj.clientHeight;
		if (y>screen.height)
			y = screen.height;

		var top = (y/2) - 50+obj.scrollTop;
		var left = (x/2) - 150+obj.scrollLeft;
		if( left<=0 ) left = 10;
		if( top<=0 ) top = 10;
		var el = document.createElement("DIV");
		el.style.position="absolute";
		el.style.visibility ='visible';
		el.style.display = 'block';
		el.style.left = left + "px"
		el.style.top = top + "px";
		el.style.width = "300px";
		el.style.height = "100px";
		el.style.zIndex = self.getzIndex();
		el.innerHTML = "<table border=0 cellspacing=0 width=200 height=100 bgcolor=white><tr><td align=center><img src=images/loading.gif align=center/></td><td><strong>数据载入中...</strong><br /><span style='font-size:8pt;'>Initializing......</span></td></tr></table>";
		self.divWait = el;
		obj.insertBefore(el,obj.firstChild);
	}

	this.HideProgress = function () {
		if (self.divWait) {
			self.divWait.parentNode.removeChild(self.divWait);
			self.divWait.innerHTML = "";
		}
		self.divWait = null;
	}
	// 窗口内容提交，然后关闭
	this.submit = function (value) {
		var callback = self.callback;
		if (!callback) {
			self.close();
			return;
		}

		eval(callback + ".call(this,self.parentWindow,self.srcTarget,'" + value + "',self.grid,self.rowId,self.fieldid)");
		self.close();
	}

	this.close = function () {
		var iframe = document.getElementById(self.Id);
		iframe.parentNode.removeChild(iframe);
		if (self.divMask) {
			self.divMask.parentNode.removeChild(self.divMask);
			self.divMask = null;
		}
		self.divDialog.parentNode.removeChild(self.divDialog);
		self.divDialog.innerHTML = "";
		self.divDialog = null;
		document.body.scrollTop = self.scrollTop;
		var mobile = document.getElementById("$MOBILE");
		if (!mobile)
			mobile = "N";
		else {
			mobile = mobile.value;
			if (!mobile)
				mobile = "N";
		}
		if (browser.versions.mobile || mobile=="Y") {
			document.body.scrollTop = self.scrollTop;
		}
	}
	// 设置回调函数
	this.setCallbackFunc = function (func) {
		self.callback = func;
	}

	this.getParentWindow = function () {
		return self.parentWindow;
	}
	
	this.getParentDocument = function () {
		return self.parentWindow.document;
	}

	this.returnValue = function (v) {

	}

	// 取屏幕高度
	this.getClientHeight = function () {
		var clientHeight = 0;
		if (document.body.clientHeight && document.documentElement.clientHeight) {
			clientHeight = (document.body.clientHeight < document.documentElement.clientHeight) ? document.documentElement.clientHeight : document.body.clientHeight;
		} else {
			clientHeight = (document.body.clientHeight > document.documentElement.clientHeight) ? document.body.clientHeight : document.documentElement.clientHeight;
		}

		return clientHeight;
	}

	// 取屏幕高度
	this.getClientWidth = function () {
		var clientWidth = 0;
		if (document.body.clientWidth && document.documentElement.clientWidth) {
			clientWidth = (document.body.clientWidth < document.documentElement.clientWidth) ? document.documentElement.clientWidth : document.body.clientWidth;
		} else {
			clientWidth = (document.body.clientWidth > document.documentElement.clientWidth) ? document.body.clientWidth : document.documentElement.clientWidth;
		}

		return clientWidth;
	}
}
