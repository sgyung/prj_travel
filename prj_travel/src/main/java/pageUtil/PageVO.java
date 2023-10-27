package pageUtil;

public class PageVO {
	private int startNum, endNum;
	private String field, keyword;
	
	public PageVO() {
		
	}

	public PageVO(int startNum, int endNum, String field, String keyword) {
		super();
		this.startNum = startNum;
		this.endNum = endNum;
		this.field = field;
		this.keyword = keyword;
	}

	public int getStartNum() {
		return startNum;
	}

	public void setStartNum(int startNum) {
		this.startNum = startNum;
	}

	public int getEndNum() {
		return endNum;
	}

	public void setEndNum(int endNum) {
		this.endNum = endNum;
	}

	public String getField() {
		return field;
	}

	public void setField(String field) {
		this.field = field;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "PageVO [startNum=" + startNum + ", endNum=" + endNum + ", field=" + field + ", keyword=" + keyword
				+ "]";
	}
	
	
}
