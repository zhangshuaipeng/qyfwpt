var dxTree = function() {
	var root;
	var selected;

	var self = this;

	this.init = function(divId) {
		self.root = document.getElementById(divId);
		if (!self.root)	{
			self.root = document.createElement("div");
			self.root.className = "x-tree";
			document.body.appendChild(self.root);
		} else {
			self.root.className = "x-tree";
		}
	}

	this.getTree = function () {
		return self.root;
	}
	
	this.createFolder = function(tree,xmlNode) {
		var folder = document.createElement("dl");
		tree.appendChild(folder);
		var dt = document.createElement("dt");
		dt.setAttribute("unselectable","on");
		folder.appendChild(dt);
		dt.className = "open";
		var img = document.createElement("img");
		dt.appendChild(img);
		img.src = "images/null.gif";
		img.className = "arrow";
		img.onclick = function () {
			if (hasClass(this.parentNode,"open")) {
				removeClass(this.parentNode,"open");
				addClass(this.parentNode,"close");
				self.toggleChild(this.parentNode,"none");
				return;
			}
			removeClass(this.parentNode,"close");
			addClass(this.parentNode,"open");
			self.toggleChild(this.parentNode,"");
		}

		dt.ondblclick = function () {
			if (hasClass(this,"open")) {
				removeClass(this,"open");
				addClass(this,"close");
				self.toggleChild(this,"none");
				return;
			}
			removeClass(this,"close");
			addClass(this,"open");
			self.toggleChild(this,"");
		}
		
		var a = document.createElement("a");
		var str = xmlNode.getAttribute("action");
		if (str) {
			a.href = str;
			str = xmlNode.getAttribute("target");
			if (str) {
				a.target = str;
			}
		}
		dt.appendChild(a);

		img = document.createElement("img");
		img.src = "images/null.gif";
		img.className = "folder";
		a.appendChild(img);
		
		var span = document.createElement("span");
		span.innerHTML = xmlNode.getAttribute("text");
		a.appendChild(span);

		dt.onmouseover = function () {
			addClass(this,"over");
		}

		dt.onmouseout = function () {
			removeClass(this,"over");
		}

		dt.onmousedown = function () {
			if (self.selected)	{
				removeClass(self.selected,"selected");
			}
			
			self.selected = this;
			addClass(self.selected,"selected");
		}

		return folder;
	}

	this.createNode = function(tree,xmlNode) {
		var dd = document.createElement("dd");
		dd.setAttribute("unselectable","on");
		tree.appendChild(dd);
		
		var img = document.createElement("img");
		img.src = xmlNode.getAttribute("icon");
		dd.appendChild(img);

		var span = document.createElement("span");
		span.innerHTML = xmlNode.getAttribute("text");
		dd.appendChild(span);

		dd.onmouseover = function () {
			addClass(this,"over");
		}

		dd.onmouseout = function () {
			removeClass(this,"over");
		}

		dd.onmousedown = function () {
			if (self.selected)	{
				removeClass(self.selected,"selected");
			}
			
			self.selected = this;
			addClass(self.selected,"selected");
		}
		dd.onclick = function () {
			var id = xmlNode.getAttribute("id");
			var title = xmlNode.getAttribute("text");
			var url = xmlNode.getAttribute("action");
			var icon = xmlNode.getAttribute("icon");
			tab.addTab(id,title,url,icon,true);
		}
	}

	this.toggleChild = function (o,state) {
		var sb = o.nextSibling; 
		while (sb && sb.tagName.toLowerCase()!='dt') {
			sb.style.display = state; 
			sb = sb.nextSibling; 
		}
	}
}
