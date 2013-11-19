package au.com.holden.web;

import java.util.HashMap;
import java.util.List;

import au.com.holden.domain.Asset;

/*
 * POJO to be used from JSP to load a Basic Asset
 * 
 * @author Ken Chen
 */

public class BasicAssetType extends Asset {

	private String category;
	private String type;
	private String status;
	private String startDate;
	private String endDate;
	private String template;
	private String subtype;

	private List<AssetAssociation> associations;
	private List<HashMap<String, String>> attributes;

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
	}

	public String getTemplate() {
		return template;
	}

	public void setTemplate(String template) {
		this.template = template;
	}

	public String getSubtype() {
		return subtype;
	}

	public void setSubtype(String subtype) {
		this.subtype = subtype;
	}

	public List<AssetAssociation> getAssociations() {
		return associations;
	}

	public void setAssociations(List<AssetAssociation> associations) {
		this.associations = associations;
	}

	public List<HashMap<String, String>> getAttributes() {
		return attributes;
	}

	public void setAttributes(List<HashMap<String, String>> attributes) {
		this.attributes = attributes;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

}
