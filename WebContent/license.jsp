<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="java.util.*" %>
<%@ taglib uri="/htm" prefix="htm" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/1999/REC-html401-19991224/loose.dtd">
<HTML>
<HEAD>
<TITLE>License授权信息</TITLE>
<meta HTTP-EQUIV="Pragma" content="no-cache" /> 
<meta HTTP-EQUIV="Cache-Control" content="no-cache" /> 
<meta HTTP-EQUIV="Expires" content="0">
<META http-equiv=Content-Type content="text/html; charset=UTF-8">

<SCRIPT src="util/ajax.js" type=text/javascript></SCRIPT>
</HEAD>

<BODY>
<FIELDSET><LEGEND>License 授权信息</LEGEND>
<form name="LicenseForm" action="/LicenseAction.do"  method="POST">
<input type=hidden name="actionType" value="save"/>
<DIV id=formResponse>
<TABLE>
  <TBODY>
  <TR>
    <TD align=right>序列号</TD>
    <TD><htm:radio name="serialno" value="fff" required="false">系统</htm:radio>
	</TD>
  </TR>
  <TR>
    <TD align=right>版本号</TD>
    <TD><htm:select name="Version" value="ff" required="false">
			<htm:option value="">-- 选择 --</htm:option>
			<htm:option value="1">男</htm:option>
			<htm:option value="2">女</htm:option>
		</htm:select>
	</TD>
  </TR>
  <TR>
    <TD align=right>系统名称</TD>
    <TD><htm:text name="System" size="60" value="ss" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD align=right>组织名称</TD>
    <TD><htm:text name="Name" size="60" value="dd" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD align=right>开始时间</TD>
    <TD><htm:text name="From" value="" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD align=right>截止时间</TD>
    <TD><htm:text name="DeadLine" value="" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD align=right>服务器IP</TD>
    <TD><htm:text name="IP" value="a" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD align=right>网卡MAC地址</TD>
    <TD><htm:text name="MAC" value="" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD align=right>服务器备用IP</TD>
    <TD><htm:text name="ip1" value="" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD align=right>网卡MAC备用地址</TD>
    <TD><htm:text name="mac1" value="" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD align=right>注册用户数</TD>
    <TD><htm:text name="UserNumber" value="" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD align=right>允许创建的子组织数</TD>
    <TD><htm:text name="Organize" value="" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD align=right>OU授权</TD>
    <TD><htm:text name="ou" value="" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD align=right>EFORM授权</TD>
    <TD><htm:text name="eform" value="" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD align=right>workflow授权</TD>
    <TD><htm:text name="workflow" value="" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD align=right>portal授权</TD>
    <TD><htm:text name="portal" value="" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD align=right>cms授权</TD>
    <TD><htm:text name="cms" value="" required="false"/>
	</TD>
  </TR>
  <TR>
    <TD colSpan=2></TD>
    <TD><INPUT class=formButton id=mySubmit onclick=formObj.submit() type=button value=保存> 
	</TD>
  </TR>
</TBODY>
</TABLE>
<P>
<font color=red>License授权信息不能随意改动，否则将导致系统无法正常运行！下列情况可能导致系统无法正常启动：<br>
（1）当前服务器时间不在生效日期内；<br>
（2）服务器绑定的IP地址不正确；<br>
（3）服务器绑定的MAC地址不正确；<br>
（4）注册用户数超过允许的用户数； <br>
</font>
</P>
</DIV>
</form>
</FIELDSET>
<SCRIPT type=text/javascript>
var formObj = new DHTMLSuite.form({ formRef:'LicenseForm',action:'util/license.jsp',responseEl:'formResponse'});
</SCRIPT>

</BODY>
</HTML>
