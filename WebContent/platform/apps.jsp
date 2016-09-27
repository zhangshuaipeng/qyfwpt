<%@ page pageEncoding="UTF-8" %>

<%
	com.siqiansoft.framework.model.project.ProjectModel[] list = (com.siqiansoft.framework.model.project.ProjectModel[])com.siqiansoft.framework.util.TagUtil.getFieldValue(request,"apps");
	System.out.println(list);
%>

	<UL class="xingzheng">
	   <span> <img src="../images/nav.png"></span>应用列表</UL>
		<ul class="xiaminaneirong">
<%
	if (list!=null) {
		for (int i=0;i<list.length;i++) {	
%>
			<LI class="liucheng" onmouseover="addClass(this,'bg');" onmouseout="removeClass(this,'bg');">
				<a href="project.cmd?$ACTION=enter&code=<%=list[i].getCode()%>"><img src="../images/app.gif" style="float:left;margin-right:15px;height:48px;width:48px;border:0px;"></a>
				<a style="vertical-align:middle;" href="project.cmd?$ACTION=enter&code=<%=list[i].getCode()%>" style="font-weight:bold;"><%=list[i].getName()%></a>
				<p><%=list[i].getComments()%></p>
			</LI>

<%		}
	}
%>
       </ul>
