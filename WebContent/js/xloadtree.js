/*----------------------------------------------------------------------------\
|                               XLoadTree 1.11                                |
|-----------------------------------------------------------------------------|
|                         Created by Erik Arvidsson                           |
|                  (http://webfx.eae.net/contact.html#erik)                   |
|                      For WebFX (http://webfx.eae.net/)                      |
|-----------------------------------------------------------------------------|
| An extension to xTree that allows sub trees to be loaded at runtime by      |
| reading XML files from the server. Works with IE5+ and Mozilla 1.0+         |
|-----------------------------------------------------------------------------|
|             Copyright (c) 2001, 2002, 2003, 2006 Erik Arvidsson             |
|-----------------------------------------------------------------------------|
| Licensed under the Apache License, Version 2.0 (the "License"); you may not |
| use this file except in compliance with the License.  You may obtain a copy |
| of the License at http://www.apache.org/licenses/LICENSE-2.0                |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| Unless  required  by  applicable law or  agreed  to  in  writing,  software |
| distributed under the License is distributed on an  "AS IS" BASIS,  WITHOUT |
| WARRANTIES OR  CONDITIONS OF ANY KIND,  either express or implied.  See the |
| License  for the  specific language  governing permissions  and limitations |
| under the License.                                                          |
|-----------------------------------------------------------------------------|
| Dependencies: xtree.js     - original xtree library                         |
|               xtree.css    - simple css styling of xtree                    |
|               xmlextras.js - provides xml http objects and xml document     |
|                              objects                                        |
|-----------------------------------------------------------------------------|
| 2001-09-27 | Original Version Posted.                                       |
| 2002-01-19 | Added some simple error handling and string templates for      |
|            | reporting the errors.                                          |
| 2002-01-28 | Fixed loading issues in IE50 and IE55 that made the tree load  |
|            | twice.                                                         |
| 2002-10-10 | (1.1) Added reload method that reloads the XML file from the   |
|            | server.                                                        |
| 2003-05-06 | Added support for target attribute                             |
| 2006-05-28 | Changed license to Apache Software License 2.0.                |
|-----------------------------------------------------------------------------|
| Created 2001-09-27 | All changes are in the log above. | Updated 2006-05-28 |
\----------------------------------------------------------------------------*/


webFXTreeConfig.loadingText = "Loading...";
webFXTreeConfig.loadErrorTextTemplate = "Error loading \"%1%\"";
webFXTreeConfig.emptyErrorTextTemplate = "Error \"%1%\" does not contain any tree items";

// 初始化树
function initTree(system,module,treeid,imgPath,expvalue,runurl,expandAll,target) {
	var path = imgPath;
	if (!path)
		path = "../images";
	webFXTreeConfig.path = path + "/";
	path += "/tree";
	webFXTreeConfig.rootIcon = path + "/rootfolder.gif";
	webFXTreeConfig.openRootIcon = path + "/openrootfolder.gif";
	webFXTreeConfig.folderIcon = path + "/folder.gif";
	webFXTreeConfig.openFolderIcon = path + "/openfolder.gif";
	webFXTreeConfig.fileIcon = path + "/file.gif";
	webFXTreeConfig.lMinusIcon = path + "/Lminus.gif";
	webFXTreeConfig.lPlusIcon = path + "/Lplus.gif";
	webFXTreeConfig.tMinusIcon = path + "/Tminus.gif";
	webFXTreeConfig.tPlusIcon = path + "/Tplus.gif";
	webFXTreeConfig.iIcon = path + "/I.gif";
	webFXTreeConfig.lIcon = path + "/L.gif";
	webFXTreeConfig.tIcon = path + "/T.gif";
	webFXTreeConfig.blankIcon = path + "/blank.gif";

	webFXTreeConfig.system = system;
	webFXTreeConfig.module = module;
	webFXTreeConfig.treeid = treeid;
	webFXTreeConfig.expvalue = expvalue;
	webFXTreeConfig.runurl = runurl;
	webFXTreeConfig.expandAll = expandAll;
	webFXTreeConfig.target = target;
}

/*
 * WebFXLoadTree class
 */

