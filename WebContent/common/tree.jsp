<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="/htm" prefix="htm" %>

<html>
<head>
 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title></title>
<style>
a{TEXT-DECORATION: none;}
td{font-size:12px}

body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}

</style>
<link type="text/css" rel="stylesheet" href="../css/xtree.css" />
</head>
<script type="text/javascript" src="../js/ajax.js"></script>
<script type="text/javascript" src="../js/xtree.js"></script>
<script type="text/javascript" src="../js/xmlextras.js"></script>
<script type="text/javascript" src="../js/xloadtree.js"></script>

<script type="text/javascript">
function myFunction(ajaxObj){
	var root = ajaxObj.responseXML.documentElement; 
	
	var tree = new WebFXTree(root.getAttribute("text"),root.getAttribute("action"));
	tree.target=root.getAttribute("target");

	var nodes = root.childNodes;
	fillTreeNode(nodes,tree);
	
	document.getElementById("content").innerHTML = tree;
	//document.write(tree);
	tree.expand();


}

function fillTreeNode(nodes,folder) {
	if (nodes==null) return;

	var pnode;
	var subNodes;

	for (var i=0;i<nodes.length;i++) {
		if (nodes[i].nodeType!=1) continue;
		pnode = new WebFXTreeItem(nodes[i].getAttribute("id") + "." + nodes[i].getAttribute("text"),nodes[i].getAttribute("action"));
		pnode.target = nodes[i].getAttribute("target");
		folder.add(pnode);
		subNodes = nodes[i].childNodes;
		if (subNodes==null || subNodes.length==0) continue;
		fillTreeNode(subNodes,pnode);
	}
}

function initTree() {
	var imgPath = '<htm:write name="imgpath"/>';
	webFXTreeConfig.rootIcon = imgPath + "/rootfolder.gif";
	webFXTreeConfig.openRootIcon = imgPath + "/openrootfolder.gif";
	webFXTreeConfig.folderIcon = imgPath + "/folder.gif";
	webFXTreeConfig.openFolderIcon = imgPath + "/openfolder.gif";
	webFXTreeConfig.fileIcon = imgPath + "/file.gif";
	webFXTreeConfig.lMinusIcon = imgPath + "/Lminus.gif";
	webFXTreeConfig.lPlusIcon = imgPath + "/Lplus.gif";
	webFXTreeConfig.tMinusIcon = imgPath + "/Tminus.gif";
	webFXTreeConfig.tPlusIcon = imgPath + "/Tplus.gif";
	webFXTreeConfig.iIcon = imgPath + "/I.gif";
	webFXTreeConfig.lIcon = imgPath + "/L.gif";
	webFXTreeConfig.tIcon = imgPath + "/T.gif";
	webFXTreeConfig.blankIcon = imgPath + "/blank.gif";

	DHTMLSuite.ajax.sendRequest('TreeAction.cmd?$ACTION=load&$TREEID=<htm:write name="$TREEID"/>','','myFunction');
}
</script>

<body style="overflow:auto;" onload="initTree();">
<div id="content" style="margin-top:5px;margin-left:5px;font-size:14px;">
</div>

</body>


</html>