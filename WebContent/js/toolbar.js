var Class = {
	//创建类
	create : function () {
		return function () {
			this.initialize.apply(this, arguments);
		};
	}
};

var $A = function (a) {
	//转换数组
	return a ? Array.apply(null, a) : new Array;
};

var $ = function (id) {
	//获取对象
	return document.getElementById(id);
};

var Try = {
	//检测异常
	these : function () {
		var returnValue, arg = arguments, lambda, i;
	 
		for (i = 0 ; i < arg.length ; i ++) {
			lambda = arg[i];
			try {
				returnValue = lambda();
				break;
			} catch (exp) {}
		}

		return returnValue;
	}
};

Object.extend = function (a, b) {
	//追加方法
	for (var i in b) a[i] = b[i];
		return a;
};

Object.extend(Object, {
	addEvent : function (a, b, c, d) {
		//添加函数
		if (a.attachEvent) 
			a.attachEvent(b[0], c);
		else 
			a.addEventListener(b[1] || b[0].replace(/^on/, ""), c, d || false);
		return c;
	},
 
	delEvent : function (a, b, c, d) {
		if (a.detachEvent) 
			a.detachEvent(b[0], c);
		else 
			a.removeEventListener(b[1] || b[0].replace(/^on/, ""), c, d || false);
		return c;
	},
 
	reEvent : function () {
		//获取Event
		return window.event ? window.event : (function (o) {
			do {
				o = o.caller;
			} while (o && !/^\[object[ A-Za-z]*Event\]$/.test(o.arguments[0]));
			
			return o.arguments[0];
		})(this.reEvent);
	}
 
});

Function.prototype.bind = function () {
	//绑定事件
	var wc = this, a = $A(arguments), o = a.shift();
	return function () {
		wc.apply(o, a.concat($A(arguments)));
	};
};

var CDrag = Class.create();

CDrag.IE = /MSIE/.test(window.navigator.userAgent);

CDrag.load = function (obj_string, func, time) {
	//加载对象
	var index = 0, timer = window.setInterval(function () {
		try {
			if (eval(obj_string + ".loaded")) {
				window.clearInterval(timer);
				func(eval("new " + obj_string));
			}
		} catch (exp) {}

		if (++ index == 20) window.clearInterval(timer);
	}, time + index * 3);
};


CDrag.Ajax = Class.create();

Object.extend(CDrag.Ajax, {
	getTransport: function() {
		return Try.these(
			function () { return new ActiveXObject('Msxml2.XMLHTTP') },
			function () { return new ActiveXObject('Microsoft.XMLHTTP') },
			function () { return new XMLHttpRequest() }
		) || false;
	}
});

CDrag.Ajax.prototype = {
	initialize : function (url) {
		//初始化
		var wc = this;
		wc.ajax = CDrag.Ajax.getTransport();
	},

	load : function (func) {
		var wc = this, ajax = wc.ajax;
		if (ajax.readyState == 4 && ajax.status == 200)
			func(ajax.responseText);
	},
 
	send : function (url, func) {
		var wc = this, ajax = wc.ajax,
		querys = url + "&" + new Date().getTime() + (10000 + parseInt(Math.random() * 10000));
		ajax.open("get", querys, true);
		ajax.onreadystatechange = wc.load.bind(wc, func);
		ajax.send(null);
	}
};

CDrag.Table = Class.create();

CDrag.Table.prototype = {
	//列的拖拽暂时不考虑
	initialize : function () {
		//初始化
		var wc = this;
		wc.items = []; //创建列组
	},
 
	add : function (objCont) {
		//添加列
		var wc = this, id = wc.items.length;
		return wc.items[id] = new CDrag.Table.Cols(objCont.id, wc, objCont);
	}
};

CDrag.Table.Cols = Class.create();

CDrag.Table.Cols.prototype = {
	initialize : function (id, parent, element) {
		//初始化
		var wc = this;
		wc.items = []; //创建列组
		wc.id = id;
		wc.parent = parent;
		wc.element = element;
	},
 
	add : function () {
		//添加行
		var wc = this, id = wc.items.length, arg = arguments;
		return wc.items[id] = new CDrag.Table.Rows(id, wc, arg[0]);
	},
	// 向容器添加已经存在的标签
	addTag : function (portletid) {
		var wc = this, id = wc.items.length, arg = arguments;
		return wc.items[id] = new CDrag.Table.Rows(id, wc,null,portletid);
	},

	ins : function (num, row) {
		//插入行
		var wc = this, items = wc.items, i;

		if (row.parent == wc && row.id < num) num --; //同列向下移动的时候
		for (i = num ; i < items.length ; i ++) items[i].id ++;

		items.splice(num, 0, row);
		row.id = num, row.parent = wc;

		return row;
	},
 
	del : function (num) {
		//删除行
		var wc = this, items = wc.items, i;

		if (num >= items.length) return;
		for (i = num + 1; i < items.length ; i ++) items[i].id = i - 1;
		return items.splice(num, 1)[0];
	}
 
};