function WebFXLoadTree(sText, sXmlSrc, sAction, sBehavior, sIcon, sOpenIcon) {
	// call super
	this.WebFXTree = WebFXTree;
	this.WebFXTree(sText, sAction, sBehavior, sIcon, sOpenIcon);

	// setup default property values
	this.src = sXmlSrc;
	this.loading = false;
	this.loaded = false;
	this.errorText = "";

	// check start state and load if open
	if (this.open)
		_startLoadXmlTree(this.src, this);
	else {
		// and create loading item if not
		this._loadingItem = new WebFXTreeItem(webFXTreeConfig.loadingText);
		this.add(this._loadingItem);
	}
}

WebFXLoadTree.prototype = new WebFXTree;

// override the expand method to load the xml file
WebFXLoadTree.prototype._webfxtree_expand = WebFXTree.prototype.expand;
WebFXLoadTree.prototype.expand = function() {
	if (!this.loaded && !this.loading) {
		// load
		_startLoadXmlTree(this.src, this);
	}
	this._webfxtree_expand();
};

/*
 * WebFXLoadTreeItem class
 */

function WebFXLoadTreeItem(sText, sXmlSrc, sAction, eParent, sIcon, sOpenIcon) {
	// call super
	this.WebFXTreeItem = WebFXTreeItem;
	this.WebFXTreeItem(sText, sAction, eParent, sIcon, sOpenIcon);

	// setup default property values
	this.src = sXmlSrc;
	this.loading = false;
	this.loaded = false;
	this.errorText = "";

	// check start state and load if open
	if (this.open)
		_startLoadXmlTree(this.src, this);
	else {
		// and create loading item if not
		this._loadingItem = new WebFXTreeItem(webFXTreeConfig.loadingText);
		this.add(this._loadingItem);
	}
}

WebFXLoadTreeItem.prototype = new WebFXTreeItem;

// override the expand method to load the xml file
WebFXLoadTreeItem.prototype._webfxtreeitem_expand = WebFXTreeItem.prototype.expand;
WebFXLoadTreeItem.prototype.expand = function() {
	if (!this.loaded && !this.loading) {
		// load
		_startLoadXmlTree(this.src, this);
	}
	this._webfxtreeitem_expand();
};

// reloads the src file if already loaded
WebFXLoadTree.prototype.reload =
WebFXLoadTreeItem.prototype.reload = function () {
	// if loading do nothing
	if (this.loaded) {
		var open = this.open;
		// remove
		while (this.childNodes.length > 0)
			this.childNodes[this.childNodes.length - 1].remove();

		this.loaded = false;

		this._loadingItem = new WebFXTreeItem(webFXTreeConfig.loadingText);
		this.add(this._loadingItem);

		if (open)
			this.expand();
	}
	else if (this.open && !this.loading)
		_startLoadXmlTree(this.src, this);
};

/*
 * Helper functions
 */

// creates the xmlhttp object and starts the load of the xml document
function _startLoadXmlTree(sSrc, jsNode) {
	if (jsNode.loading || jsNode.loaded)
		return;
	jsNode.loading = true;
	var xmlHttp = XmlHttp.create();
	xmlHttp.open("GET", sSrc + "&timestamp=" + Date.parse(new Date()), true);	// async
	xmlHttp.onreadystatechange = function () {
		if (xmlHttp.readyState == 4) {
			_xmlFileLoaded(xmlHttp.responseXML, jsNode);
		}
	};
	// call in new thread to allow ui to update
	window.setTimeout(function () {
		xmlHttp.send(null);
	}, 10);
}

// Converts an xml tree to a js tree. See article about xml tree format
function _xmlTreeToJsTree(oNode) {
	// retreive attributes
	var text = oNode.getAttribute("text");
	var action = oNode.getAttribute("action");
	var parent = null;
	var icon = oNode.getAttribute("icon");
	var openIcon = oNode.getAttribute("openIcon");
	var src = oNode.getAttribute("src");
	var target = oNode.getAttribute("target");
	// create jsNode
	var jsNode;
	if (src != null && src != "") {
		src = "TreeAction.cmd?$ACTION=subnode&$SYSTEM=" + webFXTreeConfig.system + "&$MODULE=" + webFXTreeConfig.module + "&$TREEID=" + webFXTreeConfig.treeid + "&parentid=" + src;
		jsNode = new WebFXLoadTreeItem(createTreeNodeText(oNode), src, action, parent, icon, openIcon);
	} else
		jsNode = new WebFXTreeItem(createTreeNodeText(oNode), action, parent, icon, openIcon);
	jsNode.setNodeId(oNode.getAttribute("id"));
	if (target != "")
		jsNode.target = target;

	// go through childNOdes
	var cs = oNode.childNodes;
	var l = cs.length;
	for (var i = 0; i < l; i++) {
		if (cs[i].tagName == "tree")
			jsNode.add( _xmlTreeToJsTree(cs[i]), true );
	}

	return jsNode;
}

