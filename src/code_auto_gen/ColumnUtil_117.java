package code_auto_gen;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class ColumnUtil_117 {

	
	public static Column selectColumn(String table) {
		if (DB_Tool_117.conn == null) {
			DB_Tool_117.init();
		}

		String sql = "select column_name,data_type,column_type,COLUMN_COMMENT,column_default from information_schema.columns  where table_schema='"
				+ DB_Tool_117.sourceDB + "' and table_name='" + table + "'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Column col = new Column();
		try {

			pstmt = DB_Tool_117.conn.prepareStatement(sql);// 0
			Vector<String> vectorName = new Vector<String>();
			Vector<String> vectorDataType = new Vector<String>();
			Vector<String> vectorColumnType = new Vector<String>();
			Vector<String> vectorColumnComment = new Vector<String>();
			Vector<String> vectorColumnDefalut = new Vector<String>();
			for (rs = pstmt.executeQuery(); rs.next();) {
				String name = rs.getString(1).toLowerCase();
				String type = rs.getString(2).toLowerCase();
				String column = rs.getString(3).toLowerCase();
				String comment = rs.getString(4).toLowerCase();
				if (comment == null) {
					comment = "";
				} else {
					comment = comment.toLowerCase();
				}
				String default_value = rs.getString(5);
				if (default_value == null) {
					default_value = "";
				} else {
					default_value = default_value.toLowerCase();
				}
				vectorName.add(name);
				vectorDataType.add(type);
				vectorColumnType.add(column);
				vectorColumnComment.add(comment);
				vectorColumnDefalut.add(default_value);
			}
			col.setColumns(vectorName.toArray());
			col.setDataTypes(vectorDataType.toArray());
			col.setColumnTypes(vectorColumnType.toArray());
			col.setColumnComment(vectorColumnComment.toArray());
			col.setColumnDefalut(vectorColumnDefalut.toArray());
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < col.getColumns().length; i++) {
				sb.append(String.valueOf(col.getColumns()[i]).toLowerCase());
				if (i != col.getColumns().length - 1) {
					sb.append(",");
				}
			}
			StringBuffer sb1 = new StringBuffer();
			for (int i = 0; i < col.getColumns().length; i++) {
				sb1.append("`" + String.valueOf(col.getColumns()[i]).toLowerCase() + "`");
				if (i != col.getColumns().length - 1) {
					sb1.append(",");
				}
			}
			col.setColumnString(sb.toString());
			col.setColumnString1(sb1.toString());
			col.setNum(col.getColumns().length);
			col.setTableName(table);
			return col;
		} catch (Exception e) {
			e.printStackTrace();
			return null;
		} finally {

			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();

				}
		}

	}
}
