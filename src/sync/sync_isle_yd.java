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
	// ��������ip���˿ڣ��û���������
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
//		src = "D:\\workspace_java\\dealer\\WebContent\\WEB-INF\\"; // �����ļ���
//		dst = "/data/app/tomcat1/webapps/dealer/WEB-INF/"; // Ŀ���ļ���
//		putDirectory(src, dst, chSftp, contain_ftl);
//
//		// class
//		src = "D:\\workspace_java\\dealer\\build\\classes\\"; // �����ļ���
//		dst = "/data/app/tomcat1/webapps/dealer/WEB-INF/classes/"; // Ŀ���ļ���
//		putDirectory(src, dst, chSftp, contain_class);
//		restart = true;

//		// html
		 src = "D:\\Apache2.2\\isle\\"; // �����ļ���
		 dst = "/data/app/apache2/isle/"; // Ŀ���ļ���
		 putDirectory(src, dst, chSftp, contain_html);

		
		// ����tomcat
		if (restart) {
			ChannelShell channelShell = channel.getChannelShell();
			if (channelShell != null) {

				// ��ȡ�������������
				InputStream instream = channelShell.getInputStream();
				OutputStream outstream = channelShell.getOutputStream();

				// ������Ҫִ�е�SHELL�����Ҫ��\n��β����ʾ�س�
				String shellCommand = "/data/app/tomcat1/bin/stop.sh \n";
				outstream.write(shellCommand.getBytes());
				outstream.flush();

				// ����ʱ��
				System.out.println(">>> tomcat is bean stop");
				Thread.sleep(7 * 1000);
				
				//
				shellCommand = "/data/app/tomcat1/bin/up.sh";
				outstream.write(shellCommand.getBytes());
				outstream.flush();

				System.out.println(">>> tomcat is bean start");

				// ��ȡ����ִ�еĽ��
				if (instream.available() > 0) {
					byte[] data = new byte[instream.available()];
					int nLen = instream.read(data);

					if (nLen < 0) {
						throw new Exception("network error.");
					}

					// ת������������ӡ����
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

	
	
	
	// srcԭ�ļ��� dst Ŀ��Ŀ¼
	public static void putDirectory(String src, String dst, ChannelSftp chSftp, String contain) throws SftpException {
		// ���������Ŀ¼�����ڣ���Ҫ����Ŀ¼
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
		// file���ļ�
		if (dir == null) {

			String f_type = getFileType(src);
			// ƥ���ϴ��ļ�����
			if (contain.indexOf(f_type) > -1) {
				System.out.println(src + " >>> " + dst);
				// �ϴ�
				// long fileSize = file.length();
				// chSftp.put(src, dst, new FileProgressMonitor(fileSize),
				// ChannelSftp.OVERWRITE);
				chSftp.put(src, dst, ChannelSftp.OVERWRITE);
			}
			return;
		}
		// Ŀ¼
		for (int i = 0; i < dir.length; i++) {
			File sub_file = dir[i];
			File[] sub_dir = sub_file.listFiles();
			// �ļ�
			if (sub_dir == null) {
				putDirectory(sub_file.getPath(), dst, chSftp, contain);
				continue;
			}
			// Ŀ¼ ��ҪȡĿ¼��
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
