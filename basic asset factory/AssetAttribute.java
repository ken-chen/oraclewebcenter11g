package au.com.holden.web;

/*
 * POJO to be used from JSP to load attributes between Basic Assets
 * 
 * 
 */
public class AssetAttribute {

	private String name = "";
	private String value = "";

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

}
