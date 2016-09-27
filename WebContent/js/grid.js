function Datagrid(tabid) {
	var self = this;

	if (!window.objGrids) 
		window.objGrids = new Array();
	window.objGrids[tabid] = this;

	this.id = tabid;
	this.state = "readonly";       // readonly、write、update
	this.showIndexNo = true;       // 是否显示序号
	this.box = "checkbox";         // 显示选择框：radio-单选/checkbox-多选/其他为不显示
	this.showpagectrl = true;      // 是否显示翻页控件
	this.tabHeader = null;
	this.currentTD = null;
	this.blurRowId = null;         // 失去焦点的行号
	this.editingRowId = null;      // 正在编辑的行号
	this.tabDeatil = null;
	this.boundary = 5;
	this.resizing = false;
	this.currentTR = null;
	this.columns = null;      // 列属性
	this.grid = null;         // 子表属性
	this.dict = null;         // 字典列表
	this.maxId = (new Date()).getTime();
	this.data = new Array();
	this.pageCtl = null;     // 页面记录信息
	this.multiHead = false;  // 是否多层标题

	this.prev = null;         // 向前翻页SPAN
	this.next = null;         // 向后翻页
	this.page = null;         // 显示页信息SPAN
	this.record = null;       // 显示记录信息SPAN

	this.width = null;        // 表格宽度
	this.height = null;       // 表格高度

	this.queryArea = null;    // 查询区

	this.contextPath = "";
	this.required = false;    // 非必填


	this.init = function (data)	{
		self.contextPath = globalPath;
		self.columns = data['$GRID$'].columns;
		self.grid = data['$GRID$'];
		data['$GRID$'] = null;
		self.dict = data;
		// 设置编辑状态
		if (self.grid.state)
			self.setState(self.grid.state);
		if (self.grid.index && self.grid.index=="N")
			self.setShowIndexNo(false);
		if (self.grid.box)
			self.setBox(self.grid.box);

		if (self.grid.pageControl && self.grid.pageControl=="N")
			self.setShowPageCtrl(false);

	}
	// 画表格
	this.drawGrid = function () {
		self.createGrid();

		var div = document.getElementById(self.id);

		var ele = self.getChild(div,"DIV",1);
		if (!ele || ele.className!="gridheader")
			ele = self.getChild(div,"DIV",0);
		ele = self.getChild(ele,"DIV",0);
		self.tabHeader = self.getChild(ele,"TABLE",0);
		
		ele = self.getChild(div,"DIV",2);
		if (!ele || ele.className!="griddata")
			ele = self.getChild(div,"DIV",1);
		addEvent(ele,"scroll",self.onScroll);
		self.tabDetail = self.getChild(ele,"TABLE",0);

		addEvent(self.tabHeader.rows[1], 'mousemove', self.onMoveOverHeader);
		if (self.tabHeader.rows.length>2) {
			addEvent(self.tabHeader.rows[2], 'mousemove', self.onMoveOverHeader);
		}

		var oTR = self.tabHeader.rows[1];
		for(var i=0;i<oTR.cells.length;i++) {
			addEvent(oTR.cells[i], "mousedown", self.onMouseClick);
		}
		if (self.tabHeader.rows.length>2) {
			oTR = self.tabHeader.rows[2];
			for(var i=0;i<oTR.cells.length;i++) {
				addEvent(oTR.cells[i], "mousedown", self.onMouseClick);
			}
		}
		// 颜色设置
		self.showRowsBackground();
		self.setRowAction();

		// 绑定操作属性
		for (var i=0;i<self.tabDetail.rows.length;i++) {
			oTR = self.tabDetail.rows[i];
			for (var j=0;j<oTR.cells.length;j++) {
				var cell = oTR.cells[j];
				addEvent(cell,"click",self.onClick);
			}
		}
		var height = null;
		if (self.height) {
			height = self.height;
			div.style.height = height + "px";
		}
		if (!height) {
			height = self.getClientHeight();
			height -= self.pageY(div);  // 除去导航条高度
			height -= 10;  // 间隔
			if (getUserAgent()=="MSIE")
				height -= 2;
		}
		// 减TAB页签
		if (document.getElementById("FORMTAB"))	{
//			if (getUserAgent()=="FIREFOX")
//				height -= parseInt(document.getElementById("FORMTAB").offsetHeight) + 10;
//			else if (getUserAgent()=="SAFARI")
//				height -= 10;
		}
		// 减工具栏
		ele = self.getChild(div,"DIV",0);
		if (ele.className=="gridtoolbar" && ele.style.display!="none") {
			var toolbar = self.getStyle(ele,"height");
			if (!toolbar || toolbar=="auto")
				toolbar = "32";
			height -= parseInt(toolbar);
		}

		// 减表头
		height -= parseInt(self.getStyle(self.tabHeader.parentNode.parentNode,"height"));
		if (self.showpagectrl) {
			height -= 20;
		}
		if (height<=0) return;

		self.tabDetail.parentNode.style.height = height + "px";
	}
	// 标签的y轴位置
	this.pageY = function (elem){
        return elem.offsetParent?(elem.offsetTop + self.pageY(elem.offsetParent)):elem.offsetTop;
    }
	// 取式样
	this.getStyle = function(obj, attr) {
		if (obj.style.height) {
			return eval("obj.style." + attr);
		}
		if (obj.currentStyle) {
			return obj.currentStyle[attr];  //Chrome、IE
		} else {
			return window.getComputedStyle(obj, null)[attr];  //FF
		}
	}
	// 设置表格状态： readonly、write、update
	this.setState = function (state) {
		self.state = state;
	}
	// 设置子表的必填属性
	this.setRequired = function (required) {
		self.required = required;
	}
	// 设置显示序号
	this.setShowIndexNo = function (bShow) {
		if (bShow)
			self.showIndexNo = true;
		else
			self.showIndexNo = false;
	}
	// 设置显示翻页控制
	this.setShowPageCtrl = function (bShow) {
		if (bShow)
			self.showpagectrl = true;
		else
			self.showpagectrl = false;
	}
	// 设置选择框:radio/checkbox/
	this.setBox = function (box) {
		self.box = box;
	}
	// 设置表格宽度
	this.setWidth = function (width) {
		self.width = width;
	}
	// 设置表格高度
	this.setHeight = function (height) {
		self.height = height;
	}
	// 取下一有效标识号
	this.getNewRowId = function () {
		self.maxId++;

		return self.id + String(self.maxId);
	}
	// 取记录行数
	this.getRowsCount = function () {
		var i = 0;
		for (var str in self.data) {
			if (self.data[str]["$status"]=="delete") continue;
			i++;
		}
		
		return i;
	}
	// 根据行序号取号号
	this.getRowIdByIndex = function (rowInd) {
		var i = 0;
		for (var str in self.data) {
			if (self.data[str]["$status"]=="delete") continue;
			if (i==rowInd) {
				return str;
			}
			i++;
		}
		
		return null;
	}
	// 取行号数组
	this.getRowsId = function() {
		var rowIds = new Array();
		var i = 0;
		for (var str in self.data) {
			rowIds[i] = str;
			i++;
		}
	}
	// 创建表格
	this.createGrid = function () {
		var grid = document.getElementById(self.id);

		grid.parentNode.style.overflow = "hidden";

		var maxWidth = grid.offsetWidth;

		if (self.width)	{
			maxWidth = self.width;
		}
		if (!maxWidth || parseInt(maxWidth)<100)
			maxWidth = "640";
		grid.style.width = maxWidth + "px";
		maxWidth = maxWidth - 2;

		// 先清除grid中的内容
		for (var i=0; i<grid.childNodes.length;) {
			var childNode = grid.childNodes[i];
			grid.removeChild(childNode);
		}

		// 保存页行数
		var inp = document.createElement("input");
		inp.type = "hidden";
		inp.id = "$" + self.id + "-pagerows";
		inp.value = self.grid.rowsPerPage;
		grid.appendChild(inp);

		inp = document.createElement("input");
		inp.type = "hidden";
		inp.id = "$" + self.id + "-key";
		inp.value = "";
		grid.appendChild(inp);
		
		
		var div = document.createElement("div");
		div.className = "gridtoolbar";
		grid.appendChild(div);

		var tab = document.createElement("table");
		tab.border = "0";
		tab.style.border = "0px";
		tab.width = "100%";
		var tr = tab.insertRow(0);
		var td = tr.insertCell(0);
		td.style.border = "0px";
		var isNotNull1 = self.createQueryArea(td);
		if (self.grid.aloneOptArea && self.grid.aloneOptArea=="Y")	{
			td.style.border = "1px solid #cccccc";
			if (!isNotNull1) 
				tr.style.display = "none";
			tr = tab.insertRow(0);
			td = tr.insertCell(0);
		} else
			td = tr.insertCell(1);
		td.style.border = "0px";
		var isNotNull2 = self.createButtonArea(td);
		if (self.grid.aloneOptArea && self.grid.aloneOptArea=="Y")	{
			if (!isNotNull2) 
				tr.style.display = "none";
		}
		div.appendChild(tab);
		if (!isNotNull1 && !isNotNull2)	{
			div.style.display = "none";
		}
		if (self.grid.aloneOptArea && self.grid.aloneOptArea=="Y")	{
			if (isNotNull1 && isNotNull2) {
				div.style.height = "66px";
			}
		}

		div = document.createElement("div");
		div.className = "gridheader";
		grid.appendChild(div);
		div.style.width = maxWidth + "px";
		div.appendChild(self.createHeader(maxWidth));
		if (self.multiHead)	{
			div.style.height = "56px";
		}

		// 创建内容区
		div = document.createElement("div");
		div.className = "griddata";
		grid.appendChild(div);
		div.style.width = maxWidth + "px";
		div.style.overflow = "auto";
		
		self.tabDetail = document.createElement("table");
		div.appendChild(self.tabDetail);
		self.tabDetail.rules = 'all';
		if (getUserAgent()=="MSIE")
			self.tabDetail.border = "0";
		else
			self.tabDetail.border = "1";
		self.tabDetail.cellSpacing = "0";
		self.tabDetail.cellPadding = "0";
		self.tabDetail.style.tableLayout = "fixed";
		//self.tabDetail.style.display = "block";

		var tr = self.tabDetail.insertRow(self.tabDetail.rows.length);
		tr.style.height = "0px";

		var nIndex = 0;
		// 增加选择框列
		if (self.box=="radio" || self.box=="checkbox") {
			td = tr.insertCell(tr.cells.length);
			td.style.border = "0px";
			td.style.fontSize = "0px";
			td.style.margin = "0px";
			td.style.padding = "0px";
			td.style.width = self.tabHeader.rows[0].cells[nIndex].style.width;
			nIndex++;
		}
		// 增加行序号列
		if (self.showIndexNo) {
			td = tr.insertCell(tr.cells.length);
			td.style.border = "0px";
			td.style.fontSize = "0px";
			td.style.margin = "0px";
			td.style.padding = "0px";
			td.style.width = self.tabHeader.rows[0].cells[nIndex].style.width;
			nIndex++;
		}

		for (var i=0;i<self.columns.length;i++)	{
			if (self.columns[i].showType=="HIDDEN") continue;
			var td = tr.insertCell(tr.cells.length);
			td.style.border = "0px";
			td.style.fontSize = "0px";
			td.style.margin = "0px";
			td.style.padding = "0px";
			td.style.width = self.tabHeader.rows[0].cells[nIndex].style.width;
			nIndex++;
		}

		self.tabDetail.style.width = self.tabHeader.style.width;

		// 创建翻页区
		if (self.showpagectrl)
			self.createPageCtrlArea(grid);
	}
	// 创建表头
	this.createHeader = function (maxWidth) {
		var divTitle = document.createElement("div");
		divTitle.className = "gridtitle";
		divTitle.style.width = maxWidth + "px";
		// 增加表格
		self.tabHeader = document.createElement("table");
		divTitle.appendChild(self.tabHeader);
		self.tabHeader.cellSpacing = "0";
		self.tabHeader.cellPadding = "0";
		self.tabHeader.style.width = (maxWidth-18) + "px";
		self.tabHeader.style.tableLayout = "fixed";
		// self.tabHeader.style.display = "block";
		var hideTR = self.tabHeader.insertRow(0);
		hideTR.style.height = "0px";
		// 增加行
		var tr = self.tabHeader.insertRow(1);
		var tr1;
		var nWidth = 0;
		var td;
		var nIndex = 0;  // 列序号计数

		if (!self.columns) return divTitle;

		// 是否多层标题
		if (self.columns) {
			for (var i=0;i<self.columns.length;i++)	{
				if (self.columns[i].showType=="HIDDEN") continue;
				if (self.columns[i].ptitle) {
					self.multiHead = true;
					tr1 = self.tabHeader.insertRow(2);
					break;
				}
			}
		}

		// 增加选择框列
		if (self.box=="radio" || self.box=="checkbox") {
			td = hideTR.insertCell(hideTR.cells.length);
			td.style.width = "32px";
			td.style.border = "0px";
			td.style.fontSize = "0px";
			td.style.margin = "0px";
			td.style.padding = "0px";
			
			td = tr.insertCell(tr.cells.length);
			td.innerHTML = "选择";
			if (self.box=="checkbox")
				td.onclick = self.selectAll;
			nWidth += 32;
			if (self.multiHead)	{
				td.rowSpan = 2;
			}
			td.setAttribute("titleIndex",String(tr.cells.length - 1));
			nIndex++;
		}
		// 增加行序号列
		if (self.showIndexNo) {
			td = hideTR.insertCell(hideTR.cells.length);
			td.style.width = "32px";
			td.style.border = "0px";
			td.style.fontSize = "0px";
			td.style.margin = "0px";
			td.style.padding = "0px";

			td = tr.insertCell(tr.cells.length);
			td.style.width = "32px";
			td.innerHTML = "序号";
			nWidth += 32;
			if (self.multiHead)	{
				td.rowSpan = 2;
			}
			td.setAttribute("titleIndex",String(tr.cells.length - 1));
			nIndex++;
		}
		
		var dataWidth = 0;    // 数据内容宽度

		for (var i=0;i<self.columns.length;i++)	{
			if (self.columns[i].showType=="HIDDEN") continue;
			if (!self.columns[i].width)
				self.columns[i].width = "64";
			dataWidth += parseInt(self.columns[i].width);
			self.columns[i].colIndex = String(nIndex);   // 保存列序号
			nIndex++;
		}
		var nScale = 1;
		dataWidth += 24;
		// 是否超过长度
		if (dataWidth<(maxWidth-nWidth)) {
			nScale = (maxWidth-nWidth)/dataWidth;
		}
		var nSpan;
		var th;
		for (var i=0;i<self.columns.length;i++)	{
			if (self.columns[i].showType=="HIDDEN") continue;
			th = hideTR.insertCell(hideTR.cells.length);
			nWidth += parseInt(self.columns[i].width) * nScale;
			// nWidth += 1;
			self.columns[i].width *= nScale;
			// 对于最后一列,如果没有充满,则将表格剩余宽度全部留给该列
			th.style.width = self.columns[i].width + "px";
			th.style.border = "0px";
			th.style.fontSize = "0px";
			th.style.margin = "0px";
			th.style.padding = "0px";

			if (self.multiHead)	{   // 多层标题
				nSpan = self.getColSpan(i);
				if (nSpan==0) {
					th = tr.insertCell(tr.cells.length);
					th.rowSpan = 2;
				}
				if (nSpan==-1) {
					th = tr1.insertCell(tr1.cells.length);
				}
				if (nSpan>0) {
					th = tr.insertCell(tr.cells.length);
					th.colSpan = nSpan;
					th.innerHTML = self.columns[i].ptitle;
					th.setAttribute("titleIndex",String(hideTR.cells.length - 1 + nSpan - 1));

					th = tr1.insertCell(tr1.cells.length);
				}
			} else
				th = tr.insertCell(tr.cells.length);
			
			th.setAttribute("titleIndex",String(hideTR.cells.length - 1));
			th.innerHTML = self.columns[i].title;
			// 列编辑状态
			if (self.state!="readonly")	{
				if (self.columns[i].showType=="READONLY") {
					th.style.color = "#888888";
				} else {
					if (self.columns[i].isNotNull && self.columns[i].isNotNull=="Y") {
						th.innerHTML += "<font color=red>*</font>";
					}
				}
			}
		}

		return divTitle;
	}

	// 选择所有记录
	this.selectAll = function () {
		var selected = document.getElementsByName("$" + self.id + "-selected");
		if (!selected) return;
		for (var i=0;i<selected.length;i++)	{
			selected[i].checked = !selected[i].checked;
		}
	}
	// 取合并的列数,返回：-1 表示中间的合并列，0 表示无合并列，大于0 表示需要合并后续几列
	this.getColSpan = function (nIndex) {
		var ptitle = self.columns[nIndex].ptitle;
		// 无合并列
		if (!ptitle)
			return 0;
		
		// 是否中间列
		if (nIndex>0) {
			for (var i=nIndex-1;i>=0;i--) {
				if (self.columns[i].showType=="HIDDEN") continue;
				if (self.columns[i].ptitle==ptitle) {
					return -1;
				}
			}
		}

		// 起始列
		var len = 0;
		for (var i=nIndex;i<self.columns.length;i++) {
			if (self.columns[i].showType=="HIDDEN") continue;
			if (self.columns[i].ptitle==ptitle) {
				len++;
				continue;
			}
			return len;
		}

		return len;
	}
	// 创建翻页控制区
	this.createPageCtrlArea = function (grid) {
		var div = document.createElement("div");
		div.className = "gridbottom";
		grid.appendChild(div);

		self.prev = document.createElement("span");
		self.prev.className = "disable-page";
		div.appendChild(self.prev);

		// first
		var btn = document.createElement("button");
		btn.className = "x-btn x-page-first";
		btn.innerHTML = "&nbsp;";
		btn.onclick = self.pageControl;
		self.prev.appendChild(btn);

		// prev
		btn = document.createElement("button");
		btn.className = "x-btn x-page-prev";
		btn.innerHTML = "&nbsp;";
		btn.onclick = self.pageControl;
		self.prev.appendChild(btn);
		
		// split
		var span = document.createElement("span");
		span.className = "x-btn-split";
		span.innerHTML = "&nbsp;";
		div.appendChild(span);

		// 翻页
		var page = document.createElement("span");
		div.appendChild(page);
		span = document.createElement("span");
		span.innerHTML = "第";
		page.appendChild(span);
		var inp = document.createElement("input");
		inp.type = "text";
		inp.id = "$" + self.id + "-pageno";
		inp.size = "3";
		inp.style.height = "20px";
		inp.onchange = self.pageControl;
		page.appendChild(inp);
		span = document.createElement("span");
		span.innerHTML = "页/";
		page.appendChild(span);
		self.page = document.createElement("span");
		page.appendChild(self.page);
		span = document.createElement("span");
		span.innerHTML = "页";
		page.appendChild(span);

		// 分隔
		span = document.createElement("span");
		span.className = "x-btn-split";
		span.innerHTML = "&nbsp;";
		div.appendChild(span);

		self.next = document.createElement("span");
		self.next.className = "disable-page";
		div.appendChild(self.next);
		

		// next
		btn = document.createElement("button");
		btn.className = "x-btn x-page-next";
		btn.innerHTML = "&nbsp;";
		btn.onclick = self.pageControl;
		self.next.appendChild(btn);

		// last
		btn = document.createElement("button");
		btn.className = "x-btn x-page-last";
		btn.innerHTML = "&nbsp;";
		btn.onclick = self.pageControl;
		self.next.appendChild(btn);

		// 分隔
		span = document.createElement("span");
		span.className = "x-btn-split";
		span.innerHTML = "&nbsp;";
		div.appendChild(span);

		self.record = document.createElement("span");
		div.appendChild(self.record);
	}
	// 创建按钮
	this.createButtonArea = function (grid) {
		// 是否有内置按钮？
		// 是否存在外置按钮
		if (!self.grid.actions && (self.state=="readonly" || self.state=="update")) return false;

		var div = document.createElement("div");
		div.style.styleFloat = "right";
		div.style.textAlign = "right";
		div.style.verticalAlign = "middle";
		div.style.lineHeight = "100%";
		div.style.overflow = "hidden";
		div.style.paddingRight = "10px";
		div.style.height = "28px";

		grid.appendChild(div);

		var btn;
		// 先增加内置按钮
		if (self.state=="write") {
			btn = document.createElement("button");
			btn.innerHTML = "<b style=\"background-image:url('" + self.contextPath + "/images/icon/add.gif');\"></b>增加行";
			btn.setAttribute("actionid","ADD");
			btn.onclick = self.runGlobalAction;
			div.appendChild(btn);

			btn = document.createElement("button");
			btn.innerHTML = "<b style=\"background-image:url('" + self.contextPath + "/images/icon/delete.gif');\"></b>删除行";
			btn.setAttribute("actionid","DELETE");
			btn.onclick = self.runGlobalAction;
			div.appendChild(btn);
		}

		if (!self.grid.actions) {
			if (!btn)
				return false;
			return true;
		}

		var existBtn = (btn!=null);
		for (var i=0;i<self.grid.actions.length;i++) {
			var action = self.grid.actions[i];
			if (self.isBindField(action)) continue;
			if (action.operand=="ROW") continue;

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
			btn.onclick = self.runAction;
			div.appendChild(btn);
			existBtn = true;
		}

		return existBtn;
	}
	// 操作是否被绑定在记录上
	this.isBindField = function (action) {
		for (var i=0;i<self.grid.columns.length;i++) {
			if (self.grid.columns[i].actionId==action.code)	{
				return true;
			}
		}

		return false;
	}
	// 子表内部操作
	this.runGlobalAction = function (event) {
		self.syncLinkField();
		var e = event || window.event;
		var target = e.target || e.srcElement;
		var action = target.getAttribute("actionid");

		var rowId;
		var data;

		// 增加行
		if (action=="ADD")	{
			// 是否有增加行事件
			if (eval("typeof(on" + self.id + "AddRow)")=="function") {
				data = self.createNullRowData();
				if (eval("on" + self.id + "AddRow(data)")==false) {
					return false;
				}
				rowId = self._addRow(data);
				return false;
			}

			rowId = self._addRow();
			return false;
		}
		// 删除行
		if (action=="DELETE") {
			var tr = self.currentTR;
			if (tr && tr.getAttribute("rowId")) {
				rowId = tr.getAttribute("rowId");

				// 是否有删除行事件
				if (eval("typeof(on" + self.id + "DeleteRow)")=="function") {
					data = self.data[rowId];
					if (eval("on" + self.id + "DeleteRow(data)")==false) {
						return false;
					}
				}

				self.deleteRow(rowId);
			}

			return false;
		}

		return false;
	}
	// 综合处理方法
	this.runAction = function () {
		self.syncLinkField();
		var action = self.getAction(this.getAttribute("actionid"));
		// 先判断是否要运行某个操作的预操作
		if (eval("typeof(on" + self.id + action.code + "Click)")=="function") {
			if (eval("on" + self.id + action.code + "Click()")==false) {
				return false;
			}
		}

		if (document.getElementById("$ACTION"))
			document.getElementById("$ACTION").value = "";

		return self.runGridAction(action,this);
	}
	// 根据操作号，运行操作
	this.runGridActionByActionId = function (actionId) {
		self.syncLinkField();
		var action = self.getAction(actionId);
		if (!action) {
			alert("操作号：" + actionId + "不存在，或未定义！");
			return false;
		}
		if (document.getElementById("$ACTION"))
			document.getElementById("$ACTION").value = "";
		
		return self.runGridAction(action);
	}
	// 子表行运行行请求
	this.runGridRowAction = function (actionId) {
		self.syncLinkField();
		var action = self.getAction(actionId);
		if (!action) {
			alert("操作号：" + actionId + "不存在，或未定义！");
			return false;
		}
		// 有效性校验
		if (action.unCheck && action.unCheck=="Y")	{
			if (!self.onFormSubmit()) {
				// self.showMessage("子表格数据检查不通过，无法完成本次请求！");
				return false;
			}
		}

		self.submitUrl("",action,self.getSelectedRow());
	}
	// 运行某个Action
	this.runGridAction = function (action,obj) {
		// 有效性校验
		if (action.unCheck && action.unCheck=="Y")	{
			if (!self.onFormSubmit()) {
				// self.showMessage("子表格数据检查不通过，无法完成本次请求！");
				return false;
			}
		}

		if (action.type=="URL") {
			self.submitUrl("",action);
			return false;
		}

		if (action.type=="ROWS") {
			// 是否已经选定了记录？
			if (!self.isSelected()) return false;
			if (!action.url)
				action.url = self.grid.module + ".cmd?$ACTION=" + action.href;
			self.submitUrl("",action);
			return false;
		}
		if (action.type=="ROW") {
			if (!action.url)
				action.url = self.grid.module + ".cmd?$ACTION=" + action.href;
			self.submitUrl("",action);
			return false;
		}
		
		if (action.type=="CUSTOM") {
			if (!action.url)
				action.url = self.grid.module + ".cmd?$ACTION=" + action.href;
			self.submitUrl("",action);
			return false;
		}
		
		if (action.type=="AJAX") {
			self.submitGridAjaxRequest(action.href,{params:(action.params ? action.params : ""),rets:(action.rets ? action.rets : ""),callback:(action.callback ? action.callback : "")});
			return false;
		}
		if (action.type=="SELECTED") {
			var selected = self.getSelectedValues();
			if (selected=="") {
				alert("没有选定数据，无法返回！");
				return false;
			}
			top.window.submitDialog(window,self.getSelectedValues());
			return false;
		}
		if (action.type=="CLOSE") {
			top.window.getDialog(window).close();
			return false;
		}
		if (action.type=="POPUP") {
			var multi = action.operand;
			if (multi=="ROW")
				multi = "radio";
			else if (multi=="ROWS")
				multi = "checkbox";
			else
				multi = "";

			if (action.href=="DATE") {
				top.window.showDialog(window,action.name,"common/date.html","240","210","dialogSubmit",obj);
				return false;
			}
			if (action.href=="DATETIME") {
				top.window.showDialog(window,action.name,"common/datetime.html","240","260","dialogSubmit",obj);
				return false;
			}
			if (action.href=="USER") {
				top.window.showDialog(window,action.name,"ou/user.cmd?$ACTION=deptusertree&box=" + multi,"330","410","dialogSubmit",obj);
				return false;
			}
			if (action.href=="DEPT") {
				top.window.showDialog(window,action.name,"ou/dept.cmd?$ACTION=deptselect&box=" + multi,"330","410","dialogSubmit",obj);
				return false;
			}
			if (action.href=="RIGHT") {
				top.window.showDialog(window,action.name,"ou/acl.cmd?$ACTION=main","670","484","dialogSubmit",obj);
				return false;
			}
			if (action.href=="URL")	{
				var href = action.url;
				if (multi) {
					if (href.indexOf("?")==-1)
						href += "?";
					else
						href += "&";
					href += "$BOX" + multi;
				}

				href += self.addColParams(null,action.args);
				href += self.addParams(action.params);
				top.window.showDialog(window,action.name,href,action.width,action.height,"gridDialogSubmit",obj);
				return false;
			}
			self.showMessage("弹出操作不支持，无法继续！");
			return false;
		}
		if (action.type=="JAVASCRIPT") {
			if (action.url) {
				eval(action.url);
			}

			return false;
		}

		self.showMessage("未处理的请求：" + action.type);
		return false;
	}
	// 运行子表请求，ctrl-请求号，ins-输入参数
	this.runController = function (ctrl,ins) {
		var url = this.contextPath + "/GridAction.cmd?$ACTION=control";
		url += "&$SYSTEM=" + document.getElementById("$SYSTEM").value;
		url += "&$MODULE=" + document.getElementById("$MODULE").value;
		url += "&$FIELDSET=" + self.id;
		url += "&$GRIDID=" + self.grid.code;
		url += "&$CONTROL=" + ctrl;
		
		var params = self.addParams(ins);

		DHTMLSuite.ajax.sendRequest(url,params,'grid' + self.id + '.controlRetHandler');
	}
	// 运行子表行请求，ctrl-请求号，ins-输入参数，outs-输出参数
	this.runRowController = function (ctrl,ins,outs) {
		var rowId = self.getSelectedRow();
		if (!rowId) {
			alert("无法获取行号，控制请求：" + ctrl + "无法执行！");
			return false;
		}
		var url = this.contextPath + "/GridAction.cmd?$ACTION=control";
		url += "&$SYSTEM=" + document.getElementById("$SYSTEM").value;
		url += "&$MODULE=" + document.getElementById("$MODULE").value;
		url += "&$GRIDID=" + self.grid.code;
		url += "&$FIELDSET=" + self.id;
		url += "&$CONTROL=" + ctrl;
		url += "&$ROWID=" + rowId;
		if (outs)
			url += "&$RETS=" + outs;
		
		var params = self.addColParams(rowId,ins);
		DHTMLSuite.ajax.sendRequest(url,params,'grid' + self.id + '.controlRetHandler');
		
	}
	// 子表请求返回处理
	this.controlRetHandler = function (ajax) {
		var ajaxObj = eval("(" + ajax['response'] + ")");
		var str;
		var b;
		var rowId = ajaxObj.$ROWID;
		var rets = ajaxObj.$RETS;
		var handler = ajaxObj.$HANDLER;   // 处理方法：create/update/delete/other
		var data = ajaxObj.DATA;

		if (handler=="create")	{
			self.addRow(data);
			return;
		}

		if (handler=="update")	{
			if (rowId)	{
				for (str in data) {
					if (str.indexOf("$")!=-1) continue;
					if (rets) {
						b = false;
						var r = rets.split(",");
						for (var i=0;i<r.length;i++) {
							if (r[i]==str)	{
								b = true;
								break;
							}
						}
						if (!b) continue;
					}
					self.setFieldValue(rowId,str,data[str]);
				}
				self.rowChange(rowId);
			}

			return;
		}
		
		if (handler=="delete") {
			self.deleteRow(rowId);
			return;
		}

		str = ajaxObj.$RESULT;
		document.getElementById("$MESSAGE").innerHTML = "";
		if (str && String(str)!="0") {
			if (ajaxObj.$MESSAGE)
				document.getElementById("$MESSAGE").innerHTML = ajaxObj.$MESSAGE;
			else
				document.getElementById("$MESSAGE").innerHTML = "操作失败！";
		} else {
			if (ajaxObj.$MESSAGE)
				document.getElementById("$MESSAGE").innerHTML = ajaxObj.$MESSAGE;
		}
		if (ajaxObj.$ALERT && ajaxObj.$ALERT=="Y" && ajaxObj.$MESSAGE)	{
			alert(ajaxObj.$MESSAGE);
		}

		// 调用回调函数
		str = ajaxObj.$CALLBACK;
		if (str) {
			eval(str + "(ajaxObj);");
		}
	}
	// 取选择框内容，使用竖线分隔，多值内部使用逗号分隔
	this.getSelectedValues = function () {
		var selected = document.getElementsByName("$" + self.id + "-selected");
		if (!selected || selected.length==0) {
			return "";
		}
		if (selected.length==1)
			return selected[0].value;

		var value;
		var v = null;
		for (var i=0;i<selected.length;i++)	{
			if (selected[i].checked==false) continue;
			if (!v) {
				v = selected[i].value.split("|");
				continue;
			}
			value = selected[i].value.split("|");
			for (var n=0;n<v.length;n++) {
				v[n] += ",";
				v[n] += value[n];
			}
		}

		var ret = "";
		// 合成最终值
		if (v)	{
			for (var i=0;i<v.length;i++) {
				if (ret!="")
					ret += "|";
				ret += v[i];
			}
		}

		return ret;
	}
	// 处理请求
	this.clickURL = function (fieldid,actionId,rowId) {
		var action = self.getActionByFieldId(fieldid);

		if (action==null) {
			self.showMessage("操作不存在！");
			return;
		}

		// 先判断是否要运行某个操作的预操作
		if (eval("typeof(on" + self.id + action.code + "Click)")=="function") {
			var data = self.data[rowId];
			if (eval("on" + self.id + action.code + "Click(data)")==false) {
				return false;
			}
		}
		

		self.submitUrl(fieldid,action,rowId);
	}
	// 请求提交处理
	this.submitUrl = function(fieldid,action,rowId) {
		if (action.confirm=="Y") {
			if (!confirm("您真的要进行[" + action.name + "]操作吗?")) {
				return false;
			}
		}
		if (document.getElementById("$ACTION"))
			document.getElementById("$ACTION").value = "";
		if (!action.url && !action.href) {
			self.showMessage("操作设置不全，无法继续！");
			return;
		}

		// URL优先
		var href = action.url;
		if (!href)	{
			href = self.grid.module + ".cmd?$ACTION=" + action.href;
		}
		// 设置参数，只针对行操作
		if (rowId) {
			var data = self.data[rowId];
			var url = self.getDyncUrl(fieldid,data);
			if (url) 
				href = url;
			
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
				top.window.showGridDialog(window,action.name,"common/date.html","240","210","gridDialogSubmit",self,rowId,fieldid);
				return false;
			}
			if (action.href=="DATETIME") {
				top.window.showGridDialog(window,action.name,"common/datetime.html","240","260","gridDialogSubmit",self,rowId,fieldid);
				return false;
			}
			if (action.href=="USER") {
				top.window.showGridDialog(window,action.name,"ou/user.cmd?$ACTION=deptusertree&box=" + multi,"330","410","gridDialogSubmit",self,rowId,fieldid);
				return false;
			}
			if (action.href=="DEPT") {
				top.window.showGridDialog(window,action.name,"ou/dept.cmd?$ACTION=deptselect&box=" + multi,"330","410","gridDialogSubmit",self,rowId,fieldid);
				return false;
			}
			if (action.href=="RIGHT") {
				top.window.showGridDialog(window,action.name,"ou/acl.cmd?$ACTION=main","670","484","gridDialogSubmit",self,rowId,fieldid);
				return false;
			}
			if (action.href=="URL")	{
				if (multi!="")
					href += "&$BOX=" + multi;
				href += self.addColParams(rowId,action.args);
				href += self.addParams(action.params);
				top.window.showGridDialog(window,action.name,href,action.width,action.height,"gridDialogSubmit",self,rowId,fieldid);
				return false;
			}
			self.showMessage("弹出操作不支持，无法继续！");
			return false;
		}

		if (action.type=="JAVASCRIPT") {
			if (action.url) {
				eval(action.url);
			}

			return false;
		}
		
		if (action.type=="AJAX") {
			self.submitGridRowAjaxRequest(action.href,{params:(action.args ? action.args : ""),rets:(action.rets ? action.rets : ""),callback:(action.callback ? action.callback : "")});
			return false;
		}

		// 在不同的目标运行
		if (action.target=="DIALOG") {
			if (!action.width)
				action.width = "640";
			if (!action.height)
				action.height = "400";
			// href = self.grid.system + "/" + href;
			top.window.showDialog(window,action.name,href,action.width,action.height);
			return;
		}

		if (action.target=="TAB") {
			top.window.tab.addTab(action.code,action.name,href,null,true);
			return;
		}

		if (action.target=="_blank") {
			window.open(href);
			return;
		}

		self.clearOpts();
		

		document.forms[0].action = href;
		document.forms[0].target = action.target;
		document.forms[0].method = "post";
		document.forms[0].submit();
	}
	// 清除选定行数据，fields-制定字段，空表示所有字段数据
	this.clearRowData = function (fields) {
		var rowId = self.getSelectedRow();
		var fieldId;
		if (fields)	{
			var str = fields.split(",");
			for (var i=0;i<str.length;i++)	{
				if (!str[i]) continue;
				self.setFieldValue(rowId,str[i],"");
			}

		} else {
			for (var i=0;i<self.columns.length;i++) {
				self.setFieldValue(rowId,self.columns[i].code,"");
			}
		}
		self.rowChange(rowId);
	}
	// 取动态设置合成动态的链接内容
	this.getDyncUrl = function (fieldid,data) {
		if (!self.grid.rowDisplay) return null;

		for (var i=0;i<self.grid.rowDisplay.length;i++)	{
			v = data[self.grid.rowDisplay[i].col];
			if (!v || v!=self.grid.rowDisplay[i].value) continue;
			if (!self.grid.rowDisplay[i].cell) continue;
			if (self.grid.rowDisplay[i].cell!=fieldid) continue;
			if (!self.grid.rowDisplay[i].url) continue;
			return self.grid.rowDisplay[i].url;
		}

		return null;
	}
	// 单元格失去焦点
	this.onCellBlur = function (evt) {
		var e = window.event || evt;
		var src = e.srcElement || e.target;
		stopPropagation(e);
		self.blurRowId = src.parentNode.getAttribute("rowId");

		setTimeout(self.blurHandler,50);
	}
	// 判断是否行变更
	this.blurHandler = function () {
		if (!self.blurRowId)
			return;
		var obj = document.activeElement;
		if (obj.parentNode && obj.parentNode.tagName=="TD")
			obj = obj.parentNode;
		if (obj.tagName=="TD") {
			obj = obj.parentNode.getAttribute("rowId");
			if (obj && obj==self.blurRowId) {
				return;     // 是同一行的网格
			}
		}
		// 出现控件或弹出框，判断是否在编辑同一行
		if (self.editingRowId) {
			if (self.editingRowId==self.blurRowId)
				return;
		}
		var str = self.data[self.blurRowId]['$status'];
		if (str=='add' || str=='edit') {
		//	document.getElementById("$MESSAGE").innerHTML += self.blurRowId + "行变更！";
			self.rowChange(self.blurRowId);
		}
	}
	// 控件结束编辑
	this.cellEdited = function () {
		if (!self.blurRowId)
			return;
		var obj = document.activeElement;
		if (obj.parentNode && obj.parentNode.tagName=="TD")
			obj = obj.parentNode;
		if (obj.tagName=="TD") {
			obj = obj.parentNode.getAttribute("rowId");
			if (obj && obj==self.blurRowId) {
				return;     // 是同一行的网格
			}
		}
		// document.getElementById("$MESSAGE").innerHTML += "行变更！";
		self.rowChange(self.blurRowId);
	}
	// 行变更
	this.rowChange = function (rowId,action) {
		if (self.state=="readonly") return;
		if (!document.getElementById("$ID")) return;

		if (!self.validRowData(rowId)) {
			if (action=="ADD")
				self.showMessage("");
			// alert("行数据无法通过校验，请校对！");
			return false;
		}

		var params = "";
		var data = self.data[rowId];
		// 行数据没有变更
		if (data["$changed"]!="true") {
			return false;
		}

		// 是否有编辑事件
		if (eval("typeof(on" + self.id + "UpdateRow)")=="function") {
			var data = self.data[rowId];
			if (eval("on" + self.id + "UpdateRow(data)")==false) {
				return false;
			}
		}

		var c;
		for (c in data)	{
			if (!data[c]) continue;
			if (params!="")
				params += "&";
			params += c + "=" + self.Encode(data[c]);
		}

		DHTMLSuite.ajax.sendRequest(self.contextPath + "/GridAction.cmd?$ACTION=cache&$id=" + document.getElementById("$ID").value + "&$gridid=" + self.id + "&$rowid=" + rowId,params);
		data["$changed"] = "";
		return false;
	}
	// 转码，处理AJAX POST方式时，特殊字符：&=
	this.Encode = function (value) {
		var str = String(value);
		str = str.replace(/\&/g,"%26");
		str = str.replace(/\=/g,"%3D");
		
		return str;
	} 

	// 缓冲结果
	this.cacheResult = function () {
		self.showMessage("已保存到服务器！");
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
	// 选择框是否选择
	this.isSelected = function () {
		if (self.box!="radio" && self.box!="checkbox") {
			self.showMessage("没有选择框，无法进行记录选择！");
			return false;
		}

		var selected = document.getElementsByName("$" + self.id + "-selected");
		for (var i=0;i<selected.length;i++) {
			if (selected[i].checked) {
				return true;
			}
		}
		alert("没有选择记录，请选择！");
		
		return false;
	}
	// 创建查询区
	this.createQueryArea = function (grid) {
		if (!self.grid.opts && !self.grid.exportXls) return false;

		var div = document.createElement("div");
		div.style.styleFloat = "left";
		div.style.textAlign = "left";
		div.style.paddingLeft = "10px";
		div.style.verticalAlign = "middle";
		div.style.lineHeight = "100%";
		div.style.overflow = "hidden";
		div.style.height = "28px";
		div.style.whiteSpace = "nowrap";

		grid.appendChild(div);
		self.queryArea = div;
		
		if (!self.grid.opts && self.grid.exportXls) {
			var exp = document.createElement("button");
			// query.className = "x-btn-text x-btn-search";
			exp.innerHTML = "<b style=\"background-image:url('../images/icon/exportxls.gif');\"></b>导出Excel";
			exp.onclick = function () {
				self.runExport();
				return false;
			}
			div.appendChild(exp);
			return true;
		}

		var showBtn = false;
		for (var i=0;i<self.grid.opts.length;i++) {
			var input = self.createQueryInput(div,self.grid.opts[i]);
			if (input.type!="hidden") {
				var span = document.createElement("span");
				span.innerHTML = "&nbsp;";
				span.className = "x-btn-split";
				div.appendChild(span);
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
		div.appendChild(query);

		if (self.grid.exportXls) {
			var exp = document.createElement("button");
			// query.className = "x-btn-text x-btn-search";
			exp.innerHTML = "<b style=\"background-image:url('../images/icon/exportxls.gif');\"></b>导出Excel";
			exp.onclick = function () {
				self.runExport();
				return false;
			}
			div.appendChild(exp);
		}

		return true;
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
			tag.value = opt.title;
			tag.title = opt.title;
			tag.setAttribute("readOnly","true");
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
					top.window.showDialog(window,tag.title,"ou/dept.cmd?$ACTION=deptselect&box=radio","330","410","dialogClauseSubmit",tag);
					return;
				}
				if (opt.dictId=="DATE") {
					top.window.showDialog(window,tag.title,"common/date.html","240","210","dialogClauseSubmit",tag);
					return;
				}
				if (opt.dictId=="DATETIME") {
					top.window.showDialog(window,tag.title,"common/datetime.html","240","260","dialogClauseSubmit",tag);
					return;
				}
				if (opt.dictId=="USER") {
					top.window.showDialog(window,tag.title,"ou/user.cmd?$ACTION=deptusertree&box=radio","330","410","dialogClauseSubmit",tag);
					return;
				}
				if (opt.dictId=="RIGHT") {
					top.window.showDialog(window,tag.title,"ou/acl.cmd?$ACTION=main","670","484","dialogClauseSubmit",tag);
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
			tag.value = opt.title;
			tag.title = opt.title;
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

		tag.onfocus = function () {
			if (this.value==this.title) {
				if (this.style.color=="#000" || this.style.color=="rgb(0, 0, 0)"){
					return;
				}
				this.value = "";
			}
			this.style.color = "#000";
		}

		tag.onblur = function () {
			if (!this.value)	{
				this.value = this.title;
				this.style.color = "#888";
				return;
			}
		}

		div.appendChild(tag);

		return tag;
	}
	// 重新对关联域赋值
	this.syncLinkField = function () {
		if (!self.grid.opts) return;

		for (var i=0;i<self.grid.opts.length;i++) {
			if (self.grid.opts[i].type!="LINK")	continue;
			// 父级域
			if (document.getElementById(self.grid.opts[i].dictId))
				document.getElementById("$" + self.id + "-option-" + self.grid.opts[i].id).value = document.getElementById(self.grid.opts[i].dictId).value;
		}
	}
	// 显示页面记录信息
	this.showPageInfo = function (pageCtl) {
		if (!self.showpagectrl) return;

		self.pageCtl = pageCtl;
		// 显示当前页
		document.getElementById("$" + self.id + "-pageno").value = pageCtl.curpage;
		// 显示页信息
		self.page.innerHTML = pageCtl.pagecount;
		// 显示记录信息
		self.record.innerHTML = "第(" + String(pageCtl.from) + "-" + String(pageCtl.to) + ")/" + pageCtl.rowscount + "条";
		if (pageCtl.curpage>1)
			self.prev.className = "enable-page";
		else
			self.prev.className = "disable-page";
		if (pageCtl.curpage==pageCtl.pagecount || pageCtl.pagecount==0)
			self.next.className = "disable-page";
		else
			self.next.className = "enable-page";
	}
	// 处理翻页
	this.pageControl = function () {
		if (!self.showpagectrl) return;
		if (this.parentNode.className=="disable-page") return false;
		var pageno = document.getElementById("$" + self.id + "-pageno").value;
		// 处理跳转翻页
		if (this.tagName=="INPUT") {
			if (isNaN(pageno)) {
				document.getElementById("$" + self.id + "-pageno").value = self.pageCtl.curpage;
				return false;
			}
		}
		// 处理前后翻页
		if (this.className.indexOf("prev")!=-1) {
			pageno--;
		}
		if (this.className.indexOf("next")!=-1) {
			pageno++;
		}
		if (this.className.indexOf("first")!=-1) {
			pageno = 1;
		}
		if (this.className.indexOf("last")!=-1) {
			pageno = self.pageCtl.pagecount;
		}

		document.getElementById("$" + self.id + "-pageno").value = pageno;
		self.runQuery();

		return false;
	}
	// 查询处理
	this.runQuery = function (isInit) {
		if (isInit)
			document.getElementById("$" + self.id + "-pageno").value = "1";

		// 将查询条件为空的文本内容清除
		self.clearOpts();
		self.clearAll();
		var form = new DHTMLSuite.form({ formRef:self.id,action:'GridAction.cmd?$ACTION=query&$SYSTEM=' + self.grid.system + '&$MODULE=' + self.grid.module + '&$FIELDSET=' + self.id + '&$GRIDID=' + self.grid.code,callbackOnComplete:'grid' + self.id + '.showQueryResult'});
		form.submit();
		// DHTMLSuite.ajax.sendTagRequest('GridAction.cmd?$ACTION=query&$MODULE=' + self.grid.module + '&$FIELDSET=' + self.id + '&$GRIDID=' + self.grid.code,self.id,'grid' + self.id + '.showQueryResult');
	}
	// 导出excel
	this.runExport = function () {
		// 将查询条件为空的文本内容清除
		var form = document.createElement("form");
		document.body.appendChild(form);
		if (self.queryArea) {
			var inputs = self.queryArea.getElementsByTagName("input");
			for (var i=0;i<inputs.length;i++) {
				if (inputs[i].style.color!="#000" && inputs[i].style.color!="rgb(0, 0, 0)") continue;
				var field = document.createElement("input");
				field.type = "hidden";
				field.id = inputs[i].id;
				field.name = inputs[i].name;
				field.value = inputs[i].value;
				form.appendChild(field);
			}
			inputs = self.queryArea.getElementsByTagName("select");
			for (var i=0;i<inputs.length;i++) {
				if (!inputs[i].value) continue;
				var field = document.createElement("input");
				field.type = "hidden";
				field.id = inputs[i].id;
				field.name = inputs[i].name;
				field.value = inputs[i].value;
				form.appendChild(field);
			}
		}
		form.action = 'GridAction.cmd?$ACTION=export&$SYSTEM=' + self.grid.system + '&$MODULE=' + self.grid.module + '&$FIELDSET=' + self.id + '&$GRIDID=' + self.grid.code;
		form.target = "_blank";
		form.method = "POST";
		form.submit();
		document.body.removeChild(form);
	}
	// 显示查询结果
	this.showQueryResult = function (ajaxObj) {
		//var ajaxObj = Obj.response;
		//ajaxObj = eval("(" + ajaxObj + ")");
		// 将查询条件为空的文本内容恢复
		self.resumeOpts();

		var data = ajaxObj.grid;
		var pageCtl = ajaxObj.pagecontrol;
		self.pageCtl = pageCtl;
		if (data)
			self.addRow(data,true);
		self.showPageInfo(pageCtl);
		self.saveClause();
	}
	// 清除查询选项的内容
	this.clearOpts = function () {
		if (!self.queryArea) return;

		var inputs = self.queryArea.getElementsByTagName("input");
		for (var i=0;i<inputs.length;i++) {
			if (inputs[i].type=="hidden") continue;
			if (inputs[i].style.color!="#000" && inputs[i].style.color!="rgb(0, 0, 0)") {
				inputs[i].value = "";
			}
		}
	}
	// 恢复查询选项的内容
	this.resumeOpts = function () {
		if (!self.queryArea) return;

		var inputs = self.queryArea.getElementsByTagName("input");
		for (var i=0;i<inputs.length;i++) {
			if (inputs[i].type=="hidden") continue;
			if (!inputs[i].value) {
				inputs[i].value = inputs[i].title;
				inputs[i].style.color = "#888";
			}
		}
	}

	// 增加行
	this.addRow = function (jsonArray,bIsNotManual) {
		if (!jsonArray) {    // 增加一个空行
			self._addRow(null,bIsNotManual);	
			return;
		}

		for (var i=0;i<jsonArray.length;i++) {
			var row = jsonArray[i];
			self._addRow(row,bIsNotManual);		
		}
	}
	// 增加行数据
	this._addRow = function (data,bIsNotManual) {
		if (!data)
			data = self.createNullRowData();

		// 取rowId
		var rowId = data["$rowid"];
		if (!rowId)
			rowId = self.getNewRowId();
		data["$rowid"] = rowId;      // 保存记录号
		if (bIsNotManual) {
			data["$changed"] = "";   // 保存
			data["$status"] = "";     // 保存状态
		} else {
			data["$changed"] = "true";   // 保存
			data["$status"] = "add";     // 保存状态
		}

		self.data[rowId] = data;
		
		// 显示
		var tr = self.tabDetail.insertRow(self.tabDetail.rows.length);
		tr.setAttribute("rowId",rowId);
		var td;
		// 增加选择框列
		if (self.box=="checkbox") {
			td = tr.insertCell(tr.cells.length);
			td.style.textAlign = "center";
			addEvent(td,"blur",self.onCellBlur);
			td.tabIndex = 1;
			var box = document.createElement("input");
			box.type = self.box;
			box.name = "$" + self.id + "-selected";
			box.id = box.name;
			td.appendChild(box);
			// 对选择框进行赋值
			box.value = self.getRowKey(rowId);
			box.onclick = function () { 
				if (typeof(onGridBoxClick)=="function") {
					onGridBoxClick(this);
				}
			};
		}
		if (self.box=="radio") {
			td = tr.insertCell(tr.cells.length);
			td.style.textAlign = "center";
			td.tabIndex = 1;
			addEvent(td,"blur",self.onCellBlur);
			var box;
			var value = self.getRowKey(rowId);
			var name = "$" + self.id + "-selected";
			if(document.uniqueID) {
				box = document.createElement("<input type='radio' name='" + name + "' id='" + name + "' value='" + value + "'>");
			} else {
				box = document.createElement("input");
				box.type = self.box;
				box.name = name;
				box.id = name;
				box.value = value;
			}
			td.appendChild(box);
			box.onclick = function () { 
				if (typeof(onGridBoxClick)=="function") {
					onGridBoxClick(this);
				}
			};
		}
		// 增加行序号列
		if (self.showIndexNo) {
			td = tr.insertCell(tr.cells.length);
			if (self.pageCtl)
				td.innerHTML = (self.tabDetail.rows.length - 1) + (self.pageCtl.curpage==0 ? 0 : self.pageCtl.curpage - 1) * self.pageCtl.pagerows;
			else
				td.innerHTML = self.tabDetail.rows.length - 1;
			td.style.textAlign = "center";
			addEvent(td,"blur",self.onCellBlur);
			td.tabIndex = 2;
		}

		var tds = new Array();   // 记录每列的TD对象
		for (var i=0;i<self.columns.length;i++) {
			if (self.columns[i].showType=="HIDDEN") continue;
			td = tr.insertCell(tr.cells.length);
			td.tabIndex = i + 10;
			addEvent(td,"blur",self.onCellBlur);
			if (self.columns[i].align==null || self.columns[i].align=="")
				self.columns[i].align = "center";
			td.style.textAlign = self.columns[i].align;
			if ((self.columns[i].showType=="TEXT" || self.columns[i].showType=="TEXTAREA" || self.columns[i].showType=="COMBOX") && self.state!="readonly")  
				addEvent(td,"click",self.onClick);
			if (self.columns[i].code!="length")
				tds[self.columns[i].code] = td;
			if (self.isHidden(self.columns[i].code,data)) {
				td.innerHTML = "&nbsp;";
				continue;
			}
			// 绑定链接或操作
			self.showHtml(td);
		}
		self.setRowColor(tr,tds,data);
		self.showRowsBackground();
		self.setRowAction();

		self.rowChange(rowId,"ADD");

		return rowId;
	}
	// 设置个性化显示
	this.setRowColor = function (tr,tds,data) {
		if (!self.grid.rowDisplay) return false;

		var v;

		var fields = "";
		for (var i=0;i<self.grid.rowDisplay.length;i++)	{
			v = data[self.grid.rowDisplay[i].col];
			v = String(v);
			if (!v || v!=self.grid.rowDisplay[i].value) continue;
			// 设置单元格的颜色
			if (self.grid.rowDisplay[i].cell) {
				fields = self.grid.rowDisplay[i].cell.split(",");
				for (var n=0;n<fields.length;n++) {
					if (!tds[fields[n]]) continue;
					if (self.grid.rowDisplay[i].cellColor)
						tds[fields[n]].style.color = self.grid.rowDisplay[i].cellColor;
					
					if (self.grid.rowDisplay[i].cellBgcolor)
						tds[fields[n]].style.background = self.grid.rowDisplay[i].cellBgcolor;
				}
			}

			if (self.grid.rowDisplay[i].rowColor) {
				tr.style.color = self.grid.rowDisplay[i].rowColor;
			}
			if (self.grid.rowDisplay[i].rowBold) {
				tr.style.fontWeight = "bold";
			}
			if (self.grid.rowDisplay[i].rowBgcolor)	{
				tr.style.background = self.grid.rowDisplay[i].rowBgcolor;
			}
			if (self.grid.rowDisplay[i].disableBox && self.grid.rowDisplay[i].disableBox=="Y") {
				var list = tr.getElementsByTagName("input");
				for (var n=0;n<list.length;n++ ) {
					if ((list[n].type=="checkbox" || list[n].type=="radio") && (list[n].id==("$" + self.id + "-selected"))) {
						list[n].disabled = true;
					}
				}
			}
		}
	}
	// 列内容是否隐藏
	this.isHidden = function (col,data) {
		if (!self.grid.rowDisplay) return false;

		var v;
		var fields = "";
		for (var i=0;i<self.grid.rowDisplay.length;i++)	{
			v = data[self.grid.rowDisplay[i].col];
			v = String(v);
			if (!v || v!=self.grid.rowDisplay[i].value) continue;
			// 是否包含在隐藏设置中
			fields = self.grid.rowDisplay[i].hideCols;
			if (!fields) continue;
			var str = fields.split(",");
			for (var n=0;n<str.length;n++) {
				if (col==str[n]) {
					return true;
				}
			}
		}

		return false;
	}
	// 创建一个带默认值的空行数据
	this.createNullRowData = function () {
		var data = new Array();
		for (var i=0;i<self.columns.length;i++) {
			// 是否关系条件映射的字段？
			var field = self.getLinkField(self.columns[i].code);
			if (field)	{
				field = document.getElementById(field);
				if (!field) continue;
				data[self.columns[i].code] = field.value;
				continue;
			}
			if (!self.columns[i].defaultValue) continue;
			data[self.columns[i].code] = self.columns[i].defaultValue;
		}

		return data;
	}
	// 取某个字段对应的关系条件映射的表单域
	this.getLinkField = function (field) {
		if (!field) return null;
		if (!self.grid.opts) return null;
		
		for (var i=0;i<self.grid.opts.length;i++) {
			if (self.grid.opts[i].type!="LINK") continue;
			if (self.grid.opts[i].field==field) {
				return self.grid.opts[i].dictId;
			}
		}

		return null;
	}
	// 清除新增状态
	this.clearStatus = function () {
		var c;
		var data;
		for (c in self.data) {
			data = self.data[c];
			data["$status"] = "";
			data["$changed"] = "";
		}
	}
	// 删除行
	this.deleteRow = function (rowId) {
		if (self.tabDetail.rows.length<=1) return;
		// 如果没有指定，则只删除当前选中行
		var id;
		var tr;

		for (var i=self.tabDetail.rows.length-1;i>0;i--) {
			tr = self.tabDetail.rows[i];
			id = tr.getAttribute("rowId");
			if (id!=rowId) continue;
			var data = self.data[rowId];
			data["$status"] = "delete";
			data["$changed"] = "true";
			self.rowChange(rowId);
			self.tabDetail.deleteRow(i);
			break;
		}
	}
	// 删除所有行
	this.clearAll = function () {
		if (self.tabDetail.rows.length<=1) return;
		
		var rowId;
		var tr;
		for (var i=self.tabDetail.rows.length-1;i>0;i--) {
			tr = self.tabDetail.rows[i];
			rowId = tr.getAttribute("rowId");
			self.deleteRow(rowId);
			var data = self.data[rowId];
			if (data["$status"] == "add")
				self.data[rowId] = null;
			else
				data["$status"] = "delete";
		}
		
		self.data = new Array();
	}
	// 设置当前行
	this.setCurrentRow = function () {

	}
	// 交错显示
	this.showRowsBackground = function () {
		if (self.tabDetail.rows.length<=1) return;
		
		var tr;
		for (var i=1;i<self.tabDetail.rows.length;i++) {
			tr = self.tabDetail.rows[i];
			if (i % 2 == 1)
				addClass(tr,"uneven");
			else
				addClass(tr,"even");
		}
	}
	// 设置行选择颜色
	this.setRowAction = function () {
		if (self.tabDetail.rows.length<=1) return;
		
		var tr;
		for (var i=1;i<self.tabDetail.rows.length;i++) {
			tr = self.tabDetail.rows[i];
			addEvent(tr, "mouseover", self.onRowOver);
			addEvent(tr, "mouseout", self.onRowOut);
			addEvent(tr, "mousedown", self.onRowSelected);
		}
	}
	//列头上移动鼠标的事件
	this.onMoveOverHeader = function(e) {
		e = e || window.event;
		var target = e.target || e.srcElement;
		if (target.nodeName=='TD' && !self.resizing) {
			var x = getActlClientX(e);
			//第一个判断列的顶部和底部，第二个判断表格的左右边界，第三个判读列的合适位置
			if (x > getElementLeft(target) + parseInt(target.offsetWidth) - self.tabDetail.parentNode.scrollLeft - self.boundary){
				target.style.cursor = 'e-resize';
			} else {
				target.style.cursor = 'default';
			}
			//阻止事件进行冒泡
			stopPropagation(e);
		} 
	}
	// 鼠标单击开始移动
	this.onMouseClick = function(event) {
		event=event||window.event;
		var target = event.target || event.srcElement;
		if (target.style.cursor!='e-resize')
			return;
		var obj = target;
		self.currentTD = obj;
		self.resizing = true;

		preventDefault(event);
		//删除事件监听
		removeEvent(obj, 'mousemove', self.onMoveOverHeader);
		//添加新的事件监听
		addEvent(document, 'mousemove', self.onMouseClickMove);
		addEvent(document, 'mouseup', self.onMouseUp);
		obj.mouseDownX=event.clientX;
		obj.mouseDownY=event.clientY;
		// obj.tdW = obj.offsetWidth;
	}
	// 鼠标调整表格宽度
	this.onMouseClickMove = function (event) {
		// 取消文本选定
		if (document.selection) {
			document.selection.empty();
		} else if (window.getSelection) {
			window.getSelection().removeAllRanges();
		}
		if(!self.currentTD) return ;
		var obj = self.currentTD;
		event=event||window.event;
		if(!obj.mouseDownX) return false;
		// if(obj.parentNode.rowIndex!=0) return false;

		var cell = self.getTitleCell(obj.getAttribute("titleIndex"));
		var newWidth = parseInt(cell.style.width)*1 + event.clientX*1 - obj.mouseDownX;
		if(newWidth<=0)
			newWidth = 1;
		cell.style.width = newWidth + "px";
		var nIndex = self.currentTD.getAttribute("titleIndex");
		self.tabDetail.rows[0].cells[parseInt(nIndex)].style.width = cell.style.width;
		obj.mouseDownX=event.clientX;
		obj.mouseDownY=event.clientY;
	}
	// 鼠标up
	this.onMouseUp = function (){
		if(!self.currentTD) return;
		if (self.currentTD.releaseCapture) 
			self.currentTD.releaseCapture();
		self.currentTD=null;
		//删除事件监听
		removeEvent(document, 'mousemove', self.onMouseClickMove);
		removeEvent(document, 'mouseup', self.onMouseUp);
		self.resizing = false;
	}
	// 取标题列首行单元格
	this.getTitleCell = function (titleIndex) {
		return self.tabHeader.rows[0].cells[parseInt(titleIndex)];
	}
	// 鼠标经过行数据
	this.onRowOver = function (event) {
		event=event||window.event;
		var target = event.target || event.srcElement;
		addClass(target.parentNode,"mouseover");

		//阻止事件进行冒泡
		stopPropagation(event);
	}
	// 鼠标离开
	this.onRowOut = function (event) {
		event=event||window.event;
		var target = event.target || event.srcElement;
		removeClass(target.parentNode,"mouseover");
		//阻止事件进行冒泡
		stopPropagation(event);
	}
	// 鼠标按下
	this.onRowSelected = function (event) {
		event=event||window.event;
		var target = event.target || event.srcElement;
		if (self.currentTR)	{
			removeClass(self.currentTR,"rowselected");
		}
		self.currentTR = self.getCurrentRow(target);

		addClass(self.currentTR,"rowselected");
		//阻止事件进行冒泡
		stopPropagation(event);
	}
	// 取当前行的TR
	this.getCurrentRow = function (target) {
		var obj = target;

		while (true) {
			if (obj.tagName=="TR")	{
				if (obj.getAttribute("rowId"))
					return obj;
			}
			obj = obj.parentNode;
			if (obj.tagName=="BODY") return null;
		}
	}
	// 滚动表格
	this.onScroll = function () {
		self.tabHeader.parentNode.scrollLeft = self.tabDetail.parentNode.scrollLeft;
	}

	// 鼠标单击响应
	this.onClick = function (event) {
		event = event || window.event;
		var cell = event.target || event.srcElement;
		if (window.event) {
			event.cancelBubble = true;
		} else {
			event.stopPropagation();
		}
		
		if (cell.tagName!="TD")
			return;
		var field = self.getField(cell);
		if (field==null) return;
		var rowId = self.getRowId(cell);
		if (!rowId) return;
		self.editingRowId = rowId;    // 设置正在编辑的行号
		if (field.showType=="TEXT")
			self.showText(cell);
		else if (field.showType=="TEXTAREA")
			self.showTextArea(cell);
		else if (field.showType=="COMBOX")
			self.showCombox(cell,field);
		else
			self.showHtml(cell);

	}
	// 显示只读
	this.showReadOnly = function (cell,field) {
		return;
	}
	// 显示下拉
	this.showCombox = function (cell,field) {
		if (self.isBindAction(cell)) return;
		// 是否服务器端字典
		if (field.dictType && field.dictType=="S" && field.dictId) {
			var rowId = self.getRowId(cell);
			var url = "DictAction.cmd";
			url += "?$dictid=" + field.dictId;
			url += "&$rowid=" + rowId;
			url += "&$field=" + field.code;
			var params = self.addColParams(rowId,field.linkFields);
			DHTMLSuite.ajax.sendRequest(url,params,'grid' + self.id + '.dictHandler');
			return;
		}
		var tag = document.createElement("select");
		tag.className = "gridcombox";
		tag.style.display = "block";
		tag.style.position = "absolute";
		tag.style.left = (getLeft(cell) + document.body.scrollLeft) + "px";
		tag.style.top = (getTop(cell) + document.body.scrollTop) + "px";
		tag.style.width = (parseInt(cell.clientWidth)-2) + "px";
		tag.size = 8;
		tag.onblur = function () {
			var value = tag.value;
			var isChange = false;
			if (value!=self.getCellValue(cell))
				isChange = true;
			tag.parentNode.removeChild(tag);
			self.saveEditValue(cell,value);
			if (isChange) {
				if (field.onChangeMethod) {
					eval(field.onChangeMethod);
				}
			}
		}
		tag.onchange = function () {
			var value = tag.value;
			var isChange = false;
			if (value!=self.getCellValue(cell))
				isChange = true;
			tag.parentNode.removeChild(tag);
			self.saveEditValue(cell,value);
			if (isChange) {
				if (field.onChangeMethod) {
					eval(field.onChangeMethod);
				}
			}
		}
		// 填充内容
		self.fillOptions(tag,field,self.getCellValue(cell));
		cell.innerHTML = "";
		document.body.appendChild(tag);
		tag.focus();
	}
	// 填充内容
	this.fillOptions = function (tag,field,value) {
		var options = self.dict[field.dictId];
		if (!options || options.length==0) return;

		for (var i=0;i<options.length;i++) {
			var item = options[i];
			tag.options[tag.options.length] = new Option(item.value,item.key);
			if (item.key==value) {
				tag.options[tag.options.length - 1].selected = true;
			}
		}
	}
	// 显示服务器端返回下拉列表
	this.showComboxFromServer = function (cell,fieldid,options) {
		var tag = document.createElement("select");
		tag.className = "gridcombox";
		tag.style.display = "block";
		tag.style.position = "absolute";
		tag.style.left = (getLeft(cell) + document.body.scrollLeft) + "px";
		tag.style.top = (getTop(cell) + document.body.scrollTop) + "px";
		tag.style.width = (parseInt(cell.clientWidth)-2) + "px";
		tag.size = 8;
		var field = self.getFieldById(fieldid);
		tag.onblur = function () {
			var value = tag.value;
			var isChange = false;
			if (value!=self.getCellValue(cell))
				isChange = true;
			tag.parentNode.removeChild(tag);
			self.saveEditValue(cell,value);
			if (isChange) {
				if (field.onChangeMethod) {
					eval(field.onChangeMethod);
				}
			}
		}
		tag.onchange = function () {
			var value = tag.value;
			var isChange = false;
			if (value!=self.getCellValue(cell))
				isChange = true;
			tag.parentNode.removeChild(tag);
			self.saveEditValue(cell,value);
			if (isChange) {
				if (field.onChangeMethod) {
					eval(field.onChangeMethod);
				}
			}
		}
		// 填充内容
		var value = self.getCellValue(cell);
		if (options && options.length>0) {
			for (var i=0;i<options.length;i++) {
				var item = options[i];
				tag.options[tag.options.length] = new Option(item.value,item.key);
				if (item.key==value) {
					tag.options[tag.options.length - 1].selected = true;
				}
			}
		}

		cell.innerHTML = "";
		document.body.appendChild(tag);
		tag.focus();
	}
	// 处理服务器端字典返回结果
	this.dictHandler = function (ajax) {
		var ajaxObj = eval("(" + ajax['response'] + ")");
		var rowId = ajaxObj.$rowid;
		var fieldId = ajaxObj.field;
		var list = ajaxObj.data;

		self.dict[ajaxObj.$dictid] = list;
		var cell = self.getCellByFieldId(rowId,fieldId);
		self.showComboxFromServer(cell,fieldId,list);
	}
	// 是否绑定了操作
	this.isBindAction = function (cell) {
		var field = self.getField(cell);
		var action = self.getAction(field.actionId);

		if (action)
			return true;

		return false;
	}
	// 文本控件
	this.showText = function (cell) {
		if (self.isBindAction(cell)) return;
		var tag = document.createElement("input");
		tag.type = "text";
		tag.className = "gridtext";
		tag.style.height = cell.clientHeight + "px";
		tag.style.left = getLeft(cell) + "px";
		tag.style.width = (parseInt(cell.clientWidth)-2) + "px";
		tag.value = self.getCellValue(cell);
		tag.onblur = function () {
			var value = tag.value;
			if (value==null)
				value = "";
			var isChange = false;
			if (value!=self.getCellValue(cell))
				isChange = true;
			tag.parentNode.removeChild(tag);
			self.saveEditValue(cell,value);
			// 是否值变更
			if (isChange) {
				var field = self.getField(cell);
				if (field.onChangeMethod) {
					eval(field.onChangeMethod);
				}
			}
		}
		tag.onchange = function () {
		}
		cell.innerHTML = "";
		cell.appendChild(tag);
		tag.focus();
	}
	// 大文本控件
	this.showTextArea = function (cell) {
		if (self.isBindAction(cell)) return;
		var tag = document.createElement("textarea");
		tag.className = "gridtextarea";
		tag.style.display = "block";
		tag.style.position = "absolute";
		tag.style.left = (getLeft(cell)  + document.body.scrollLeft - self.tabDetail.parentNode.scrollLeft) + "px";
		tag.style.top = (getTop(cell) + document.body.scrollTop) + "px";
		tag.style.width = (parseInt(cell.clientWidth) < 50 ? 50 : parseInt(cell.clientWidth) - 2) + "px";
		tag.style.height = "60px";
		tag.value = self.getCellValue(cell);
		tag.onblur = function () {
			var value = tag.value;
			var isChange = false;
			if (value!=self.getCellValue(cell))
				isChange = true;
			tag.parentNode.removeChild(tag);
			self.saveEditValue(cell,value);
			// 是否值变更
			if (isChange) {
				var field = self.getField(cell);
				if (field.onChangeMethod) {
					eval(field.onChangeMethod);
				}
			}
		}
		tag.onchange = function () {
		}
		cell.innerHTML = "";
		document.body.appendChild(tag);
		tag.focus();
	}
	// 显示一个录入区域
	this.showDiv = function (cell) {
		if (self.isBindAction(cell)) return;
		var tag = document.createElement("div");
		tag.className = "griddiv";
		tag.style.display = "block";
		tag.style.position = "absolute";
		tag.style.border = "solid 1px red";
		tag.style.background = "blue";
		tag.style.left = getLeft(cell) + "px";
		tag.style.top = (getTop(cell) + cell.clientHeight) + "px";
		tag.style.width = (cell.clientWidth < 50 ? 50 : cell.clientWidth) + "px";
		tag.style.height = 200 + "px";
		tag.value = self.getCellValue(cell);
		tag.onblur = function () {
			var value = tag.value;
			tag.parentNode.removeChild(tag);
			// self.saveEditValue(cell,value);
		}
		tag.onchange = function () {
		
		}
		document.body.appendChild(tag);
		tag.tabindex = "1";
		tag.focus();
	}
	// 显示提示
	this.showTips = function (cell) {
		if (self.isBindAction(cell)) return;
		var tag = document.createElement("div");
		tag.className = "gridtips";
		tag.style.display = "block";
		tag.style.position = "absolute";
		tag.style.border = "solid 1px red";
		tag.style.background = "blue";
		tag.style.left = getLeft(cell) + "px";
		tag.style.top = (getTop(cell) - 200) + "px";
		tag.style.width = (cell.clientWidth < 50 ? 50 : cell.clientWidth) + "px";
		tag.style.height = 200 + "px";
		tag.tabIndex = "1";
		tag.value = self.getCellValue(cell);
		tag.onblur = function () {
			var value = tag.value;
			tag.parentNode.removeChild(tag);
			// self.saveEditValue(cell,value);
		}

		document.body.appendChild(tag);
		tag.focus();
		
	}
	// 编辑完成
	this.saveEditValue = function (cell,value) {
		self.setCellValue(cell,value);
		self.showHtml(cell);
		setTimeout(self.cellEdited,10);
	}
	// 动态显示转换内容
	this.showHtml = function (cell) {
		if (!cell) return;
		var value = self.getCellValue(cell);
		if (value!=null)
			value = String(value);
		var field = self.getField(cell);
		var options = self.dict[field.dictId];

		// 针对CONST/IMAGE显示类型，进行特殊处理
		if (field.showType=="CONST" || field.showType=="IMAGE") {
			if (!value) {
				if (field.showType=="CONST") {
					value = field.title;
				} else {
					value = "<img src=\"../images/icon/" + field.dictId + "\" border=\"0\">";
				}
			} else
				value = "<img src=\"" + value + "\" border=\"0\">";
		}

		// 字典图片
		if (field.showType=="DICTIMG") {
			if (options && value!=null && value!="") {
				for (var i=0;i<options.length;i++) {
					if (options[i].key==value)	{
						value = options[i].value;
						break;
					}
				}
			}
			if (!value || value.indexOf(".")==-1) 
				value = null;
			else
				value = "<img src=\"" + value + "\" border=\"0\">";
		}
		if (value==null || value=="")
			value = "&nbsp;";
		// 是否绑定了操作？
		var action = self.getAction(field.actionId);
		var rowId = self.getRowId(cell);

		if (field.showType=="RADIO" && options) {
			cell.innerHTML = "";
			for (var i=0;i<options.length;i++) {
				var obj = document.createElement("input");
				obj.type = "radio";
				obj.id = field.code + "$" + cell.parentNode.getAttribute("rowId");
				obj.name = field.code + "$" + cell.parentNode.getAttribute("rowId");
				obj.value = options[i].key;
				cell.appendChild(obj);
				obj.checked = self.isChecked(value,options[i].key);
				obj.onclick = self.onBoxClick;
				if (options.length==1) continue;
				obj = document.createElement("span");
				obj.innerHTML = options[i].value;
				cell.appendChild(obj);
			}
			
			return;
		}
		if (field.showType=="CHECKBOX" && options) {
			cell.innerHTML = "";
			for (var i=0;i<options.length;i++) {
				var obj = document.createElement("input");
				obj.type = "checkbox";
				obj.id = field.code + "$" + cell.parentNode.getAttribute("rowId");
				obj.name = field.code + "$" + cell.parentNode.getAttribute("rowId");
				obj.value = options[i].key;
				cell.appendChild(obj);
				obj.checked = self.isChecked(value,options[i].key);
				obj.onclick = self.onBoxClick;
				if (options.length==1) continue;
				obj = document.createElement("span");
				obj.innerHTML = options[i].value;
				cell.appendChild(obj);
			}
			return;
		}
		if (options) {
			var existKey = false;
			var data = self.data[rowId];
			var v = self.getDictKey(data,field);

			for (var i=0;i<options.length;i++) {
				if (options[i].comment && options[i].comment==v) {
					value = options[i].value;
					existKey = true;
					break;
				}
			}
			if (!existKey)	{
				for (var i=0;i<options.length;i++) {
					if (options[i].key==value) {
						value = options[i].value;
						break;
					}
				}
			}
		}

		if (action) {
			// 处理没有转换的内容
			if (action.showType=="BUTTON") {
				cell.onclick = function () {
					self.clickURL(field.code,action.code,rowId);
					return false;
				}
				cell.innerHTML = String(value);
			} else
				cell.innerHTML = "<a href='#' onclick=\"grid" + self.id + ".clickURL('" + field.code + "','" + action.code + "','" + rowId + "');return false;\">" + String(value) + "</a>";
			var title = cell.innerText ? cell.innerText : cell.textContent;
			if (!title)
				title = action.name;
			cell.title = title;
			return;
		}

		cell.innerHTML = String(value);
		if (String(value))	{
			if (String(value)!="&nbsp;")
				cell.title = String(value);
		}
	}
	// 取动态字典的联合值
	this.getDictKey = function (data,field) {
		if (!field.linkFields) return null;

		var v = "";
		var str = field.linkFields.split(",");
		for (var i=0;i<str.length;i++) {
			if (v!="")
				v += "-";
			var value = data[str[i]];
			if (!value)
				value = "";
			v += value;
		}
		v += "-";
		v += data[field.code];

		return v;
	}
	// 是否选择本选项
	this.isChecked = function (value,key) {
		if (!value || !key) return false;

		var str = value.split(",");
		for (var i=0;i<str.length;i++) {
			if (!str[i]) continue;
			if (str[i]==key) return true;
		}
		return false;
	}
	// 选择框列进行了选项选定时
	this.onBoxClick = function (event) {
		var e = event || window.event;
		var obj = e.target || e.srcElement;

		var str = obj.id.split("$");
		var fieldId = str[0];
		var rowId = str[1];
		var value = self.getFieldValue(rowId,fieldId);
		// 如果是单选
		if (obj.type=="radio") {
			self.setFieldValue(rowId,fieldId,obj.value);
			self.rowChange(rowId);
			return;
		}

		value = "";
		var selected = document.getElementsByName(obj.id);
		for (var i=0;i<selected.length;i++) {
			if (!selected[i].checked) continue;
			if (value) 
				value += ",";
			value += selected[i].value;
		}

		if (!value)
			value = "";
		self.setFieldValue(rowId,fieldId,value);
		self.rowChange(rowId);
	}
	// 设置网格的内容
	this.setCellValueByFieldId = function (rowId,fieldid,value) {
		var cell = self.getCellByFieldId(rowId,fieldid);
		if (!cell) { 
			self.data[rowId][fieldid] = value;
			return;
		}
		self.setCellValue(cell,value);
		self.showHtml(cell);

		self.rowChange(rowId);
	}
	// 根据域号取网格对象
	this.getCellByFieldId = function (rowId,fieldid) {
		// 先取行tr
		var tr = self.getRowByRowId(rowId);
		if (!tr) return null;
		var colIndex = self.getColIndexByFieldId(fieldid);
		if (colIndex==null)
			return null;
		return tr.cells[parseInt(colIndex)];
	}
	// 根据域号,取列序号
	this.getColIndexByFieldId = function (fieldid) {
		for (var i=0;i<self.columns.length;i++)	{
			if (self.columns[i].code==fieldid)
				return self.columns[i].colIndex;
		}
		
		return null;
	}
	// 根据行号取TR对象
	this.getRowByRowId = function (rowId) {
		if (self.tabDetail.rows.length<=1) return;

		var id;
		var tr;
		for (var i=0;i<self.tabDetail.rows.length;i++) {
			tr = self.tabDetail.rows[i];
			id = tr.getAttribute("rowId");
			if (id==rowId)
				return tr;
		}

		return null;
	}
	// 取选择的行号，如果没有选择，则返回null
	this.getSelectedRow = function () {
		var tr = self.currentTR;
		var rowId = null;
		if (tr)
			rowId = tr.getAttribute("rowId");

		return rowId;
	}
	// 取操作对象
	this.getAction = function (actionid) {
		if (self.grid.actions==null) return;

		for (var i=0;i<self.grid.actions.length;i++) {
			if (self.grid.actions[i].code==actionid) 
				return self.grid.actions[i];
		}

		return null;
	}
	// 保存编辑域的值
	this.setCellValue = function (cell,value) {
		var rowId = self.getRowId(cell);

		var row = self.data[rowId];
		var field = self.getField(cell);
		var v = self.getFieldValue(rowId,field.code);
		self.setFieldValue(rowId,field.code,value);

		if (value!=v && self.data[rowId]['$status']!='add')
			self.data[rowId]['$status'] = 'edit';
	}
	// 取编辑域的值
	this.getCellValue = function (cell) {
		var rowId = self.getRowId(cell);

		var field = self.getField(cell);
		
		return self.getFieldValue(rowId,field.code);
	}
	// 设置域值
	this.setFieldValue = function (rowId,fieldid,value) {
		// 域是否存在？
		if (!self.getFieldById(fieldid)) return;

		var row = self.data[rowId];
		if (!row) return;
		if (row[fieldid]==String(value)) {
			return;
		}

		// 设置行已经变更状态
		row["$changed"] = "true";
		row[fieldid] = String(value);
		if (row["$status"]!="add" && row["$status"]!="delete")
			row["$status"] = "edit";

		var cell = self.getCellByFieldId(rowId,fieldid);
		if (!cell) return;
		var field = self.getField(cell);
		// 是否服务器字典，如果是，则重新载入字典
		if (field.dictType && field.dictType=="S" && field.dictId && String(value)) {
			var url = "DictAction.cmd";
			url += "?$dictid=" + field.dictId;
			url += "&$rowid=" + rowId;
			url += "&$field=" + field.code;
			url += "&$value=" + String(value);
			var params = self.addColParams(rowId,field.linkFields);
			DHTMLSuite.ajax.sendRequest(url,params,'grid' + self.id + '.dictKeyHandler');
			return;
		}

		self.showHtml(cell);
	}
	// 字典值转换
	this.dictKeyHandler = function (ajax) {
		var ajaxObj = eval("(" + ajax['response'] + ")");
		var rowId = ajaxObj.$rowid;
		var fieldId = ajaxObj.field;
		var list = ajaxObj.data;

		self.dict[ajaxObj.$dictid] = list;
		var cell = self.getCellByFieldId(rowId,fieldId);
		self.showHtml(cell);
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
	// 取行号
	this.getRowId = function (cell) {
		var tr = cell.parentNode;
		if (!tr || tr.tagName!="TR") {
			// alert("不是列表行的网格！");
			return null;
		}

		return tr.getAttribute("rowId");
	}
	// 根据单击的单元格对象取列字段定义
	this.getField = function (cell) {
		var nIndex = self.getColIndex(cell);
		if (self.showIndexNo)
			nIndex--;
		if (self.box=="radio" || self.box=="checkbox")
			nIndex--;
		var nPos = 0;

		if (nIndex<0) {
			alert(nIndex);
			return null;
		}

		for (var i=0;i<self.columns.length;i++) {
			if (self.columns[i].showType=="HIDDEN") continue;
			if (nPos==nIndex)
				return self.columns[i];
			nPos++;
		}

		return null;
	}
	// 根据列号取域属性
	this.getFieldById = function (fieldid) {
		for (var i=0;i<self.columns.length;i++) {
			if (self.columns[i].code==fieldid) return self.columns[i];
		}

		return null;
	}
	// 取某域绑定的操作
	this.getActionByFieldId = function (fieldid) {
		if (self.grid.actions==null) return null;

		for (var i=0;i<self.columns.length;i++) {
			if (self.columns[i].code==fieldid) {
				for (var n=0;n<self.grid.actions.length;n++) {
					if (self.grid.actions[n].code==self.columns[i].actionId) 
						return self.grid.actions[n];
				}

				return null;
			}
		}

		return null;
	}
	// 取列序号
	this.getColIndex = function (cell) {
		var tr = cell.parentNode;
		// 取td
		var cells = tr.childNodes;
		var nIndex = -1;
		for (var i=0;i<cells.length;i++) {
			if (cells[i].nodeType!=1) continue;
			nIndex++;
			if (cells[i]==cell) 
				return nIndex;
		}

		return -1;
	}

	this.existYScroll = function () {
		return self.tabDetail.offsetHeight>self.tabDetail.parentNode.offsetHeight-1;
	}

	this.existXScroll = function () {
		return self.tabDetail.offsetWidth>self.tabDetail.parentNode.offsetWidth-1;
	}
	// 取第几个子标签
	this.getChild = function (ele,tagName,nIndex) {
		if (ele.childNodes==null || ele.childNodes.length==0) return null;
		
		var n = 0;
		for (var i=0;i<ele.childNodes.length ;i++ ) {
			if (ele.childNodes[i].tagName==tagName) {
				if (!nIndex && nIndex<1) return ele.childNodes[i];
				if (n==nIndex) return ele.childNodes[i];
				n++;
			}
		}
		
		return null;
	}
	// 取下一个同级标签
	this.getNextSibling = function (ele) {
		var tag = ele.nextSibling;
		while (true) {
			if(tag.nodeType==1){
                break;
            }else{
                if(tag.nextSibling){
                    tag = tag.nextSibling;
                }else{
					tag = null;
                    break;
                }
            }			
		}

		return tag;
	}

	// 检查某个单元的值
	this.validRowData = function (rowId) {
		var value;
		for (var i=0;i<self.columns.length;i++)	{
			if (self.columns[i].showType=="HIDDEN") continue;
			value = self.getFieldValue(rowId,self.columns[i].code);

			// 是否为空
			if (self.columns[i].isNotNull=="Y")	{
				if (value==null || value=="") {
					self.showMessage(self.columns[i].title + "不能为空！");
					return false;
				}
			}
			if (value==null || value=="")	
				continue;
			
			var str = String(value);
			// 字符型判断
			var len = self.columns[i].length;
			if (self.columns[i].dataType=="STRING")	{
				if (str.replace(/[^\x00-\xff]/g,"**").length>len && parseInt(len)>0) {
					self.showMessage(self.columns[i].title + "字符数超过了最大长度" + self.columns[i].length);
					return false;
				}
				continue;
			}

			// 整型判断
			if (self.columns[i].dataType=="INTEGER") {
				if (!str.match(/^-?\d+$/gi)) {
					self.showMessage(self.columns[i].title + "列的内容必须为整数类型！");
					return false;
				}
				continue;
			}

			// 浮点判断
			if (self.columns[i].dataType=="DOUBLE")	{
				if (!str.match(/^(-?\d+)(\.\d+)?$/gi)) {
					self.showMessage(self.columns[i].title + "列的内容必须为小数类型！");
					return false;
				}
				continue;
			}
		}
		
		
		return true;
	}

	// 显示提示信息
	this.showMessage = function (message) {
		var obj = document.getElementById("$MESSAGE");
		if (obj) {
			obj.innerHTML = message;
			return;
		}

		alert(message);
	}
	// 初始化查询条件的值
	this.initClause = function (values) {
		if (!values) return;
		
		var c,v;
		var ctl;
		for (c in values) {
			v = values[c];
			if (!v) continue;
			ctl = document.getElementById("$" + self.id + "-option-" + c);
			if (!ctl) continue;
			ctl.value = v;
			ctl.style.color = "#000";
		}
	}
	// 保存条件
	this.saveClause = function () {
		// 如果子表可编辑，则不处理
		if (self.state!="readonly" || !self.grid.action) return;
		var table = document.getElementById("$TABLE");
		if (!table) return;
		
		var v = "";
		// 取所有$XXX-option-开头的域
		var list = document.getElementById(self.id).getElementsByTagName("input");
		if (list) {
			for (var i=0;i<list.length ;i++ ) {
				if (!list[i].name) continue;
				if (!list[i].value) continue;
				if (list[i].value==list[i].getAttribute("title")) continue;
				if (list[i].name=="$" + self.id + "-selected") continue;
				if (v)
					v += "\3";
				v += list[i].name + "\2" + list[i].value;
			}
		}
		// 取页号
		if (v)
			v += "\3";
		if (document.getElementById("$" + self.id + "-pageno"))
			v += "$" + self.id + "-pageno\2" + document.getElementById("$" + self.id + "-pageno").value;
		
		// 是否已经存在,如果存在,则覆盖
		var clause = table.value;
		if (!clause) {
			table.value = self.grid.system + "-" + self.grid.module + "-" + self.grid.action + "\4" + v;
			return;
		}
			
		var str = clause.split("\5");
		clause = "";
		var isInc = false;
		for (var i=0;i<str.length;i++) {
			if (clause)
				clause += "\5";
			if (str[i].indexOf(self.grid.system + "-" + self.grid.module + "-" + self.grid.action + "\4")==0) { // 如果已经存在，则截取
				isInc = true;
				str[i] = self.grid.system + "-" + self.grid.module + "-" + self.grid.action + "\4" + v;
				clause += str[i];
				break;
			}
			clause += str[i];
		}
		if (!isInc)	
			clause += "\5" + self.grid.system + "-" + self.grid.module + "-" + self.grid.action + "\4" + v;

		table.value = clause;
	}
	// 发送AJAX请求,param是一个Hash对象,主要的KEY包括:args-表单上或子表中的域;params-子表的列号;rets-返回的域;callback-返回后回调的函数
	this.submitGridAjaxRequest = function (act,param) {
		var url = document.getElementById("$MODULE").value;
		url += ".cmd?$ACTION=" + act;
		var obj = document.getElementById("$VERSION");
		if (obj && obj.value) {
			url += "&$VERSION=" + obj.value;
		}

		var data = "";
		// 加上行号$ROWID,$RETS,$CALLBACK
		if (param.rets)	{
			data += "&$RETS=" + param.rets;
		}
		if (param.callback)	{
			data += "&$CALLBACK=" + param.callback;
		}
		if (param.params) {
			data += self.addParams(param.params);
		}

		DHTMLSuite.ajax.sendRequest(url,data,'grid' + self.id + '.ajaxGridHandler');
	}
	// 发送AJAX行请求,param是一个Hash对象,主要的KEY包括:args-表单上或子表中的域;params-子表的列号;rets-返回的域;callback-返回后回调的函数
	this.submitGridRowAjaxRequest = function (act,param) {
		var url = document.getElementById("$MODULE").value;
		url += ".cmd?$ACTION=" + act;
		var obj = document.getElementById("$VERSION");
		if (obj && obj.value) {
			url += "&$VERSION=" + obj.value;
		}

		var data = "";
		// 加上行号$ROWID,$RETS,$CALLBACK
		var tr = self.currentTR;
		var rowId = null;
		if (tr)
			rowId = tr.getAttribute("rowId");
		if (rowId)	{
			data += "&$ROWID=" + rowId;
		}
		if (param.rets)	{
			data += "&$RETS=" + param.rets;
		}
		if (param.callback)	{
			data += "&$CALLBACK=" + param.callback;
		}

		if (param.args)
			data += self.addParams(param.args);
		if (param.params)
			data += self.addColParams(rowId,param.params);

		DHTMLSuite.ajax.sendRequest(url,data,'grid' + self.id + '.ajaxGridHandler');
	}
	// ajax返回处理，一般只能给行赋值，如果要进行其他操作，则使用回调函数
	this.ajaxGridHandler = function (ajax) {
		var ajaxObj = eval("(" + ajax['response'] + ")");
		var str;
		var b;
		var rowId = ajaxObj.$ROWID;
		var rets = ajaxObj.$RETS;

		if (rowId)	{
			for (str in ajaxObj) {
				if (str.indexOf("$")!=-1) continue;
				if (rets) {
					b = false;
					var r = rets.split(",");
					for (var i=0;i<r.length;i++) {
						if (r[i]==str)	{
							b = true;
							break;
						}
					}
					if (!b) continue;
				}
				self.setFieldValue(rowId,str,ajaxObj[str]);
			}
		}
		str = ajaxObj.$RESULT;
		document.getElementById("$MESSAGE").innerHTML = "";
		if (str && String(str)!="0") {
			if (ajaxObj.$MESSAGE)
				document.getElementById("$MESSAGE").innerHTML = ajaxObj.$MESSAGE;
			else
				document.getElementById("$MESSAGE").innerHTML = "操作失败！";
		} else {
			if (ajaxObj.$MESSAGE)
				document.getElementById("$MESSAGE").innerHTML = ajaxObj.$MESSAGE;
			else
				document.getElementById("$MESSAGE").innerHTML = "操作成功！";
		}
		if (ajaxObj.$ALERT && ajaxObj.$ALERT=="Y" && ajaxObj.$MESSAGE)	{
			alert(ajaxObj.$MESSAGE);
		}

		// 调用回调函数
		str = ajaxObj.$CALLBACK;
		if (str) {
			eval(str + "(ajaxObj);");
		}
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
	// 取屏幕高度
	this.getClientHeight = function () {
		var clientHeight = 0;
		if (document.body.clientHeight && document.documentElement.clientHeight) {
			clientHeight = (document.body.clientHeight < document.documentElement.clientHeight) ? document.documentElement.clientHeight : document.body.clientHeight;
		} else {
			clientHeight = (document.body.clientHeight > document.documentElement.clientHeight) ? document.body.clientHeight : document.documentElement.clientHeight;
		}
		if (clientHeight==0) {
			clientHeight = 480;
		}

		return clientHeight;
	}
	// 当表单进行提交时,判断子表单的数据是否可提交
	this.onFormSubmit = function () {
		if (self.state=="readonly") {
			return true;
		}
		if (self.required)	{
			if (self.getRowsCount()==0)	{
				alert("表格内容不能为空!");
				return false;
			}
		}
		if (self.getRowsCount()==0) return true;

		var i = 0;
		var rowId;
		for (i=0;i<self.getRowsCount();i++) {
			rowId = self.getRowIdByIndex(i);
			if (rowId==null) continue;
			if (!self.validRowData(rowId)) {
				return false;
			}
		}

		return true;
	}
}

//获取鼠标的行坐标位置，包含滚动条
function getActlClientX(e) {
	if (document.body.scrollLeft == 0 && document.documentElement.scrollLeft == 0) {//default
		return e.clientX;
	} else if (document.body.scrollLeft) {//chrome safari
		return e.clientX + document.body.scrollLeft;
	} else {//IE Firefox opera
		return e.clientX + document.documentElement.scrollLeft;
	}
}
//获取元素距离视图的左边距
function getElementLeft(el) {
	var actlLeft = el.offsetLeft;
	var current = el.offsetParent;
	while (current != null) {
		actlLeft += current.offsetLeft - current.scrollLeft;;
		current = current.offsetParent;
	}

	return actlLeft;
}

function getTop(e) {
	var t = e.offsetTop;
	while (e = e.offsetParent) {
		t += e.offsetTop - e.scrollTop;
	}
	
	return t;
}
function getLeft(e) {
	var l = e.offsetLeft;
	while (e = e.offsetParent) {
		l += e.offsetLeft - e.scrollLeft;
	}
	return l;
}
//获取鼠标坐标 支持Firefox
function getOffset(evt) {
	var target = evt.target;
	if (target.offsetLeft == undefined) {
		target = target.parentNode;
	}
	var pageCoord = getPageCoord(target);
	var eventCoord = {x:window.pageXOffset + evt.clientX, y:window.pageYOffset + evt.clientY};
	var offset = {offsetX:eventCoord.x - pageCoord.x, offsetY:eventCoord.y - pageCoord.y};
	return offset;
}
function getPageCoord(element) {
	var coord = {x:0, y:0};
	while (element) {
		coord.x += element.offsetLeft;
		coord.y += element.offsetTop;
		element = element.offsetParent;
	}
	return coord;
}

