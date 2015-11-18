package code_auto_gen;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;
import java.util.Vector;

public class CodeAutoGen_117 {
	static String path = "C:\\Users\\wm\\Desktop\\315che\\daos\\";
	static Map<String, Integer> map = new HashMap<String, Integer>();

	public static void main(String[] args) throws Exception {
		String[] sqls = { "select * from dbo_dea_byschedulesenior where eid = ? and bydate >= ? and bydate <= ? and isdelete = 0" };
		for (int i = 0; i < sqls.length; i++) {
			String code = createSql(sqls[i]);
			System.out.println(code);
		}
	}

	public static void loadMethodMap() {
		map = new HashMap<String, Integer>();
		if (DB_Tool.conn == null) {
			DB_Tool.init();
		}
		String sql1 = "select methodName,real_method_name from tb_sql_auto order by methodName";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB_Tool.conn.prepareStatement(sql1);// 0
			for (rs = pstmt.executeQuery(); rs.next();) {
				String methodName = rs.getString(1);
				// 解析初始methodName
				String realMethodName = rs.getString(2);
				int seq = 1;
				if (methodName.equals(realMethodName)) {
					seq = 1;
				} else {
					seq = Integer.parseInt(methodName.replace(realMethodName, ""));
				}
				Object obj = map.get(realMethodName);
				if (obj == null) {
					map.put(realMethodName, new Integer(seq));
				} else {
					map.put(realMethodName, new Integer(seq));
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

		Set set = map.keySet();
		Iterator it = set.iterator();
		while (it.hasNext()) {
			String realMethodName = (String) it.next();
			Integer seq = map.get(realMethodName);
			System.out.println("realMethodName=" + realMethodName + " seq=" + seq.intValue());
		}

	}

	public static String checkSql(String sql, String tableName, int status, String methodName, String realMethodName) {
		int count = count(sql, tableName);
		if (count == 0) {
			DB_Tool.insert("insert into tb_sql_auto(table_name,`sql`,create_date,`status`,methodName,real_method_name) values('" + tableName + "','" + sql
					+ "',sysdate()," + status + ",'" + methodName + "','" + realMethodName + "')");
			return "";
		} else {
			return selectMethodName(sql, tableName);
		}
	}

	public static int count(String sql, String tableName) {
		if (DB_Tool.conn == null) {
			DB_Tool.init();
		}
		String sql1 = "select count(*) from tb_sql_auto where `sql`='" + sql + "' and table_name='" + tableName + "'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			pstmt = DB_Tool.conn.prepareStatement(sql1);// 0

			for (rs = pstmt.executeQuery(); rs.next();) {
				int count = rs.getInt(1);
				return count;
			}
			return -1;
		} catch (Exception e) {
			e.printStackTrace();
			return -1;
		} finally {

			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();

				}
		}

	}

