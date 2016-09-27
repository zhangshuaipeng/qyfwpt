<%
	com.siqiansoft.framework.model.LoginModel login = (com.siqiansoft.framework.model.LoginModel)request.getSession(false).getAttribute("LOGINMODEL");
	if (login==null) {
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
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" />
<title>首页</title>
<link href="css/mobile.css" type="text/css" rel="stylesheet" />
</head>

<script>

</script>
<body>
<div class="top">北京天竺综合保税区</div>
<div style="height:37px;">
</div>
<div class="center">
  <div class="system">
    <a href="navigator.jsp"><img src="images/mobile/b1.jpg"/><br />OA办公</a>
    <a href="#"><img src="images/mobile/b2.jpg"/><br />领导决策</a>
    <a href="#"><img src="images/mobile/b3.jpg"/><br />基础数据</a>
    <a href="#"><img src="images/mobile/b4.jpg"/><br />一站式审批</a>
    <a href="#"><img src="images/mobile/b5.jpg"/><br />在线服务</a>
    <a href="#"><img src="images/mobile/b6.jpg"/><br />综合服务</a>
    <a href="#"><img src="images/mobile/b7.jpg"/><br />知识中心</a>
    <a href="#"><img src="images/mobile/b8.jpg"/><br />资源共享</a>
  </div>
  <div class="tips">
   <h1 class="daiyue"><span><img src="images/mobile/pi1.jpg"/>待批文件：</span><a href="#">40条</a></h1>
   <h1 class="jianbao"><span><img src="images/mobile/pi4.jpg"/>待阅简报：</span><a href="#">10条</a></h1>
   <h1 class="daiyue"><span><img src="images/mobile/pi2.jpg"/>未读消息：</span><a href="#">10条</a></h1>
   <h1 class="jianbao"><span><img src="images/mobile/pi3.jpg"/>未读邮件：</span><a href="#">0封</a></h1>
  </div>
  <div class="system">
    <a href="#"><img src="images/mobile/b9.jpg"/><br />已阅简报</a>
    <a href="#"><img src="images/mobile/b10.jpg"/><br />通知通告</a>
    <a href="#"><img src="images/mobile/b11.jpg"/><br />通讯录</a>
    <a href="#"><img src="images/mobile/b12.jpg"/><br />值班安排</a>
    <a href="dailyoffice/todo.cmd?$ACTION=list"><img src="images/mobile/b13.jpg"/><br />待办工作</a>
    <a href="#"><img src="images/mobile/b14.jpg"/><br />启动工作</a>
    <a href="#"><img src="images/mobile/b15.jpg"/><br />已办工作</a>
    <a href="#"><img src="images/mobile/b16.jpg"/><br />领导日程</a>
  </div>
</div>
</body>
</html>
