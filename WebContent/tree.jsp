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
<link type="text/css" rel="stylesheet" href="css/xtree.css" />
</head>
<script type="text/javascript" src="js/common.js"></script>
<script type="text/javascript" src="js/ajax.js"></script>
<script type="text/javascript" src="js/xtree.js"></script>
<script type="text/javascript" src="js/xmlextras.js"></script>
<script type="text/javascript" src="js/xloadtree.js"></script>

<script type="text/javascript">

function loadNavTree() {
	initTree('','','','images/icon','');

	var url = 'TreeAction.cmd?$ACTION=system';
	DHTMLSuite.ajax.sendRequest(url,'','showXmlTree');
}
</script>

<body style="overflow:auto;" onload="loadNavTree();">
<div id="systree" style="margin-top:5px;margin-left:5px;font-size:14px;">
</div>

</body>


</html>