// Inserts an xml document as a subtree to the provided node
function _xmlFileLoaded(oXmlDoc, jsParentNode) {
	if (jsParentNode.loaded)
		return;

	var bIndent = false;
	var bAnyChildren = false;
	jsParentNode.loaded = true;
	jsParentNode.loading = false;

	// check that the load of the xml file went well
	if( oXmlDoc == null || oXmlDoc.documentElement == null) {
		// alert(oXmlDoc.xml);
		jsParentNode.errorText = parseTemplateString(webFXTreeConfig.loadErrorTextTemplate,jsParentNode.src);
	}
	else {
		// there is one extra level of tree elements
		var root = oXmlDoc.documentElement;

		// loop through all tree children
		var cs = root.childNodes;
		var l = cs.length;
		for (var i = 0; i < l; i++) {
			if (cs[i].tagName == "tree") {
				bAnyChildren = true;
				bIndent = true;
				jsParentNode.add( _xmlTreeToJsTree(cs[i]), true);
			}
		}

		// if no children we got an error
		if (!bAnyChildren)
			jsParentNode.errorText = parseTemplateString(webFXTreeConfig.emptyErrorTextTemplate,
										jsParentNode.src);
	}

	// remove dummy
	if (jsParentNode._loadingItem != null) {
		jsParentNode._loadingItem.remove();
		bIndent = true;
	}

	if (bIndent) {
		// indent now that all items are added
		jsParentNode.indent();
	}

	// show error in status bar
	if (jsParentNode.errorText != "")
		window.status = jsParentNode.errorText;
}

// parses a string and replaces %n% with argument nr n
function parseTemplateString(sTemplate) {
	var args = arguments;
	var s = sTemplate;

	s = s.replace(/\%\%/g, "%");

	for (var i = 1; i < args.length; i++)
		s = s.replace( new RegExp("\%" + i + "\%", "g"), args[i] )

	return s;
}





// 显示树
function showXmlTree(ajaxObj){
	var root = ajaxObj.responseXML.documentElement; 
	var id = root.getAttribute("id");
	
	var content = createTreeNodeText(root);
	var icon;
	var openIcon;

	icon = root.getAttribute("icon");
	if (icon)
		icon = webFXTreeConfig.path + icon;
	openIcon = root.getAttribute("openIcon");
	if (openIcon)
		openIcon = webFXTreeConfig.path + openIcon;
	var tree = new WebFXTree(createTreeNodeText(root),root.getAttribute("action"),null,icon,openIcon);
	tree.target=root.getAttribute("target");
	runFirstURL(root.getAttribute("id"),root.getAttribute("action"),icon,root.getAttribute("target"),root.getAttribute("text"));
	var nodes = root.childNodes;
	fillTreeNode(nodes,tree);
	
	document.getElementById(id).innerHTML = tree;
	//document.write(tree);
	tree.expand();
	if (webFXTreeConfig.expandAll && webFXTreeConfig.expandAll=="Y") {
		tree.expandAll();
	}
}

