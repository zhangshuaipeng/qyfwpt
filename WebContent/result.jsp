<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="/htm" prefix="htm" %>

<html>
<head>

<meta HTTP-EQUIV="Pragma" content="no-cache" /> 
<meta HTTP-EQUIV="Cache-Control" content="no-cache" /> 
<meta HTTP-EQUIV="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<title>运行请求提示</title>
<LINK href="<%=request.getContextPath()%>/css/main.css" type="text/css" rel="stylesheet">
<style>
body{ 
	font-size:12px;
	TEXT-ALIGN: center; 
}

</style>

<script>

function returnAction() {
	<%
	String str = request.getParameter("forward");
	if (str!=null && !str.equals("")) {
	%>
	location.href = '<%=str%>';
	<%}%>
	if (top.window.getDialog) {
		var dialog = top.window.getDialog(window);
		if (dialog) {
			dialog.close();
			return;
		}
	}
	
	history.back(-1);
}
</script>
</head>


<body>

<div class="formarea" style="width:40%;">
  <div>
	<div class="formhead"><htm:write name="NAVIGATOR" defaultv="操作结果"/></div>
	<div class="formbody">
      <fieldset align="center" class="bodyoptionarea">
      <legend class="tabgroup" >操作运行结果</legend>
		<br/><br/><br/>
		<font color="red"><span style="font-size:14px;"><htm:write name="VALUEOBJECT" property="$MESSAGE"/></span></font>
		<br/><br/><br/>
		<div align="right">
              <input type="button" name="exit2" onClick="returnAction();" value="返  回">
            </div></td>
        </tr>
      </table>
      </fieldset>
	</div>
  </div>
</div> 


</body>
</html>




