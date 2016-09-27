<%@ page pageEncoding="UTF-8" %>
<%
	String[][] actors = null;
	Object obj = com.siqiansoft.framework.util.TagUtil.getFieldValue(request,"actors");
	if (obj!=null && (obj instanceof String[][]))
		actors = (String[][])obj;
	String actorType = (String)com.siqiansoft.framework.util.TagUtil.getFieldValue(request,"actortype");
	System.out.println("actortype--->" + actorType);

if (actors!=null) {

if (actorType.equals("list")) {
%>
<table width="100%" border="0" style="font-size:14px;border:0px;clear:both;">
<%
	for (int i=0;i<actors.length;i++) {
		if (i%2==0) {
%>
<tr>
<%		}%>
	<td align="left" style="border:0px;width:50%;">
		<input type="radio" id="actor" name="actor" value="<%=actors[i][0]%>"><span onclick="getSubTag(this.parentNode,'input','actor').checked=true;"><%=actors[i][1]%></span>
	</td>
<%		if ((i+1)%2==0) {%>
</tr>
<%		}
	}
%>
</table>

<%} else {%>

<script>

function checkActor(obj) {
	var ctrl = getSubTag(obj.parentNode,'input','__selected');
	if (!ctrl) return;

	ctrl.checked = !ctrl.checked;
}
</script>
<input type="hidden" name="actor" id="actor">
<input type="hidden" name="actorname" id="actorname">
<input type="hidden" name="selected" id="selected">

<table width="100%" border="0" style="font-size:14px;border:0px;clear:both;">
	<tr>
		<td width="45%">
		可选办理人:<br>
		<div id="selected__" style="border:solid 1px #dddddd;overflow:auto;height:200px;">
<%
	for(int i=0;i<actors.length;i++){
%>
		<div>
			<input type="checkbox" name="__selected" value="<%=actors[i][0]%>"><span onclick="checkActor(this);"><%=actors[i][1]%></span>
		</div>
<%	}%>
		<div>
		</td>
		<td valign="middle">
			<input type="button" class="button" name="Submit3" value=" &gt;&gt; "  onclick="moveMultiBox('selected','actor');"><br>
			<input type="button" class="button" name="Submit23" value=" &lt;&lt; "  onclick="moveMultiBox('actor','selected');">
		</td>
		<td width="45%">
		已选办理人:<br>
		<div id="actor__" style="border:solid 1px #dddddd;overflow:auto;height:200px;">
		</div>	
		</td>
	<tr>
</table>

<%}
}%>