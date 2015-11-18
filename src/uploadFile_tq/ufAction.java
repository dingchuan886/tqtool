package uploadFile_tq;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;


public class ufAction {
	
	
	
	private String photoContentType;
	private String photoFileName;
	private File photo;

	private String tempPhoto;
	
	
	
	
//	public String uploadPagePic(){
//		if (!"image/jpeg".equals(photoContentType)) {
//			setErr( "<font color='red'>请上传一张图片作为头像</font>");
//			setAjax("error");
//			return AJAX;
//		}
//		//重命名
//		tempPhoto = newPhotoName(photoFileName);
//		//目录
//		 String dataDir = MyConfig.shopDisplayPath;
//         SimpleDateFormat f= new SimpleDateFormat("yyyyMMdd");
//         String dt = f.format(new Date());
//         String subpath = "/" + dt;
//         //
//         File dirname = new File(dataDir + subpath);
//         if  (!dirname.isDirectory()) 
//         {
//      	   dirname.mkdir();
//         }
//         
//         File savedFile = new File(dataDir + subpath, tempPhoto);
//		photo.renameTo(savedFile);
//		//插入数据库
//		String insertPic = "ct1/"+dt+"/"+tempPhoto;
//		
//		//返回到页面
//		setAjax(HtmlGenerator.urlPath+"/upload/"+dt+"/"+tempPhoto);
//		return AJAX;
//	}
	
	public static String newPhotoName(String fileName) {
		SimpleDateFormat sdf = new SimpleDateFormat("HHmmssSSS");
		return sdf.format(new Date()) + fileName.hashCode()
				+ fileName.substring(fileName.lastIndexOf("."));
	}
	
	
	
	
	

	public String getPhotoContentType() {
		return photoContentType;
	}

	public void setPhotoContentType(String photoContentType) {
		this.photoContentType = photoContentType;
	}

	public String getPhotoFileName() {
		return photoFileName;
	}

	public void setPhotoFileName(String photoFileName) {
		this.photoFileName = photoFileName;
	}

	public File getPhoto() {
		return photo;
	}

	public void setPhoto(File photo) {
		this.photo = photo;
	}


}
