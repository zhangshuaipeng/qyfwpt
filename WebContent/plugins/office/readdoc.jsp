<%
try
{
	java.util.HashMap<String,String> map = com.siqiansoft.framework.attach.AttachUtil.getAttach(request);
	String filename = map.get("SAVEFILE");
	System.out.println(filename);
		
	java.io.File tFile = new java.io.File(map.get("SAVEPATH")+"/"+filename);
	System.out.println(map.get("SAVEPATH") + "/" + filename);
	if (!tFile.exists()) //����ļ������ڣ�����һ��˵���ĵ�
	{
		tFile = new java.io.File(application.getRealPath("error_nofile.doc"));
	}
	if (!tFile.exists()) //�������˵���ļ������ڣ�����һ���ַ���
	{
		out.println("������ļ������ڣ��Ҵ����ļ�error_nofile.doc�����ڡ�");
		return;
	}
	
	response.reset();
	response.setContentType("application/octet-stream");
	response.setHeader("Content-Disposition", "attachment; filename=" + map.get("SOURCEFILE"));
	java.io.InputStream inStream=new java.io.FileInputStream(tFile);
	byte[] buf = new byte[10240];
	int bytes = 0;
	java.io.OutputStream outStream = response.getOutputStream();
	while((bytes = inStream.read(buf)) != -1)
			outStream.write(buf, 0, bytes);
	inStream.close();	
	outStream.close();
}
catch(Throwable e)
{
	System.out.println(e.toString());
	throw new ServletException(e.toString());
}
%>
