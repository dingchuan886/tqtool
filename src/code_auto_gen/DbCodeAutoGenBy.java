package code_auto_gen;

import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

public class DbCodeAutoGenBy {

	// static String beanPath =
	// "C:\\Users\\wm\\Desktop\\dealer\\src\\com\\deity\\dealer\\beans\\";
	// static String daosPath =
	// "C:\\Users\\wm\\Desktop\\dealer\\src\\com\\deity\\dealer\\daos\\";

	public static Map<String, Vector<String>> map_code = new HashMap<String, Vector<String>>();

	// 数据库对应的dao代码，bean代码自动生成工具
	public static void main(String[] args) {
		try {
			SqlCodeAutoGen.map.clear();
			DB_Tool.init();
			String work = "bean";
			if (work.equals("bean")) {
				String beanPath = "C:\\Users\\wm\\Desktop\\car_beans\\";
				genBeanCode(beanPath);
			} else if (work.equals("dao")) {
				String daosPath = "C:\\Users\\wm\\Desktop\\car_daos\\";
				genDaoAll(daosPath);
			} else {
				String beanPath = "C:\\Users\\wm\\Desktop\\car_beans\\";
				genBeanCode(beanPath);
				String daosPath = "C:\\Users\\wm\\Desktop\\car_daos\\";
				genDaoAll(daosPath);
			}

		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @throws IOException
	 */
	private static void genDaoAll(String daosPath) throws IOException {
		genDaoCode(daosPath);
		selectSql();
		// 打印文件
		Set set = map_code.keySet();
		Iterator it = set.iterator();
		while (it.hasNext()) {
			String tableName = (String) it.next();
			String className = Tool.getClassName(tableName);
			FileWriter fw = new FileWriter(new File(daosPath + className + "Dao.java"), false);
			Vector<String> vet = map_code.get(tableName);
			for (int i = 0; i < vet.size(); i++) {
				fw.write((String) vet.get(i));
			}
			fw.write("}");
			fw.close();
		}
	}

	static String packageNameBean = "car_beans";
	static String packageNameDao = "car_daos";

	public static void selectForeignRelation(String tableName, StringBuffer buffer) {
		if (DB_Tool.conn == null) {
			DB_Tool.init();
		}
		StringBuffer sb = new StringBuffer();
		String sql = "select main_table,main_column,foreign_table,foreign_column,name from tb_foreign_relation where main_table='" + tableName + "'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			pstmt = DB_Tool.conn.prepareStatement(sql);// 0
			for (rs = pstmt.executeQuery(); rs.next();) {
				String main_column = rs.getString(2);
				String foreign_table = rs.getString(3);
				String foreign_column = rs.getString(4);
				String name = rs.getString(5);
				String className = Tool.getClassName(foreign_table);
				String columnName = "";
				if (name == null || name.equals("")) {
					columnName = main_column + "Obj";
				} else {
					columnName = name;
				}
				if (foreign_column == null) {
					className = foreign_table;
				}
				String columnNameMethod = columnName.substring(0, 1).toUpperCase() + columnName.substring(1);
				bufferAddNewLine(buffer, "	private " + className + " " + columnName + ";//");
				bufferAddNewLine(buffer, "	public void set" + columnNameMethod + "(" + className + " " + columnName + ")");
				bufferAddNewLine(buffer, "	{");
				bufferAddNewLine(buffer, "		this." + columnName + "=" + columnName + ";");
				bufferAddNewLine(buffer, "	}");
				bufferAddNewLine(buffer, "	public " + className + " get" + columnNameMethod + "()");
				bufferAddNewLine(buffer, "	{");
				bufferAddNewLine(buffer, "		return " + columnName + ";");
				bufferAddNewLine(buffer, "	}");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();

				}
		}

	}

	public static void genBeanCode(String path) {
		if (DB_Tool.conn == null) {
			DB_Tool.init();
		}

		StringBuffer sb = new StringBuffer();
		String sql = "select table_name from information_schema.tables  where table_schema='" + DB_Tool.sourceDB + "'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			pstmt = DB_Tool.conn.prepareStatement(sql);// 0
			for (rs = pstmt.executeQuery(); rs.next();) {
				String tableName = rs.getString(1);
				System.out.println(tableName);
				printBeanCode(path, tableName);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();

				}
		}

	}

