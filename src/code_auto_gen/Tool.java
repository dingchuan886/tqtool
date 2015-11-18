package code_auto_gen;

public class Tool {
	public static String getClassName(String tableName) {
		boolean flag = false;
		String name = tableName;
		String Name = "";
		for (int i = 0; i < name.length(); i++) {
			char c = name.charAt(i);
			if (i == 0) {
				Name = String.valueOf(c).toUpperCase();
			} else {
				if (c == '_') {
					flag = true;
					continue;
				} else {
					if (flag == true) {
						Name = Name + String.valueOf(c).toUpperCase();
						flag = false;
					} else {
						Name = Name + String.valueOf(c);
					}
				}
			}
		}
		return Name;
	}

	public static void bufferAddNewLine(StringBuffer buffer, String a) {
		buffer.append(a);
		buffer.append("\n");
	}
}