	public static String selectMethodName(String sql, String tableName) {
		if (DB_Tool.conn == null) {
			DB_Tool.init();
		}
		String sql1 = "select methodName from tb_sql_auto where `sql`='" + sql + "' and table_name='" + tableName + "'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {

			pstmt = DB_Tool.conn.prepareStatement(sql1);// 0

			for (rs = pstmt.executeQuery(); rs.next();) {
				String methodName = rs.getString(1);
				return methodName;
			}
			return "";
		} catch (Exception e) {
			e.printStackTrace();
			return "";
		} finally {

			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();

				}
		}

	}

	/**
	 * @param sql
	 * @throws Exception
	 */
	public static String createSql(String sql) {
		try {
			if (sql == null || sql.equals("") || sql.length() < 5) {
				return "sql is null";
			}
			WhereTree.columnNameList = new ArrayList<String>();
			WhereTree.columnTypeList = new ArrayList<String>();
			WhereTree.columnRealNameList = new ArrayList<String>();
			ParseSelectSql.initVar();
			boolean flag = ParseSelectSql.parseSelect(sql);
			System.out.println("declare_var2=" + ParseSelectSql.declare_var);
			if (flag) {
				System.out.println("declare_var3=" + ParseSelectSql.declare_var);
				return printCode(ParseSelectSql.tableName, sql);

			} else {
				return "error";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "error";
	}

	public static String createComplicatedSql(String sql) {
		try {
			if (sql == null || sql.equals("") || sql.length() < 5) {
				return "sql is null";
			}
			WhereTree.columnNameList = new ArrayList<String>();
			WhereTree.columnTypeList = new ArrayList<String>();
			WhereTree.columnRealNameList = new ArrayList<String>();
			ParseComplicatedSelectSql.initVar();
			boolean flag = ParseComplicatedSelectSql.parseSelect(sql);
			if (flag) {
				return printSelectCode(ParseComplicatedSelectSql.tables, sql);
			} else {
				return "error";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "error";
	}

	public static String createUpdateSql(String sql) {
		try {
			if (sql == null || sql.equals("") || sql.length() < 5) {
				return "sql is null";
			}
			WhereTree.columnNameList = new ArrayList<String>();
			WhereTree.columnTypeList = new ArrayList<String>();
			WhereTree.columnRealNameList = new ArrayList<String>();
			ParseUpdateSql_117.initVar();
			boolean flag = ParseUpdateSql_117.parseUpdate(sql);
			if (flag) {
				return printUpdateCode(ParseUpdateSql_117.tableName, sql);

			} else {
				return "error";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "error";
	}

	private static String printUpdateCode(String tableName, String sql) throws Exception {

		StringBuffer bufferSql = new StringBuffer();

		Column column = ColumnUtil.selectColumn(tableName);
		String className = Tool.getClassName(tableName);

		Object obj = map.get(ParseUpdateSql_117.funcName);
		System.out.println("ParseUpdateSql_117.funcName1=" + ParseUpdateSql_117.funcName);
		String realMethodName = ParseUpdateSql_117.funcName;
		String oldMethodName = selectMethodName(sql, tableName);
		if (oldMethodName.equals("")) {
			int times = 0;
			if (obj == null) {
				map.put(ParseUpdateSql_117.funcName, new Integer(1));
			} else {
				Integer integer = (Integer) obj;
				times = integer.intValue();
				times++;
				map.put(ParseUpdateSql_117.funcName, new Integer(times));
				System.out.println("times=" + times);
				ParseUpdateSql_117.funcName = ParseUpdateSql_117.funcName + String.valueOf(times);
			}
			System.out.println("ParseUpdateSql_117.funcName2=" + ParseUpdateSql_117.funcName);
			// 检查该sql db是否存在
			checkSql(sql.trim(), ParseUpdateSql_117.tableName, 2, ParseUpdateSql_117.funcName, realMethodName);
		} else {
			ParseUpdateSql_117.funcName = oldMethodName;
		}
		String setFunctionParam = "";

		// 解析ParseUpdateSql_117.setColumn
		for (int i = 0; i < ParseUpdateSql_117.setColumn.size(); i++) {
			String columnName = ParseUpdateSql_117.setColumn.get(i);
			for (int j = 0; j < column.getNum(); j++) {
				String columnName1 = (String) column.getColumns()[j];
				columnName1 = columnName1.toLowerCase();

				String dataType = (String) column.getDataTypes()[j];
				if (columnName1.equals(columnName)) {
					if ((dataType.equals("varchar") || dataType.equals("char") || dataType.equals("text") || dataType.equals("blob") || dataType
							.equals("longtext"))) {
						setFunctionParam = setFunctionParam + "String " + columnName1 + ",";
					} else if (dataType.equals("timestamp") || dataType.equals("datetime") || dataType.equals("date")) {
						setFunctionParam = setFunctionParam + "String " + columnName1 + ",";
					} else if (dataType.equals("int") || dataType.equals("tinyint")) {
						setFunctionParam = setFunctionParam + "int " + columnName1 + ",";

					} else if (dataType.equals("bigint")) {
						setFunctionParam = setFunctionParam + "long " + columnName1 + ",";
					} else if (dataType.equals("decimal") || dataType.equals("double")) {
						setFunctionParam = setFunctionParam + "double " + columnName1 + ",";
					} else {
						throw new Exception();
					}
					break;
				} else {

				}
			}
		}
		setFunctionParam = setFunctionParam.substring(0, setFunctionParam.length() - 1);
		if (ParseUpdateSql_117.declare_var.length() > 0) {
			bufferAddNewLine(bufferSql, "	public static int " + ParseUpdateSql_117.funcName + "(" + setFunctionParam + "," + ParseUpdateSql_117.declare_var + "){");
		} else {
			bufferAddNewLine(bufferSql, "	public static int " + ParseUpdateSql_117.funcName + "(" + setFunctionParam + "){");
		}
		bufferAddNewLine(bufferSql, "	int result=EXECUTE_FAIL;");
		bufferAddNewLine(bufferSql, "	DBConnect dbc = null;");

		bufferAddNewLine(bufferSql, "	String sql = \"" + sql + "\";");
		bufferAddNewLine(bufferSql, "");
		bufferAddNewLine(bufferSql, "	try {");
		bufferAddNewLine(bufferSql, "		dbc = new DBConnect(sql);");
		int k = 0;
		// 解析ParseUpdateSql_117.setColumn
		for (int i = 0; i < ParseUpdateSql_117.setColumn.size(); i++) {
			String columnName = ParseUpdateSql_117.setColumn.get(i);
			for (int j = 0; j < column.getNum(); j++) {
				String columnName1 = (String) column.getColumns()[j];
				columnName1 = columnName1.toLowerCase();
				System.out.println(columnName1);
				String dataType = (String) column.getDataTypes()[j];
				if (columnName1.equals(columnName)) {
					k++;
					if ((dataType.equals("varchar") || dataType.equals("char") || dataType.equals("text") || dataType.equals("blob") || dataType
							.equals("longtext"))) {
						bufferAddNewLine(bufferSql, "		dbc.setString(" + k + ", " + columnName1 + ");");
					} else if (dataType.equals("timestamp") || dataType.equals("datetime") || dataType.equals("date")) {
						bufferAddNewLine(bufferSql, "		dbc.setString(" + k + ", " + columnName1 + ");");
					} else if (dataType.equals("int") || dataType.equals("tinyint")) {
						bufferAddNewLine(bufferSql, "		dbc.setInt(" + k + ", " + columnName1 + ");");
					} else if (dataType.equals("bigint")) {
						bufferAddNewLine(bufferSql, "		dbc.setLong(" + k + ", " + columnName1 + ");");
					} else if (dataType.equals("decimal") || dataType.equals("double")) {
						bufferAddNewLine(bufferSql, "		dbc.setDouble(" + k + ", " + columnName1 + ");");
					} else {
						throw new Exception();
					}
				}
			}
		}
		for (int i = 0; i < WhereTree.columnNameList.size(); i++) {
			k = k + 1;
			String type = WhereTree.columnTypeList.get(i);
			String name1 = WhereTree.columnNameList.get(i);
			if (type.equals("String")) {
				bufferAddNewLine(bufferSql, "		dbc.setInt(" + k + ", " + name1 + ");");
			} else if (type.equals("int")) {
				bufferAddNewLine(bufferSql, "		dbc.setInt(" + k + ", " + name1 + ");");
			} else if (type.equals("long")) {
				bufferAddNewLine(bufferSql, "		dbc.setLong(" + k + ", " + name1 + ");");
			} else if (type.equals("double")) {
				bufferAddNewLine(bufferSql, "		dbc.setDouble(" + k + ", " + name1 + ");");
			} else {
				throw new Exception();
			}

		}
		bufferAddNewLine(bufferSql, "		dbc.executeUpdate();");
		bufferAddNewLine(bufferSql, "		result = EXECUTE_SUCCESSS;");
		bufferAddNewLine(bufferSql, "	} catch (Exception e) {");
		bufferAddNewLine(bufferSql, "		e.printStackTrace();");
		bufferAddNewLine(bufferSql, "	} finally {");
		bufferAddNewLine(bufferSql, "		try {");
		bufferAddNewLine(bufferSql, "			if (dbc != null)");
		bufferAddNewLine(bufferSql, "				dbc.close();");
		bufferAddNewLine(bufferSql, "		} catch (Exception e) {");
		bufferAddNewLine(bufferSql, "			e.printStackTrace();");
		bufferAddNewLine(bufferSql, "		}");
		bufferAddNewLine(bufferSql, "	}");
		bufferAddNewLine(bufferSql, "	return result;");
		bufferAddNewLine(bufferSql, "	}");

		bufferAddNewLine(bufferSql, "");

		if (ParseUpdateSql_117.declare_var.length() > 0) {
			bufferAddNewLine(bufferSql, "	public static int " + ParseUpdateSql_117.funcName + "(DBConnect dbc," + setFunctionParam + ","
					+ ParseUpdateSql_117.declare_var + "){");
		} else {
			bufferAddNewLine(bufferSql, "	public static int " + ParseUpdateSql_117.funcName + "(DBConnect dbc," + setFunctionParam + "){");
		}
		bufferAddNewLine(bufferSql, "	int result=EXECUTE_FAIL;");
		bufferAddNewLine(bufferSql, "	String sql = \"" + sql + "\";");
		bufferAddNewLine(bufferSql, "");
		bufferAddNewLine(bufferSql, "	try {");

		bufferAddNewLine(bufferSql, "		dbc.prepareStatement(sql);");
		k = 0;
		// 解析ParseUpdateSql_117.setColumn
		for (int i = 0; i < ParseUpdateSql_117.setColumn.size(); i++) {
			String columnName = ParseUpdateSql_117.setColumn.get(i);
			for (int j = 0; j < column.getNum(); j++) {
				String columnName1 = (String) column.getColumns()[j];
				columnName1 = columnName1.toLowerCase();
				System.out.println(columnName1);
				String dataType = (String) column.getDataTypes()[j];
				if (columnName1.equals(columnName)) {
					k++;
					if ((dataType.equals("varchar") || dataType.equals("char") || dataType.equals("text") || dataType.equals("blob") || dataType
							.equals("longtext"))) {
						bufferAddNewLine(bufferSql, "		dbc.setString(" + k + ", " + columnName1 + ");");
					} else if (dataType.equals("timestamp") || dataType.equals("datetime") || dataType.equals("date")) {
						bufferAddNewLine(bufferSql, "		dbc.setString(" + k + ", " + columnName1 + ");");
					} else if (dataType.equals("int") || dataType.equals("tinyint")) {
						bufferAddNewLine(bufferSql, "		dbc.setInt(" + k + ", " + columnName1 + ");");
					} else if (dataType.equals("bigint")) {
						bufferAddNewLine(bufferSql, "		dbc.setLong(" + k + ", " + columnName1 + ");");
					} else if (dataType.equals("decimal") || dataType.equals("double")) {
						bufferAddNewLine(bufferSql, "		dbc.setDouble(" + k + ", " + columnName1 + ");");
					} else {
						throw new Exception();
					}
				}
			}
		}
		for (int i = 0; i < WhereTree.columnNameList.size(); i++) {
			k = k + 1;
			String type = WhereTree.columnTypeList.get(i);
			String name1 = WhereTree.columnNameList.get(i);
			if (type.equals("String")) {
				bufferAddNewLine(bufferSql, "		dbc.setInt(" + k + ", " + name1 + ");");
			} else if (type.equals("int")) {
				bufferAddNewLine(bufferSql, "		dbc.setInt(" + k + ", " + name1 + ");");
			} else if (type.equals("long")) {
				bufferAddNewLine(bufferSql, "		dbc.setLong(" + k + ", " + name1 + ");");
			} else if (type.equals("double")) {
				bufferAddNewLine(bufferSql, "		dbc.setDouble(" + k + ", " + name1 + ");");
			} else {
				throw new Exception();
			}

		}
		bufferAddNewLine(bufferSql, "		dbc.executeUpdate();");
		bufferAddNewLine(bufferSql, "		result = EXECUTE_SUCCESSS;");
		bufferAddNewLine(bufferSql, "	} catch (Exception e) {");
		bufferAddNewLine(bufferSql, "		e.printStackTrace();");
		bufferAddNewLine(bufferSql, "	}");
		bufferAddNewLine(bufferSql, "	return result;");
		bufferAddNewLine(bufferSql, "	}");

		Vector<String> vet = DbCodeAutoGen.map_code.get(tableName);
		if (vet != null) {
			vet.add(bufferSql.toString());
		}
		return bufferSql.toString();
	}

	private static String printCode(String tableName, String sql) throws Exception {

		StringBuffer bufferSql = new StringBuffer();
		StringBuffer bufferFunc = new StringBuffer();

		Column column = ColumnUtil.selectColumn(tableName);
		String cName = Tool.getClassName(tableName);
		String className = "" + cName;
		String realMethodName = ParseSelectSql.funcName;

		String oldMethodName = selectMethodName(sql, tableName);
		if (oldMethodName.equals("")) {
			System.out.println("ParseSelectSql.funcName1=" + ParseSelectSql.funcName);
			Object obj = map.get(ParseSelectSql.funcName);
			int times = 0;
			if (obj == null) {
				map.put(ParseSelectSql.funcName, new Integer(1));

			} else {
				Integer integer = (Integer) obj;
				times = integer.intValue();
				times++;
				System.out.println("times=" + times);
				map.put(ParseSelectSql.funcName, new Integer(times));
				ParseSelectSql.funcName = ParseSelectSql.funcName + String.valueOf(times);
			}
			System.out.println("ParseSelectSql.funcName2=" + ParseSelectSql.funcName);
			// 检查该sql db是否存在
			checkSql(sql.trim(), ParseSelectSql.tableName, 1, ParseSelectSql.funcName, realMethodName);
		} else {
			ParseSelectSql.funcName = oldMethodName;
		}

		bufferAddNewLine(bufferSql, "");
		if (ParseSelectSql.sqlType == 1 || ParseSelectSql.sqlType == 3) {
			if (ParseSelectSql.declare_var.length() > 0) {
				bufferAddNewLine(bufferSql, "	public static List<" + className + "> " + ParseSelectSql.funcName + "(" + ParseSelectSql.declare_var + "){");
			} else {
				bufferAddNewLine(bufferSql, "	public static List<" + className + "> " + ParseSelectSql.funcName + "(){");
			}
		} else if (ParseSelectSql.sqlType == 2) {
			bufferAddNewLine(bufferSql, "	public static int " + ParseSelectSql.funcName + "(" + ParseSelectSql.declare_var + "){");

		} else {
			throw new Exception();
		}

		bufferAddNewLine(bufferSql, "		DBConnect dbc = null;");
		bufferAddNewLine(bufferSql, "		String sql = \"" + sql + "\";");
		if (ParseSelectSql.sqlType == 1 || ParseSelectSql.sqlType == 3) {
			bufferAddNewLine(bufferSql, "		List<" + className + "> list = new ArrayList<" + className + ">();");
		}
		bufferAddNewLine(bufferSql, "	");
		bufferAddNewLine(bufferSql, "		try {");
		bufferAddNewLine(bufferSql, "			dbc = new DBConnect(sql);");
		for (int i = 0; i < WhereTree.columnNameList.size(); i++) {
			int j = i + 1;
			String type = WhereTree.columnTypeList.get(i);
			String name1 = WhereTree.columnRealNameList.get(i);
			if (type.equals("String")) {
				bufferAddNewLine(bufferSql, "			dbc.setString(" + j + ", " + name1 + ");");
			} else if (type.equals("int")) {
				bufferAddNewLine(bufferSql, "			dbc.setInt(" + j + ", " + name1 + ");");
			} else if (type.equals("long")) {
				bufferAddNewLine(bufferSql, "			dbc.setLong(" + j + ", " + name1 + ");");
			} else if (type.equals("double")) {
				bufferAddNewLine(bufferSql, "			dbc.setDouble(" + j + ", " + name1 + ");");
			} else {
				throw new Exception();
			}

		}

		bufferAddNewLine(bufferSql, "			ResultSet rs = dbc.executeQuery();");
		if (ParseSelectSql.sqlType == 1 || ParseSelectSql.sqlType == 3) {
			bufferAddNewLine(bufferSql, "			while (rs.next()) {");
			bufferAddNewLine(bufferSql, "				" + className + " obj = new " + className + "();");
			bufferAddNewLine(bufferSql, "				fill(rs, obj);");
			bufferAddNewLine(bufferSql, "				list.add(obj);");
			bufferAddNewLine(bufferSql, "			}");
			bufferAddNewLine(bufferSql, "		} catch (Exception e) {");
			bufferAddNewLine(bufferSql, "			e.printStackTrace();");
		} else if (ParseSelectSql.sqlType == 2) {
			bufferAddNewLine(bufferSql, "			while (rs.next()) {");
			bufferAddNewLine(bufferSql, "				return rs.getInt(1);");
			bufferAddNewLine(bufferSql, "			}");
			bufferAddNewLine(bufferSql, "			return -1;");
			bufferAddNewLine(bufferSql, "		} catch (Exception e) {");
			bufferAddNewLine(bufferSql, "			e.printStackTrace();");
			bufferAddNewLine(bufferSql, "			return -1;");

		}

		bufferAddNewLine(bufferSql, "		} finally {");
		bufferAddNewLine(bufferSql, "			try {");
		bufferAddNewLine(bufferSql, "				if (dbc != null)");
		bufferAddNewLine(bufferSql, "					dbc.close();");
		bufferAddNewLine(bufferSql, "			} catch (Exception e) {");
		bufferAddNewLine(bufferSql, "				e.printStackTrace();");
		bufferAddNewLine(bufferSql, "			}");
		bufferAddNewLine(bufferSql, "		}");
		if (ParseSelectSql.sqlType == 1 || ParseSelectSql.sqlType == 3) {
			bufferAddNewLine(bufferSql, "		return list;");
		} else if (ParseSelectSql.sqlType == 2) {
		}
		bufferAddNewLine(bufferSql, "	}");

		Vector<String> vet = DbCodeAutoGen.map_code.get(tableName);
		if (vet != null) {
			vet.add(bufferSql.toString());
		}
		return bufferSql.toString();

	}

	private static String printSelectCode(String[] tables, String sql) throws Exception {

		StringBuffer bufferSql = new StringBuffer();

		Column column = ColumnUtil.selectColumn(tables[0]);
		String cName = Tool.getClassName(tables[0]);
		String className = "" + cName;
		String realMethodName = ParseComplicatedSelectSql.funcName;

		String oldMethodName = selectMethodName(sql, tables[0]);
		if (oldMethodName.equals("")) {
			System.out.println("ParseComplicatedSelectSql.funcName1=" + ParseComplicatedSelectSql.funcName);
			Object obj = map.get(ParseComplicatedSelectSql.funcName);
			int times = 0;
			if (obj == null) {
				map.put(ParseComplicatedSelectSql.funcName, new Integer(1));

			} else {
				Integer integer = (Integer) obj;
				times = integer.intValue();
				times++;
				System.out.println("times=" + times);
				map.put(ParseComplicatedSelectSql.funcName, new Integer(times));
				ParseComplicatedSelectSql.funcName = ParseComplicatedSelectSql.funcName + String.valueOf(times);
			}
			System.out.println("ParseComplicatedSelectSql.funcName2=" + ParseComplicatedSelectSql.funcName);
			// 检查该sql db是否存在
			checkSql(sql.trim(), tables[0], 3, ParseComplicatedSelectSql.funcName, realMethodName);
		} else {
			ParseComplicatedSelectSql.funcName = oldMethodName;
		}
		System.out.println("ParseComplicatedSelectSql.declare_var=" + ParseComplicatedSelectSql.declare_var);
		bufferAddNewLine(bufferSql, "");
		if (ParseComplicatedSelectSql.declare_var.length() > 0) {
			bufferAddNewLine(bufferSql, "	public static List<" + className + "> " + ParseComplicatedSelectSql.funcName + "("
					+ ParseComplicatedSelectSql.declare_var + "){");
		} else {
			bufferAddNewLine(bufferSql, "	public static List<" + className + "> " + ParseComplicatedSelectSql.funcName + "(){");
		}

		bufferAddNewLine(bufferSql, "		DBConnect dbc = null;");
		bufferAddNewLine(bufferSql, "		String sql = \"" + ParseComplicatedSelectSql.realSql + "\";");
		bufferAddNewLine(bufferSql, "		List<" + className + "> list = new ArrayList<" + className + ">();");
		bufferAddNewLine(bufferSql, "	");
		bufferAddNewLine(bufferSql, "		try {");
		bufferAddNewLine(bufferSql, "			dbc = new DBConnect(sql);");
		for (int i = 0; i < ComplicatedWhereTree.columnNameList.size(); i++) {
			int j = i + 1;
			String type = ComplicatedWhereTree.columnTypeList.get(i);
			String name1 = ComplicatedWhereTree.columnNameList.get(i);
			if (type.equals("String")) {
				bufferAddNewLine(bufferSql, "			dbc.setString(" + j + ", " + name1 + ");");
			} else if (type.equals("int")) {
				bufferAddNewLine(bufferSql, "			dbc.setInt(" + j + ", " + name1 + ");");
			} else if (type.equals("long")) {
				bufferAddNewLine(bufferSql, "			dbc.setLong(" + j + ", " + name1 + ");");
			} else if (type.equals("double")) {
				bufferAddNewLine(bufferSql, "			dbc.setDouble(" + j + ", " + name1 + ");");
			} else {
				throw new Exception();
			}
		}
		bufferAddNewLine(bufferSql, "			ResultSet rs = dbc.executeQuery();");
		bufferAddNewLine(bufferSql, "			while (rs.next()) {");

		// fill
		// 根据2个表判断是否存在主外键关系
		if (ParseComplicatedSelectSql.tables.length != 2) {
			throw new Exception();
		}
		String relation = selectForeignRelation(ParseComplicatedSelectSql.tables[0], ParseComplicatedSelectSql.tables[1]);
		if (relation.length() == 0) {
			throw new Exception();
		}
		String foreignClassName1 = relation.split("#")[0];
		String foreignName = relation.split("#")[1];
		String objectMethod = foreignName.substring(0, 1).toUpperCase() + foreignName.substring(1);
		Column mainColmn = ParseComplicatedSelectSql.columns[0];
		Column foreiginColmmn = ParseComplicatedSelectSql.columns[1];

		String mainTableName = mainColmn.getTableName();
		String mainClassName = Tool.getClassName(mainTableName);
		String mainObjName = mainClassName.toLowerCase();
		String foreignTableName = foreiginColmmn.getTableName();
		String foreignClassName = Tool.getClassName(foreignTableName);
		String foreignObjName = foreignClassName.toLowerCase();
		if (foreignClassName1.equals(foreignClassName)) {

		} else {
			throw new Exception();
		}
		bufferAddNewLine(bufferSql, "				" + mainClassName + " " + mainObjName + " = new " + className + "();");
		for (int i = 0; i < mainColmn.getColumns().length; i++) {
			String columnName = (String) mainColmn.getColumns()[i];
			columnName = columnName.toLowerCase();
			String showName = ParseComplicatedSelectSql.getShowName(columnName, mainTableName);
			if (showName.equals("")) {
				throw new Exception();
			}

			String columnNameMethod = columnName.substring(0, 1).toUpperCase() + columnName.substring(1);
			String dataType = (String) mainColmn.getDataTypes()[i];
			if ((dataType.equals("varchar") || dataType.equals("char") || dataType.equals("text") || dataType.equals("blob") || dataType.equals("longtext"))) {
				bufferAddNewLine(bufferSql, "				" + mainObjName + ".set" + columnNameMethod + "(rs.getString(\"" + showName + "\"));");
			} else if (dataType.equals("timestamp") || dataType.equals("datetime") || dataType.equals("date")) {
				bufferAddNewLine(bufferSql, "				" + mainObjName + ".set" + columnNameMethod + "(rs.getTimestamp(\"" + showName + "\"));");
			} else if (dataType.equals("int") || dataType.equals("tinyint")) {
				bufferAddNewLine(bufferSql, "				" + mainObjName + ".set" + columnNameMethod + "(rs.getInt(\"" + showName + "\"));");
			} else if (dataType.equals("bigint")) {
				bufferAddNewLine(bufferSql, "				" + mainObjName + ".set" + columnNameMethod + "(rs.getLong(\"" + showName + "\"));");
			} else if (dataType.equals("decimal") || dataType.equals("double")) {
				bufferAddNewLine(bufferSql, "				" + mainObjName + ".set" + columnNameMethod + "(rs.getDouble(\"" + showName + "\"));");
			} else {

			}

		}

		bufferAddNewLine(bufferSql, "				" + foreignClassName + " " + foreignObjName + " = new " + foreignClassName + "();");
		for (int j = 0; j < foreiginColmmn.getColumns().length; j++) {
			String foreignColumnName = (String) foreiginColmmn.getColumns()[j];
			String foreignShowName = ParseComplicatedSelectSql.getShowName(foreignColumnName, foreignTableName);
			if (foreignShowName.equals("")) {
				throw new Exception();
			}

			String foreignColumnNameMethod = foreignColumnName.substring(0, 1).toUpperCase() + foreignColumnName.substring(1);
			String foreignDataType = (String) foreiginColmmn.getDataTypes()[j];
			if ((foreignDataType.equals("varchar") || foreignDataType.equals("char") || foreignDataType.equals("text") || foreignDataType.equals("blob") || foreignDataType
					.equals("longtext"))) {
				bufferAddNewLine(bufferSql, "				" + foreignObjName + ".set" + foreignColumnNameMethod + "(rs.getString(\"" + foreignShowName + "\"));");
			} else if (foreignDataType.equals("timestamp") || foreignDataType.equals("datetime") || foreignDataType.equals("date")) {
				bufferAddNewLine(bufferSql, "				" + foreignObjName + ".set" + foreignColumnNameMethod + "(rs.getTimestamp(\"" + foreignShowName + "\"));");
			} else if (foreignDataType.equals("int") || foreignDataType.equals("tinyint")) {
				bufferAddNewLine(bufferSql, "				" + foreignObjName + ".set" + foreignColumnNameMethod + "(rs.getInt(\"" + foreignShowName + "\"));");
			} else if (foreignDataType.equals("bigint")) {
				bufferAddNewLine(bufferSql, "				" + foreignObjName + ".set" + foreignColumnNameMethod + "(rs.getLong(\"" + foreignShowName + "\"));");
			} else if (foreignDataType.equals("decimal") || foreignDataType.equals("double")) {
				bufferAddNewLine(bufferSql, "				" + foreignObjName + ".set" + foreignColumnNameMethod + "(rs.getDouble(\"" + foreignShowName + "\"));");
			} else {

			}

		}
		bufferAddNewLine(bufferSql, "				" + mainObjName + ".set" + objectMethod + "(" + foreignObjName + ");");

		bufferAddNewLine(bufferSql, "				list.add(" + mainObjName + ");");
		bufferAddNewLine(bufferSql, "			}");
		bufferAddNewLine(bufferSql, "		} catch (Exception e) {");
		bufferAddNewLine(bufferSql, "			e.printStackTrace();");

		bufferAddNewLine(bufferSql, "		} finally {");
		bufferAddNewLine(bufferSql, "			try {");
		bufferAddNewLine(bufferSql, "				if (dbc != null)");
		bufferAddNewLine(bufferSql, "					dbc.close();");
		bufferAddNewLine(bufferSql, "			} catch (Exception e) {");
		bufferAddNewLine(bufferSql, "				e.printStackTrace();");
		bufferAddNewLine(bufferSql, "			}");
		bufferAddNewLine(bufferSql, "		}");
		bufferAddNewLine(bufferSql, "		return list;");
		bufferAddNewLine(bufferSql, "	}");

		Vector<String> vet = DbCodeAutoGen.map_code.get(mainTableName);
		if (vet != null) {
			vet.add(bufferSql.toString());
		}
		return bufferSql.toString();

	}

	public static String selectForeignRelation(String main_table, String foreign_table) {
		if (DB_Tool.conn == null) {
			DB_Tool.init();
		}
		StringBuffer sb = new StringBuffer();
		String sql = "select main_table,main_column,foreign_table,foreign_column,name from tb_foreign_relation where main_table='" + main_table
				+ "' and foreign_table='" + foreign_table + "'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB_Tool.conn.prepareStatement(sql);// 0
			for (rs = pstmt.executeQuery(); rs.next();) {
				String main_column = rs.getString(2);
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
				return className + "#" + columnName;
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
		return "#";
	}

	/**
	 * @param buffer
	 * @param a
	 */
	public static void bufferAddNewLine(StringBuffer buffer, String a) {
		buffer.append(a);
		buffer.append("\n");
	}

}
