package code_auto_gen;

public class ParseSelectSql {

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
	}

	/**
	 * @param sql
	 */
	public static boolean parseSelect(String sql) throws Exception {
		WhereTree.init();
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

		String tables = "";
		String alias_tables = "";
		String[] columns = {};
		String limitNum = "";
		String limitBegin = "";

		if (select_stmt.length() > 0) {
			columns = select_stmt.split(",");
		}

		if (from_stmt.length() > 0) {
			int aliasPos = from_stmt.indexOf(" ");
			if (aliasPos > 0) {
				alias_tables = from_stmt.substring(aliasPos, from_stmt.length()).trim();
				tables = from_stmt.substring(0, aliasPos).trim();
			} else {
				tables = from_stmt;
			}
		}

		if (limit_stmt.length() > 0) {
			int limitPos1 = limit_stmt.indexOf(",");
			if (limitPos1 > 0) {
				limitNum = limit_stmt.substring(limitPos1 + 1, limit_stmt.length()).trim();
				limitBegin = limit_stmt.substring(0, limitPos1).trim();
			} else {
				limitNum = limit_stmt;
			}
		}
		Column column = ColumnUtil.selectColumn(tables);
		if (column.getColumnString().equals("")) {

			return false;
		}
		String[] columnNames = column.getColumnString().toLowerCase().split(",");
		columnDone = "";
		for (int i = 0; i < columns.length; i++) {
			System.out.println("columns=" + columns[i]);
			if (columns[i].equals("*")) {
				sqlType = 1;
				for (int j = 0; j < columnNames.length; j++) {
					columnDone = columnDone + "`" + columnNames[j] + "`,";
				}
			} else if (columns[i].indexOf("count(*)") >= 0) {
				sqlType = 2;
				columnDone = "count(*),";
			} else {
				sqlType = 3;
				int dotIndex = columns[i].indexOf(".");
				if (dotIndex > 0) {
					String[] aliasColumn = columns[i].split(".");
					if (aliasColumn[0].equals(alias_tables)) {
						columnDone = columnDone + aliasColumn[1] + ",";
					} else {
						throw new Exception();
					}
				} else {
					boolean columnFlag = false;
					for (int k = 0; k < columnNames.length; k++) {
						if (columnNames[k].equals(columns[i].toLowerCase())) {
							columnFlag = true;
							break;
						}
					}
					if (columnFlag) {
						columnDone = columnDone + "`" + columns[i].toLowerCase() + "`,";
					}
				}
			}
		}
		if (columnDone.length() == 0) {
			return false;
		}
		columnDone = columnDone.substring(0, columnDone.length() - 1);
		System.out.println(columnDone);
		System.out.println("table=" + tables);
		tableName = tables;
		String name = tables.substring(3);
		String cName = Tool.getClassName(tables);
		className = "" + cName;
		if (sqlType == 1) {
			funcName = className + "SelectAllColumn";
		} else if (sqlType == 2) {
			funcName = className + "Count";
		} else if (sqlType == 3) {
			funcName = className + "Select";
		}

		System.out.println("alias=" + alias_tables);
		System.out.println("limitBegin=" + limitBegin);
		System.out.println("limitNum=" + limitNum);

		WhereTree wt = null;
		// 解析where条件
		if (where_stmt.length() > 0) {
			SqlLex.init();
			SqlLex.parse(where_stmt + '$');
			wt = new WhereTree(SqlLex.listType, SqlLex.listToken);
			wt.parse();
			System.out.println("====" + where_stmt + "======");
			wt.doAll(column);
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

			System.out.println(wt.buffer.toString());
			System.out.println(wt.var);
		}

		if (limitBegin.equals("?") && limitNum.equals("?")) {
			limit_stmt = "%d,%d";
			if (wt.columnVar.length() > 0) {
				column_var = wt.columnVar + "," + "limit_begin,limit_num";
				param_var = wt.var + "," + "limit_begin,limit_num";
				declare_var = wt.declareVar + "," + "int limit_begin,int limit_num";
				WhereTree.columnTypeList.add("int");
				WhereTree.columnNameList.add("limit_begin");
				WhereTree.columnRealNameList.add("limit_begin");
				WhereTree.columnTypeList.add("int");
				WhereTree.columnNameList.add("limit_num");
				WhereTree.columnRealNameList.add("limit_num");

			} else {
				column_var = "limit_begin,limit_num";
				param_var = "limit_begin,limit_num";
				declare_var = "int limit_begin,int limit_num";
				WhereTree.columnTypeList.add("int");
				WhereTree.columnNameList.add("limit_begin");
				WhereTree.columnRealNameList.add("limit_begin");
				WhereTree.columnTypeList.add("int");
				WhereTree.columnNameList.add("limit_num");
				WhereTree.columnRealNameList.add("limit_num");
			}

		} else if (limitBegin.equals("?") && limitNum.length() > 0) {
			limit_stmt = "%d," + limitNum;
			if (wt.var.length() > 0) {
				column_var = wt.columnVar + "," + "limit_begin";
				param_var = wt.var + "," + "limit_begin";
				declare_var = wt.declareVar + "," + "int limit_begin";
				WhereTree.columnTypeList.add("int");
				WhereTree.columnNameList.add("limit_begin");
				WhereTree.columnRealNameList.add("limit_begin");

			} else {
				column_var = "limit_begin";
				param_var = "limit_begin";
				declare_var = "int limit_begin";
				WhereTree.columnTypeList.add("int");
				WhereTree.columnNameList.add("limit_begin");
				WhereTree.columnRealNameList.add("limit_begin");
			}
		} else if (limitNum.equals("?") && limitBegin.length() > 0) {
			limit_stmt = limitBegin + ",%d";
			if (wt.var.length() > 0) {
				column_var = wt.columnVar + "," + "limit_num";
				param_var = wt.var + "," + "limit_num";
				declare_var = wt.declareVar + "," + "int limit_num";

				WhereTree.columnTypeList.add("int");
				WhereTree.columnNameList.add("limit_num");
				WhereTree.columnRealNameList.add("limit_num");
			} else {
				column_var = "limit_num";
				param_var = "limit_num";
				declare_var = "int limit_num";
				WhereTree.columnTypeList.add("int");
				WhereTree.columnNameList.add("limit_num");
				WhereTree.columnRealNameList.add("limit_num");
			}
		} else if (limitNum.equals("?") && limitBegin.length() == 0) {
			limit_stmt = "%d";
			if (wt.var.length() > 0) {
				column_var = wt.columnVar + "," + "limit_num";
				param_var = wt.var + "," + "limit_num";
				declare_var = wt.declareVar + "," + "int limit_num";
				WhereTree.columnTypeList.add("int");
				WhereTree.columnNameList.add("limit_num");
				WhereTree.columnRealNameList.add("limit_num");
			} else {
				column_var = "limit_num";
				param_var = "limit_num";
				declare_var = "int limit_num";
				WhereTree.columnTypeList.add("int");
				WhereTree.columnNameList.add("limit_num");
				WhereTree.columnRealNameList.add("limit_num");
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
		buffer.append(tables + " ");
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
		if (column_var.length() > 0) {
			String[] params = column_var.split(",");
			funcName = funcName + "By";
			for (int k = 0; k < params.length; k++) {
				funcName = funcName + params[k];
			}
		}
		if (forupdate_stmt.length() > 0) {
			funcName = funcName + "ForUpdate";
		}

		return true;
	}
}
