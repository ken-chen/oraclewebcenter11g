package au.com.holden.web;

import java.util.List;

/*
 * POJO to be used from JSP to load an Association between Basic Assets
 * 
 *
 */

public class AssetAssociation {

	private String name;
	private List<BasicAssetType> assetDestination;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<BasicAssetType> getAssetDestination() {
		return assetDestination;
	}

	public void setAssetDestination(List<BasicAssetType> assetDestination) {
		this.assetDestination = assetDestination;
	}

}
