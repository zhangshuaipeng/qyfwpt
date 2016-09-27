<%
	if (com.siqiansoft.framework.util.Utilities.isMobile(request)) {
		request.getRequestDispatcher("mobilelogin.jsp").forward(request,response);
		return;
	}
%>

<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@page import="java.util.*"%>
<%@ taglib uri="/htm" prefix="htm" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<title>用户登陆</title>
<style>
*{
 margin:0; 
 padding:0;
 }
body{margin:0;padding:0;border:0 none;font-size:12px;font-family:"黑体"}
ul,li,dl,dt,dd,form,span,label,p{margin:0px; padding:0px;}
ul,li{ list-style:none;}
img{border:0;}
div{margin:0 auto;font-size:12px;}
a{text-decoration:none;color:#000;}
h1,h2,h3,h4,h5,h6{font-size:100%;font-weight:normal; margin:0;padding:0;}
.clear{clear:both;height:0;overflow:hidden;}


.box { position:absolute; top:50%;left:50%;margin:-190px 0 0 -226px; }
.left{ width:17px; height:328px; float:left;}
.center{ width:418px; height:328px; float:left; background:url(<%=request.getContextPath()%>/image/center.jpg) repeat-x;}
.right{ width:17px; height:328px; float:left;}
.biaoti{ font-family:"微软雅黑";width:418px; height:72px; background:url(<%=request.getContextPath()%>/image/xx.jpg) no-repeat center bottom; font-size:30px; color:#de760f; text-align:center; padding-top:40px;}
.dljm{ width:418px; height:216px; padding-top:20px; text-align:center;}
.wbk{ width:219px; height:30px; border:1px solid #adb6c9; vertical-align:middle; line-height:30px;}
.yzm{ width:119px; height:30px; border:1px solid #adb6c9; vertical-align:middle; line-height:30px;}
.dljm p{ display:block; margin-bottom:12px; text-align:center;}
.dljm span{ font-size:14px; color:#333333; width:70px; display:inline-block; text-align:right;}
.dljm a{ width:100px; height:30px; vertical-align:bottom; display:inline-block;}
.dljm h1{ padding-right:65px; display:block;}
.dlanniu{ width:86px; height:33px; background:url(<%=request.getContextPath()%>/image/login.gif) no-repeat; border:none;}
</style>
</head>
<script language="javascript">
	if (top.location != self.location)top.location=self.location;
</script>

<body>
<div class="box">
<div class="left">
  <img src="<%=request.getContextPath()%>/image/left.jpg"/></div>
<div class="center">
 <div class="biaoti">
 <htm:configitem catalog="license" property="system-name"/>
 </div>
<form action="<%=request.getContextPath()%>/login.cmd" method="POST" class="dljm">
  <htm:loginparam/>
 <p><span>用户名：</span><input type="text" name="usercode" class="wbk" /></p>
 <p><span>密&nbsp;&nbsp;码：</span><input type="password" name="pwd" class="wbk" /></p>
 <h1><input name="" type="submit" value=" " class="dlanniu" /></h1>
 </form>
</div>
<div class="right">
<img src="<%=request.getContextPath()%>/image/right.jpg"/></div>
</div>
</body>
</html>
