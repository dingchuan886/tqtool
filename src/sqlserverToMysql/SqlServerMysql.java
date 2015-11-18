package sqlserverToMysql;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.TreeMap;
import java.util.Vector;

public class SqlServerMysql {
	static String old_file = "D:\\workspace_java\\tqtool\\src\\sqlserverToMysql\\permission.sql";
//	static String old_file = "D:\\workspace_java\\tqtool\\src\\sqlserverToMysql\\cardata1.sql";
	static String new_file = "D:\\workspace_java\\tqtool\\src\\sqlserverToMysql\\permission2.sql";
	static int status = 0;

	static Connection conn = null;
	static String sourceDB = "315che_cardata";
	static String IP = "192.168.137.48";
	// static String tables =
	// "#are_catalog@,#dea_click@,#dea_dayclick@,#dea_backdayclick@,#new_catalog@,#car_catalognew@,#dea_employee@,#dea_smsnotice@,#dea_dealerinfo@,#dea_storedisplay@,#dea_message@,#dea_phonemanage@,#dea_wxaccount@,#dea_news@,#dea_wxmsg@,#dea_wxintmsg@,#dea_wxzhuanti@,#dea_wxactivities@,#dea_prizeinfo@,#dea_wxactjoin@,#dea_wxaccount@,#dea_dealers@,#dea_sccommodity@,#dea_scsignature@,#dea_scbussinessinfo@,#ent_product@,#dea_news@,#dea_hqnews@,#dea_hqprice@,#dea_ordercar@,#dea_byyuyue@,#dea_wxershouche@,#dea_byschedulesenior@,#dea_wxservice@,#dea_scoressort@,#dea_opertions@"
	// ;
	// static String tables = "#dnt_userlevel@,#dnt_users@";
	static String tables = "#dnt_tousu@";
	// static String tables = "#newdealernewscontentbak@";
	static Map<String, Vector<Column>> gmap = new TreeMap<String, Vector<Column>>();
	static Map<String, String> gmap_comment = new HashMap<String, String>();
	static Map<String, String> map_table = new HashMap<String, String>();

