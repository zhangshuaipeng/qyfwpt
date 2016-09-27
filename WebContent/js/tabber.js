function Tabber() {
	var self = this;

	this.tab;
	this.divLeft;
	this.divRight;
	this.container;
	this.ul;
	this.selectedLI;
	this.divFrame;

	this.timer;
	this.tabs;

	this.Init = function(id) {
		self.tabs = new Array();
		self.tab = document.getElementById(id);
		if (!self.tab)	{
			alert("û������ҳǩID!");
			return;
		}
		self.tab.className = "tabheader";
		// ����ʽ��
		self.tab.style.position = "relative";
		// ����������
		self.divFrame = document.createElement("div");
		self.divFrame.style.overflow = "hidden";
		self.divFrame.style.clear = "both";
		self.tab.parentNode.appendChild(self.divFrame);
		// �����������
		self.divLeft = document.createElement("div");
		self.divLeft.className = "tab-toleft";
		self.divLeft.onmousedown = self.scrollLeftStart;
		self.divLeft.onmouseup = self.scrollStop;
		self.divLeft.onmouseout = self.scrollStop;
		self.tab.appendChild(self.divLeft);
		// ����ҳǩ����
		self.container = document.createElement("div");
		self.container.className = "tabcontainer";
		if (!self.tab.offsetWidth)
			self.container.style.width = "480px";
		else
			self.container.style.width = self.tab.offsetWidth + "px";
		self.ul = document.createElement("ul");
		self.ul.style.width = self.container.style.width;
		self.container.appendChild(self.ul);
		self.disableSelection(self.ul);
		self.disableSelection(self.container);
		self.disableSelection(self.tab);
		self.tab.appendChild(self.container);
		// �����ҹ�����
		self.divRight = document.createElement("div");
		self.divRight.className = "tab-toright";
		self.divRight.onmousedown = self.scrollRightStart;
		self.divRight.onmouseup = self.scrollStop;
		self.divRight.onmouseout = self.scrollStop;
		self.tab.appendChild(self.divRight);
		// ��ʾ����
		self.divLeft.style.display = "none";
		self.divRight.style.display = "none";
	}

	this.scrollLeftStart = function () {
		if (self.timer)
			window.clearInterval(self.timer);		
		self.timer = window.setInterval(function () {self.container.scrollLeft -= 25;},100);
		return false;
	}

	this.scrollStop = function () {
		if (self.timer)
			window.clearInterval(self.timer);	
		if (!self.timer) return;
		if (self.container.scrollLeft + self.container.clientWidth >= self.ul.offsetWidth) {
			self.divLeft.disabled = false;
			self.divRight.disabled = true;
			return;
		}
		if (self.container.scrollLeft==0) {
			self.divLeft.disabled = true;
			self.divRight.disabled = false;
			return;
		}
		self.timer = null;
		self.divLeft.disabled = false;
		self.divRight.disabled = false;
	}

	this.scrollRightStart = function () {
		if (self.timer)
			window.clearInterval(self.timer);		
		self.timer = window.setInterval(function () {self.container.scrollLeft += 25; },100);
		return false;
	}
	// id-��ǩ��;title-ҳǩ����,url-ҳǩ��URL,icon-��ʾ��ͼ��,btnClose-�Ƿ���ʾ�ر�ͼ��true/false,activeRefresh-����ҳǩ�����ظ�ҳǩtrue/false
	this.addTab = function (id,title,url,icon,btnClose,activeRefresh) {
		if (!title)	{
			alert("������ⲻ��Ϊ��!");
			return;
		}
		var li;
		if (!id)
			id = (new Date()).getTime();
		if ((id in self.tabs) && self.tabs[id]) {
			li = self.tabs[id];
			var nIndex = self.getTabIndex(li);
			self.refresh(nIndex,url);
		} else {
			li = self.createTabPage(id,title,url,icon,btnClose,activeRefresh);
			self.tabs[id] = li;
		}

		self.selectedLI = li;
		self.setSelected();
	}
	// ��������iframe��ҳǩ
	this.addTabNoIframe = function (id,title,url) {
		if (!title)	{
			alert("������ⲻ��Ϊ��!");
			return;
		}
		var li;
		if (!id)
			id = (new Date()).getTime();
		li = self.createTabSinglePage(id,title,url);
		self.tabs[id] = li;
		
		// self.selectedLI = li;
		// self.setSelected();
	}
	// ѡ��ĳ��ҳǩ
	this.setTagSelected = function (id) {
		var li = self.tabs[id];
		if (!li)
			li = self.tabs[0];
		self.selectedLI = li;
		self.setSelected();
	}
	// ����������ҳǩ	
	this.createTabSinglePage = function (id,title,url) {
		var li = document.createElement("li");
		li.className = "selected";
		li.style.cursor = "pointer";
		var a = document.createElement("a");

		var span = document.createElement("span");
		span.innerHTML = title;
		a.appendChild(span);
		li.appendChild(a);
		li.setAttribute("action",url);

		li.onmouseover = function (e) {
			this.className = "selected";
		}
		li.onmouseout = function (e) {
			if (this==self.selectedLI)
				return;
			this.className = "";
		}
		li.onclick = function (e) {
			//if (this==self.selectedId)
			//	return;
			var action = this.getAttribute("action");
			if (action.indexOf("javascript:")==0) {
				eval(action);
			} else
				document.location.href = action;
			return false;
		}
		self.ul.appendChild(li);
		self.calcTabsWidth();
		self.disableSelection(li);

		return li;
	}

	this.createTabPage = function (id,title,url,icon,btnClose,activeRefresh) {
		var li = document.createElement("li");
		li.className = "selected";
		li.style.cursor = "pointer";
		if (activeRefresh)	{
			li.setAttribute("refresh","true");
		}
		var a = document.createElement("a");
		if (icon) {
			var img = document.createElement("img");
			if (!icon)
				icon = "images/leaf.gif";
			img.style.verticalAlign = "middle";
			img.setAttribute("border","0");
			img.src = icon;
			a.appendChild(img);
		}
		var span = document.createElement("span");
		span.innerHTML = title;
		a.appendChild(span);
		li.appendChild(a);
		if (btnClose) {
			span = document.createElement("span");
			span.className = "close";
			span.onclick = self.closeTab;
			li.appendChild(span);
		}
		li.onmouseover = function (e) {
			this.className = "selected";
		}
		li.onmouseout = function (e) {
			if (this==self.selectedLI)
				return;
			this.className = "";
		}
		li.onclick = function (e) {
			self.selectedLI = this;
			self.setSelected();
		}
		self.ul.appendChild(li);
		self.calcTabsWidth();
		self.disableSelection(li);

		var iframe = document.createElement("iframe");
		iframe.style.width = "100%";
		iframe.frameBorder = "no";
		iframe.border = "0px";
		iframe.style.height = (self.tab.parentNode.offsetHeight - self.container.offsetHeight - 2) + "px";
		iframe.src = url;
		self.divFrame.appendChild(iframe);
		
		return li;
	}
	// ����ѡ��ҳǩ�ɼ�
	this.setSelected = function () {
		var nIndex = 0;
		var lis = self.ul.getElementsByTagName("li");
		var nWidth = 0;
		for (var i=0;i<lis.length;i++) {
			if (nIndex==0)
				nWidth += lis[i].offsetWidth + 3;
			if (lis[i]==self.selectedLI) {
				nIndex = i;
				self.selectedLI.className = "selected";
				continue;
			}
			lis[i].className = "";
		}
		// ������ĩ��
		if (nWidth>=self.container.offsetWidth)
			self.container.scrollLeft = nWidth - self.container.offsetWidth;
		else
			self.container.scrollLeft = 0;

		var activeRefresh = self.selectedLI.getAttribute("refresh");
		// ��������
		var frames = self.divFrame.getElementsByTagName("iframe");
		if (!frames)
			return;
		for (var i=0;i<frames.length;i++) {
			if (i==nIndex) {
				frames[i].style.display = "block";
				if (activeRefresh)
					frames[i].src = frames[i].src;
				continue;
			}
			frames[i].style.display = "none";
		}
	}

	this.disableSelection = function (target){
		if (typeof target.onselectstart!="undefined") //IE route
			target.onselectstart=function(){return false}
		else if (typeof target.style.MozUserSelect!="undefined") //Firefox route
			target.style.MozUserSelect="none"
		else //All other route (ie: Opera)
			target.onmousedown=function(){return false}
			target.style.cursor = "default"
	} 

	this.closeTab = function (e) {
		e = e || window.event;

		if (self.getTabCount()==1)
			return;
		var obj = this.parentNode;
		var nIndex = self.getTabIndex(obj);
		for(c in self.tabs){
			if (self.tabs[c]==obj) 
				self.tabs[c] = null;
		}
		obj.parentNode.removeChild(obj);

		var frames = self.divFrame.getElementsByTagName("iframe");
		self.divFrame.removeChild(frames[nIndex]);

		self.calcTabsWidth();
		if (self.getTabCount()<=nIndex)
			nIndex = self.getTabCount() - 1;
		obj = self.getTabObjByIndex(nIndex);
		self.selectedLI = obj;
		self.setSelected();
		stopPropagation(e);
	}
	// ͨ��ҳǩ����رյ�ǰҳǩ
	this.closeActivePage = function (objWindow) {
		if (!objWindow || !objWindow.frameElement) return;

		var frames = self.divFrame.getElementsByTagName("iframe");
		if (!frames || frames.length==1) return;
		
		var nIndex = -1;
		for (var i=0;i<frames.length;i++) {
			if (frames[i]==objWindow.frameElement) {
				nIndex = i;
				break;
			}
		}
		if (nIndex==-1) return;
		var obj = self.getTabObjByIndex(nIndex);

		for(c in self.tabs){
			if (self.tabs[c]==obj) 
				self.tabs[c] = null;
		}
		obj.parentNode.removeChild(obj);

		self.divFrame.removeChild(frames[nIndex]);

		self.calcTabsWidth();
		if (self.getTabCount()<=nIndex)
			nIndex = self.getTabCount() - 1;
		obj = self.getTabObjByIndex(nIndex);
		self.selectedLI = obj;
		self.setSelected();
	}

	this.calcTabsWidth = function () {
		var nWidth = 0;
		var lis = self.ul.getElementsByTagName("li");
		for (var i=0;i<lis.length;i++) {
			nWidth += lis[i].offsetWidth + 3;
		}
		if (nWidth < self.container.offsetWidth-20*2) {
			self.ul.style.width = (self.container.offsetWidth - 20*2) + "px";
			self.container.style.left = "2px";
			self.divLeft.style.display = "none";
			self.divRight.style.display = "none";
			return;
		}
		if (nWidth > lis.length * 3)
			self.ul.style.width = nWidth + "px";

		if (!self.tab.offsetWidth)
			self.container.style.width = (480 - 20 * 2) + "px";
		else
			self.container.style.width = (self.tab.offsetWidth - 20 * 2) + "px";
		self.container.style.left = "20px";
		self.divLeft.style.display = "block";
		self.divRight.style.display = "block";
	}

	this.getTabIndex = function (obj) {
		var lis = self.ul.getElementsByTagName("li");
		for (var i=0;i<lis.length;i++) {
			if (obj==lis[i]) {
				return i;
			}
		}
		
		return 0;
	}

	this.getTabObjByIndex = function (nIndex) {
		var lis = self.ul.getElementsByTagName("li");
		if (lis==null)
			return null;
		if (nIndex>lis.length-1)
			return null;
		
		return lis[nIndex];
	}

	this.getTabCount = function () {
		var lis = self.ul.getElementsByTagName("li");
		if (lis)
			return lis.length;
		
		return 0;
	}

	this.refresh = function (nIndex,url) {
		var frames = self.divFrame.getElementsByTagName("iframe");
		frames[nIndex].src = url;
	}

	this.resize = function () {
		var width = self.tab.parentNode.offsetWidth;
		var height = self.tab.parentNode.offsetHeight;
		// ���ÿ��
		self.tab.style.width = width + "px";
		if (width>parseInt(self.ul.style.width)) {
			self.container.style.width = width + "px";
		} else
			self.container.style.width = (width - 40) + "px";
		
		var frames = self.divFrame.getElementsByTagName("iframe");
		for (var i=0;i<frames.length ;i++ )	{
			frames[i].style.height = (height - parseInt(self.tab.style.height)) + "px";
		}
	}
}
