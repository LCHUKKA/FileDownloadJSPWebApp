<%@page import="org.apache.jasper.tagplugins.jstl.core.ForEach"%>
<%@page import="java.io.File"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<form action="/PreProdSupport/FileManager.jsp" method="POST">
<table align="left" border="2" cellpadding="1" cellspacing="1">
	<thead>
		<tr style="background-color: #57aa5a;font-size: large;">
			<th scope="col">Resource</th>
			<th scope="col">Path</th>
			<th scope="col">Action</th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td style="text-align: center;">Location</td>
			<td style="text-align: center;"><input type="text" name="fileName" id="fileName"></input></td>
			<td style="text-align: center;"><input type="submit" name="open" value="Open"></input></td>
		</tr>
	</tbody>
</table>
</form>

<br>
<br>
<br>
<br>
<div>

<table align="left" border="2" cellpadding="1" cellspacing="1">
<thead>
		<tr style="background-color: #57aa5a;font-size: large;" align="justify">
			<th>Resource</th>
		</tr>
</thead>
<tbody>
<%
String fileName = null;
File[] files = null;
if (request.getParameter("fileName") != null) {

		fileName = request.getParameter("fileName");
		File returnFile = new File(fileName);
		if(returnFile!=null){
			if(returnFile.isDirectory()){
				if(returnFile.getParentFile()!=null){
					out.println("<tr><td align='center'><a href='/PreProdSupport/FileManager.jsp?fileName="+returnFile.getParentFile().getAbsolutePath()+ "'> ..........Go..Back..Previous..Level..... </a></td></tr>");
				}
				files=returnFile.listFiles();
				for(File f : files){
					if(f.isDirectory())
						out.println("<tr><td><a href='/PreProdSupport/FileManager.jsp?fileName="+f.getAbsolutePath()+ "'>"+f.getAbsolutePath()+"</a></td></tr>");
					else
						out.println("<tr><td><a href='/PreProdSupport/SecureFileDownload?fileName="+f.getAbsolutePath()+ "'>"+f.getAbsolutePath()+"</a></td></tr>");
				}
			}else{
				out.println("<tr><td><a href='/PreProdSupport/SecureFileDownload?fileName="+returnFile.getAbsolutePath()+"' >"+returnFile.getAbsolutePath()+"</a></td></tr>");
			}
		  }
		}
else{
	out.println("<tr><td>--No-filName-parameter-received--</td></tr>");
}
%>		
</tbody>
</table>
</div>
</body>
</html>