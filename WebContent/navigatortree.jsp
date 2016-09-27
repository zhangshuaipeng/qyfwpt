<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@ taglib uri="/htm" prefix="htm" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<title>首页</title>
<link href="css/mobile.css" type="text/css" rel="stylesheet" />
</head>
<style type="text/css"> 

.x-tree dt,dl,dd {
	line-height:20px;
	cursor:pointer;
	font-size:12px;
	margin-top:0px;
	-moz-user-select:none;
}

.x-tree dt {
	margin-left:0px;
}

.x-tree dl dd {
	margin-left:32px;
}

.x-tree dl dl {
	margin-left:32px;
}

.x-tree img {
	vertical-align:middle;
	margin-right:2px;
}

.x-tree a img,span {
	border:0px;
}

.x-tree a,a:link,a.visited,a:hover,a:active {
	text-decoration: none;
	color:black;
}

.x-tree .open {
	vertical-align:middle;
	line-height:16px;
}

.x-tree .open .arrow {
    background: url("images/arrows.gif") no-repeat scroll -16px 0 transparent;
    height: 16px;
    margin: 0;
    padding: 0;
    width: 16px;
}

.x-tree .open .folder {
	background: url("images/openfolder.gif") repeat scroll 0 0 transparent;
    height: 18px;
    margin: 0;
    padding: 0;
    width: 16px;
	margin-right:2px;
}

.x-tree .close .arrow {
    background: url("images/arrows.gif") no-repeat scroll 0 0 transparent;
    height: 16px;
    margin: 0;
    padding: 0;
    width: 16px;
}

.x-tree .close .folder {
	background: url("images/folder.gif") repeat scroll 0 0 transparent;
    height: 18px;
    margin: 0;
    padding: 0;
    width: 16px;
	margin-right:2px;
}

.x-tree .selected {
	background-color:#D9E8FB;
}

.x-tree .over {
	background-color:#eeeeee;
}
</style> 

<script src="js/common.js"></script>
<script src="js/ajax.js"></script>
<script type="text/javascript"> 
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
		
		var a = document.createElement("a");
		var str = xmlNode.getAttribute("action");
		if (str) {
			a.href = str;
			str = xmlNode.getAttribute("target");
			if (str) {
			//	a.target = str;
			}
		}
		dd.appendChild(a);
		
		var img = document.createElement("img");
		img.src = xmlNode.getAttribute("icon");
		a.appendChild(img);

		var span = document.createElement("span");
		span.innerHTML = xmlNode.getAttribute("text");
		a.appendChild(span);

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
	}

	this.toggleChild = function (o,state) {
		var sb = o.nextSibling; 
		while (sb && sb.tagName.toLowerCase()!='dt') {
			sb.style.display = state; 
			sb = sb.nextSibling; 
		}
	}
}


function myFunction(ajaxObj){
	// document.getElementById('content').innerHTML = ajaxObj.response;
	var root = ajaxObj.responseXML.documentElement; 
	createTreeNodes(root,null);
}



// 取下一个子节点
function createTreeNodes(node,tree) {
	var nodes = node.childNodes;
	var item;
	var treeNode;
	var subNode;

	if (!tree) {
		treeNode = objTree.getTree();
	} else
		treeNode = tree;

	for (var i=0;i<nodes.length;i++) {
		if (nodes[i].nodeType==1) {   // 表示真实的子节点
			item = nodes[i];
			// 是否是文件夹
			if (item.childNodes.length>0) {
				subNode = objTree.createFolder(treeNode,item);
				createTreeNodes(item,subNode);
			} else
				objTree.createNode(treeNode,item);
		}
	}
}


var objTree = new dxTree();

function loadTree() {
	var url = 'TreeAction.cmd?$ACTION=system'; // 'platform/TreeAction.cmd?$MODULE=bizmodel&$ACTION=load&$TREEID=tree&$SYSTEM=platform'
	DHTMLSuite.ajax.sendRequest(url,'','myFunction');
	objTree.init("tree");
}

</script> 
<body style="margin:0px 0px 0px 0px;padding:0px;" onload="loadTree();"> 
<div class="top">北京天竺综合保税区</div>
<div style="height:37px;">
</div>
<div id="tree" style="margin-top:3px;">
</div>
</body> 
</html> 
