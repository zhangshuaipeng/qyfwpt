
function ListView(tabid,gridCode,system,module) {
	var self = this;

	this.id = tabid;		// 控件号
	this.gridCode = gridCode;
	this.system = system;
	this.module = module;

	this.listCtrl = null;	// 控件
	this.pageCtrl = null;	// 翻页控件
	this.queryArea = null;	// 查询区
	this.actionArea = null; // 操作区

	this.columns = null;	// 列
	this.actions = null;	// 操作
	this.opts = null;		// 条件
	this.dict = null;		// 字典转换
	this.view = null;		// 显示定义
	this.page = null;		// 页信息数据

	this.baseInd = (new Date()).getTime();
	this.nCount = 0;

	this.contextPath = null;

	this.data = new Array();       // 数据内容

	// 初始化
	this.init = function (config) {
		self.contextPath = self.getContextPath();

		self.columns = config.columns;
		self.actions = config.actions;
		self.opts = config.opts;
		self.dict = config.dict;
		self.view = config.view;

		// 查询区
		self.queryArea = document.getElementById(self.id + "-QUERYAREA");
		self.createQueryArea();
		self.actionArea = document.getElementById(self.id + "-ACTIONAREA");
		self.createButtonArea();
		
		// 取标签
		self.listCtrl = document.getElementById("list-" + self.id);
		
		// 翻页控制
		self.pageCtrl = document.getElementById(self.id + "_page");
		if (!self.pageCtrl) return;
		self.pageCtrl.parentNode.onclick = function () {
			if (self.page.rowsCount==0) return;
			
			if (self.page.curPage==self.page.pageCount) return;
			
			document.getElementById("$" + self.id + "-pageno").value = String(parseInt(document.getElementById("$" + self.id + "-pageno").value) + 1);

			// 翻下一页
			var form = new DHTMLSuite.form({ formRef:self.id,action:'GridAction.cmd?$ACTION=query&$SYSTEM='+ self.system + '&$MODULE=' + self.module + '&$FIELDSET=' + self.id + '&$GRIDID=' + self.gridCode,callbackOnComplete:'list' + self.id + '.showQueryResult'});
			form.submit();

		}

		// 处理初始化条件内容
		var obj = document.createElement("input");
		obj.type = "hidden";
		obj.id = "$" + self.id + "-pageno";
		obj.value = "1";
		self.pageCtrl.parentNode.appendChild(obj);

	}
	// 取绝对路径
	this.getContextPath = function () {
		var pathName = document.location.pathname;
		var index = pathName.substr(1).indexOf("/");
		var result = pathName.substr(0,index + 1);
		return result;
	}
	// 创建查询区
	this.createQueryArea = function () {
		if (!self.opts) return false;
		if (!self.view.showQuery || self.view.showQuery!="Y") {
			// 只填充关系条件
			for (var i=0;i<self.opts.length;i++) {
				if (self.opts[i].type=="LINK") {
					self.createQueryInput(self.queryArea,self.opts[i]);
				}
			}
			return;
		}

		var str = null;
		if (self.view.queryOpts) {
			str = self.view.queryOpts.split(",");
		}
		var showBtn = false;
		var isHidden;
		for (var i=0;i<self.opts.length;i++) {
			// 是否隐藏该条件
			isHidden = false;
			if (str) {
				for (var n=0;n<str.length;n++) {
					if (str[n]==self.opts[i].id) {
						isHidden = true;
						break;
					}
				}
			}
			if (isHidden) continue;

			var input = self.createQueryInput(self.queryArea,self.opts[i]);
			if (input.type!="hidden") {
				var span = document.createElement("span");
				span.innerHTML = "&nbsp;";
				span.className = "x-btn-split";
				self.queryArea.appendChild(span);
				showBtn = true;
			}
		}
		if (!showBtn)
			return false;

		var query = document.createElement("button");
		// query.className = "x-btn-text x-btn-search";
		query.innerHTML = "<b style=\"background-image:url('../images/icon/search.png');\"></b>查询";
		query.onclick = function () {
			self.runQuery(true);
			return false;
		}
		self.queryArea.appendChild(query);

		return true;
	}
	// 创建按钮区
	this.createButtonArea = function () {
		if (!self.actions) return;
		if (!self.view.showAction || self.view.showAction!="Y") return;

		for (var i=0;i<self.actions.length;i++) {
			var action = self.actions[i];
			if (action.type=="ROW" || action.operand=="ROW") continue;
			
			if (!self.isVisibleAction(action.code)) continue;

			// 加图标
			var btn = document.createElement("button");
			btn.innerHTML = "<b style=\"background-image:url('" + self.contextPath + "/images/icon/" + action.icon + "');\"></b>" + action.name;
			btn.setAttribute("actionid",action.code);
			if (action.rets) 
				btn.setAttribute("rets",action.rets);
			if (action.callback)
				btn.setAttribute("callback",action.callback);
			if (action.params)
				btn.setAttribute("params",action.params);
			if (action.args)
				btn.setAttribute("args",action.args);
			btn.onclick = self.submitAction;
			self.actionArea.appendChild(btn);
		}

	}
	// 操作是否显示
	this.isVisibleAction = function (action) {
		if (!self.view.actions) return true;

		var str = self.view.actions.split(",");

		for (var n=0;n<str.length;n++) {
			if (action==str[n]) {
				return false;
			}
		}

		return true;
	}
	// 查询处理
	this.runQuery = function (isInit) {
		if (isInit) {
			// 清除除第一行外的其他行
			self.clearAll();
			document.getElementById("$" + self.id + "-pageno").value = "1";
		}
		// 翻下一页
		var form = new DHTMLSuite.form({ formRef:self.id,action:'GridAction.cmd?$ACTION=query&$SYSTEM=' + self.system + '&$MODULE=' + self.module + '&$FIELDSET=' + self.id + '&$GRIDID=' + self.gridCode,callbackOnComplete:'list' + self.id + '.showQueryResult'});
		form.submit();
	}
	// 删除所有行
	this.clearAll = function () {
		if (self.listCtrl.tagName=="TABLE") {
			var rowId;
			var tr;
			for (var i=self.listCtrl.rows.length-1;i>=0;i--) {
				tr = self.listCtrl.rows[i];
				rowId = tr.getAttribute("rowId");
				self.listCtrl.deleteRow(i);
				self.data[rowId] = null;
			}
		}

		if (self.listCtrl.tagName=="UL") {
			self.listCtrl.innerHTML = "";
		}
		
		self.data = new Array();
	}
	// 创建查询输入框
	this.createQueryInput = function (div,opt) {
		var type = "";
		var tag;
		if (opt.type=="LINK"){
			type = "hidden";
		} else {
			if (opt.display=="HIDDEN")
				type = "hidden";
		}
		
		// 对于移动端隐藏的条件
		if (opt.hideMobile && opt.hideMobile=="Y") {
			type = "hidden";
		}

		if (opt.option=="ASC" || opt.option=="DESC" || opt.option=="IS NULL" || opt.option=="IS NOT NULL") {
			type = "hidden";
		}
		// 显示下拉框条件
		if (type!="hidden") {
			if (opt.display=="COMBOX") {
				type = "combox";
			} else if (opt.display=="HIDDEN") {
				type = "hidden";
			} else if (opt.display=="POPUP") {
				type = "popup";
			} else
				type = "text";
		}
		if (type=="combox")	{
			tag = document.createElement("select");
			tag.id = "$" + self.id + "-option-" + opt.id;
			tag.name = tag.id;
			if (opt.parents)
				tag.setAttribute("parents",opt.parents);
			if (opt.refreshs)
				tag.setAttribute("refreshs",opt.refreshs);
			if (opt.dictId)
				tag.setAttribute("dictid",opt.dictId);
			var objOption = document.createElement("OPTION");
			objOption.text= opt.title;
			objOption.value = "";
			tag.style.color = "#888";
			tag.options.add(objOption);
			tag.onchange = function () {
				if (this.value=="")
					this.style.color = "#888";
				else
					this.style.color = "#000";
				var refreshs = this.getAttribute("refreshs");
				if (refreshs) {
					eval(refreshs);
				}
			}

			var list = self.dict[opt.dictId];
			if (!list || list.length==0) {
				div.appendChild(tag);
				return tag;
			}
			for (var i=0;i<list.length;i++) {
				var data = list[i];
				objOption = document.createElement("OPTION");
				objOption.text= data.value;
				objOption.value = data.key;
				tag.options.add(objOption);
			}
			div.appendChild(tag);

			return tag;
		}
		
		if (type=="popup") {
			if (opt.hideField=="Y")	{
				tag = document.createElement("input");
				tag.type = "hidden";
				tag.id = "$" + self.id + "-option-" + opt.id;
				tag.name = tag.id;
				div.appendChild(tag);
			}
			tag = document.createElement("input");
			tag.type = "text";
			tag.className = "popupflag";
			tag.style.color = "#888";
			// tag.setAttribute("readOnly","true");
			tag.setAttribute("placeholdler",opt.title);
			if (!opt.width)
				opt.width = "100";
			tag.style.width = opt.width + "px";
			if (opt.hideFiled=="Y")
				tag.id = "$" + self.id + "-option-" + opt.id + "-value";
			else
				tag.id = "$" + self.id + "-option-" + opt.id;
			tag.name = tag.id;
			if (opt.hideField=="Y") 
				tag.setAttribute("rets","$" + self.id + "-option-" + opt.id + "," + "$" + self.id + "-option-" + opt.id + "-value");
			else
				tag.setAttribute("rets","$" + self.id + "-option-" + opt.id);
			
			tag.onclick = function () {
				if (opt.dictId=="DEPT")	{
					top.window.showDialog(window,tag.title,self.contextPath + "/ou/dept.cmd?$ACTION=deptselect&box=radio","330","410","dialogClauseSubmit",tag);
					return;
				}
				if (opt.dictId=="DATE") {
					top.window.showDialog(window,tag.title,self.contextPath + "/common/date.html","240","210","dialogClauseSubmit",tag);
					return;
				}
				if (opt.dictId=="DATETIME") {
					top.window.showDialog(window,tag.title,self.contextPath + "/common/datetime.html","240","260","dialogClauseSubmit",tag);
					return;
				}
				if (opt.dictId=="USER") {
					top.window.showDialog(window,tag.title,self.contextPath + "/ou/user.cmd?$ACTION=deptusertree&box=radio","330","410","dialogClauseSubmit",tag);
					return;
				}
				if (opt.dictId=="RIGHT") {
					top.window.showDialog(window,tag.title,self.contextPath + "/ou/acl.cmd?$ACTION=main","670","484","dialogClauseSubmit",tag);
					return;
				}
				if (opt.dictId=="URL")	{
					top.window.showDialog(window,tag.title,opt.url + "&$BOX=radio","640","510","dialogClauseSubmit",tag);
					return;
				}

			}
			
			div.appendChild(tag);
			return tag;
		}

		tag = document.createElement("input");
		tag.type = type;
		if (type!="hidden")	{
			tag.style.color = "#888";
			tag.setAttribute("placeholder",opt.title);
		}
		tag.id = "$" + self.id + "-option-" + opt.id;
		tag.name = tag.id;
		if (tag.type=="hidden") {
			div.appendChild(tag);
			return tag;
		}

		tag.style.height = "20px";
		if (!opt.width)
			opt.width = "100";
		tag.style.width = opt.width + "px";


		div.appendChild(tag);

		return tag;
	}
	// 显示查询结果
	this.showQueryResult = function (ajaxObj) {
		var data = ajaxObj.grid;
		var page = ajaxObj.pagecontrol;
		self.setPageCtrl(page);
		if (data)
			self.addRows(data);
	}
	// 设置列表翻页
	this.setPageCtrl = function (page) {
		self.page = page;
		if (!page.rowsCount && page.rowscount)
			page.rowsCount = page.rowscount;
		if (!page.pageCount && page.pagecount) 
			page.pageCount = page.pagecount;
		if (!page.curPage && page.curpage)
			page.curPage = page.curpage;
		if (page.pageCount==0) {
			self.pageCtrl.innerHTML = "没有符合条件的数据！";
			return;
		}
		if (page.rowsCount<page.to)	{
			page.rowsCount = page.to;
		}
		if (!page.rowsCount)
			page.rowsCount = 0;
		var info = "已显示" + page.to + "/" + page.rowsCount + "。";
		if (page.curPage==page.pageCount) {
			self.pageCtrl.innerHTML = info;
			return;
		}
		
		info += "点击显示下一页";

		self.pageCtrl.innerHTML = info;
	}
	// 增加行
	this.addRows = function (data) {
		if (!data) return;
		
		for (var i=0;i<data.length;i++)	{
			self.addRow(data[i]);
		}
	}
	// 增加单行
	this.addRow = function (data) {
		self.nCount++;
		var rowId = String(self.nCount + self.baseInd);

		self.data[rowId] = data;

		// 如果没有做任何设置
		if (!self.view) {
			var tr = self.listCtrl.insertRow(self.listCtrl.rows.length);
			tr.setAttribute("rowId",rowId);
			if (self.listCtrl.rows.length%2==1)
				tr.className = "even";
			else
				tr.className = "odd";
			var cell = tr.insertCell(0);
			cell.innerHTML = self.fillRow(data,true);

			if (!self.actions)
				return;

			var p = document.createElement("p");
			p.className = "row";
			cell.appendChild(p);
			// 增加操作
			for (var i=0;i<self.actions.length;i++)	{
				if (self.actions[i].operand!="ROW") continue;
				if (!self.isVisibleAction(self.actions[i].code)) continue;

				// 是否行操作
				var btn = document.createElement("input");
				btn.type = "button";
				btn.id = self.actions[i].code;
				btn.value = self.actions[i].name;
				btn.onclick = self.submitAction;
				p.appendChild(btn);
			}

			return;
		}

		// 没有设置任何记录集视图
		if (self.view.type=="mtable") {
			var tr = self.listCtrl.insertRow(self.listCtrl.rows.length);
			tr.setAttribute("rowId",rowId);
			if (self.listCtrl.rows.length%2==1)
				tr.className = "even";
			else
				tr.className = "odd";
			var str = "";
			var bHide;
			for (var i=0;i<self.columns.length;i++)	{
				if (self.columns[i].showType=="HIDDEN") continue;
				bHide = false;
				// 是否要显示该列
				if (self.view.columns) {
					var columns = self.view.columns.split(",");
					for (var n=0;n<columns.length;n++) {
						if (self.columns[i].code==columns[n]) {
							bHide = true;
							break;
						}
					}
					if (bHide) continue;
				}

				var cell = tr.insertCell(tr.cells.length);
				var v = data[self.columns[i].code];
				if (self.columns[i].showType=="IMAGE") {
					v = self.columns[i].title;
				}
				v = self.getValue(self.columns[i],v);
				if (!v) continue;
				var action = self.getAction(self.columns[i].actionId);
				if (action && self.isVisibleAction(action.code))	{
					var a = document.createElement("a");
					a.setAttribute("actionid",action.code);
					a.innerHTML = v;
					a.onclick = self.submitAction;
					cell.appendChild(a);
					continue;
				}
				cell.innerHTML = v;
			}

			return;
		}

		// 表格
		if (self.view.type=="stable") {

			var tr = self.listCtrl.insertRow(self.listCtrl.rows.length);
			tr.setAttribute("rowId",rowId);
			var cell = tr.insertCell(0);
			if (self.nCount%2==1)
				cell.className = "odd";
			else
				cell.className = "even";
			cell.innerHTML = self.getDataHtml(data);
			
			self.fillRowAction(cell);
			return;
		}

		if (self.view.type=="ul-li") {
			var li = document.createElement("li");
			li.setAttribute("rowId",rowId);
			if (self.nCount%2==1)
				li.className = "odd";
			else
				li.className = "even";
			li.innerHTML = self.getDataHtml(data);
			self.listCtrl.appendChild(li);

			self.fillRowAction(li);
		}

	}
	// 填充行操作
	this.fillRowAction = function (cell) {
		if (!self.actions) return;

		var p = document.createElement("p");
		for (var i=0;i<self.actions.length;i++)	{
			if (self.actions[i].operand!="ROW") continue;
			var action = self.actions[i];
			if (!self.isVisibleAction(action.code)) continue;
			var a = document.createElement("a");
			a.setAttribute("actionid",action.code);
			a.innerHTML = action.name;
			a.onclick = self.submitAction;
			p.appendChild(a);
			cell.appendChild(p);
		}

	}
	
	// 填充行
	this.fillRow = function (data,showHref) {
		var str = "";
		var nIndex = 0;
		for (var i=0;i<self.columns.length;i++)	{
			if (self.columns[i].showType=="HIDDEN") continue;
			if (!showHref && self.columns[i].showType=="IMAGE") continue;

			if (nIndex%2==0) {
				str += "<p class=\"row\">";
				str += "<span class=\"left\">";
			} else
				str += "<span class=\"right\">";

			var v = data[self.columns[i].code];
			v = self.getValue(self.columns[i],v);
			if (!v) {
				str += "</span>";
			} else {
				str += "<span class=\"collabel\">" + self.columns[i].title + ":</span><span class=\"coltext\">" + v + "</span></span>";
			}
			if (nIndex%2==1) 
				str += "</p>";
			nIndex++;
		}

		return str;
	}
	// 是否要显示该列的列标题
	this.isAttachCaption = function (colname) {
		if (!self.view.attachTitle) return true;
		var str = self.view.attachTitle.split(",");
		for (var i=0;i<str.length;i++) {
			if (str[i]==colname) {
				return false;
			}
		}

		return true;
	}
	// 取列属性
	this.getColumn = function (code) {
		if (!code) return null;
		for (var i=0;i<self.columns.length;i++) {
			if (self.columns[i].code==code) return self.columns[i];
		}

		return null;
	}
	// 根据行式样填充行信息
	this.fillRowByStyle = function (data) {
		if (!self.view.styles) {   // 如果没有设置行式样
			return self.fillRow(data);
		}

		var str = "<p class=\"rowstyle\">";
		var title;
		var style;
		var column;
		for (var i=0;i<self.view.styles.length;i++)	{
			style = self.view.styles[i];
			column = self.getColumn(style.code);
			
			// 是否换行？
			if (style.newLine && style.newLine=="Y") {
				if (i>0)
					str += "</p>";
				str += "<p class=\"rowstyle\">";
			}
			
			// 是否显示标题
			title = "";
			if (self.isAttachCaption(style.code)) {
				title = "<span class=\"collabel\" ";
				// 标题颜色
				if (style.titleColor) {
					title += "style=\"color:" + style.titleColor + ";\"";
				}
				title += ">";
				// 如果存在标题图标，则只显示图标
				if (style.titleIcon)
					title += "<img src=\"" + self.contextPath + "/images/icon/" + style.titleIcon + "\" border=\"0\">";
				else
					title += column.title + ":";
				title += "</span>";
			}

			str += "<span style=\"";
			// 是否设置了宽度？
			if (style.width) {
				str += "width:" + style.width + ";";
			}
			// 是否设置了颜色
			if (style.fontSize) {
				str += "font-size:" + style.fontSize + ";";
			}
			// 是否设置了背景
			if (style.bkColor) {
				str += "background:" + style.bkColor + ";";
			}
			// 是否设置了颜色
			if (style.color) {
				str += "color:" + style.color + ";";
			}
			// 是否加粗字体
			if (style.weight && style.weight=="Y") {
				str += "font-weight:bold;";
			}
			str += "\">";

			str += title;

			var v = data[column.code];
			v = self.getValue(column,v);
			if (!v) {
				str += "</span>";
			} else {
				str += "<span>" + v + "</span></span>";
			}
		}
		str += "</p>";

		return str;
	}
	// 取列的内容
	this.getValue = function (col,value) {
		if (!value) return "";
		
		if (!col.dictId) return value;
		
		if (!self.dict) return value;
		
		var dict = self.dict[col.dictId];
		for (var i=0;i<dict.length;i++) {
			if (dict[i].key==value) {
				return dict[i].value;
			}
		}

		return value;
	}
	// 取绑定的操作
	this.getAction = function (action) {
		if (!self.actions)
			return null;

		// 增加操作
		for (var i=0;i<self.actions.length;i++)	{
			if (self.actions[i].code==action)
				return self.actions[i];
		}

		return null;
	}
	// 取列定义
	this.getColumn = function (code) {
		if (!code) return null;

		for (var i=0;i<self.columns.length;i++) {
			if (self.columns[i].code==code)	{
				return self.columns[i];
			}
		}

		return null;
	}
	// 填充好的实际内容
	this.getDataHtml = function(data) {
		if (!self.view.html || !self.view.html.ROW) {
			return self.fillRowByStyle(data);
		}

		var html = self.view.html.ROW;
		var str = html.split("\2");
		html = "";
		var col;
		for (var i=0;i<str.length;i++) {
			if (str[i].charAt(0)=='@') {
				col = self.getColumn(str[i].substring(1));
				if (col!=null) {
					html += col.title;
					continue;
				}
			}
			if (str[i].charAt(0)=='%') {
				col = self.getColumn(str[i].substring(1));
				if (col!=null) {
					var v = data[col.code];
					v = self.getValue(self.columns[i],v);
					html += v;
					continue;
				}
			}
			html += str[i];
		}

		return html;
	}
	// 按钮事件处理方法
	this.submitAction = function () {
		var rowId;

		if (this.tagName!="BUTTON")	{
			var row = this.parentNode;
			while (!row.getAttribute("rowId")) {
				row = row.parentNode;
			}

			var rowId = row.getAttribute("rowId");

		}

		var id = this.getAttribute("actionid");
		var action = null;

		for (var i=0;i<self.actions.length;i++)	{
			if (self.actions[i].code==id) {
				action = self.actions[i];
				break;
			}
		}

		// 取操作
		if (!action.url && !action.href) {
			self.showMessage("操作设置不全，无法继续！");
			return;
		}

		// URL优先
		var href = action.url;

		if (!href)	{
			document.getElementById("$ACTION").value = "";
			href = self.system + "/" + self.module + ".cmd?$ACTION=" + action.href;
		}
		
		if (href.indexOf("../")==0)	{
			href = self.system + "/" + href;
		}
		// 设置参数，只针对行操作
		if (rowId) {
			var data = self.data[rowId];
			
			if (action.args) {
				var str = action.args.split(",");
				for (var i=0;i<str.length;i++) {
					// 是否转义
					var p = str[i].split(":");
					if (p.length>1)
						str[i] = p[1];
					if (!data[p[0]]) continue;
					if (href.indexOf("?")==-1)
						href += "?" + str[i] + "=" + data[p[0]];
					else
						href += "&" + str[i] + "=" + data[p[0]];
				}
			}
			if (href.indexOf("?")==-1)
				href += "?$" + self.id + "-key=" + self.getRowKey(rowId);
			else
				href += "&$" + self.id + "-key=" + self.getRowKey(rowId);
		} else {
			if (action.args) {
				var str = action.args.split(",");
				for (var i=0;i<str.length;i++) {
					// 是否转义
					var p = str[i].split(":");
					if (p.length>1)
						str[i] = p[1];
					var v = document.getElementById(p[0]);
					if (!v || !v.value) continue;
					if (href.indexOf("?")==-1)
						href += "?" + str[i] + "=" + v.value;
					else
						href += "&" + str[i] + "=" + v.value;
				}
			}
		}
		href += "&$FIELDSET=" + self.id;

		// 处理弹出窗口
		if (action.type=="POPUP") {
			var multi = action.operand;
			if (multi=="ROW")
				multi = "radio";
			else if (multi=="ROWS")
				multi = "checkbox";
			else
				multi = "";

			if (action.href=="DATE") {
				top.window.showGridDialog(window,action.name,self.contextPath + "/common/date.html","240","210","gridDialogSubmit",self,rowId,fieldid);
				return false;
			}
			if (action.href=="DATETIME") {
				top.window.showGridDialog(window,action.name,self.contextPath + "/common/datetime.html","240","260","gridDialogSubmit",self,rowId,fieldid);
				return false;
			}
			if (action.href=="USER") {
				top.window.showGridDialog(window,action.name,self.contextPath + "/ou/user.cmd?$ACTION=deptusertree&box=" + multi,"330","410","gridDialogSubmit",self,rowId,fieldid);
				return false;
			}
			if (action.href=="DEPT") {
				top.window.showGridDialog(window,action.name,self.contextPath + "/ou/dept.cmd?$ACTION=deptselect&box=" + multi,"330","410","gridDialogSubmit",self,rowId,fieldid);
				return false;
			}
			if (action.href=="RIGHT") {
				top.window.showGridDialog(window,action.name,self.contextPath + "/ou/acl.cmd?$ACTION=main","670","484","gridDialogSubmit",self,rowId,fieldid);
				return false;
			}
			if (action.href=="URL")	{
				if (multi!="")
					href += "&$BOX=" + multi;
				href += self.addColParams(rowId,action.args);
				href += self.addParams(action.params);
				top.window.showGridDialog(window,action.name,href,action.width,action.height,"gridDialogSubmit",self,rowId);
				return false;
			}
			self.showMessage("弹出操作不支持，无法继续！");
			return false;
		}

		// 加上绝对路径
		href = self.contextPath + "/" + href;

		document.getElementById("$ACTION").value = "";
		document.forms[0].action = href;
		document.forms[0].method = "post";
		document.forms[0].submit();

	}
	// 增加表单域参数
	this.addParams = function (args) {
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
	// 增加列参数
	this.addColParams = function (rowId,args) {
		if (!rowId || !args)
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
			var v = self.getFieldValue(rowId,keys[i]);
			if (!v) {  // 如果列中没有值，则找表单上的值
				if (document.getElementById(keys[i])) {
					v = document.getElementById(keys[i]).value;
				}
				if (!v)
					continue;
			}
			str += "&" + param + "=" + v;
		}
		return str;
	}
	// 读取域值
	this.getFieldValue = function (rowId,fieldid) {
		var row = self.data[rowId];
		if (!row)
			return "";
		var v = row[fieldid];
		if (v==null)
			v = "";

		return String(v);
	}
	// 取行流水
	this.getRowKey = function (rowId) {
		if (!rowId) return "";

		var data = self.data[rowId];
		if (!data) return "";

		var v = "";
		for (var i=0;i<self.columns.length;i++) {
			if (!self.columns[i].boxValue || self.columns[i].boxValue!="Y") continue;
			if (v!="")
				v += "|";
			v += data[self.columns[i].code];
		}
		if (!v)
			v = data[self.columns[0].code];
		return v;
	}
}
