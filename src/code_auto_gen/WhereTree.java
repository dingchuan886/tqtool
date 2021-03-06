package code_auto_gen;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class WhereTree {

	WhereTree leftTrees;
	WhereTree rightTrees;
	String relation;
	List listType;
	List listToken;
	int pos;
	int indent;
	String indentString;

	public static List<String> columnTypeList = new ArrayList();
	public static List<String> columnNameList = new ArrayList();
	public static List<String> columnRealNameList = new ArrayList();

	static String sql = "";
	static String format = "";
	static String var = "";
	static String columnVar = "";
	static String declareVar = "";
	static StringBuffer buffer = new StringBuffer();
	static Map<String, Integer> map = new HashMap<String, Integer>();

	public static void main(String[] args) throws Exception {
		String sql = "uid1=? or uid2=?$";
		SqlLex.parse(sql);
		WhereTree wt = new WhereTree(SqlLex.listType, SqlLex.listToken);
		wt.parse();
		System.out.println("====" + sql + "======");
		wt.printAll();
		System.out.println("===========1============");
		for (int i = 0; i < SqlLex.listType.size(); i++) {
			System.out.println(SqlLex.listType.get(i));
		}
		System.out.println("===========2============");
		for (int i = 0; i < SqlLex.listToken.size(); i++) {
			System.out.println(SqlLex.listToken.get(i));
		}
	}

	WhereTree(List type, List token) {
		init();
		listType = type;
		listToken = token;
		relation = "";
		indentString = "";

	}

	/**
	 * 
	 */
	public static void init() {
		sql = "";
		var = "";
		buffer = new StringBuffer();
		declareVar = "";
		map.clear();
		columnVar = "";
	}

	WhereTree() {
		init();
		listType = new ArrayList();
		listToken = new ArrayList();
		relation = "";
		indentString = "";
	}

	String getTypeToken() {
		String type = (String) listType.get(pos);
		String token = (String) listToken.get(pos);
		pos++;
		return type + "#" + token;
	}

	void ungetTypeToken() {
		pos--;
	}

	public String parse() throws Exception {
		int kk = 0;
		for (; kk < indent; kk++)
			indentString = indentString + "	";
		System.out.println(indentString + "func=parse");
		print();
		while (true) {
			String typeToken = getTypeToken();
			System.out.println(indentString + "typeToken=" + typeToken + " pos=" + pos);
			String[] tt = typeToken.split("#");

			if (tt[0].equals("end")) {
				return "END";
			} else if (pos == listType.size()) {
				return "END";
			} else if (tt[0].equals("left_bracket")) {
				String typeToken1 = getTypeToken();
				System.out.println(indentString + "leftBracketAfterToken=" + typeToken1 + " pos=" + pos);
				String[] tt1 = typeToken1.split("#");
				int num = 0;
				while (true) {
					if (num == 0 && tt1[0].equals("right_bracket")) {
						if (pos == listType.size()) {
							createSubTree();
							return "END";
						}
						// 找到结束点，处理
						String typeToken2 = getTypeToken();
						System.out.println(indentString + "rightBracketAfterToken=" + typeToken2 + " pos=" + pos);
						String[] tt2 = typeToken2.split("#");
						if (tt2[0].equals("end")) {
							ungetTypeToken();
							createSubTree();
							return "END";
						} else if (tt2[0].equals("and")) {
							createLeftdDelBracket();
							relation = "and";
							createRight();
							return "END";
						} else if (tt2[0].equals("or")) {
							createLeftdDelBracket();
							relation = "or";
							createRight();
							return "END";
						} else {
							throw new Exception();
						}
					} else if (tt1[0].equals("left_bracket")) {
						num++;
						System.out.println(indentString + "num=" + num);
					} else if (tt1[0].equals("right_bracket")) {
						num--;
						System.out.println(indentString + "num=" + num);
					} else if (tt1[0].equals("end")) {
						return "END";
					} else {

					}

					typeToken1 = getTypeToken();
					tt1 = typeToken1.split("#");
					System.out.println(indentString + "BracketMiddleToken=" + typeToken1 + " pos=" + pos);
				}
			} else if (tt[0].equals("and")) {
				createLeft();
				relation = "and";
				createRight();
				return "";

			} else if (tt[0].equals("or")) {
				createLeft();
				relation = "or";
				createRight();
				return "";
			} else {

			}
		}

	}

	/**
	 * 
	 */
	private void createRight() throws Exception {
		System.out.println(indentString + "func=createRight");
		rightTrees = new WhereTree();
		rightTrees.indent = indent + 1;
		for (int i = pos; i < listType.size(); i++) {
			rightTrees.listType.add(listType.get(i));
			rightTrees.listToken.add(listToken.get(i));
		}
		rightTrees.parse();

	}

	/**
	 * 
	 */
	private void createLeft() throws Exception {
		System.out.println(indentString + "func=createLeft");
		leftTrees = new WhereTree();
		leftTrees.indent = indent + 1;
		for (int i = 0; i < pos - 1; i++) {
			leftTrees.listType.add(listType.get(i));
			leftTrees.listToken.add(listToken.get(i));
		}
		leftTrees.parse();
	}

	private void createLeftdDelBracket() throws Exception {
		System.out.println(indentString + "func=createLeftdDelBracket");
		leftTrees = new WhereTree();
		leftTrees.indent = indent + 1;
		for (int i = 1; i < pos - 2; i++) {
			leftTrees.listType.add(listType.get(i));
			leftTrees.listToken.add(listToken.get(i));
		}
		leftTrees.parse();
	}

	private void createSubTree() throws Exception {
		System.out.println(indentString + "func=createSubTree");
		leftTrees = new WhereTree();
		leftTrees.indent = indent + 1;
		relation = "sub";
		for (int i = 1; i < pos - 1; i++) {
			leftTrees.listType.add(listType.get(i));
			leftTrees.listToken.add(listToken.get(i));
		}
		leftTrees.parse();
	}

	/**
	 * 
	 */
	private void print() {
		System.out.print(indentString + "print=");
		for (int i = 0; i < listType.size(); i++) {
			System.out.print(listType.get(i) + "|" + listToken.get(i) + ";");
		}
		System.out.println();
	}

	public void printAll() {
		int kk = 0;
		String indentString = "";
		for (; kk < indent; kk++)
			indentString = indentString + "	";
		if (relation.equals("sub")) {
			System.out.println(indentString + "(");
			leftTrees.printAll();
			System.out.println(indentString + ")");
		} else if (relation.equals("and")) {
			leftTrees.printAll();
			System.out.println(indentString + "and");
			rightTrees.printAll();
		} else if (relation.equals("or")) {
			leftTrees.printAll();
			System.out.println(indentString + "or");
			rightTrees.printAll();
		} else if (relation.equals("")) {
			for (int i = 0; i < listType.size(); i++) {
				System.out.println(indentString + listType.get(i) + "|" + listToken.get(i) + ";");
			}
		}
	}

	public void printWhereSql() {

		if (relation.equals("sub")) {
			buffer.append("(");
			leftTrees.printWhereSql();
			buffer.append(")");
		} else if (relation.equals("and")) {
			leftTrees.printWhereSql();
			buffer.append(" and ");
			rightTrees.printWhereSql();
		} else if (relation.equals("or")) {
			leftTrees.printWhereSql();
			buffer.append(" and ");
			rightTrees.printWhereSql();
		} else if (relation.equals("")) {
			for (int i = 0; i < listType.size(); i++) {
				buffer.append(listToken.get(i) + " ");
			}
		}
	}

	public void doAll(Column column) {
		String columnString = column.getColumnString();
		String[] columns = columnString.split(",");
		if (relation.equals("sub")) {
			leftTrees.doAll(column);
		} else if (relation.equals("and")) {
			leftTrees.doAll(column);
			rightTrees.doAll(column);
		} else if (relation.equals("or")) {
			leftTrees.doAll(column);
			rightTrees.doAll(column);
		} else if (relation.equals("")) {
			if (listType.size() == 3 || listType.size() == 4) {
				// String type0 = (String) listType.get(0);// token
				String type2 = (String) listType.get(2);// expr
				String token0 = (String) listToken.get(0);// column
				// String token2 = (String) listToken.get(2);// ?
				if (type2.equals("question_mark_expr")) {
					for (int i = 0; i < columns.length; i++) {
						if (token0.equals(columns[i])) {
							String dataType = (String) column.getDataTypes()[i];
							String columnType = (String) column.getColumnTypes()[i];
							String columnName = (String) column.getColumns()[i];
							columnName = columnName.toLowerCase();
							Object obj = map.get(columnName);
							int times = 0;
							String realColumn = "";
							if (obj == null) {
								map.put(columnName, new Integer(1));
								realColumn = columnName;
							} else {
								Integer integer = (Integer) obj;
								times = integer.intValue();
								times++;
								map.put(columnName, new Integer(times));
								realColumn = columnName + String.valueOf(times);
							}
							if ((dataType.equals("varchar") || dataType.equals("char") || dataType.equals("text") || dataType.equals("blob") || dataType
									.equals("longtext"))) {
								listToken.set(2, "'%s'");
								var = var + realColumn + ".c_str(),";
								columnVar = columnVar + columnName + ",";
								declareVar = declareVar + "String " + realColumn + ",";
								columnNameList.add(columnName);
								columnRealNameList.add(realColumn);
								columnTypeList.add("String");

							} else if (dataType.equals("timestamp") || dataType.equals("datetime") || dataType.equals("date")) {
								columnVar = columnVar + columnName + ",";
								listToken.set(2, "'%s'");
								var = var + realColumn + ".c_str(),";
								declareVar = declareVar + "String " + realColumn + ",";
								columnNameList.add(columnName);
								columnRealNameList.add(realColumn);
								columnTypeList.add("String");
							} else if (dataType.equals("int") || dataType.equals("tinyint")) {
								columnVar = columnVar + columnName + ",";

								listToken.set(2, "%d");
								var = var + realColumn + ",";
								declareVar = declareVar + "int " + realColumn + ",";

								columnNameList.add(columnName);
								columnRealNameList.add(realColumn);
								columnTypeList.add("int");
							} else if (dataType.equals("bigint")) {
								columnVar = columnVar + columnName + ",";
								listToken.set(2, "%lld");
								var = var + realColumn + ",";
								declareVar = declareVar + "long " + realColumn + ",";
								columnNameList.add(columnName);
								columnRealNameList.add(realColumn);
								columnTypeList.add("long");
							} else if (dataType.equals("decimal") || dataType.equals("double")) {
								columnVar = columnVar + columnName + ",";
								listToken.set(2, "%lf");
								var = var + realColumn + ",";
								declareVar = declareVar + "double " + realColumn + ",";
								columnNameList.add(columnName);
								columnRealNameList.add(realColumn);
								columnTypeList.add("double");
							}
						}
					}

				}
			}
		}
	}
}
