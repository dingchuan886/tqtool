package code_auto_gen;

import java.io.File;
import java.io.FileWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

public class FormGen {

	static String path = "D:\\zzz\\";
	static Map<String, Integer> map = new HashMap<String, Integer>();

	public static void main(String[] args) throws Exception {
		// String[] sqls = {
		// "select * from dbo_dea_byschedulesenior where eid = ? and bydate >= ? and bydate <= ? and isdelete = 0"
		// };
		// for (int i = 0; i < sqls.length; i++) {
		// String code = createSql(sqls[i]);
		// System.out.println(code);
		// }

//		genForm("dbo_new_news", "news");
//		genForm("dbo_new_content", "content");
		
		genForm("dbo_contentbak", "contentbak");
		

	}

	/**
	 * @param buffer
	 * @param a
	 */
	public static void genForm(String tab_name, String tab_alias) throws Exception {

		Column column = ColumnUtil.selectColumn(tab_name);
		String[] columnNames = column.getColumnString().toLowerCase()
				.split(",");
		System.out.print(column.getColumnString().toLowerCase());
		FileWriter fw = new FileWriter(new File(path + tab_alias + ".ftl"),
				false);
		StringBuffer buffer = new StringBuffer();
		for (String string : columnNames) {
			String idStr = tab_alias + "_" + string;
			String nameStr = tab_alias + "." + string;
			// <input id="news_newscatalogid" name="news.newscatalogid"
			// type="hidden" value="${(news.newscatalogid)!}" />
			buffer.append("<input id=\"" + idStr + "\" name=\"" + nameStr
					+ "\" type=\"hidden\" value=\"${(" + nameStr + ")!}\" />\n");
		}
		fw.write(buffer.toString());
		fw.close();
	}

}
