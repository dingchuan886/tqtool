package code_auto_gen;

import java.util.Vector;

public class ParseUpdateSql_117 {

	public static String update_stmt = "";
	public static String set_stmt = "";
	public static String where_stmt = "";
	public static String orderby_stmt = "";
	public static String limit_stmt = "";
	public static String className = "";
	public static String funcName = "";
	public static String tableName = "";
	public static String aliasTableName = "";
	public static String declare_var = "";

	public static Vector<String> setColumn = new Vector<String>();

	public static void main(String[] args) throws Exception {
		initVar();
		parseUpdate("update a set a=e where a=3");
		String a = "a=c";
		String[] as = a.split(",");
		for (int i = 0; i < as.length; i++) {
			System.out.println(as[i]);
		}
	}

	public static void initVar() {
		setColumn = new Vector<String>();
		update_stmt = "";
		set_stmt = "";
		where_stmt = "";
		orderby_stmt = "";
		limit_stmt = "";
		className = "";
		funcName = "";
		tableName = "";
		aliasTableName = "";
		declare_var = "";

	}

	public static boolean parseUpdate(String sql) throws Exception {
		WhereTree.init();

		int updatePos = sql.indexOf("update ");
		if (updatePos < 0) {
			return false;
		}
		int setPos = sql.indexOf("set ");
		if (setPos < 0) {
			return false;
		}

		update_stmt = sql.substring(updatePos + 7, setPos).trim();

		int wherePos = sql.indexOf("where ");
		int orderPos = sql.indexOf("order ");
		int limitPos = sql.indexOf("limit ");
		if (wherePos > 0) {
			set_stmt = sql.substring(setPos + 4, wherePos).trim();
		} else {
			if (orderPos > 0) {
				set_stmt = sql.substring(setPos + 4, orderPos).trim();
			} else if (limitPos > 0) {
				set_stmt = sql.substring(setPos + 4, limitPos).trim();
			} else {
				set_stmt = sql.substring(setPos + 4).trim();
			}
		}
		// where order limit顺序要正常
		if (orderPos > 0 && wherePos > 0) {
			if (wherePos > orderPos) {
				return false;
			}
		}
		if (limitPos > 0 && wherePos > 0) {
			if (wherePos > limitPos) {
				return false;
			}
		}
		if (orderPos > 0 && limitPos > 0) {
			if (orderPos > limitPos) {
				return false;
			}
		}

		if (orderPos > 0) {
			// 判断后面是否有by关键字
			String tmp = sql.substring(orderPos + 6);
			if (tmp.indexOf(" by") < 0) {
				// 不是order by语句
				return false;
			}
		}

		if (wherePos > 0) {
			if (orderPos < 0 && limitPos < 0) {
				where_stmt = sql.substring(wherePos + 6).trim();
			} else if (orderPos > 0) {
				where_stmt = sql.substring(wherePos + 6, orderPos).trim();
			} else if (limitPos > 0) {
				where_stmt = sql.substring(wherePos + 6, limitPos).trim();
			} else {
				return false;
			}
		}

		if (orderPos > 0) {
			String tmp = sql.substring(orderPos + 6);
			if (tmp.indexOf(" by") < 0) {
				return false;
			} else {
				tmp = tmp.substring(tmp.indexOf(" by") + 3).trim();
				if (limitPos > 0) {
					limitPos = tmp.indexOf("limit ");
					orderby_stmt = tmp.substring(0, limitPos);
					limit_stmt = tmp.substring(limitPos + 6).trim();
				} else {
					orderby_stmt = tmp;
				}
			}
		}
		System.out.println("update_stmt=" + update_stmt);
		System.out.println("set_stmt=" + set_stmt);
		System.out.println("where_stmt=" + where_stmt);
		System.out.println("orderby_stmt=" + orderby_stmt);
		System.out.println("limit_stmt=" + limit_stmt);

		// 判断update_stmt是否有别名
		if (update_stmt.indexOf(" ") > 0) {
			tableName = update_stmt.substring(0, update_stmt.indexOf(" ")).trim();
			aliasTableName = update_stmt.substring(update_stmt.indexOf(" ")).trim();
		} else {
			tableName = update_stmt;
		}
		System.out.println("tableName=" + tableName);
		System.out.println("aliasTableName=" + aliasTableName);

		// 解析set语句
		String[] set_stmts = set_stmt.split(",");
		for (int i = 0; i < set_stmts.length; i++) {
			// 获取每个set语句的条件
			String detail = set_stmts[i].trim();
			if (detail.indexOf("=") <= 0) {
				return false;
			} else {
				String[] details = detail.split("=");
				if (details.length != 2) {
					return false;
				}
				String column1 = details[0].trim();
				String column2 = details[1].trim();
				if (column1.equals("?") && !column2.equals("?")) {
					setColumn.add(column2);
				} else if (!column1.equals("?") && column2.equals("?")) {
					setColumn.add(column1);
				} else {
					return false;
				}
			}
		}

		String limitNum = "";
		String limitBegin = "";
		if (limit_stmt.length() > 0) {
			int limitPos1 = limit_stmt.indexOf(",");
			if (limitPos1 > 0) {
				limitNum = limit_stmt.substring(0, limitPos1).trim();
				limitBegin = limit_stmt.substring(limitPos1 + 1, limit_stmt.length()).trim();
			} else {
				limitNum = limit_stmt;
			}
		}
		System.out.println("limitBegin=" + limitBegin);
		System.out.println("limitNum=" + limitNum);

		String className = Tool.getClassName(tableName);

		funcName = className + "Update";

		Column column = ColumnUtil_117.selectColumn(tableName);
		if (column.getColumnString().equals("")) {

			return false;
		}

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

		// 解析where条件

		if (wt.columnVar.length() > 0) {
			String[] params = wt.columnVar.split(",");
			funcName = funcName + "By";
			for (int k = 0; k < params.length; k++) {
				funcName = funcName + params[k];
			}
		}
		declare_var = wt.declareVar;
		return true;

	}
}
