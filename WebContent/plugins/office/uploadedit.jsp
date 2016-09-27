<%@ page pageEncoding="UTF-8" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page language="java" import="com.jspsmart.upload.*"%>
<jsp:useBean id="mySmartUpload" scope="page" class="com.jspsmart.upload.SmartUpload" />
<%
	java.util.HashMap<String,String> map = com.siqiansoft.framework.attach.AttachUtil.getAttach(request);

	String filename;
	String title;
	long filesize;
	String contenttype;
	// Initialization
 	mySmartUpload.initialize(pageContext);
	// Upload
	mySmartUpload.upload();
	
	//uncomment the following to save file to upload dir also
	//mySmartUpload.save(UPLOADPATH);
	
 	com.jspsmart.upload.File myFile = null;
	
	for (int i=0;i<mySmartUpload.getFiles().getCount();i++)
	{
		myFile = mySmartUpload.getFiles().getFile(i);
  		//处理数据及文件
  		if (!myFile.isMissing())
	 	{
	  		//out.println("File=" + myFile.getFileName()+"<br>");
	 		filename = myFile.getFileName();
	 		filesize = myFile.getSize();
	 		System.out.println("myFile.getFieldName()="+myFile.getFieldName());	
	 		
			contenttype = myFile.getContentType();		 			 		
			System.out.println("contenttype="+contenttype);
			try
			{
				//只是简单保存
				myFile.saveAs(map.get("SAVEPATH") + "/" + myFile.getFieldName(),com.jspsmart.upload.File.SAVEAS_PHYSICAL);
			}
			catch(Exception e)
			{
				out.println("发生错误: " + e.toString());				
			}				

			out.println("保存的文件: " + filename + "<br>");
			out.println("大小: " + filesize + " bytes<br>");
	 	}  // end if (!myFile.isMissing())
	}// end for 	
%>

		

