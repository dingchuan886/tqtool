package code_auto_gen;

public class Column {

	String tableName;

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	int num;
	Object columns[];
	Object dataTypes[];
	Object columnTypes[];

	Object columnComment[];

	Object columnDefalut[];

	public Object[] getColumnDefalut() {
		return columnDefalut;
	}

	public void setColumnDefalut(Object[] columnDefalut) {
		this.columnDefalut = columnDefalut;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public Object[] getColumnComment() {
		return columnComment;
	}

	public void setColumnComment(Object[] columnComment) {
		this.columnComment = columnComment;
	}

	String columnString;
	String columnString1;

	public String getColumnString1() {
		return columnString1;
	}

	public void setColumnString1(String columnString1) {
		this.columnString1 = columnString1;
	}

	public String getColumnString() {
		return columnString;
	}

	public void setColumnString(String columnString) {
		this.columnString = columnString;
	}

	public Object[] getColumns() {
		return columns;
	}

	public void setColumns(Object[] columns) {
		this.columns = columns;
	}

	public Object[] getDataTypes() {
		return dataTypes;
	}

	public void setDataTypes(Object[] dataTypes) {
		this.dataTypes = dataTypes;
	}

	public Object[] getColumnTypes() {
		return columnTypes;
	}

	public void setColumnTypes(Object[] columnTypes) {
		this.columnTypes = columnTypes;
	}

}
