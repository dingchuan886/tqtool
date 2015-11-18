package code_auto_gen;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Vector;

public class DB_Tool_117 {

	public static Connection conn = null;
	public static String sourceDB = "wei";
	public static String IP = "182.254.132.117";

	public static void init() {

		try {
			Class.forName("com.mysql.jdbc.Driver").newInstance();
			conn = DriverManager.getConnection("jdbc:mysql://" + IP + ":3306/" + sourceDB + "?useUnicode=true&characterEncoding=UTF-8", "main", "main");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static void test() {
		String sql = "select sysdate() from dual";
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = conn.prepareStatement(sql);// 0
			for (rs = pstmt.executeQuery(); rs.next();) {
			}
		} catch (Exception e) {
			// e.printStackTrace();
			init();
		} finally {

			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();

				}
		}
	}

	static void insert(String sql) {
		if (DB_Tool_117.conn == null) {
			DB_Tool_117.init();
		}
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			pstmt = DB_Tool_117.conn.prepareStatement(sql);// 0
			pstmt.execute();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(sql);
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (Exception e) {
					e.printStackTrace();
				}
		}
	}

	public static void main(String[] args) throws Exception {
		test();
		String a = "adaa'dfee";
		a = a.replace("'", "''");
		insert("insert into tb_sql_auto(table_name) values('" + a + "')");
	}

}
