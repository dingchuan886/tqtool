package code_auto_gen;

public class Test {

	public static String test() {
		return "ac";
	}

	public static void main(String[] args) throws Exception {
		String sql1 = "uPDATE3eeee";
		sql1 = sql1.substring(0, 7).toLowerCase() + sql1.substring(7, sql1.length());
		System.out.println(sql1);
	}

}
