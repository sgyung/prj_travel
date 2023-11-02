package admin.vo;

public class ConvenienceVO {
	private String id;
	private String convenienceName;
	
	public ConvenienceVO() {
		
	}

	public ConvenienceVO(String id, String convenienceName) {
		super();
		this.id = id;
		this.convenienceName = convenienceName;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getConvenienceName() {
		return convenienceName;
	}

	public void setConvenienceName(String convenienceName) {
		this.convenienceName = convenienceName;
	}

	@Override
	public String toString() {
		return "ConvenienceVO [id=" + id + ", convenienceName=" + convenienceName + "]";
	}
	
	
	
}
