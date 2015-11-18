
package sync;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.ChannelShell;
import com.jcraft.jsch.SftpException;

public class sync_113_adminche {

	private static final String tomcat = "tomcat4";	//tomcat1|tomcat2|tomcat3
	private static final String app = "adminche";	//adminche|che
	

	private static final boolean ftl_boo = true;	//false|true
	private static final boolean class_boo = true;	
	private static final boolean html_boo = false;
	

	private static final String contain_ftl = "ftl|xml";		// ftl|jar|xls|xml|xls|jsp|json
	private static final String contain_class = "class|xml";	//|xml|properties
	private static final String contain_html = "css|js";		// css|js|jpg|gif|png|PNG|eot|woff|ttf|sv             g;	//注意：html和js不能轻易更新
	

	
	// 设置主机ip，端口，用户名，密码
//	private static Map<String, String> sftpDetails_249;
//	private static Map<String, String> sftpDetails_143;0
	private static Map<String, String> sftpDetails_113;
//	private static Map<String, String> sftpDetails_197;
//	private static Map<String, String> sftpDetails_117;
	
	
	                                                                 

	static {
//		sftpDetails_249 = new HashMap<String, String>();
//		sftpDetails_249.put(SFTPConstants.SFTP_REQ_HOST, "192.168.1.249");
//		sftpDetails_249.put(SFTPConstants.SFTP_REQ_USERNAME, "root");
//		sftpDetails_249.put(SFTPConstants.SFTP_REQ_PASSWORD, "111111");
//		sftpDetails_249.put(SFTPConstants.SFTP_REQ_PORT, "22");
//		//
//		sftpDetails_143 = new HashMap<String, String>();
//		sftpDetails_143.put(SFTPConstants.SFTP_REQ_HOST, "182.254.217.143");
//		sftpDetails_143.put(SFTPConstants.SFTP_REQ_USERNAME, "root");
//		sftpDetails_143.put(SFTPConstants.SFTP_REQ_PASSWORD, "qiandao@31588");
//		sftpDetails_143.put(SFTPConstants.SFTP_REQ_PORT, "22");
		//
		sftpDetails_113 = new HashMap<String, String>();
		sftpDetails_113.put(SFTPConstants.SFTP_REQ_HOST, "182.254.131.113");
		sftpDetails_113.put(SFTPConstants.SFTP_REQ_USERNAME, "root");
		sftpDetails_113.put(SFTPConstants.SFTP_REQ_PASSWORD, "qiandao@31588");
		sftpDetails_113.put(SFTPConstants.SFTP_REQ_PORT, "23193");
//		//
//		sftpDetails_197 = new HashMap<String, String>();
//		sftpDetails_197.put(SFTPConstants.SFTP_REQ_HOST, "115.159.56.197");
//		sftpDetails_197.put(SFTPConstants.SFTP_REQ_USERNAME, "root");
//		sftpDetails_197.put(SFTPConstants.SFTP_REQ_PASSWORD, "qiandao@31588");
//		sftpDetails_197.put(SFTPConstants.SFTP_REQ_PORT, "22");
//		//
//		sftpDetails_117 = new HashMap<String, String>();
//		sftpDetails_117.put(SFTPConstants.SFTP_REQ_HOST, "182.254.132.117");
//		sftpDetails_117.put(SFTPConstants.SFTP_REQ_USERNAME, "root");
//		sftpDetails_117.put(SFTPConstants.SFTP_REQ_PASSWORD, "qiandao@31588");
//		sftpDetails_117.put(SFTPConstants.SFTP_REQ_PORT, "22");
//		
	}