function runFirstURL(id,action,icon,target,text) {
	if (!target)
		target = webFXTreeConfig.target;
	if (!action || action=="null") return;
	if (action.indexOf("javascript:")!=-1) return;
	if (!webFXTreeConfig.runurl || webFXTreeConfig.runurl!="Y") return;
	webFXTreeConfig.runurl = "";
	// 在页签中运行
	if (target && target=="TAB") {
		self.top.tab.addTab(id,text,action,icon,true);
	} else	if (target && target.indexOf("FRAME")==0) { // 在框架中运行
		var nIndex = parseInt(target.substring(5));
		// 是否超出框架总数
		if (window.parent.dhxLayout.items.length<=nIndex) {
			alert("框架不存在！");
		} else
			if (action.indexOf("http://")!=0 && action.indexOf("/")!=0)	{
				var pathName = document.location.pathname;
				var index = pathName.lastIndexOf("/");
				var path = pathName.substring(0,index + 1);
				action = path + action;
			}
			window.parent.dhxLayout.items[nIndex].attachURL(action);
	}

}
// 填充树节点
function fillTreeNode(nodes,folder) {
	if (nodes==null) return;

	var pnode;
	var subNodes;
	var src;
	var icon;
	var openIcon;

	for (var i=0;i<nodes.length;i++) {
		if (nodes[i].nodeType!=1) continue;
		src = nodes[i].getAttribute("src");
		icon = nodes[i].getAttribute("icon");
		if (icon)
			icon = webFXTreeConfig.path + icon;
		openIcon = nodes[i].getAttribute("openIcon");
		if (openIcon)
			openIcon = webFXTreeConfig.path + openIcon;
		if (src==null || src=="")
			pnode = new WebFXTreeItem(createTreeNodeText(nodes[i]),nodes[i].getAttribute("action"),null,icon,openIcon);
		else {
			src = "TreeAction.cmd?$ACTION=subnode&$SYSTEM=" + webFXTreeConfig.system + "&$MODULE=" + webFXTreeConfig.module + "&$TREEID=" + webFXTreeConfig.treeid + "&parentid=" + src;
			pnode = new WebFXLoadTreeItem(createTreeNodeText(nodes[i]),src,nodes[i].getAttribute("action"),null,icon,openIcon);
		}
		pnode.setNodeId(nodes[i].getAttribute("id"));
		pnode.target = nodes[i].getAttribute("target");
		folder.add(pnode);
		subNodes = nodes[i].childNodes;
		runFirstURL(nodes[i].getAttribute("id"),nodes[i].getAttribute("action"),icon,nodes[i].getAttribute("target"),nodes[i].getAttribute("text"));
		if (subNodes==null || subNodes.length==0) continue;
		fillTreeNode(subNodes,pnode);
	}
}
// 创建节点文本
function createTreeNodeText(node) {
	var id = node.getAttribute("id");
	var box = node.getAttribute("box");
	var tagName = node.getAttribute("boxtag");
	var content = node.getAttribute("text");
	var checked = node.getAttribute("defaultv");
	var onclick = "";

	if (!tagName)
		tagName = "selected";

	if (typeof(onTreeBoxClick)=="function")
		onclick = " onclick=\"onTreeBoxClick(this);\" ";

	// 如果是checkbox/checkboxs/radio/radios，则显示
	if (box!="checkbox" && box!="checkboxs" && box!="radio" && box!="radios") 
		return content;
	if (box=="checkbox" || box=="radio") {
		if (checked==id)
			checked = "checked";
		else
			checked = "";
		if (webFXTreeConfig.expvalue && webFXTreeConfig.expvalue=="Y")
			return "<input type=\"" + box + "\" id=\"" + tagName + "\" name=\"" + tagName + "\" value=\"" + id + "|" + content + "\" " + checked + onclick + ">" + content;
		else
			return "<input type=\"" + box + "\" id=\"" + tagName + "\" name=\"" + tagName + "\" value=\"" + id + "\" " + checked + onclick + ">" + content;
	}

	content += "&nbsp;&nbsp;";
	var key = node.getAttribute("key");
	var keys = key.split(",");
	var v = node.getAttribute("value");
	v = v.split(",");
	if (box=="checkboxs")
		box = "checkbox";
	if (box=="radios")
		box = "radio";

	for (var i=0;i<keys.length;i++) {
		if (checked==keys[i])
			content += "<input type=\"" + box + "\" id=\"" + tagName + "\" name=\"" + tagName + "\" value=\"" + keys[i] + "\"" + onclick + " checked>" + v[i];
		else
			content += "<input type=\"" + box + "\" id=\"" + tagName + "\" name=\"" + tagName + "\" value=\"" + keys[i] + "\"" + onclick + ">" + v[i];
	}

	return content;
}
