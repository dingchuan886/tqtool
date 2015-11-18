<%@ page contentType="text/html;charset=GBK"%>
<%@ page	import="java.util.*"%>
<form action="code_auto_gen.jsp" method="post">
<p>Sql: <input name="sql" value="" size="200" type="text"/></p>
<p>多个表Sql: <input name="sql1" value="" size="200" type="text"/></p>
<p><input name="submit"  type="submit" /></p>
</form>


<%
String result="";
String sql=request.getParameter("sql");
if(sql==null){
	result="";
	sql="";
}
String sql1=request.getParameter("sql1");
if(sql1==null){
	result="";
	sql1="";
}

if(sql.length()<10&&sql1.length()<10){
	result="sql is error";
}
else if (sql.length()>10){
	System.out.println(sql);
	code_auto_gen.DB_Tool.test();
	code_auto_gen.SqlCodeAutoGen.loadMethodMap();
	sql=sql.trim();
	sql = sql.substring(0, 7).toLowerCase() + sql.substring(7, sql.length());
	// 判断sql是select 还是update
	if (sql.indexOf("select ") == 0) {
		result=code_auto_gen.SqlCodeAutoGen.createSql(sql);
	} else if (sql.indexOf("update ") == 0) {
		result=code_auto_gen.SqlCodeAutoGen.createUpdateSql(sql);
	} else {
		result="sql is no select or update";
	}
}else if (sql1.length()>10){
	System.out.println(sql1);
	code_auto_gen.DB_Tool.test();
	code_auto_gen.SqlCodeAutoGen.loadMethodMap();
	sql1=sql1.trim();
	result=code_auto_gen.SqlCodeAutoGen.createComplicatedSql(sql1);
}
%>
<%=result%>