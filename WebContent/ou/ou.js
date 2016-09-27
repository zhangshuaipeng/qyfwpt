

// 向选择框中添加某个类型的内容
function addSelectBox(obj,type) {
	var value = obj.value;

	var v = value.split("|");
	if (type=="user") {
		v[0] = "U." + v[0];
	}
	if (type=="dept") {
		v[0] = "D." + v[0];
	}
	if (type=="role") {
		v[0] = "R." + v[0];
	}
	if (type=="group") {
		v[0] = "G." + v[0];
	}

	// 是否已经存在
	var ctl = document.getElementById("selected");
	for (var i=0;i<ctl.options.length;i++) {
		if (v[0]==ctl.options[i].value) return;
	}

	ctl = document.getElementById("selectedid");
	if (ctl.value)
		ctl.value += ",";
	ctl.value += v[0];

	ctl = document.getElementById("selectedvalue");
	if (ctl.value)
		ctl.value += ",";
	ctl.value += v[1];

	showSelected();
}

// 重新刷新选择项
function showSelected() {
	var ctl = document.getElementById("selected");
	for (var i=ctl.options.length-1;i>=0;i--) {
		ctl.options[i] = null;
	}

	ctl = document.getElementById("selectedid");
	if (!ctl.value)
		return;

	var key = ctl.value.split(",");
	ctl = document.getElementById("selectedvalue");
	var value = ctl.value.split(",");

	var objOption;
	ctl = document.getElementById("selected");

	for (var i=0;i<key.length;i++) {
		objOption = document.createElement("OPTION");
		objOption.text= value[i];
		objOption.value = key[i];
		ctl.options.add(objOption);
	}
}

// 删除选定条目
function delSelected() {
	var ctl = document.getElementById("selected");
	if (ctl.options.length==0)
		return;

	for (var i=ctl.options.length-1;i>=0;i--) {
		if (ctl.options[i].selected)
			ctl.options[i] = null;
	}

	var key = "";
	var value = "";

	for (var i=0;i<ctl.options.length;i++) {
		if (key)
			key += ",";
		if (value)
			value += ",";

		key += ctl.options[i].value;
		value += ctl.options[i].text;
	}

	document.getElementById("selectedid").value = key;
	document.getElementById("selectedvalue").value = value;
}

// 清除所有
function clearAll() {
	var ctl = document.getElementById("selected");
	if (ctl.options.length==0)
		return;

	for (var i=ctl.options.length-1;i>=0;i--) {
		ctl.options[i] = null;
	}

	document.getElementById("selectedid").value = "";
	document.getElementById("selectedvalue").value = "";
}

// 传值返回
function submit() {
	var key = document.getElementById("selectedid").value;
	if (!key)
		key = "";

	var value = document.getElementById("selectedvalue").value;
	if (!value)
		value = "";

	value = key + "|" + value;

	top.window.getDialog(window).submit(value);
}