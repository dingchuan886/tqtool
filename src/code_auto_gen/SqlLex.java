package code_auto_gen;

import java.util.ArrayList;
import java.util.List;

public class SqlLex {

	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception {
		String sql = "a.b='1'$";
		parse(sql);
	}

	static void parse(String sql1) throws Exception {
		sql = sql1.replace("`", "");
		length = sql.length();
		pos = 0;
		token_buffer = "";
		while (true) {
			String type = lex();
			System.out.println(type + " " + token_buffer);
			listType.add(type);
			listToken.add(token_buffer);
			if (type.equals("end")) {
				break;
			}
		}
		for (int i = 0; i < listType.size(); i++) {
			System.out.println(listType.get(i) + " " + listToken.get(i));
		}
	}

	static int length;
	static int pos = 0;
	static String sql = "";
	static String token_buffer = "";
	static List listToken = new ArrayList();
	static List listType = new ArrayList();

	static void init() {
		length = 0;
		pos = 0;
		sql = "";
		token_buffer = "";
		listToken = new ArrayList();
		listType = new ArrayList();
	}

	static int getc() {
		char c = sql.charAt(pos);
		pos++;
		if (c == '$') {
			return c;
		}
		return c;
	}

	static void ungetc() {

		pos--;
	}

	static int skip_white_space() {
		int c;
		c = getc();
		for (;;) {
			if (c == '/') // 当c=/时，判断是否是注释 早期注释只有/* */格式没有//
			{

			} else if (c == '\n') {

			} else if (c == ' ' || c == '\t' || c == '\f' || c == '\r' || c == '\b') {
				c = getc();
			} else if (c == '\\') {
			} else {
				return (c);
			}
		}
	}

	static String lex() throws Exception {
		token_buffer = "";
		int c;
		c = skip_white_space();
		// System.out.println((char) c);
		if (c == '$') {
			return "end";
		} else if ((c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || c == '_') {
			while (((c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z') || (c >= '0' && c <= '9')) || (c == '_')) {
				token_buffer = token_buffer + (char) c;
				c = getc();
			}
			ungetc();
			// 判断是否是 and or 关键字
			if (token_buffer.equals("and")) {
				return "and";
			} else if (token_buffer.equals("or")) {
				return "or";
			}
			return "token";
		} else if (c >= '0' && c <= '9' || c == '.') {
			while (c >= '0' && c <= '9') {
				token_buffer = token_buffer + (char) c;
				c = getc();
			}
			ungetc();
			return "number";
		} else if (c == '\'') {
			token_buffer = token_buffer + "\'";
			c = getc();
			while (c != '\'') {
				token_buffer = token_buffer + (char) c;
				c = getc();
			}
			token_buffer = token_buffer + (char) c;
			return "single_quote";
		} else if (c == '\"') {
			c = getc();
			while (c != '\"') {
				token_buffer = token_buffer + (char) c;
				c = getc();
			}
			token_buffer = token_buffer + (char) c;
			return "double_quote";
		} else if (c == '?' || c == '+' || c == '-' || c == '<' || c == '>' || c == '*' || c == '/' || c == '%' || c == '!' || c == '=') {
			token_buffer = token_buffer + (char) c;
			int c1 = getc();
			if (c1 == '=') {
				token_buffer = token_buffer + (char) c1;
				if (c == '<') {
					return "le_expr";
				} else if (c == '=') {
					return "eq_expr";
				} else if (c == '>') {
					return "ge_expr";
				} else if (c == '!') {
					return "ne_expr";
				}
			} else if (c1 == '>' && c == '<') {
				token_buffer = token_buffer + (char) c1;
				return "ne_expr";
			} else {
				ungetc();
				if (c == '=') {
					return "assign";
				} else if (c == '<') {
					return "lt_expr";
				} else if (c == '>') {
					return "gt_expr";
				} else if (c == '*') {
					return "mult_expr";
				} else if (c == '/') {
					return "trunc_div_expr";
				} else if (c == '%') {
					return "trunc_mod_expr";
				} else if (c == '+') {
					return "plus_expr";
				} else if (c == '-') {
					return "minus_expr";
				} else if (c == '?') {
					return "question_mark_expr";
				}
			}
			System.out.println((char) c);
			throw new Exception();
		} else if (c == '(') {
			token_buffer = token_buffer + (char) c;
			return "left_bracket";
		} else if (c == ')') {
			token_buffer = token_buffer + (char) c;
			return "right_bracket";
		} else {
			System.out.println((char) c);
			throw new Exception();
		}
	}

}
