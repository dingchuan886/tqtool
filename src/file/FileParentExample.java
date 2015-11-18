package file;

import java.io.File;

public class FileParentExample {

	public static void main(String[] args){
		System.out.println("sdfsdf");
		File f = new File("D:\\Apache2.2\\chetuan\\upload\\20140814\\162543311-882831749.jpg");
		
		System.out.println("--->"+f.getParent());
	}
}
