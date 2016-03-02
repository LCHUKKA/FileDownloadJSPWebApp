package com.test.support;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SecureFileDownload
 */
public class SecureFileDownload extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SecureFileDownload() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	@Override
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String fileName = "D:\\Temp\\bb.txt";
		// This messageID would be used to get the correct file eventually
		// long messageID = Long.parseLong(request.getParameter("messageID"));
		if (request.getParameter("fileName") != null) {

			fileName = request.getParameter("fileName");
			File returnFile = new File(fileName);

			ServletOutputStream out = response.getOutputStream();
			ServletContext context = getServletConfig().getServletContext();
			String mimetype = context.getMimeType(fileName);

			response.setContentType((mimetype != null) ? mimetype
					: "application/octet-stream");
			response.setContentLength((int) returnFile.length());
			response.setHeader("Content-Disposition", "attachment; filename=\""
					+ returnFile.getName() + "\"");

			FileInputStream in = new FileInputStream(returnFile);
			byte[] buffer = new byte[4096];

			int length;
			while ((length = in.read(buffer)) > 0) {
				out.write(buffer, 0, length);
			}
			in.close();
			out.flush();
		} else {
			ServletOutputStream out = response.getOutputStream();
			out.println("--No fileName parameter provided--");
			out.print("fileName="+request.getParameter("fileName"));
			out.close();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("html/text");
	//	ServletOutputStream out = response.getOutputStream();
	//	out.println("---doesn't support POST method---");
		doGet(request, response);

	}

}