CDrag.Table.Rows = Class.create();

CDrag.Table.Rows.prototype = {
 
	initialize : function (id, parent, portlet,tag) {
		//初始化
		var wc = this;
  
		wc.id = id;
		wc.parent = parent;
		wc.root_id = portlet ? portlet.id : id;
		wc.window = portlet ? portlet.window : 1;
		wc.element = tag ? $(tag) : wc.element_init();

		wc.title = getElementByClassName(wc.element,"xtitle");
		wc.reduce = getElementByClassName(wc.element,"xreduce");
		wc.lock = getElementByClassName(wc.element,"xlock"), wc.locks = false;
		wc.edit = getElementByClassName(wc.element,"xedit");
		wc.close = getElementByClassName(wc.element,"xclose");
		wc.content = getElementByClassName(wc.element,"xcontent");

		wc.Class = wc.mousedown = wc.reduceFunc = wc.lockFunc = wc.editFunc = wc.closeFunc = null;

		wc.init();
		if (!tag)
			wc.load(portlet);
		//console.log(portlet);
	},
 
	element_init : function () {
		//初始化元素
		var wc = this, div = $("root_row").cloneNode(true);

		wc.parent.element.appendChild(div);
		div.style.display = "block";
		return div;
	},
 
	init : function () {
		//初始化信息
		var wc = this;
		if (wc.window == 0) {
			wc.content.style.display = "none";
			//wc.reduce.innerHTML = "放大";
		} else {
			wc.content.style.display = "block";
			//wc.reduce.innerHTML = "缩小";
		}

		//if (wc.lock)
		//	wc.lock.innerHTML = !wc.locks ? "锁定" : "解除";
	},
 
	load : function (info) {
		if (!info) return;

		//获取相关信息
		var wc = this, script;

		wc.title.innerHTML = info.title;

		if (info.src) {
			wc.content.innerHTML = "loading";
			script = document.createElement("script");
			script.src = info.src + ".js"//, script.defer = true;
			document.getElementsByTagName("head")[0].appendChild(script);
			CDrag.load(info.className, wc.upload.bind(wc), 5);
		} else 
			wc.content.innerHTML = info.className;
	},
 
	upload : function (obj) {
		 /*加载类信息
		  注：这里给行加入了一个扩展类，这里行的内容可以通过扩展类来控制^o^
		  不过扩展类的格式必须有open方法和edit方法，还有类名.静态成员loaded = true；为了检测是否加载完毕
		  扩展类需放到单独的.js文件里，然后从database结构体内设定其参数即可
		 */
		var wc = this;
		wc.Class = obj;
		wc.Class.parent = wc;
		wc.editFunc = Object.addEvent(wc.edit, ["onclick"], wc.lockF(wc.Class, wc.Class.edit, wc));
		wc.Class.open();
	},
 
	lockF : function () {
		//检索锁定
		var wc = this, arg = $A(arguments), root = arg.shift(), func = arg.shift();
		return function () {
			if (!wc.locks) func.apply(root, arg.concat($A(arguments)));
		};
	}
};