	static void insert(String sql) { 
		System.out.println(sql);
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);// 0
			pstmt.execute();
		} catch (Exception e) {
			e.printStackTrace();
			// System.out.println(sql);
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
	}

	public static String getComment(String table, String column) {
		if (conn == null) {
			init();
		}

		StringBuffer sb = new StringBuffer();
		String sql = "select comment from tb_column_comment where table_name='" + table + "' and column_name='" + column + "'";
		PreparedStatement pstmt = null;
		try {

			pstmt = conn.prepareStatement(sql);// 0
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				return rs.getString(1);
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

	public static String getTableComment(String table) {
		if (conn == null) {
			init();
		}

		StringBuffer sb = new StringBuffer();
		String sql = "select comment from tb_table_comment where table_name='" + table + "'";
		PreparedStatement pstmt = null;
		try {

			pstmt = conn.prepareStatement(sql);// 0
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				return rs.getString(1);
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

	static void init() {

		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection("jdbc:mysql://" + IP + ":3306/" + sourceDB + "?useUnicode=true&characterEncoding=UTF-8", "main", "main");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void updateColumnDefault(String table_name, String column_name, String default_value) {
		Vector<Column> vet1 = gmap.get(table_name);
		for (int i = 0; i < vet1.size(); i++) {
			Column col = vet1.get(i);
			if (col.name.equals(column_name)) {
				col.desc = col.desc + " default '" + default_value + "'";
				break;
			}
		}
	}

	public static void updateColumnComment(String table_name, String column_name, String comment) {

		Vector<Column> vet1 = gmap.get(table_name);
		if (vet1 == null) {
			System.out.println(table_name);
			return;
		}
		for (int i = 0; i < vet1.size(); i++) {
			Column col = vet1.get(i);
			if (col.name.equals(column_name)) {
				col.comment = " comment '" + comment + "'";
				break;
			}
		}
	}

	public static void updateColumnPrimary(String table_name, String column_name) {
		Vector<Column> vet1 = gmap.get(table_name);
		for (int i = 0; i < vet1.size(); i++) {
			Column col = vet1.get(i);
			if (col.name.equals(column_name)) {
				col.primary_key = true;
				break;
			}
		}
	}

	public static void main(String[] args) throws Exception {
		init();
//		insert("delete from  tb_column_comment;");
//		insert("insert into tb_column_comment(table_name,column_name,comment) select table_name,column_name,COLUMN_COMMENT from information_schema.columns  where table_schema='"
//				+ sourceDB + "';");
//		insert("delete from  tb_table_comment;");
//		insert("insert into tb_table_comment(table_name,comment) select table_name,table_COMMENT from information_schema.tables  where table_schema='"
//				+ sourceDB + "';");
		StringBuffer strBuffer = new StringBuffer();
		//InputStreamReader isr = new InputStreamReader(new FileInputStream(old_file), "Unicode");
		InputStreamReader isr = new InputStreamReader(new FileInputStream(old_file), "utf-8");
		BufferedReader fileReader = new BufferedReader(isr);
		// BufferedReader fileReader = new BufferedReader(new
		// FileReader(old_file));
		String schema = "";
		String table_name = "";
		int k = 0;
		while (true) {
			String line = fileReader.readLine();
			if (line == null) {
				break;
			}
			k++;
			// if (k > 50) {
			// break;
			// }
			line = line.toLowerCase().trim();
			line = line.replace("[", "");
			line = line.replace("]", "");
			System.out.println(status + "--" + line);
			if (status == 3) {
				status = 0;
				continue;
			}
			if (status == 0) {
				if (line.indexOf("sys.sp_addextendedproperty") >= 0) {
					while (true) {
						String new_line = fileReader.readLine();
						if (new_line == null) {
							break;
						}
						if (new_line.equals("GO")) {
							break;
						} else {
							line = line + new_line;
						}
					}

					// 解析字段描述
					// EXEC sys.sp_addextendedproperty
					// @name=N'MS_Description',
					// @value=N'专题id' ,
					// @level0type=N'SCHEMA',@level0name=N'dbo',
					// @level1type
					// =N'TABLE',@level1name=N'zht_relatedSerial',
					// @level2type=N'COLUMN',@level2name=N'contentId'
					String[] detail = line.split(",");
					String desc = "";
					String level0name = "";
					String level1name = "";
					String level2name = "";
					for (int i = 0; i < detail.length; i++) {
						String[] values = detail[i].split("=");
						if (values[0].trim().equals("@value")) {
							desc = values[1].trim();
							desc = desc.substring(2);
							desc = desc.replace("'", "");
						} else if (values[0].trim().equals("@level0name")) {
							level0name = values[1].trim();
							level0name = level0name.substring(2);
							level0name = level0name.replace("'", "");
						} else if (values[0].trim().equals("@level1name")) {
							level1name = values[1].trim();
							level1name = level1name.substring(2);
							level1name = level1name.replace("'", "");
						} else if (values[0].trim().equals("@level2name")) {
							level2name = values[1].trim();
							level2name = level2name.substring(2);
							level2name = level2name.replace("'", "");
						}
					}
					if (checkTable(level1name)) {
						// 创建comment
						updateColumnComment(level0name + "_" + level1name, level2name, desc);
					}
				} else if (line.indexOf("alter table") >= 0 && line.indexOf("default") >= 0) {
					// default处理
					// ALTER TABLE [dbo].[dea_click] ADD DEFAULT ((1)) FOR
					// [clickCount]
					String detail = line.replace("alter table", "").trim();
					detail = detail.replace("(", "");
					detail = detail.replace(")", "");
					int index1 = detail.indexOf(".");
					int index2 = detail.indexOf("add ");
					String schema1 = detail.substring(0, index1);
					String table_name1 = detail.substring(index1 + 1, index2).trim();
					int index4 = detail.indexOf("for ");
					int index3 = detail.indexOf("default ");
					String column_name1 = detail.substring(index4 + 3).trim();
					String default_value = detail.substring(index3 + 8, index4 - 1);
					default_value = default_value.replace("'", "");
					System.out.println(default_value);
					if (checkTable(table_name1)) {
						if (default_value.equals("getdate")) {

						} else {
							updateColumnDefault(schema1 + "_" + table_name1, column_name1, default_value);
						}

					}
				}
			}
			if (line.indexOf("create table ") == 0 && line.indexOf("create table tablespaceinfo") != 0) {
				String primary_key = "";

				status = 1;// table 状态
				// 解析schema table_name
				int dotSize = line.indexOf(".");
				schema = line.substring(13, dotSize);
				table_name = line.substring(dotSize + 1, line.length() - 1);
				System.out.println(schema);
				System.out.println(table_name);
				if (checkTable(table_name)) {

				} else {
					status = 0;
					continue;
				}
				strBuffer.append("create table ");
				strBuffer.append(schema + "_" + table_name + "(");
				// 保存到map中
				Vector<Column> vet = new Vector<Column>();
				gmap.put(schema + "_" + table_name, vet);

				System.out.println(schema + "_" + table_name);
				while (true) {
					line = fileReader.readLine();
					System.out.println(line);
					if (line == null) {
						break;
					}
					line = line.trim();
					line = line.replace("[", "");
					line = line.replace("]", "");
					line = line.toLowerCase().trim();

					if (line.indexOf(",") >= 0) {
						status = 2;// 开始
					} else {
						if (status == 2) {
							// 分析是否有主键
							if (line.indexOf("primary key") > 0) {
								status = 3;
								line = fileReader.readLine();
								line = fileReader.readLine();
								line = line.toLowerCase().trim();
								line = line.replace("[", "");
								line = line.replace("]", "");
								line = line.replace("asc", "");

								strBuffer.append("primary key (`" + line.trim() + "`)");
								strBuffer.append(");\n");
								map_table.put(schema + "_" + table_name, line);

								updateColumnPrimary(schema + "_" + table_name, line.trim());
								break;
							} else {
								status = 3;
								strBuffer.deleteCharAt(strBuffer.length() - 1);
								System.out.println(strBuffer.toString());
								strBuffer.append(");\n");
								break;
							}
						}
					}
					if (status == 2) {
						int column_name_size = line.indexOf(" ");
						String column_name = line.substring(0, column_name_size).trim();
						line = line.substring(column_name_size + 1);
						int column_type_size = line.indexOf(" ");
						String column_type = line.substring(0, column_type_size).trim();
						
						line = line.substring(column_type_size + 1);

						int size = 0;
						int size1 = 0;
						// 判断类型后是否有大小
						if (!column_type.equals("int") && line.indexOf("(") >= 0 && line.indexOf(")") > 0) {
							int brace_left_index = line.indexOf("(");
							int brace_right_index = line.indexOf(")");
							String detail = line.substring(brace_left_index + 1, brace_right_index);
							if (detail.indexOf(",") > 0) {
								size = Integer.parseInt(detail.split(",")[0]);
								size1 = Integer.parseInt(detail.split(",")[1].trim());
							} else {
								String value = line.substring(brace_left_index + 1, brace_right_index);
								if (value.equals("max")) {
									size = 4000;
								} else {
									size = Integer.parseInt(value);
								}

							}
							//column_type = column_type.substring(0, column_type.indexOf("("));
						} else {

						}
						boolean notnull_flag = false;
						if (line.indexOf("not null") >= 0) {
							notnull_flag = true;
						}
						System.out.println("column_name=" + column_name);
						System.out.println("column_type=" + column_type);
						System.out.println("size=" + size);
						System.out.println("notnull_flag=" + notnull_flag);
						String real_type = "";

						if (column_type.indexOf("nvarchar") == 0) {
							real_type = "varchar";
						} else if (column_type.indexOf("nchar") == 0) {
							real_type = "varchar";
						} else if (column_type.indexOf("bit") == 0) {
							real_type = "int";
						} else if (column_type.indexOf("varchar") == 0) {
							real_type = "varchar";
						} else if (column_type.indexOf("numeric") == 0) {
							real_type = "decimal";
						} else if (column_type.indexOf("decimal") == 0) {
							real_type = "decimal";
						} else if (column_type.indexOf("ntext") == 0) {
							real_type = "text";
						} else if (column_type.indexOf("text") == 0) {
							real_type = "text";
						} else if (column_type.indexOf("char") == 0) {
							real_type = "varchar";
						} else if (column_type.indexOf("float") == 0) {
							real_type = "double";
						} else if (column_type.indexOf("int") == 0) {
							real_type = "int";
						} else if (column_type.indexOf("bigint") == 0) {
							real_type = "bigint";
						} else if (column_type.indexOf("tinyint") == 0) {
							real_type = "tinyint";
						} else if (column_type.indexOf("smallint") == 0) {
							real_type = "int";
						} else if (column_type.indexOf("smalldatetime") == 0) {
							real_type = "datetime";
						} else if (column_type.indexOf("datetime") == 0) {
							real_type = "datetime";
						} else {
							throw new Exception();
						}

						strBuffer.append(" `" + column_name + "`");
						strBuffer.append(" " + real_type);
						if (size1 > 0) {
							strBuffer.append("(" + size + "," + size1 + ")");
						} else if (size > 0) {
							strBuffer.append("(" + size + ")");
						}
						if (notnull_flag) {
							strBuffer.append(" not null");
						}
						strBuffer.append(",");
						StringBuffer value = new StringBuffer();
						value.append(" " + real_type);
						if (size1 > 0) {
							value.append("(" + size + "," + size1 + ")");
						} else if (size > 0) {
							value.append("(" + size + ")");
						}
						if (notnull_flag) {
							value.append(" not null");
						}
						Column col = new Column();
						col.name = column_name;
						col.desc = value.toString();
						col.default_value = "";
						col.primary_key = false;
						col.comment = "";
						vet.add(col);
					}
				}
			}
		}

		fileReader.close();
		System.out.println("===================\n");
		System.out.println(strBuffer.toString().toLowerCase());
		System.out.println("#############################\n");
		// 对map遍历
		Iterator<String> iter = gmap.keySet().iterator();

		while (iter.hasNext()) {
			String key = iter.next();
			Vector<Column> vet = gmap.get(key);
			System.out.print("create table " + key + "(");
			if (key.equals("dbo_aut_content")) {
				System.out.print("");
			}
			String primary_key = "";
			for (int i = 0; i < vet.size(); i++) {
				Column col = vet.get(i);
				if (col.primary_key == true) {
					primary_key = col.name;
					if (primary_key.indexOf(",") >= 0) {
						System.out.print("");
					}
				}
				if (i == vet.size() - 1) {
					if (primary_key.equals("")) {
						System.out.print("`" + col.name + "` " + col.desc + col.comment + ");\n");
					} else {
						System.out.print("`" + col.name + "` " + col.desc + col.comment + ",");
						System.out.print("primary key (`" + primary_key + "`)) comment '" + getTableComment(key) + "';\n");
					}

				} else {
					System.out.print("`" + col.name + "` " + col.desc + col.comment + ",");
				}
			}
		}
		/*
		 * iter = gmap.keySet().iterator(); while (iter.hasNext()) { String key
		 * = iter.next(); Vector<Column> vet = gmap.get(key); for (int i = 0; i
		 * < vet.size(); i++) { Column col = vet.get(i); if
		 * (col.comment.equals("")) { String comment = getComment(key,
		 * col.name); if (comment.length() > 0) {
		 * System.out.println("alter table " + key + " change `" + col.name +
		 * "` `" + col.name + "` " + col.desc + " comment '" + comment + "';");
		 * } else { System.out.println("alter table " + key + " change `" +
		 * col.name + "` `" + col.name + "` " + col.desc + " comment '" +
		 * comment + "';"); }
		 * 
		 * } else { // System.out.println("alter table " + key + " change `" +
		 * // col.name + "` `" + col.name + "` " + col.desc + // col.comment +
		 * ";"); }
		 * 
		 * } }
		 */
	}

	// alter table t1 change b b bigint not null;

	/**
	 * @param table_name1
	 * @return
	 */
	private static boolean checkTable(String table_name1) {
		boolean flag = tables.indexOf("#" + table_name1 + "@") >= 0;
		flag = true;
		return flag;
	}
}
