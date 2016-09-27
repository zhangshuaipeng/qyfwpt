<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="/htm" prefix="htm" %>

<HTML>
<HEAD>
<TITLE>列表</TITLE>
<meta HTTP-EQUIV="Pragma" content="no-cache" /> 
<meta HTTP-EQUIV="Cache-Control" content="no-cache" /> 
<meta HTTP-EQUIV="Expires" content="0">
<META http-equiv=Content-Type content="text/html; charset=UTF-8">

<LINK href="../css/main.css" type=text/css rel=stylesheet>

<SCRIPT src="../js/ajax.js" type=text/javascript></SCRIPT>
<SCRIPT src="../js/validator.js" type=text/javascript></SCRIPT>
<script>
function retHandler(ajaxObj) {
	var ret = ajaxObj.$result;
	if (!ret || ret!="0") {
		document.getElementById("$message").innerHTML = "导出数据模型成功！";
	}
}

function Datagrid(tabid) {
	var self = this;

	this.id = tabid;
	this.tabHeader = null;
	this.currentTD = null;
	this.tabDeatil = null;
	this.boundary = 5;
	this.resizing = false;
	this.currentTR = null;
	this.columns = null;      // 列属性
	this.grid = null;         // 子表属性
	this.dict = null;         // 字典列表
	this.maxId = (new Date()).getTime();
	this.data = new Array();

	this.init = function (data)	{
		self.columns = data['$GRID$'].columns;
		self.grid = data['$GRID$'];
		data['$GRID$'] = null;
		self.dict = data;
		self.createGrid();
		var div = document.getElementById(self.id);

		var ele = self.getChild(div,"DIV",0);
		ele = self.getChild(ele,"DIV",0);
		self.tabHeader = self.getChild(ele,"TABLE",0);
		
		ele = self.getChild(div,"DIV",1);
		addEvent(ele,"scroll",self.onScroll);
		self.tabDetail = self.getChild(ele,"TABLE",0);

		var oTR = self.tabHeader.rows[0];
		addEvent(oTR, 'mousemove', self.onMoveOverHeader);
		var nWidth = 0;
		var width;
		self.tabHeader.style.tableLayout = "fixed";
		self.tabDetail.style.tableLayout = "fixed";
		self.tabHeader.parentNode.style.width = (self.tabDetail.parentNode.clientWidth - 2) + "px";
		self.tabHeader.style.width = self.tabHeader.parentNode.style.width;
		for(var i=0;i<oTR.cells.length;i++)   {
			var cell=oTR.cells[i];
			width = cell.offsetWidth;
			cell.style.width = width + "px";
			addEvent(cell, "mousedown", self.onMouseClick);
			self.tabDetail.rows[0].cells[i].style.width = width + "px";
			nWidth += width;
		}

		self.tabHeader.style.display = "block";
		self.tabDetail.style.display = "block";
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
	}
	// 取下一有效标识号
	this.getNewRowId = function () {
		var pageid = document.getElementById("$pageid");
		self.maxId++;

		return String(pageid) + String(self.maxId);
	}
	// 创建表格
	this.createGrid = function () {
		var grid = document.getElementById(self.id);
		// 先清除grid中的内容
		for (var i=0; i<grid.childNodes.length;) {
			var childNode = grid.childNodes[i];
			grid.removeChild(childNode);
		}

		var div = document.createElement("div");
		div.className = "gridheader";
		grid.appendChild(div);
		var divTitle = document.createElement("div");
		divTitle.className = "gridtitle";
		div.appendChild(divTitle);
		// 增加表格
		self.tabHeader = document.createElement("table");
		divTitle.appendChild(self.tabHeader);
		self.tabHeader.cellSpacing = "0";
		self.tabHeader.cellPadding = "0";
		self.tabHeader.style.width = "100%";
		// 增加行
		var tr = self.tabHeader.insertRow(0);
		if (self.columns) {
			for (var i=0;i<self.columns.length;i++)	{
				if (self.columns[i].showType=="HIDDEN") continue;
				var th = tr.insertCell(i);
				// var th = document.createElement("th");
				th.style.width = self.columns[i].width + "px";
				th.innerHTML = self.columns[i].title;
			}
		}
		// 创建内容区
		div = document.createElement("div");
		div.className = "griddata";
		grid.appendChild(div);
		
		self.tabDetail = document.createElement("table");
		div.appendChild(self.tabDetail);
		self.tabDetail.rules = 'all';
		self.tabDetail.border = "0";
		self.tabDetail.cellSpacing = "0";
		self.tabDetail.cellPadding = "0";
		self.tabDetail.style.width = self.tabHeader.offsetWidth;

		var tr = self.tabDetail.insertRow(self.tabDetail.rows.length);
		tr.style.height = "auto";
		for (var i=0;i<self.columns.length;i++)	{
			if (self.columns[i].showType=="HIDDEN") continue;
			var td = tr.insertCell(tr.cells.length);
		}
	}
	// 增加行
	this.addRow = function (jsonArray) {
		if (!jsonArray) {    // 增加一个空行
			self._addRow();	
			return;
		}

		for (var i=0;i<jsonArray.length;i++) {
			var row = jsonArray[i];
			self._addRow(row);		
		}
	}
	// 增加行数据
	this._addRow = function (data) {
		// 取rowId
		var rowId = self.getNewRowId();
		if (!data)
			data = new Array();
		data["$rowid"] = rowId;      // 保存记录号
		data["$status"] = "add";     // 保存状态
		self.data[rowId] = data;
		
		// 显示
		var tr = self.tabDetail.insertRow(self.tabDetail.rows.length);
		tr.setAttribute("rowId",rowId);

		var field;
		for (var i=0;i<self.columns.length;i++) {
			if (self.columns[i].showType=="HIDDEN") continue;
			var td = tr.insertCell(tr.cells.length);
			if (self.columns[i].align==null || self.columns[i].align=="")
				self.columns[i].align = "center";
			td.style.textAlign = self.columns[i].align;
			if (self.columns[i].showType!="RADIO" && self.columns[i].showType!="CHECKBOX") 
				addEvent(td,"click",self.onClick);
			self.showHtml(td);
		}
		self.showRowsBackground();
		self.setRowAction();
	}
	// 删除行
	this.deleteRow = function (rowId) {
		// 如果没有指定，则只删除当前选中行

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
			if (x > getElementLeft(target) + parseInt(target.style.width) - self.tabDetail.parentNode.scrollLeft - self.boundary){
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
		obj.tdW = obj.offsetWidth;

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
		if(obj.parentNode.rowIndex!=0) return false;

		var newWidth = obj.tdW*1 + event.clientX*1 - obj.mouseDownX;
		if(newWidth<=0)
			newWidth = 1;
		obj.style.width = newWidth + "px";

		var nWidth = 0;
		var oTh = self.tabHeader.rows[0];
		var userAgent = getUserAgent();
		var delX = 0;
		if (userAgent=="FIREFOX") {
			delX = 1;
		}
		if (userAgent=="SAFARI")
			delX = 3;
		for(var i=0;i<oTh.cells.length;i++)   {
			var cell=oTh.cells[i];
			nWidth += parseInt(cell.style.width);
			if (cell==self.currentTD) {
				if (cell.offsetWidth>parseInt(cell.style.width)) {
					self.tabDetail.rows[0].cells[i].style.width = (cell.offsetWidth + delX) + "px";
				} else
					self.tabDetail.rows[0].cells[i].style.width = (parseInt(cell.style.width) + delX) + "px";
				continue;
			}
		}
		// 设置对应列的宽度和总表格宽度
		self.tabHeader.style.width = nWidth + "px";
		self.tabDetail.style.width = nWidth + "px";
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
		self.currentTR = target.parentNode;
		addClass(target.parentNode,"rowselected");
		//阻止事件进行冒泡
		stopPropagation(event);
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

		var field = self.getField(cell);
		if (field.showType=="TEXT")
			self.showText(cell);
		else if (field.showType=="TEXTAREA")
			self.showTextArea(cell);
		else if (field.showType=="COMBOX")
			self.showCombox(cell,field);
		else if (field.showType=="READONLY")
			self.showReadOnly(cell,field);
		else
			self.showText(cell);

	}
	// 显示只读
	this.showReadOnly = function (cell,field) {
		return;
	}
	// 显示下拉
	this.showCombox = function (cell,field) {
		var tag = document.createElement("select");
		tag.className = "gridcombox";
		tag.style.display = "block";
		tag.style.position = "absolute";
		tag.style.left = (getLeft(cell) + document.body.scrollLeft) + "px";
		tag.style.top = (getTop(cell) + document.body.scrollTop) + "px";
		tag.style.width = cell.clientWidth + "px";
		tag.size = 8;
		tag.onblur = function () {
			var value = tag.value;
			self.setCellValue(cell,value);
			tag.parentNode.removeChild(tag);
			self.showHtml(cell);
		}
		tag.onchange = function () {
			var value = tag.value;
			self.setCellValue(cell,value);
			tag.parentNode.removeChild(tag);
			self.showHtml(cell);
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
	// 文本控件
	this.showText = function (cell) {
		var tag = document.createElement("input");
		tag.type = "text";
		tag.className = "gridtext";
		tag.style.height = cell.clientHeight + "px";
		tag.style.left = getLeft(cell) + "px";
		tag.style.width = cell.clientWidth + "px";
		tag.value = self.getCellValue(cell);
		tag.onblur = function () {
			var value = tag.value;
			self.setCellValue(cell,value);
			tag.parentNode.removeChild(tag);
			self.showHtml(cell);
		}
		tag.onchange = function () {

		}
		cell.innerHTML = "";
		cell.appendChild(tag);
		tag.focus();
	}
	// 大文本控件
	this.showTextArea = function (cell) {
		var tag = document.createElement("textarea");
		tag.className = "gridtextarea";
		tag.style.display = "block";
		tag.style.position = "absolute";
		tag.style.left = getLeft(cell) + "px";
		tag.style.top = getTop(cell) + "px";
		tag.style.width = (cell.clientWidth < 50 ? 50 : cell.clientWidth) + "px";
		tag.style.height = "60px";
		tag.value = self.getCellValue(cell);
		tag.onblur = function () {
			var value = tag.value;
			self.setCellValue(cell,value);
			tag.parentNode.removeChild(tag);
			self.showHtml(cell);
		}
		tag.onchange = function () {
		
		}
		cell.innerHTML = "";
		document.body.appendChild(tag);
		tag.focus();
	}
	// 显示一个录入区域
	this.showDiv = function (cell) {
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
			self.showHtml(cell);
		}
		tag.onchange = function () {
		
		}
		document.body.appendChild(tag);
		tag.tabindex = "1";
		tag.focus();
	}
	// 显示提示
	this.showTips = function (cell) {
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
			self.showHtml(cell);
		}

		document.body.appendChild(tag);
		tag.focus();
		
	}
	// 动态显示转换内容
	this.showHtml = function (cell) {
		var value = self.getCellValue(cell);
		if (value==null || value=="")
			value = "&nbsp;";
		var field = self.getField(cell);
		if (!field.dictId) {
			cell.innerHTML = value;
			return;
		}

		var options = self.dict[field.dictId];
		if (!options) {
			cell.innerHTML = value;
			return;
		}

		if (field.showType=="RADIO") {
			cell.innerHTML = "";
			for (var i=0;i<options.length;i++) {
				var obj = document.createElement("input");
				obj.type = "radio";
				obj.id = field.code + "$" + cell.parentNode.getAttribute("rowId");
				obj.value = options[i].key;
				cell.appendChild(obj);
				obj = document.createElement("span");
				obj.innerHTML = options[i].value;
				cell.appendChild(obj);
			}
			
			return;
		}
		if (field.showType=="CHECKBOX") {
			cell.innerHTML = "";
			for (var i=0;i<options.length;i++) {
				var obj = document.createElement("input");
				obj.type = "checkbox";
				obj.id = field.code + "$" + cell.parentNode.getAttribute("rowId");
				obj.value = options[i].key;
				cell.appendChild(obj);
				obj = document.createElement("span");
				obj.innerHTML = options[i].value;
				cell.appendChild(obj);
			}
			return;
		}

		for (var i=0;i<options.length;i++) {
			if (options[i].key==value) {
				cell.innerHTML = options[i].value;
				return;
			}
		}
		cell.innerHTML = value;
	}
	// 保存编辑域的值
	this.setCellValue = function (cell,value) {
		var rowId = self.getRowId(cell);

		var row = self.data[rowId];
		var field = self.getField(cell);

		self.setFieldValue(rowId,field.code,value);
	}
	// 取编辑域的值
	this.getCellValue = function (cell) {
		var rowId = self.getRowId(cell);

		var field = self.getField(cell);
		
		return self.getFieldValue(rowId,field.code);
	}
	// 设置域值
	this.setFieldValue = function (rowId,fieldid,value) {
		var row = self.data[rowId];

		row[fieldid] = value;
	}
	// 读取域值
	this.getFieldValue = function (rowId,fieldid) {
		var row = self.data[rowId];

		var v = row[fieldid];
		if (v==null)
			v = "";

		return v;
	}
	// 取行号
	this.getRowId = function (cell) {
		var tr = cell.parentNode;

		return tr.getAttribute("rowId");
	}
	// 根据单击的单元格对象取列字段定义
	this.getField = function (cell) {
		var nIndex = self.getColIndex(cell);
		var nPos = 0;

		for (var i=0;i<self.columns.length;i++) {
			if (self.columns[i].showType=="HIDDEN") continue;
			if (nPos==nIndex)
				return self.columns[i];
			nPos++;
		}

		return null;
	}

	// 取列序号
	this.getColIndex = function (cell) {
		var tr = cell.parentNode;
		// 取td
		var cells = tr.getElementsByTagName("td");
		var nIndex = -1;
		for (var i=0;i<cells.length;i++) {
			if (cells[i].parentNode==tr) 
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

String.prototype.UnFormatHTML = function () {
    var self=this;//.replace(/<br>/ig, "\r\n");
	self=self.replace(/&gt;/ig,"\>");
	self=self.replace(/&lt;/ig,"\<");

	return 	self;
	
}

</script>
</HEAD>

<BODY>
<FIELDSET><LEGEND>数据模型导出</LEGEND>
<form name="DbmodelForm" action="/dbmodel.cmd"  method="POST">
<input type=hidden name="$action" value="rebuild"/>
<DIV>
<TABLE>
  <TBODY>
  <TR>
    <TD>
	</TD>
  </TR>
  <TR>
    <TD>
	<input type="button" value="addRow" onclick="gridsubtable.addRow();">
	<!-- <input type="button" value="导出" onclick="var form = new DHTMLSuite.form({ formRef:'DbmodelForm',action:'dbmodel.cmd',responseEl:'$message'});form.submit();" style="diaplay:none;"> -->
	<input type="button" value="导出" onclick="var form = new DHTMLSuite.form({ formRef:'DbmodelForm',action:'dbmodel.cmd',callbackOnComplete:'retHandler'});form.submit();">
	</TD>
  </TR>
</TBODY>
</TABLE>


<P>

<div id="$message" style="color:red;"></div>
</P>
</DIV>
</form>
</FIELDSET>
	<htm:grid id="subtable" name="测试子表" gridid="test"/>

</BODY>
</HTML>
