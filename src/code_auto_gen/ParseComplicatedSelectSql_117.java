package code_auto_gen;

import java.io.File;
import java.io.FileWriter;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Set;
import java.util.Vector;

public class ParseComplicatedSelectSql_117 {

	public static String realSql = "";
	public static String param_var = "";
	public static String column_var = "";
	public static String declare_var = "";
	public static String select_stmt = "";
	public static String from_stmt = "";
	public static String where_stmt = "";
	public static String groupby_stmt = "";
	public static String orderby_stmt = "";
	public static String limit_stmt = "";
	public static String forupdate_stmt = "";
	public static int sqlType = 0; // 1基本sql 2 * 3复杂sql
	public static String className = "";
	public static String funcName = "";
	public static String columnDone = "";
	public static String tableName = "";
	public static String[] tables = null;
	public static String[] alias_tables = null;
	public static Column[] columns = null;

	public static Vector<SelectColumn> selectColumnVector = null;

	public static void initVar() {
		select_stmt = "";
		from_stmt = "";
		where_stmt = "";
		groupby_stmt = "";
		orderby_stmt = "";
		limit_stmt = "";
		forupdate_stmt = "";
		realSql = "";
		param_var = "";
		sqlType = 0;
		className = "";
		funcName = "";
		columnDone = "";
		declare_var = "";
		tableName = "";
		column_var = "";
		selectColumnVector = new Vector<SelectColumn>();
		tables = null;
		alias_tables = null;
		columns = null;
	}

	public static String getShowName(String columnName, String tableName) {
		for (int i = 0; i < selectColumnVector.size(); i++) {
			SelectColumn sc = selectColumnVector.get(i);
			if (sc.columnName.equals(columnName) && sc.tableName.equals(tableName)) {
				return sc.showName;
			}
		}
		return "";
	}

