<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>

<meta HTTP-EQUIV="Pragma" content="no-cache" /> 
<meta HTTP-EQUIV="Cache-Control" content="no-cache" /> 
<meta HTTP-EQUIV="Expires" content="0">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>电子表单</title>

<style media=print>
.Noprint{display:none;}
.Noborder{border-width:0;}
.PageNext{page-break-after: always;}
</style>
</head>


<%
	String str = "/PortletAction.cmd?$SYSTEM=test&$MODULE=portlet01&$CATALOG=发";
%>

<body >
<div>ddd
<c:import url="<%=str%>"></c:import>
000
<c:import url="<%=str + '1'%>"></c:import>
<c:import url="<%=str + '2'%>"></c:import>

</div>

</body>
</html>

