<%@ page pageEncoding="UTF-8" %>

<%
	com.siqiansoft.workflow.model.RouteModel[] routes = (com.siqiansoft.workflow.model.RouteModel[])com.siqiansoft.framework.util.TagUtil.getFieldValue(request,"routes");
%>

<%
if (routes!=null) {
	for (int i=0;i<routes.length;i++) {
%>
<span style="height:30px;font-size:18px; line-height:32px;">
	<input type="radio" id="nextnodeid" name="nextnodeid" value="<%=routes[i].getNextNode()%>"><span  onclick="getSubTag(this.parentNode,'input','nextnodeid').checked=true;"><%=routes[i].getName()%></span>
</span><br/>
<%	}
}%>

