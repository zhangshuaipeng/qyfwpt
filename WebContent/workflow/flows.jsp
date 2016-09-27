<%@ page pageEncoding="UTF-8" %>

<%
	com.siqiansoft.framework.model.dict.ItemModel[] items = (com.siqiansoft.framework.model.dict.ItemModel[])com.siqiansoft.framework.util.TagUtil.getFieldValue(request,"flowtype");
	java.util.ArrayList list = (java.util.ArrayList)com.siqiansoft.framework.util.TagUtil.getFieldValue(request,"flows");
%>

<%
	for (int i=0;i<items.length;i++) {
%>
	<UL class="xingzheng">
	   <span> <img src="../images/xz.gif"></span><%=items[i].getValue()%></UL>
		<ul class="xiaminaneirong">
<%
		for (int n=0;n<list.size();n++) {	
			java.util.HashMap<String,String> map = (java.util.HashMap<String,String>)list.get(n);
			if (map.get("TYPE").equals(items[i].getKey())) {
%>
			<LI class="liucheng" onmouseover="addClass(this,'bg');" onmouseout="removeClass(this,'bg');">
				<a href="startup.cmd?$ACTION=begin&flowcode=<%=map.get("FLOWCODE")%>"><img src="../images/flow/<%=map.get("ICON")%>" style="float:left;margin-right:15px;height:48px;width:48px;border:0px;"></a>
				<a style="vertical-align:middle;" href="startup.cmd?$ACTION=begin&flowcode=<%=map.get("FLOWCODE")%>" style="font-weight:bold;"><%=map.get("FLOWNAME")%></a>
				<p><%=map.get("NOTES")%></p>
			</LI>

<%		}}%>
       </ul>
<%	}%>
