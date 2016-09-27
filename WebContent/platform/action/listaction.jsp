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
<style media=print>
.nonprinting{display:none;}
button {display:none;}
</style>

<htm:header type="form"/>

<SCRIPT src="../js/dialog.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/common.js" type="text/javascript"></SCRIPT>
<script src="../js/xtree.js" type="text/javascript"></script>
<script src="../js/xmlextras.js" type="text/javascript"></script>
<script src="../js/xloadtree.js" type="text/javascript"></script>
<SCRIPT src="../js/validator.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/ajax.js" type="text/javascript"></SCRIPT>
<SCRIPT src="../js/portal.js" type="text/javascript"></SCRIPT>
<script src="../plugins/fckeditor/dialog/common/fck_dialog_common.js" type="text/javascript"></script>
<script type="text/javascript">

var dialog	= window.parent ;
var oEditor	= dialog.InnerDialogLoaded() ;

// Gets the document DOM
var oDOM = oEditor.FCK.EditorDocument ;

var oActiveEl = dialog.Selection.GetSelectedElement() ;

function formOnLoad() {
	// First of all, translate the dialog box texts
	oEditor.FCKLanguageManager.TranslatePage(document) ;

	oActiveEl = null ;

	dialog.SetOkButton( true ) ;
	dialog.SetAutoSize( true ) ;
	//SelectField( 'txtName' ) ;
	checkControl();
	window.parent.SetOkButton(true);
	window.focus();
}


function Ok()
{
	oEditor.FCKUndo.SaveUndoStep() ;

	var value = null;
	var selected = document.getElementsByName("$list-selected");
	for (var i=0;i<selected.length;i++) {
		if (selected[i].checked) {
			value = selected[i].value;
			break;
		}
	}
	if (value==null) {
		alert("请选择操作！");
		return false;
	}
	var key = value.substring(0,value.indexOf("|"));
	value = value.substring(value.indexOf("|") + 1); 

	oActiveEl = CreateNamedElement( oEditor, oActiveEl, 'INPUT', {name: "$action-" + key,id:"$action-" + key, type: "button"} ) ;

	SetAttribute( oActiveEl, 'value', value ) ;
	SetAttribute( oActiveEl, 'ctrltype', "action" ) ;

	return true;
}

function checkControl() {
	var c;
	var data;
	var code;
	for (c in gridlist.data) {
		data = gridlist.data[c];
		code = data['name'];
		if (oEditor.FCK.EditorDocument.getElementById("$action-" + code)) {
			gridlist.deleteRow(c);
		}
	}
}

</script>

</HEAD>

<BODY style="margin:0px;">
<htm:tabber type="form"/>
<htm:form name="EAPForm" action=""  method="POST"> 
	<htm:hidden name="system"/>
 <htm:hidden name="module"/>
 <htm:hidden name="templet"/>
 <htm:grid id="list" name="list" title="列表" gridid="actionselect"/>

<htm:hidden name="$SYSTEM"/>
<htm:hidden name="$MODULE"/>
<htm:hidden name="$ACTION"/>
<htm:hidden name="$BOX"/>
<htm:hidden name="$TABLE"/>
<htm:hidden name="$MESSAGE"/>
<htm:hidden name="$MOBILE"/>
</htm:form>
</BODY>
<script>

function onPageLoad() {
	<htm:write name="VALUEOBJECT" property="$JSONLOAD"/>

	if (typeof(formOnLoad)=="function")
		formOnLoad();
}
function onPageSubmit(obj) {
	<htm:write name="VALUEOBJECT" property="$JSONSUBMIT"/>

	return true;
}

window.onload = onPageLoad;
</script>
</HTML>