CDrag.prototype = {
 
	initialize : function () {
		//初始化成员
		var wc = this;
		wc.table = new CDrag.Table; //建立表格对象
		wc.iFunc = wc.eFunc = null;
		wc.obj = { on : { a : null, b : "" }, row : null, left : 0, top : 0 };
		wc.temp = { row : null, div : document.createElement("div") };
		wc.temp.div.setAttribute(CDrag.IE ? "className" : "class", "CDrag_temp_div");
		wc.temp.div.className = "CDrag_temp_div";
		wc.temp.div.innerHTML = "&nbsp;";
	},
 
	reMouse : function (a) {
		//获取鼠标位置
		var e = Object.reEvent();
		return {
			x : document.documentElement.scrollLeft + e.clientX,
			y : document.documentElement.scrollTop + e.clientY
		};
	},
 
	rePosition : function (o) {
		//获取元素绝对位置
		var $x = $y = 0;
		do {
			$x += o.offsetLeft;
			$y += o.offsetTop;
		} while ((o = o.offsetParent)); // && o.tagName != "BODY"

		return { x : $x, y : $y };
	},
 
	execMove : function (status, on_obj, in_obj, place) {
		//处理拖拽过程细节
		var wc = this, obj = wc.obj.on, temp = wc.temp, px;
		obj.a = on_obj, obj.b = status;
		if (place == 0) {
			//向上
			px = in_obj.element.clientWidth;
			in_obj.element.parentNode.insertBefore(temp.div, in_obj.element);
		} else if (place == 1) {
			//新加入
			px = in_obj.element.clientWidth - 2;
			in_obj.element.appendChild(temp.div);
		} else {
			//向下
			px = in_obj.element.clientWidth;
			in_obj.element.parentNode.appendChild(temp.div);
		}
  
		wc.obj.left = Math.ceil(px / temp.div.offsetWidth * wc.obj.left); //处理拖拽换行后宽度变化，鼠标距离拖拽物的距离的误差.
		temp.row.style.width = temp.div.style.width = px + "px"; //处理换列后对象宽度变化
	},
 
	sMove : function (o) {
		//当拖动开始时设置参数
		var wc = this;
		if (o.locks || wc.iFunc || wc.eFinc) return;

		var mouse = wc.reMouse(), obj = wc.obj, temp = wc.temp, div = o.element, position = wc.rePosition(div);

		obj.row = o;
		obj.on.b = "me";
		obj.left = mouse.x - position.x;
		obj.top = mouse.y - position.y;

		temp.row = document.body.appendChild(div.cloneNode(true)); //复制预拖拽对象
		temp.row.style.width = div.clientWidth + "px";

		with (temp.row.style) {
			//设置复制对象
			position = "absolute";
			left = mouse.x - obj.left + "px";
			top = mouse.y - obj.top + "px";
			zIndex = 100;
			opacity = "0.3";
			filter = "alpha(opacity:30)";
		}

		with (temp.div.style) {
			//设置站位对象
			height = div.clientHeight + "px";
			width = div.clientWidth + "px";
		}
		div.parentNode.replaceChild(temp.div, div);

		wc.iFunc = Object.addEvent(document, ["onmousemove"], wc.iMove.bind(wc));
		wc.eFunc = Object.addEvent(document, ["onmouseup"], wc.eMove.bind(wc));
		document.onselectstart = new Function("return false");
	},
 
	onMove : function (o) {
		//当拖动开始时设置参数

		var wc = this;
		if (o.locks || wc.iFunc || wc.eFinc) return;

		var mouse = wc.reMouse(), obj = wc.obj, temp = wc.temp, div = o.element, position = wc.rePosition(div);

		obj.row = o;
		obj.on.b = "me";
		obj.left = mouse.x;
		obj.top = mouse.y;

		temp.row = document.body.appendChild(div.cloneNode(true)); //复制预拖拽对象
		temp.row.style.width = div.clientWidth + "px";

		with (temp.row.style) {
			//设置复制对象
			position = "absolute";
			left = mouse.x + "px";
			top = mouse.y + "px";
			zIndex = 1000;
			opacity = "0.3";
			filter = "alpha(opacity:30)";
		}

		with (temp.div.style) {
			//设置站位对象
			height = div.clientHeight + "px";
			width = div.clientWidth + "px";
			left = mouse.x + "px";
			top = mouse.y  + "px";
		}
		div.parentNode.replaceChild(temp.div, div);
		if (window.setCapture)
			temp.div.setCapture();

		//console.log(temp.div.style.left + "-" + temp.div.style.top);

		wc.iFunc = Object.addEvent(document, ["onmousemove"], wc.iMove.bind(wc));
		wc.eFunc = Object.addEvent(document, ["onmouseup"], wc.eMove.bind(wc));
		document.onselectstart = new Function("return false");
	},
	
	tagPos : function (m) {
		var w = m.offsetLeft;
		var h = m.offsetTop;
		while (m = m.offsetParent) {
			w += m.offsetLeft - m.scrollLeft;
			h += m.offsetTop - m.scrollTop;
		}

		return { x : w, y : h };
	},

	iMove : function () {
		//当鼠标移动时设置参数
		var wc = this, mouse = wc.reMouse(), cols = wc.table.items, obj = wc.obj, temp = wc.temp,
		row = obj.row, div = temp.row, t_position, t_cols, t_rows, i, j;
	  
		with (div.style) {
			left = mouse.x - obj.left + "px";
			top = mouse.y - obj.top + "px";
		}
  
		for (i = 0 ; i < cols.length ; i ++) {
			t_cols = cols[i];
			var pos = wc.tagPos(t_cols.element);
			console.log(i + ":" + mouse.x + "->" + pos.x + "->" + (pos.x + t_cols.element.offsetWidth) + "=" + pos.y + "->" +  mouse.y + "->" + (pos.y + t_cols.element.offsetHeight));
			if (mouse.x<pos.x || mouse.x>(pos.x + t_cols.element.offsetWidth) || mouse.y<pos.y || mouse.y>(pos.y+t_cols.element.offsetHeight)) continue;
			console.log("落在：" + t_cols.id + "-->" + i);
			// if (t_cols != obj.row.parent) continue;
			t_position = wc.rePosition(t_cols.element);
			if (t_cols.items.length > 0) { //如果此列行数大于0
				if (t_cols.items[0] != obj.row && wc.rePosition(t_cols.items[0].element).y + 20 > mouse.y) {
					//如果第一行不为拖拽对象并且鼠标位置大于第一行的位置即是最上。。
					//向上
					wc.execMove("up", t_cols.items[0], t_cols.items[0], 0);
				} else if (t_cols.items.length > 1 && t_cols.items[0] == row &&	wc.rePosition(t_cols.items[1].element).y + 20 > mouse.y) {
					//如果第一行是拖拽对象而第鼠标大于第二行位置则，没有动。。
					//向上
					wc.execMove("me", t_cols.items[1], t_cols.items[1], 0);
				} else {
					for (j = t_cols.items.length - 1 ; j > -1 ; j --) {
						//重最下行向上查询
						t_rows = t_cols.items[j];
						if (t_rows == obj.row) {
							if (t_cols.items.length == 1) {
								//如果拖拽的是此列最后一行
								wc.execMove("me", t_cols, t_cols, 1);
							}
							continue;
						}
						if (wc.rePosition(t_rows.element).y < mouse.y) {
							//如果鼠标大于这行则在这行下面
							if (t_rows.id + 1 < t_cols.items.length && t_cols.items[t_rows.id + 1] != obj.row) {
								//如果这行有下一行则重这行下一行的上面插入
								wc.execMove("down", t_rows, t_cols.items[t_rows.id + 1], 0);
							} else if (t_rows.id + 2 < t_cols.items.length) {
								//如果这行下一行是拖拽对象则插入到下两行，即拖拽对象返回原位
								wc.execMove("me", null, t_cols.items[t_rows.id + 2], 0);
							} else {
								//前面都没有满足则放在最低行
								wc.execMove("down", t_rows, t_rows, 2);
							}
							return;
						}
					}
				}
			} else {
				//此列无内容添加新行
				wc.execMove("new", t_cols, t_cols, 1);
			}
			break;
		}
	},
 
	eMove : function () {
		//当鼠标释放时设置参数
		var wc = this, obj = wc.obj, temp = wc.temp, row = obj.row, div = row.element, o_cols, n_cols, number;

		if (obj.on.b != "me") {
			number = (obj.on.b == "down" ? obj.on.a.id + 1 : 0);
			n_cols = (obj.on.b != "new" ? obj.on.a.parent : obj.on.a);
			o_cols = obj.row.parent;
			n_cols.ins(number, o_cols.del(obj.row.id));
		}
		
		temp.div.parentNode.replaceChild(div, temp.div);
		if (temp.row)
			temp.row.parentNode.removeChild(temp.row);
		delete temp.row;

		Object.delEvent(document, ["onmousemove"], wc.iFunc);
		Object.delEvent(document, ["onmouseup"], wc.eFunc);
		document.onselectstart = wc.iFunc = wc.eFunc = null;
	},
 
	reduce : function (o) {
		//变大变小
		var wc = this;
		if ((o.window = (o.window == 1 ? 0 : 1))) {
			o.content.style.display = "block";
			//o.reduce.innerHTML = "缩小";
		} else {
			o.content.style.display = "none";
			//o.reduce.innerHTML = "放大";
		}
	},
 
	lock : function (o) {
		//锁定
		var wc = this;
		if (o.locks) {
			o.locks = false;
			o.lock.innerHTML = "锁定";
		} else {
			o.locks = true;
			o.lock.innerHTML = "解除";
		}
	},
 
	close : function (o) {
		//关闭对象
		var wc = this;
		wc.remove(o);
	},
 
	remove : function (o) {
		//移除对象
		var wc = this, parent = o.parent;

		Object.delEvent(o.close, ["onclick"], o.closeFunc);
		if (o.editFunc) Object.delEvent(o.edit, ["onclick"], o.editFunc);
		//if (o.lock)
		//	Object.delEvent(o.lock, ["onclick"], o.lockFunc);
		if (o.reduce)
			Object.delEvent(o.reduce, ["onclick"], o.reduceFunc);
		Object.delEvent(o.title, ["onmousedown"], o.mousedown);

		o.mousedown = o.reduceFunc = o.lockFunc = o.editFunc = o.closeFunc = null;

		parent.element.removeChild(o.element);
		parent.del(o.id);
		delete wc.Class;
		delete o;
	},
 
	create_json : function () {
		//生成json串
		var wc = this, cols = wc.table.items, a = [], b = [], i, j, r;
		for (i = 0 ; i < cols.length ; i ++) {
			for (r = cols[i].items, j = 0 ; j < r.length ; j ++)
				b[b.length] = "{id:'" + r[j].root_id + "',window:" + r[j].window + ",locks:" + r[j].locks + "}";
			a[a.length] = "cols:'" + cols[i].element.id + "',rows:[" + b.splice(0, b.length).join(",") + "]";
		}
		return escape("[{" + a.join("},{") + "}]");
	},
 
	parse_json : function (cookie) {
		//解释json成对象
		return eval("(" + cookie + ")");
	},
 

	set_cookie : function () {
		//设置COOKIE
		var wc = this, date = new Date;
		date.setDate(date.getDate() + 1);
		//alert(wc.create_json());
		document.cookie = "CDrag=" + wc.create_json() + ";expires=" + date.toGMTString();
	},
 
	parse : function (o) {
		//初始化成员
		try {
			var wc = this, table = wc.table, cols, rows, div, i, j;
			for (i = 0 ; i < o.length ; i ++) {
				div = $(o[i].cols), cols = table.add(div);
				for (j = 0 ; j < o[i].rows.length ; j ++) {
					//console.log("portlet--->" + o[i].rows[j].title);
					wc.add(cols.add(o[i].rows[j]));
				}
			}
		} catch (exp) {
		}
	},
 
	add : function (o) {
		//添加对象
		var wc = this;
		o.mousedown = Object.addEvent(o.title, ["onmousedown"], o.lockF(wc, wc.sMove, o));
		if (o.reduce)
			o.reduceFunc = Object.addEvent(o.reduce, ["onclick"], o.lockF(wc, wc.reduce, o));
		//if (o.lock)
		//	o.lockFunc = Object.addEvent(o.lock, ["onclick"], wc.lock.bind(wc, o));
		if (o.close)
			o.closeFunc = Object.addEvent(o.close, ["onclick"], o.lockF(wc, wc.close, o));
	},

	// 添加容器对象
	addContainter : function (cntId) {
		var wc = this, table = wc.table, cols,div;
		div = $(cntId), cols = table.add(div);
		// console.log("增加容器：" + cntId);
	},
	
	addPortlet : function (containter,portlet) {
		var wc = this, cols = wc.table.items, i;
		for (i = 0 ; i < cols.length ; i ++) {
			if (cols[i].element.id==containter) {
				wc.add(cols[i].addTag(portlet));
			}
		}
		
	}

 };

var wc = new CDrag;



// 保存模板配置
function saveTempletConfig() {
	var url = "../portal/templet.cmd?$ACTION=saveconfig&templet=" + document.getElementById("$templet").value;
	var data = "data=" + getPortletsData();
	DHTMLSuite.ajax.sendRequest(url,data,"templetConfigResult");
}
// 初始化默认模板内容
function initDefault() {
	var url = "../portal/templet.cmd?$ACTION=initconfig&templet=" + document.getElementById("$templet").value;
	DHTMLSuite.ajax.sendRequest(url,"","templetConfigResult");
}

// 返回结果显示
function templetConfigResult() {
	alert("模板配置成功！");
}