	public static String selectForeignRelation(String main_table, String foreign_table) {
		if (DB_Tool_117.conn == null) {
			DB_Tool_117.init();
		}
		StringBuffer sb = new StringBuffer();
		String sql = "select main_table,main_column,foreign_table,foreign_column,name from tb_foreign_relation where main_table='" + main_table
				+ "' and foreign_table='" + foreign_table + "'";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB_Tool_117.conn.prepareStatement(sql);// 0
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

	public static boolean parseSelect(String sql) throws Exception {

		// 解析的思路
		/*
		 * 1.分解 2.获取select_stmt 等信息 3.结果集放入，第一列包含表.字段名 列表，后面就是字段内容
		 * 4.解析结果，放入bean中
		 */
		ComplicatedWhereTree.init();
		// 先找到table和别名
		String select_stmt = "";
		String from_stmt = "";
		String where_stmt = "";
		String groupby_stmt = "";
		String orderby_stmt = "";
		String limit_stmt = "";
		String forupdate_stmt = "";

		int selectPos = sql.indexOf("select ");
		if (selectPos < 0) {
			return false;
		}
		int fromPos = sql.indexOf("from ");
		if (fromPos < 0) {
			return false;
		}

		select_stmt = sql.substring(selectPos + 7, fromPos);
		int wherePos = sql.indexOf("where ");
		if (wherePos > 0) {
			if (from_stmt.length() == 0) {
				from_stmt = sql.substring(fromPos + 5, wherePos);
			}
		} else {

		}
		int groupbyPos1 = sql.indexOf(" group ");
		int groupbyPos = 0;
		if (groupbyPos1 > 0) {
			groupbyPos = sql.indexOf("by ", groupbyPos1);
			if (wherePos > 0) {
				where_stmt = sql.substring(wherePos + 6, groupbyPos1);
			}
			if (from_stmt.length() == 0) {
				from_stmt = sql.substring(fromPos + 5, groupbyPos1);
			}
		} else {

		}
		int orderbyPos1 = sql.indexOf("order ");
		int orderbyPos = 0;
		if (orderbyPos1 > 0) {
			orderbyPos = sql.indexOf("by ", orderbyPos1);
			if (wherePos > 0 && where_stmt.length() == 0) {
				where_stmt = sql.substring(wherePos + 6, orderbyPos1);
			}
			if (groupbyPos > 0 && groupby_stmt.length() == 0) {
				groupby_stmt = sql.substring(groupbyPos + 3, orderbyPos1);
			}
			if (from_stmt.length() == 0) {
				from_stmt = sql.substring(fromPos + 5, orderbyPos1);
			}
		} else {

		}
		int forupdatePos = sql.indexOf("for ");
		int limitPos = sql.indexOf("limit ");
		if (forupdatePos > 0) {
			if (wherePos > 0 && where_stmt.length() == 0) {
				where_stmt = sql.substring(wherePos + 6, forupdatePos);
			}
			if (groupbyPos > 0 && groupby_stmt.length() == 0) {
				groupby_stmt = sql.substring(groupbyPos + 3, forupdatePos);
			}
			if (orderbyPos > 0 && orderby_stmt.length() == 0) {
				orderby_stmt = sql.substring(orderbyPos + 3, forupdatePos);
			}
			if (from_stmt.length() == 0) {
				from_stmt = sql.substring(fromPos + 5, forupdatePos);
			}
			forupdate_stmt = "for update";
		} else if (limitPos > 0) {
			if (wherePos > 0 && where_stmt.length() == 0) {
				where_stmt = sql.substring(wherePos + 6, limitPos);
			}
			if (groupbyPos > 0 && groupby_stmt.length() == 0) {
				groupby_stmt = sql.substring(groupbyPos + 3, limitPos);
			}
			if (orderbyPos > 0 && orderby_stmt.length() == 0) {
				orderby_stmt = sql.substring(orderbyPos + 3, limitPos);
			}
			if (from_stmt.length() == 0) {
				from_stmt = sql.substring(fromPos + 5, limitPos);
			}
			limit_stmt = sql.substring(limitPos + 6, sql.length());
		} else {
			if (wherePos > 0 && where_stmt.length() == 0) {
				where_stmt = sql.substring(wherePos + 6, sql.length());
			}
			if (groupbyPos > 0 && groupby_stmt.length() == 0) {
				groupby_stmt = sql.substring(groupbyPos + 3, sql.length());
			}
			if (orderbyPos > 0 && orderby_stmt.length() == 0) {
				orderby_stmt = sql.substring(orderbyPos + 3, sql.length());
			}
			if (from_stmt.length() == 0) {
				from_stmt = sql.substring(fromPos + 5, sql.length());
			}
		}
		select_stmt = select_stmt.trim();
		from_stmt = from_stmt.trim();
		where_stmt = where_stmt.trim();
		groupby_stmt = groupby_stmt.trim();
		orderby_stmt = orderby_stmt.trim();
		limit_stmt = limit_stmt.trim();
		forupdate_stmt = forupdate_stmt.trim();
		System.out.println("select=" + select_stmt);
		System.out.println("from=" + from_stmt);
		System.out.println("where=" + where_stmt);
		System.out.println("group=" + groupby_stmt);
		System.out.println("order=" + orderby_stmt);
		System.out.println("limit=" + limit_stmt);
		System.out.println("forupdate=" + forupdate_stmt);

		String[] tablesAndAliass = {};
		String[] selectColumns = {};
		String limitNum = "";
		String limitBegin = "";

		if (select_stmt.length() > 0) {
			selectColumns = select_stmt.split(",");
		}

		if (from_stmt.length() > 0) {
			// 分析包含几个表
			tablesAndAliass = from_stmt.split(",");
			int tableSize = tablesAndAliass.length;
			columns = new Column[tableSize];
			alias_tables = new String[tablesAndAliass.length];
			tables = new String[tablesAndAliass.length];
			for (int i = 0; i < tablesAndAliass.length; i++) {
				String tablesAndAlias = tablesAndAliass[i].trim();
				int aliasPos = tablesAndAlias.indexOf(" ");
				if (aliasPos > 0) {
					alias_tables[i] = tablesAndAlias.substring(aliasPos, tablesAndAlias.length()).trim();
					tables[i] = tablesAndAlias.substring(0, aliasPos).trim();
				} else {
					tables[i] = tablesAndAlias;
					alias_tables[i] = "";
				}
				System.out.println("tables[" + i + "]=" + tables[i]);
				System.out.println("alias_tables[" + i + "]=" + alias_tables[i]);
				columns[i] = ColumnUtil_117.selectColumn(tables[i]);
			}
		}

		// 解析tables是否存在主外键关系
		HashMap<String, TableRelation> tableRelMap = new HashMap<String, TableRelation>();
		for (int i = 0; i < tables.length; i++) {
			String tableName1 = tables[i];
			for (int j = 0; j < tables.length; j++) {
				String tableName2 = tables[j];
				if (i != j) {
					String result = selectForeignRelation(tableName1, tableName2);
					setMap(tableRelMap, tableName1, tableName2, result);
					result = selectForeignRelation(tableName2, tableName1);
					setMap(tableRelMap, tableName2, tableName1, result);
				}
			}
		}

		Set set = tableRelMap.keySet();
		Iterator it = set.iterator();
		while (it.hasNext()) {
			String tableName = (String) it.next();
			TableRelation tr = tableRelMap.get(tableName);
			System.out.println("parentName=" + tr.parentName + " tableName=" + tr.tableName + " childName=" + tr.childName.toString());
		}

		if (limit_stmt.length() > 0) {
			int limitPos1 = limit_stmt.indexOf(",");
			if (limitPos1 > 0) {
				limitNum = from_stmt.substring(limitPos1, limit_stmt.length()).trim();
				limitBegin = limit_stmt.substring(0, limitPos1).trim();
			} else {
				limitNum = limit_stmt;
			}
		}

		for (int i = 0; i < selectColumns.length; i++) {
			System.out.println("columns=" + selectColumns[i]);
			String selectColumn = selectColumns[i].trim().toLowerCase();
			String aliasName = "";
			String showName = "";
			String columnName = "";
			// 判断每个select字符串是否有别名修饰
			if (selectColumn.indexOf(" as ") > 0) {
				String tableAliasColumn = selectColumn.substring(0, selectColumn.indexOf(" as ")).trim();
				showName = selectColumn.substring(selectColumn.indexOf(" as ") + 4).trim();
				// 查看是否有别名
				if (tableAliasColumn.indexOf(".") > 0) {
					aliasName = tableAliasColumn.substring(0, tableAliasColumn.indexOf(".")).trim();
					columnName = tableAliasColumn.substring(tableAliasColumn.indexOf(".") + 1).trim();
				} else {
					aliasName = tableAliasColumn.substring(0, tableAliasColumn.indexOf(".")).trim();
					columnName = tableAliasColumn.substring(tableAliasColumn.indexOf(".") + 1).trim();
				}
			} else if (selectColumn.indexOf(" ") > 0) {
				String tableAliasColumn = selectColumn.substring(0, selectColumn.indexOf(" ")).trim();
				showName = selectColumn.substring(selectColumn.indexOf(" ") + 1).trim();
				// 查看是否有别名
				if (tableAliasColumn.indexOf(".") > 0) {
					aliasName = tableAliasColumn.substring(0, tableAliasColumn.indexOf(".")).trim();
					columnName = tableAliasColumn.substring(tableAliasColumn.indexOf(".") + 1).trim();
				} else {
					aliasName = tableAliasColumn.substring(0, tableAliasColumn.indexOf(".")).trim();
					columnName = tableAliasColumn.substring(tableAliasColumn.indexOf(".") + 1).trim();
				}
			} else {
				String tableAliasColumn = selectColumn;
				// 查看是否有别名
				if (tableAliasColumn.indexOf(".") > 0) {
					aliasName = tableAliasColumn.substring(0, tableAliasColumn.indexOf(".")).trim();
					columnName = tableAliasColumn.substring(tableAliasColumn.indexOf(".") + 1).trim();
				} else {
					aliasName = tableAliasColumn.substring(0, tableAliasColumn.indexOf(".")).trim();
					columnName = tableAliasColumn.substring(tableAliasColumn.indexOf(".") + 1).trim();
				}
			}

			System.out.println("aliasName=" + aliasName + " columnName=" + columnName + " showName=" + showName);
			if (columnName.equals("*")) {
				if (aliasName.equals("")) {

				} else {
					String tableName = "";
					Column column = null;
					// 解析 alias_tables ，tables
					for (int j = 0; j < tables.length; j++) {
						if (alias_tables[j].equals(aliasName)) {
							tableName = tables[j];
							column = columns[j];
							break;
						}
					}
					for (int k = 0; k < column.getNum(); k++) {
						SelectColumn sc = new SelectColumn();
						sc.aliasName = aliasName;

						String columnName2 = (String) column.getColumns()[k];
						sc.columnName = columnName2;
						sc.tableName = tableName;
						sc.showName = sc.aliasName + "_" + sc.columnName;
						selectColumnVector.add(sc);
					}

				}

			} else {
				SelectColumn sc = new SelectColumn();
				sc.aliasName = aliasName;
				sc.columnName = columnName;
				if (aliasName.equals("")) {
					// 循环判断columns，找到tableName
					for (int j = 0; j < columns.length; j++) {
						Column column = columns[j];
						for (int k = 0; k < column.getNum(); k++) {
							String columnName2 = (String) column.getColumns()[i];
							if (sc.columnName.equals(columnName2)) {
								sc.tableName = column.getTableName();
								break;
							}
						}
					}
				} else {
					// 解析 alias_tables ，tables
					for (int j = 0; j < tables.length; j++) {
						if (alias_tables[j].equals(aliasName)) {
							sc.tableName = tables[j];
							break;
						}
					}
				}
				if (showName.equals("")) {
					if (sc.aliasName.equals("")) {
						sc.showName = "";
					} else {
						sc.showName = sc.aliasName + "_" + sc.columnName;
					}
				} else {
					sc.showName = showName;
				}
				selectColumnVector.add(sc);
			}
		}
		columnDone = "";
		for (int i = 0; i < selectColumnVector.size(); i++) {
			SelectColumn sc = selectColumnVector.get(i);
			if (sc.aliasName.equals("")) {
				columnDone = columnDone + sc.columnName + " " + sc.showName + ",";
			} else {
				columnDone = columnDone + sc.aliasName + "." + sc.columnName + " " + sc.showName + ",";
			}

		}
		columnDone = columnDone.substring(0, columnDone.length() - 1);
		System.out.println("columnDone=" + columnDone);
		System.out.println("limitBegin=" + limitBegin);
		System.out.println("limitNum=" + limitNum);

		funcName = className + "Select";

		ComplicatedWhereTree wt = null;
		// 解析where条件
		if (where_stmt.length() > 0) {
			ComplicatedSqlLex.init();
			ComplicatedSqlLex.parse(where_stmt + '$');
			wt = new ComplicatedWhereTree(ComplicatedSqlLex.listType, ComplicatedSqlLex.listToken);
			wt.parse();
			System.out.println("====" + where_stmt + "======");
			wt.doAll(columns, tables, alias_tables);
			wt.printAll();
			wt.printWhereSql();
			if (wt.var.length() > 0) {
				wt.var = wt.var.substring(0, wt.var.length() - 1);
			}
			if (wt.columnVar.length() > 0) {
				wt.columnVar = wt.columnVar.substring(0, wt.columnVar.length() - 1);
			}
			if (wt.declareVar.length() > 0) {
				wt.declareVar = wt.declareVar.substring(0, wt.declareVar.length() - 1);
			}

		}

		if (limitBegin.equals("?") && limitNum.equals("?")) {
			limit_stmt = "%d,%d";
			if (wt.columnVar.length() > 0) {
				column_var = wt.columnVar + "," + "limit_begin,limit_num";
				param_var = wt.var + "," + "limit_begin,limit_num";
				declare_var = wt.declareVar + "," + "int limit_begin,int limit_num";
			} else {
				column_var = "limit_begin,limit_num";
				param_var = "limit_begin,limit_num";
				declare_var = "int limit_begin,int limit_num";
			}

		} else if (limitBegin.equals("?") && limitNum.length() > 0) {
			limit_stmt = "%d," + limitNum;
			if (wt.var.length() > 0) {
				column_var = wt.columnVar + "," + "limit_begin";
				param_var = wt.var + "," + "limit_begin";
				declare_var = wt.declareVar + "," + "int limit_begin";
			} else {
				column_var = "limit_begin";
				param_var = "limit_begin";
				declare_var = "int limit_begin";
			}
		} else if (limitNum.equals("?") && limitBegin.length() > 0) {
			limit_stmt = limitBegin + ",%d";
			if (wt.var.length() > 0) {
				column_var = wt.columnVar + "," + "limit_num";
				param_var = wt.var + "," + "limit_num";
				declare_var = wt.declareVar + "," + "int limit_num";
			} else {
				column_var = "limit_num";
				param_var = "limit_num";
				declare_var = "int limit_num";
			}
		} else if (limitNum.equals("?") && limitBegin.length() == 0) {
			limit_stmt = "%d";
			if (wt.var.length() > 0) {
				column_var = wt.columnVar + "," + "limit_num";
				param_var = wt.var + "," + "limit_num";
				declare_var = wt.declareVar + "," + "int limit_num";
			} else {
				column_var = "limit_num";
				param_var = "limit_num";
				declare_var = "int limit_num";
			}
		} else if (limitBegin.equals("?") && limitNum.length() == 0) {
			throw new Exception();
		} else if (limitNum.length() == 0 && limitBegin.length() == 0) {
			column_var = wt.columnVar;
			param_var = wt.var;
			declare_var = wt.declareVar;

		} else {
			column_var = wt.columnVar;
			param_var = wt.var;
			declare_var = wt.declareVar;
		}

		// 打印处理过的sql
		StringBuffer buffer = new StringBuffer();
		buffer.append("select ");
		buffer.append(columnDone + " ");
		buffer.append("from ");
		buffer.append(from_stmt + " ");
		if (where_stmt.length() > 0) {
			buffer.append("where ");
			buffer.append(wt.buffer.toString() + " ");
		}
		if (groupby_stmt.length() > 0) {
			buffer.append("group by " + groupby_stmt + " ");
		}
		if (orderby_stmt.length() > 0) {
			buffer.append("order by " + orderby_stmt + " ");
		}
		if (limit_stmt.length() > 0) {
			buffer.append("limit " + limit_stmt + " ");
		}
		if (forupdate_stmt.length() > 0) {
			buffer.append(forupdate_stmt + " ");
		}
		System.out.println("sql=" + buffer.toString());
		realSql = buffer.toString();
		if (wt.columnNameList.size() > 0) {
			funcName = funcName + "By";
			for (int k = 0; k < wt.columnNameList.size(); k++) {
				funcName = funcName + wt.columnNameList.get(k);
			}
		}
		if (forupdate_stmt.length() > 0) {
			funcName = funcName + "ForUpdate";
		}
		for (int k = 0; k < wt.columnNameList.size(); k++) {
			declare_var = declare_var + wt.columnTypeList.get(k) + " " + wt.columnRealNameList.get(k) + ",";
		}
		if (declare_var.length() > 1) {
			declare_var = declare_var.substring(0, declare_var.length() - 1);
		}
		System.out.println("declare_var=" + declare_var);
		return true;
	}

	/**
	 * @param tableRelMap
	 * @param tableName1
	 * @param tableName2
	 * @param result
	 */
	private static void setMap(HashMap<String, TableRelation> tableRelMap, String tableName1, String tableName2, String result) {
		if (result.length() > 1) {
			if (tableRelMap.get(tableName1) != null) {
				TableRelation tr = tableRelMap.get(tableName1);
				tr.tableName = tableName1;
				tr.childName.add(tableName2);
			} else {
				TableRelation tr = new TableRelation();
				tr.tableName = tableName1;
				tr.childName.add(tableName2);
				tableRelMap.put(tableName1, tr);
			}
			if (tableRelMap.get(tableName2) != null) {
				TableRelation tr = tableRelMap.get(tableName2);
				tr.tableName = tableName2;
				tr.parentName = tableName1;
			} else {
				TableRelation tr = new TableRelation();
				tr.tableName = tableName2;
				tr.parentName = tableName1;
				tableRelMap.put(tableName2, tr);
			}
		}
	}

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		try {
			String sql = "select a.*,b.*,c.* from dbo_dea_ordercar a,dbo_car_catalognew b,dbo_car_catalognew c where a.carid=b.catalogid and b.catalogid=c.catalogid and a.carid=?";
			WhereTree.columnNameList = new ArrayList<String>();
			WhereTree.columnTypeList = new ArrayList<String>();
			WhereTree.columnRealNameList = new ArrayList<String>();
			ParseComplicatedSelectSql_117.initVar();
			boolean flag = ParseComplicatedSelectSql_117.parseSelect(sql);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

	}

	public static String createSql(String sql) {
		try {
			if (sql == null || sql.equals("") || sql.length() < 5) {
				return "sql is null";
			}
			WhereTree.columnNameList = new ArrayList<String>();
			WhereTree.columnTypeList = new ArrayList<String>();
			WhereTree.columnRealNameList = new ArrayList<String>();
			ParseComplicatedSelectSql_117.initVar();
			boolean flag = ParseComplicatedSelectSql_117.parseSelect(sql);
			System.out.println("declare_var2=" + ParseComplicatedSelectSql_117.declare_var);
			if (flag) {
				System.out.println("declare_var3=" + ParseComplicatedSelectSql_117.declare_var);
				return "";

			} else {
				return "error";
			}
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "error";
	}

}
