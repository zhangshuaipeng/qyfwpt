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
<script>

function selectUser() {
var selected = document.getElementsByName("selected");
if (!selected) {
    top.window.getDialog(window).close();
    return;
}
var ret = "";
var key = "";
var value = "";
var v;
for (var i=0;i<selected.length;i++) {
   if (selected[i].checked) {
      if (ret!="") {
          ret += ",";
          key +=",";
          value += ",";
       }
      v = selected[i].value;
      ret += v;
      key += v.substring(0,v.indexOf("."));
      value += v.substring(v.indexOf(".") + 1);
   }

}

if (ret=="") {
     alert("请选择部门！");
     return;
}

top.window.getDialog(window).submit(key + "|" + value);

}

function onTreeBoxClick(obj) {
    if (obj.name=="selected") return;
    var check = obj.checked;
    var id = obj.parentNode.parentNode.id;
    id = id + "-cont";
    var cont = document.getElementById(id);
    if (!cont.innerHTML) return;
    for (var i=0;i<cont.childNodes.length;i++) {
       if (cont.childNodes[i].tagName!="DIV") continue;
       var tag = cont.childNodes[i];
       id = tag.id;
       if (id.indexOf("-cont")!=-1) continue;
       if (document.getElementById(id + "-cont").innerHTML) continue;
       var selected = tag.getElementsByTagName("input");
       if (selected) {
          for (var n=0;n<selected.length;n++) {
              if (selected[n].id=="selected")
                  selected[n].checked = check ;
          }
       }
    }
}
</script>

</HEAD>

<BODY style="margin:0px;">
<htm:tabber type="form"/>
<htm:form name="EAPForm" action=""  method="POST"> 
	<htm:tree id="tree" name="tree" title="树" width="310" height="340" dictid="deptuser" parents="box"/>
 <htm:hidden name="box" defaultv="checkbox"/>
 <htm:button name="select" value="选择" type="JAVASCRIPT" showtype="BUTTON" icon="save.png" display="ICONTEXT" url="selectUser();" target="_self"/>
 <htm:button name="exit" value="返回" type="JAVASCRIPT" showtype="BUTTON" icon="return.gif" display="ICONTEXT" url="top.window.getDialog(window).close();" target="_self"/>

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


