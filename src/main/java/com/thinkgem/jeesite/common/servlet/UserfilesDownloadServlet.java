package com.thinkgem.jeesite.common.servlet;

import java.io.*;
import java.nio.ByteBuffer;
import java.nio.channels.SeekableByteChannel;
import java.nio.file.Files;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.commons.io.IOUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.util.UriUtils;

import com.thinkgem.jeesite.common.config.Global;
import static java.nio.file.StandardOpenOption.READ;
/**
 * 查看CK上传的图片
 * @author ThinkGem
 * @version 2014-06-25
 */
public class UserfilesDownloadServlet extends HttpServlet {

	private static final int BUFFER_LENGTH = 1024 * 16;
	private static final long EXPIRE_TIME = 1000 * 60 * 60 * 24;
	private static final Pattern RANGE_PATTERN = Pattern.compile("bytes=(?<start>\\d*)-(?<end>\\d*)");
	private static final long serialVersionUID = 1L;
	private Logger logger = LoggerFactory.getLogger(getClass());

	public void fileOutputStream(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {

		String filepath = req.getRequestURI();
		int index = filepath.indexOf(Global.USERFILES_BASE_URL);
		if(index >= 0) {
			filepath = filepath.substring(index + Global.USERFILES_BASE_URL.length());
		}
		try {
			filepath = UriUtils.decode(filepath, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			logger.error(String.format("解释文件路径失败，URL地址为%s", filepath), e1);
		}
		File file = new File(Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + filepath);
		String range = req.getHeader("range");
		try {
			if (filepath.endsWith(".mp4")) {
				this.processRequest(req,resp);
			}
			else {
				resp.setHeader("Content-Type", "application/octet-stream");
				IOUtils.copy(new FileInputStream(file), resp.getOutputStream());
			}
			//FileCopyUtils.copy(new FileInputStream(file), resp.getOutputStream());
			return;
		} catch (FileNotFoundException e) {
			req.setAttribute("exception", new FileNotFoundException("请求的文件不存在"));
			req.getRequestDispatcher("/WEB-INF/views/error/404.jsp").forward(req, resp);
		}
	}

	private void processRequest(final HttpServletRequest request, final HttpServletResponse response) throws IOException {

		String filepath = request.getRequestURI();
		int index = filepath.indexOf(Global.USERFILES_BASE_URL);
		if(index >= 0) {
			filepath = filepath.substring(index + Global.USERFILES_BASE_URL.length());
		}
		try {
			filepath = UriUtils.decode(filepath, "UTF-8");
		} catch (UnsupportedEncodingException e1) {
			logger.error(String.format("解释文件路径失败，URL地址为%s", filepath), e1);
		}
		File file = new File(Global.getUserfilesBaseDir() + Global.USERFILES_BASE_URL + filepath);

		int length = (int) Files.size(file.toPath());
		int start = 0;
		int end = length - 1;

		String range = request.getHeader("Range");
		Matcher matcher = RANGE_PATTERN.matcher(range);

		if (matcher.matches()) {
			String startGroup = matcher.group("start");
			start = startGroup.isEmpty() ? start : Integer.valueOf(startGroup);
			start = start < 0 ? 0 : start;

			String endGroup = matcher.group("end");
			end = endGroup.isEmpty() ? end : Integer.valueOf(endGroup);
			end = end > length - 1 ? length - 1 : end;
		}

		int contentLength = end - start + 1;

		response.reset();
		response.setBufferSize(BUFFER_LENGTH);
		response.setHeader("Content-Disposition", String.format("inline;filename=\"%s\"", file.getName()));
		response.setHeader("Accept-Ranges", "bytes");
		response.setDateHeader("Last-Modified", Files.getLastModifiedTime(file.toPath()).toMillis());
		response.setDateHeader("Expires", System.currentTimeMillis() + EXPIRE_TIME);
		response.setContentType(Files.probeContentType(file.toPath()));
		response.setHeader("Content-Range", String.format("bytes %s-%s/%s", start, end, length));
		response.setHeader("Content-Length", String.format("%s", contentLength));
		response.setStatus(HttpServletResponse.SC_PARTIAL_CONTENT);

		int bytesRead;
		int bytesLeft = contentLength;
		ByteBuffer buffer = ByteBuffer.allocate(BUFFER_LENGTH);

		try (SeekableByteChannel input = Files.newByteChannel(file.toPath(), READ);
			 OutputStream output = response.getOutputStream()) {

			input.position(start);

			while ((bytesRead = input.read(buffer)) != -1 && bytesLeft > 0) {
				buffer.clear();
				output.write(buffer.array(), 0, bytesLeft < bytesRead ? bytesLeft : bytesRead);
				bytesLeft -= bytesRead;
			}
		}
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		fileOutputStream(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		fileOutputStream(req, resp);
	}
}