	public static void main(String[] args) throws Exception {
		
		SFTPTest test = new SFTPTest();

		Map<String, String> sftpDetails = sftpDetails_113;

		SFTPChannel channel = test.getSFTPChannel();
		ChannelSftp chSftp = channel.getChannel(sftpDetails, 60000);

		System.out.println(">>> >>> begin ...... ");

		Boolean restart = false;
		
		String src = "";
		String dst = "";
		/************************** adminche **************************/
		// ftl
		if (ftl_boo) {
			src = "D:\\workspace_java\\"+app+"\\WebContent\\"; // 本地文件名
			dst = "/data/app/" + tomcat + "/webapps/"+app+"/"; // 目标文件名
			putDirectory(src, dst, chSftp, contain_ftl);
		}

		// class
		if (class_boo) {
			src = "D:\\workspace_java\\"+app+"\\build\\classes\\";
			dst = "/data/app/" + tomcat + "/webapps/"+app+"/WEB-INF/classes/";
			putDirectory(src, dst, chSftp, contain_class);
			restart = true;
		}

		// html
		if (html_boo) {
			src = "D:\\nginx-1.4.7\\"+app+"_html\\";
			dst = "/data/app/nginx/"+app+"_html/";
			putDirectory(src, dst, chSftp, contain_html);
		}

		// 重启tomcat
		if (restart) {
			ChannelShell channelShell = channel.getChannelShell();
			if (channelShell != null) {

				// 获取输入流和输出流
				InputStream instream = channelShell.getInputStream();
				OutputStream outstream = channelShell.getOutputStream();

				// 发送需要执行的SHELL命令，需要用\n结尾，表示回车
				String shellCommand = "/data/app/" + tomcat + "/bin/stop.sh \n";
				outstream.write(shellCommand.getBytes());
				outstream.flush();
				// System.out.println("comm_1 >>> "+getCommRes(instream));

				// 缓冲时间
				System.out.println(">>> tomcat is bean stop");
				Thread.sleep(5 * 1000);

				// start
				shellCommand = "/data/app/" + tomcat + "/bin/up.sh \n";
				outstream.write(shellCommand.getBytes());
				outstream.flush();

				System.out.println(">>> tomcat is bean start");
				Thread.sleep(5 * 1000);

				shellCommand = "ps -ef|grep " + tomcat + " |grep -v grep \n";
				outstream.write(shellCommand.getBytes());
				outstream.flush();

				Thread.sleep(5 * 1000);
				System.out.println("linux: >>> \n" + getCommRes(instream));

				outstream.close();
				instream.close();

				channelShell.disconnect();
			}
		}

		chSftp.quit();
		channel.closeChannel();

		System.out.println(">>> >>> done ...... ");
	}

	private static String getCommRes(InputStream instream) throws UnsupportedEncodingException, IOException, Exception {
		// 获取命令执行的结果
		if (instream.available() > 0) {
			byte[] data = new byte[instream.available()];
			int nLen = instream.read(data);

			if (nLen < 0) {
				throw new Exception("network error.");
			}

			// 转换输出结果并打印出来
			String temp = new String(data, 0, nLen, "iso8859-1");
			return temp;
		}
		return "";
	}

	// src原文件； dst 目标目录
	public static void putDirectory(String src, String dst, ChannelSftp chSftp, String contain) throws SftpException {
		// 如果服务器目录不存在，需要创建目录
		try {
			chSftp.cd(dst);
		} catch (SftpException sException) {
			// sException.printStackTrace();
			if (ChannelSftp.SSH_FX_NO_SUCH_FILE == sException.id) {
				chSftp.mkdir(dst);
			}
		}
		//
		File file = new File(src);
		File[] dir = file.listFiles();
		// file是文件
		if (dir == null) {

			String f_type = getFileType(src);
			// 匹配上传文件类型
			if (contain.indexOf(f_type) > -1) {
				System.out.println(src + " >>> " + dst);
				// 上传
				// long fileSize = file.length();
				// chSftp.put(src, dst, new FileProgressMonitor(fileSize),
				// ChannelSftp.OVERWRITE);
				chSftp.put(src, dst, ChannelSftp.OVERWRITE);
			}
			return;
		}
		// 目录
		for (int i = 0; i < dir.length; i++) {
			File sub_file = dir[i];
			File[] sub_dir = sub_file.listFiles();
			// 文件
			if (sub_dir == null) {
				putDirectory(sub_file.getPath(), dst, chSftp, contain);
				continue;
			}
			// 目录 需要取目录名
			String sub_name = sub_file.getName();
			putDirectory(src + sub_name + "\\", dst + sub_name + "/", chSftp, contain);
			// System.out.println("subDitr:"+subDir);
		}
	}

	//
	public static String getFileType(String fileUri) {
		File file = new File(fileUri);
		String fileName = file.getName();
		String fileType = fileName.substring(fileName.lastIndexOf(".") + 1, fileName.length());
		return fileType;
	}

}