	public static void genDaoCode(String daosPath) {
		if (DB_Tool.conn == null) {
			DB_Tool.init();
		}

		StringBuffer sb = new StringBuffer();
		String sql = "select table_name from information_schema.tables  where table_schema='" + DB_Tool.sourceDB + "'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			pstmt = DB_Tool.conn.prepareStatement(sql);// 0
			for (rs = pstmt.executeQuery(); rs.next();) {
				String tableName = rs.getString(1);
				System.out.println(tableName);
				printDaosCode(daosPath, tableName);
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();

				}
		}

	}

	public static void selectSql() {
		if (DB_Tool.conn == null) {
			DB_Tool.init();
		}

		StringBuffer sb = new StringBuffer();
		String sql = "select distinct `sql`,`status` from tb_sql_auto";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			pstmt = DB_Tool.conn.prepareStatement(sql);// 0
			for (rs = pstmt.executeQuery(); rs.next();) {
				String sql1 = rs.getString(1).trim();
				int status = rs.getInt(2);
				System.out.println(sql1);
				sql1 = sql1.substring(0, 7).toLowerCase() + sql1.substring(7, sql1.length());
				// 判断sql是select 还是update
				if (status == 3) {
					SqlCodeAutoGen.createComplicatedSql(sql1);
				} else if (status == 1) {
					SqlCodeAutoGen.createSql(sql1);
				} else if (status == 2) {
					SqlCodeAutoGen.createUpdateSql(sql1);
				} else {

				}

			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {

			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();

				}
		}

	}

	private static void printBeanCode(String beanPath, String tableName) {

		try {
			String className = Tool.getClassName(tableName);
			FileWriter fw = new FileWriter(new File(beanPath + className + ".java"), false);

			System.out.println(className);
			StringBuffer buffer = new StringBuffer();
			Column column = ColumnUtil.selectColumn(tableName);
			bufferAddNewLine(buffer, "package " + packageNameBean + ";");
			bufferAddNewLine(buffer, "import java.util.Date;");
			bufferAddNewLine(buffer, "");
			bufferAddNewLine(buffer, "public class  " + className + "{");
			bufferAddNewLine(buffer, "");
			// 打印 声明
			for (int i = 0; i < column.getColumns().length; i++) {
				String columnName = (String) column.getColumns()[i];
				String comment = (String) column.getColumnComment()[i];
				columnName = columnName.toLowerCase();
				System.out.println(columnName);
				String dataType = (String) column.getDataTypes()[i];
				String columnType = (String) column.getColumnTypes()[i];
				if ((dataType.equals("varchar") || dataType.equals("char") || dataType.equals("text") || dataType.equals("blob") || dataType.equals("longtext"))) {
					bufferAddNewLine(buffer, "	private String " + columnName + ";//" + comment);
				} else if (dataType.equals("timestamp") || dataType.equals("datetime") || dataType.equals("date")) {
					bufferAddNewLine(buffer, "	private Date " + columnName + ";//" + comment);

				} else if (dataType.equals("int") || dataType.equals("tinyint")) {
					bufferAddNewLine(buffer, "	private int " + columnName + ";//" + comment);

				} else if (dataType.equals("bigint")) {
					bufferAddNewLine(buffer, "	private long " + columnName + ";//" + comment);
				} else if (dataType.equals("decimal") || dataType.equals("double")) {
					bufferAddNewLine(buffer, "	private double " + columnName + ";//" + comment);
				} else {
				}
			}
			bufferAddNewLine(buffer, "");
			selectForeignRelation(tableName, buffer);
			bufferAddNewLine(buffer, "");

			// 生成get，set方法
			for (int i = 0; i < column.getColumns().length; i++) {
				String columnName = (String) column.getColumns()[i];
				columnName = columnName.toLowerCase();
				System.out.println(columnName);
				String columnNameMethod = columnName.substring(0, 1).toUpperCase() + columnName.substring(1);
				String dataType = (String) column.getDataTypes()[i];
				String columnType = (String) column.getColumnTypes()[i];
				if ((dataType.equals("varchar") || dataType.equals("char") || dataType.equals("text") || dataType.equals("blob") || dataType.equals("longtext"))) {
					bufferAddNewLine(buffer, "	public void set" + columnNameMethod + "(String " + columnName + ")");
					bufferAddNewLine(buffer, "	{");
					bufferAddNewLine(buffer, "		this." + columnName + "=" + columnName + ";");
					bufferAddNewLine(buffer, "	}");
					bufferAddNewLine(buffer, "	public String get" + columnNameMethod + "()");
					bufferAddNewLine(buffer, "	{");
					bufferAddNewLine(buffer, "		return " + columnName + ";");
					bufferAddNewLine(buffer, "	}");

				} else if (dataType.equals("timestamp") || dataType.equals("datetime") || dataType.equals("date")) {
					bufferAddNewLine(buffer, "	public void set" + columnNameMethod + "(Date " + columnName + ")");
					bufferAddNewLine(buffer, "	{");
					bufferAddNewLine(buffer, "		this." + columnName + "=" + columnName + ";");
					bufferAddNewLine(buffer, "	}");
					bufferAddNewLine(buffer, "	public Date get" + columnNameMethod + "()");
					bufferAddNewLine(buffer, "	{");
					bufferAddNewLine(buffer, "		return " + columnName + ";");
					bufferAddNewLine(buffer, "	}");

				} else if (dataType.equals("int") || dataType.equals("tinyint")) {
					bufferAddNewLine(buffer, "	public void set" + columnNameMethod + "(int " + columnName + ")");
					bufferAddNewLine(buffer, "	{");
					bufferAddNewLine(buffer, "		this." + columnName + "=" + columnName + ";");
					bufferAddNewLine(buffer, "	}");
					bufferAddNewLine(buffer, "	public int get" + columnNameMethod + "()");
					bufferAddNewLine(buffer, "	{");
					bufferAddNewLine(buffer, "		return " + columnName + ";");
					bufferAddNewLine(buffer, "	}");

				} else if (dataType.equals("bigint")) {
					bufferAddNewLine(buffer, "	public void set" + columnNameMethod + "(long " + columnName + ")");
					bufferAddNewLine(buffer, "	{");
					bufferAddNewLine(buffer, "		this." + columnName + "=" + columnName + ";");
					bufferAddNewLine(buffer, "	}");
					bufferAddNewLine(buffer, "	public long get" + columnNameMethod + "()");
					bufferAddNewLine(buffer, "	{");
					bufferAddNewLine(buffer, "		return " + columnName + ";");
					bufferAddNewLine(buffer, "	}");

				} else if (dataType.equals("decimal") || dataType.equals("double")) {
					bufferAddNewLine(buffer, "	public void set" + columnNameMethod + "(double " + columnName + ")");
					bufferAddNewLine(buffer, "	{");
					bufferAddNewLine(buffer, "		this." + columnName + "=" + columnName + ";");
					bufferAddNewLine(buffer, "	}");
					bufferAddNewLine(buffer, "	public double get" + columnNameMethod + "()");
					bufferAddNewLine(buffer, "	{");
					bufferAddNewLine(buffer, "		return " + columnName + ";");
					bufferAddNewLine(buffer, "	}");

				} else {
				}

			}
			bufferAddNewLine(buffer, "}");
			fw.write(buffer.toString());
			fw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private static void printDaosCode(String daosPath, String tableName) {
		String tmp = daosPath;

		Vector<String> vector = new Vector<String>();
		map_code.put(tableName, vector);
		try {
			String className = Tool.getClassName(tableName);
			FileWriter fw = new FileWriter(new File(daosPath + className + "Dao.java"), false);
			System.out.println(className);
			StringBuffer buffer = new StringBuffer();
			Column column = ColumnUtil.selectColumn(tableName);
			bufferAddNewLine(buffer, "package " + packageNameDao + ";");
			bufferAddNewLine(buffer, "import java.sql.*;");
			bufferAddNewLine(buffer, "import java.util.*;");
			bufferAddNewLine(buffer, "import " + packageNameBean + ".*;");
			bufferAddNewLine(buffer, "import " + packageNameDao + ".DBConnect;");
			bufferAddNewLine(buffer, "import " + packageNameBean + "." + className + ";");

			bufferAddNewLine(buffer, "");
			bufferAddNewLine(buffer, "public class  " + className + "Dao  extends BaseDao {");
			bufferAddNewLine(buffer, "");
			// 数据包装方法

			bufferAddNewLine(buffer, "	public static void fill(ResultSet rs, " + className + " " + className.toLowerCase() + ") throws SQLException {");

			for (int i = 0; i < column.getColumns().length; i++) {
				String columnName = (String) column.getColumns()[i];
				columnName = columnName.toLowerCase();
				System.out.println(columnName);
				String comment = (String) column.getColumnComment()[i];
				String columnNameMethod = columnName.substring(0, 1).toUpperCase() + columnName.substring(1);
				String dataType = (String) column.getDataTypes()[i];
				String columnType = (String) column.getColumnTypes()[i];
				if ((dataType.equals("varchar") || dataType.equals("char") || dataType.equals("text") || dataType.equals("blob") || dataType.equals("longtext"))) {
					bufferAddNewLine(buffer, "		" + className.toLowerCase() + ".set" + columnNameMethod + "(rs.getString(\"" + columnName + "\"));//" + comment);
				} else if (dataType.equals("timestamp") || dataType.equals("datetime") || dataType.equals("date")) {
					bufferAddNewLine(buffer, "		" + className.toLowerCase() + ".set" + columnNameMethod + "(rs.getTimestamp(\"" + columnName + "\"));//"
							+ comment);

				} else if (dataType.equals("int") || dataType.equals("tinyint")) {
					bufferAddNewLine(buffer, "		" + className.toLowerCase() + ".set" + columnNameMethod + "(rs.getInt(\"" + columnName + "\"));//" + comment);

				} else if (dataType.equals("bigint")) {
					bufferAddNewLine(buffer, "		" + className.toLowerCase() + ".set" + columnNameMethod + "(rs.getLong(\"" + columnName + "\"));//" + comment);
				} else if (dataType.equals("decimal") || dataType.equals("double")) {
					bufferAddNewLine(buffer, "		" + className.toLowerCase() + ".set" + columnNameMethod + "(rs.getDouble(\"" + columnName + "\"));//" + comment);
				} else {
				}

			}

			bufferAddNewLine(buffer, "	}");

			bufferAddNewLine(buffer, "");
			// 生成find方法
			bufferAddNewLine(buffer, "	public static List<" + className + "> find() {");
			bufferAddNewLine(buffer, "		DBConnect dbc = null;");
			bufferAddNewLine(buffer, "		String sql = \"select * from " + tableName + "\";");
			bufferAddNewLine(buffer, "		List<" + className + "> list = new ArrayList<" + className + ">();");
			bufferAddNewLine(buffer, "		");
			bufferAddNewLine(buffer, "		try {");
			bufferAddNewLine(buffer, "			dbc = new DBConnect(sql);");
			bufferAddNewLine(buffer, "			ResultSet rs = dbc.executeQuery();");
			bufferAddNewLine(buffer, "			while (rs.next()) {");
			bufferAddNewLine(buffer, "				" + className + " " + className.toLowerCase() + " = new " + className + "();");
			bufferAddNewLine(buffer, "				fill(rs, " + className.toLowerCase() + ");");
			bufferAddNewLine(buffer, "				list.add(" + className.toLowerCase() + ");");
			bufferAddNewLine(buffer, "			}");
			bufferAddNewLine(buffer, "		} catch (Exception e) {");
			bufferAddNewLine(buffer, "			e.printStackTrace();");
			bufferAddNewLine(buffer, "		} finally {");
			bufferAddNewLine(buffer, "			try {");
			bufferAddNewLine(buffer, "				if (dbc != null)");
			bufferAddNewLine(buffer, "					dbc.close();");
			bufferAddNewLine(buffer, "			} catch (Exception e) {");
			bufferAddNewLine(buffer, "				e.printStackTrace();");
			bufferAddNewLine(buffer, "			}");
			bufferAddNewLine(buffer, "		}");
			bufferAddNewLine(buffer, "		return list;");
			bufferAddNewLine(buffer, "		");
			bufferAddNewLine(buffer, "	}");
			bufferAddNewLine(buffer, "");

			bufferAddNewLine(buffer, "");
			// 生成where方法
			bufferAddNewLine(buffer, "	public static List<" + className + "> where(String subsql) {");
			bufferAddNewLine(buffer, "		DBConnect dbc = null;");
			bufferAddNewLine(buffer, "		String sql = \"select * from " + tableName + " where \"+subsql+\"\";");
			bufferAddNewLine(buffer, "		List<" + className + "> list = new ArrayList<" + className + ">();");
			bufferAddNewLine(buffer, "		");
			bufferAddNewLine(buffer, "		try {");
			bufferAddNewLine(buffer, "			dbc = new DBConnect(sql);");
			bufferAddNewLine(buffer, "			ResultSet rs = dbc.executeQuery();");
			bufferAddNewLine(buffer, "			while (rs.next()) {");
			bufferAddNewLine(buffer, "				" + className + " " + className.toLowerCase() + " = new " + className + "();");
			bufferAddNewLine(buffer, "				fill(rs, " + className.toLowerCase() + ");");
			bufferAddNewLine(buffer, "				list.add(" + className.toLowerCase() + ");");
			bufferAddNewLine(buffer, "			}");
			bufferAddNewLine(buffer, "		} catch (Exception e) {");
			bufferAddNewLine(buffer, "			e.printStackTrace();");
			bufferAddNewLine(buffer, "		} finally {");
			bufferAddNewLine(buffer, "			try {");
			bufferAddNewLine(buffer, "				if (dbc != null)");
			bufferAddNewLine(buffer, "					dbc.close();");
			bufferAddNewLine(buffer, "			} catch (Exception e) {");
			bufferAddNewLine(buffer, "				e.printStackTrace();");
			bufferAddNewLine(buffer, "			}");
			bufferAddNewLine(buffer, "		}");
			bufferAddNewLine(buffer, "		return list;");
			bufferAddNewLine(buffer, "		");
			bufferAddNewLine(buffer, "	}");
			bufferAddNewLine(buffer, "");

			// 生成where方法
			bufferAddNewLine(buffer, "	public static int whereCount(String subsql) {");
			bufferAddNewLine(buffer, "		DBConnect dbc = null;");
			bufferAddNewLine(buffer, "		int result = EXECUTE_FAIL;");
			bufferAddNewLine(buffer, "		String sql = \"select count(*) from " + tableName + " where \"+subsql+\"\";");
			bufferAddNewLine(buffer, "		");
			bufferAddNewLine(buffer, "		try {");
			bufferAddNewLine(buffer, "			dbc = new DBConnect(sql);");
			bufferAddNewLine(buffer, "			ResultSet rs = dbc.executeQuery();");
			bufferAddNewLine(buffer, "			while (rs.next()) {");
			bufferAddNewLine(buffer, "				return rs.getInt(1);");
			bufferAddNewLine(buffer, "			}");
			bufferAddNewLine(buffer, "			return EXECUTE_FAIL;");
			bufferAddNewLine(buffer, "		} catch (Exception e) {");
			bufferAddNewLine(buffer, "			e.printStackTrace();");
			bufferAddNewLine(buffer, "		} finally {");
			bufferAddNewLine(buffer, "			try {");
			bufferAddNewLine(buffer, "				if (dbc != null)");
			bufferAddNewLine(buffer, "					dbc.close();");
			bufferAddNewLine(buffer, "			} catch (Exception e) {");
			bufferAddNewLine(buffer, "				e.printStackTrace();");
			bufferAddNewLine(buffer, "			}");
			bufferAddNewLine(buffer, "		}");
			bufferAddNewLine(buffer, "		return result;");
			bufferAddNewLine(buffer, "		");
			bufferAddNewLine(buffer, "	}");
			bufferAddNewLine(buffer, "");

			bufferAddNewLine(buffer, "");
			// 生成delete方法
			bufferAddNewLine(buffer, "	public static int delete(String subsql) {");
			bufferAddNewLine(buffer, "		int result = EXECUTE_FAIL;");
			bufferAddNewLine(buffer, "		DBConnect dbc = null;");
			bufferAddNewLine(buffer, "		String sql = \"delete from " + tableName + " where \"+subsql+\"\";");
			bufferAddNewLine(buffer, "		try {");
			bufferAddNewLine(buffer, "			dbc = new DBConnect();");
			bufferAddNewLine(buffer, "			dbc.prepareStatement(sql);");
			bufferAddNewLine(buffer, "			dbc.executeUpdate();");
			bufferAddNewLine(buffer, "			dbc.close();");
			bufferAddNewLine(buffer, "			result = EXECUTE_SUCCESSS;");
			bufferAddNewLine(buffer, "		} catch (Exception e) {");
			bufferAddNewLine(buffer, "			e.printStackTrace();");
			bufferAddNewLine(buffer, "		} finally {");
			bufferAddNewLine(buffer, "			try {");
			bufferAddNewLine(buffer, "				if (dbc != null)");
			bufferAddNewLine(buffer, "					dbc.close();");
			bufferAddNewLine(buffer, "			} catch (Exception e) {");
			bufferAddNewLine(buffer, "				e.printStackTrace();");
			bufferAddNewLine(buffer, "			}");
			bufferAddNewLine(buffer, "		}");
			bufferAddNewLine(buffer, "		return result;");
			bufferAddNewLine(buffer, "		");
			bufferAddNewLine(buffer, "	}");
			bufferAddNewLine(buffer, "");

			// 生成delete方法
			bufferAddNewLine(buffer, "	public static int delete(DBConnect dbc,String subsql) {");
			bufferAddNewLine(buffer, "		int result = EXECUTE_FAIL;");
			bufferAddNewLine(buffer, "		String sql = \"delete from " + tableName + " where \"+subsql+\"\";");
			bufferAddNewLine(buffer, "		try {");
			bufferAddNewLine(buffer, "			dbc.prepareStatement(sql);");
			bufferAddNewLine(buffer, "			dbc.executeUpdate();");
			bufferAddNewLine(buffer, "			result = EXECUTE_SUCCESSS;");
			bufferAddNewLine(buffer, "		} catch (Exception e) {");
			bufferAddNewLine(buffer, "			e.printStackTrace();");
			bufferAddNewLine(buffer, "		}");
			bufferAddNewLine(buffer, "		return result;");
			bufferAddNewLine(buffer, "		");
			bufferAddNewLine(buffer, "	}");
			bufferAddNewLine(buffer, "");

			String value = "";
			for (int i = 0; i < column.getNum(); i++) {
				value = value + "?,";
			}
			String columnString = "";
			for (int i = 0; i < column.getNum(); i++) {
				String columnName = (String) column.getColumns()[i];
				columnName = columnName.toLowerCase();
				columnString = columnString + "`" + columnName + "`,";
			}
			columnString = columnString.substring(0, columnString.length() - 1);
			System.out.println("className=" + className + " value=" + value);
			value = value.substring(0, value.length() - 1);
			// 打印
			String objClassName = className.toLowerCase();
			bufferAddNewLine(buffer, "	public static int save(" + className + " " + className.toLowerCase() + ") throws Exception {");
			bufferAddNewLine(buffer, "		int result = EXECUTE_FAIL;");
			bufferAddNewLine(buffer, "		DBConnect dbc = null;");
			bufferAddNewLine(buffer, "		String sql = \"insert into " + tableName + "(" + columnString + ") values(" + value + ")\";");
			bufferAddNewLine(buffer, "		dbc = new DBConnect();");
			bufferAddNewLine(buffer, "		dbc.prepareStatement(sql);");
			int k = 0;
			for (int i = 0; i < column.getNum(); i++) {
				k++;
				String columnName = (String) column.getColumns()[i];
				String comment = (String) column.getColumnComment()[i];
				columnName = columnName.toLowerCase();
				System.out.println(columnName);
				String dataType = (String) column.getDataTypes()[i];
				String columnNameMethod = columnName.substring(0, 1).toUpperCase() + columnName.substring(1);
				if ((dataType.equals("varchar") || dataType.equals("char") || dataType.equals("text") || dataType.equals("blob") || dataType.equals("longtext"))) {
					bufferAddNewLine(buffer, "		dbc.setString(" + k + ", " + objClassName + ".get" + columnNameMethod + "());");
				} else if (dataType.equals("timestamp") || dataType.equals("datetime") || dataType.equals("date")) {
					bufferAddNewLine(buffer, "		dbc.setTimestamp(" + k + ", new Timestamp(" + objClassName + ".get" + columnNameMethod + "().getTime()));");
				} else if (dataType.equals("int") || dataType.equals("tinyint")) {
					bufferAddNewLine(buffer, "		dbc.setInt(" + k + ", " + objClassName + ".get" + columnNameMethod + "());");
				} else if (dataType.equals("bigint")) {
					bufferAddNewLine(buffer, "		dbc.setLong(" + k + ", " + objClassName + ".get" + columnNameMethod + "());");
				} else if (dataType.equals("decimal") || dataType.equals("double")) {
					bufferAddNewLine(buffer, "		dbc.setDouble(" + k + ", " + objClassName + ".get" + columnNameMethod + "());");
				} else {

				}

			}
			bufferAddNewLine(buffer, "		dbc.executeUpdate();");
			bufferAddNewLine(buffer, "		dbc.close();");
			bufferAddNewLine(buffer, "		result = EXECUTE_SUCCESSS;");
			bufferAddNewLine(buffer, "		return result;");
			bufferAddNewLine(buffer, "	}");
			bufferAddNewLine(buffer, "");

			bufferAddNewLine(buffer, "	public static int save(DBConnect dbc," + className + " " + className.toLowerCase() + ") throws Exception {");
			bufferAddNewLine(buffer, "		int result = EXECUTE_FAIL;");
			bufferAddNewLine(buffer, "		String sql = \"insert into " + tableName + "(" + columnString + ") values(" + value + ")\";");
			bufferAddNewLine(buffer, "		dbc.prepareStatement(sql);");
			k = 0;
			for (int i = 0; i < column.getNum(); i++) {
				k++;
				String columnName = (String) column.getColumns()[i];
				String comment = (String) column.getColumnComment()[i];
				columnName = columnName.toLowerCase();
				System.out.println(columnName);
				String dataType = (String) column.getDataTypes()[i];
				String columnNameMethod = columnName.substring(0, 1).toUpperCase() + columnName.substring(1);
				if ((dataType.equals("varchar") || dataType.equals("char") || dataType.equals("text") || dataType.equals("blob") || dataType.equals("longtext"))) {
					bufferAddNewLine(buffer, "		dbc.setString(" + k + ", " + objClassName + ".get" + columnNameMethod + "());");
				} else if (dataType.equals("timestamp") || dataType.equals("datetime") || dataType.equals("date")) {
					bufferAddNewLine(buffer, "		dbc.setTimestamp(" + k + ", new Timestamp(" + objClassName + ".get" + columnNameMethod + "().getTime()));");
				} else if (dataType.equals("int") || dataType.equals("tinyint")) {
					bufferAddNewLine(buffer, "		dbc.setInt(" + k + ", " + objClassName + ".get" + columnNameMethod + "());");
				} else if (dataType.equals("bigint")) {
					bufferAddNewLine(buffer, "		dbc.setLong(" + k + ", " + objClassName + ".get" + columnNameMethod + "());");
				} else if (dataType.equals("decimal") || dataType.equals("double")) {
					bufferAddNewLine(buffer, "		dbc.setDouble(" + k + ", " + objClassName + ".get" + columnNameMethod + "());");
				} else {

				}

			}
			bufferAddNewLine(buffer, "		dbc.executeUpdate();");
			bufferAddNewLine(buffer, "		result = EXECUTE_SUCCESSS;");
			bufferAddNewLine(buffer, "		return result;");
			bufferAddNewLine(buffer, "	}");
			bufferAddNewLine(buffer, "");
			vector.add(buffer.toString());
			// bufferAddNewLine(buffer, "}");
			// fw.write(buffer.toString());
			// fw.close();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	private static void bufferAddNewLine(StringBuffer buffer, String line) {
		buffer.append(line);
		buffer.append("\n");
	}

}
