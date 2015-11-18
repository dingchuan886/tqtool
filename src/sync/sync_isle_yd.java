package sync;

import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.HashMap;
import java.util.Map;

import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.ChannelShell;
import com.jcraft.jsch.SftpException;

public class sync_isle_yd {

	private static final String contain_ftl = "ftl";// |jar|xml
	private static final String contain_class = "class|xml";
	private static final String contain_html = "swf|xml"; //"css|js|xml|jpg|png|gif";
	// 设置主机ip，端口，用户名，密码
	private static Map<String, String> sftpDetails_128;

	static {
		sftpDetails_128 = new HashMap<String, String>();
		sftpDetails_128.put(SFTPConstants.SFTP_REQ_HOST, "114.215.104.128");
		sftpDetails_128.put(SFTPConstants.SFTP_REQ_USERNAME, "root");
		sftpDetails_128.put(SFTPConstants.SFTP_REQ_PASSWORD, "qiandao");
		sftpDetails_128.put(SFTPConstants.SFTP_REQ_PORT, "22");
	}

	public static void main(String[] args) throws Exception {

		SFTPTest test = new SFTPTest();

		Map<String, String> sftpDetails = sftpDetails_128;

		SFTPChannel channel = test.getSFTPChannel();
		ChannelSftp chSftp = channel.getChannel(sftpDetails, 60000);

		System.out.println(">>> >>> begin ...... ");

		Boolean restart = false;

		String src = "";
		String dst = "";
		/************************** dealeradm **************************/
//		// ftl
//		src = "D:\\workspace_java\\dealer\\WebContent\\WEB-INF\\"; // 本地文件名
//		dst = "/data/app/tomcat1/webapps/dealer/WEB-INF/"; // 目标文件名
//		putDirectory(src, dst, chSftp, contain_ftl);
//
//		// class
//		src = "D:\\workspace_java\\dealer\\build\\classes\\"; // 本地文件名
//		dst = "/data/app/tomcat1/webapps/dealer/WEB-INF/classes/"; // 目标文件名
//		putDirectory(src, dst, chSftp, contain_class);
//		restart = true;

//		// html
		 src = "D:\\Apache2.2\\isle\\"; // 本地文件名
		 dst = "/data/app/apache2/isle/"; // 目标文件名
		 putDirectory(src, dst, chSftp, contain_html);

		
		// 重启tomcat
		if (restart) {
			ChannelShell channelShell = channel.getChannelShell();
			if (channelShell != null) {

				// 获取输入流和输出流
				InputStream instream = channelShell.getInputStream();
				OutputStream outstream = channelShell.getOutputStream();

				// 发送需要执行的SHELL命令，需要用\n结尾，表示回车
				String shellCommand = "/data/app/tomcat1/bin/stop.sh \n";
				outstream.write(shellCommand.getBytes());
				outstream.flush();

				// 缓冲时间
				System.out.println(">>> tomcat is bean stop");
				Thread.sleep(7 * 1000);
				
				//
				shellCommand = "/data/app/tomcat1/bin/up.sh";
				outstream.write(shellCommand.getBytes());
				outstream.flush();

				System.out.println(">>> tomcat is bean start");

				// 获取命令执行的结果
				if (instream.available() > 0) {
					byte[] data = new byte[instream.available()];
					int nLen = instream.read(data);

					if (nLen < 0) {
						throw new Exception("network error.");
					}

					// 转换输出结果并打印出来
					String temp = new String(data, 0, nLen, "iso8859-1");
					System.out.println(temp);
				}
				outstream.close();
				instream.close();

				channelShell.disconnect();
			}
		}

		chSftp.quit();
		channel.closeChannel();

		System.out.println(">>> >>> done ...... ");
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
