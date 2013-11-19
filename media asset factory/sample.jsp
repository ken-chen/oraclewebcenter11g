<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="blobservice" uri="futuretense_cs/blobservice.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="listobject" uri="futuretense_cs/listobject.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="searchstate" uri="futuretense_cs/searchstate.tld"
%><%@ taglib prefix="siteplan" uri="futuretense_cs/siteplan.tld"
%><%@ taglib prefix="holden" uri="http://www.holden.com.au/tags"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="media" uri="http://www.holden.com.au/tags/media"
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- DynamicFlashElement

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

    <assetset:setasset name="theFlash" type='<%=ics.GetVar("c")%>' id='<%=ics.GetVar("cid")%>'/>
	<assetset:getattributevalues name="theFlash" attribute="SWFFile" typename="Media_A" listvarname="SWFFileList" />
	<assetset:getattributevalues name="theFlash" attribute="Flashvars" typename="Media_A" listvarname="FlashVarsList" />
	<assetset:getattributevalues name="theFlash" attribute="FlashParams" typename="Media_A" listvarname="FlashParamsList" />
	<assetset:getattributevalues name="theFlash" attribute="SWFWidth" typename="Media_A" listvarname="SWFWidthList" />
	<assetset:getattributevalues name="theFlash" attribute="SWFHeight" typename="Media_A" listvarname="SWFHeightList" />	
	<assetset:getattributevalues name="theFlash" attribute="SWFVersion" typename="Media_A" listvarname="SWFVersionList" />	
	<assetset:getattributevalues name="theFlash" attribute="FlashAttributes" typename="Media_A" listvarname="FlashAttributesList" />
	<assetset:getattributevalues name="theFlash" attribute="NoFlashImage" typename="Media_A" listvarname="ReplacementImageList" />		
	<assetset:getattributevalues name="theFlash" attribute="NoFlashElementId" typename="Media_A" listvarname="NoFlashElementIdList" />
	<assetset:getattributevalues name="theFlash" attribute="YoutubeIdMobile" typename="Media_A" listvarname="YoutubeIdMobileList" />		
	<assetset:getattributevalues name="theFlash" attribute="ResourcesURL" typename="Media_A" listvarname="ResourcesURLList" />		
	
	<ics:if condition='<%= ics.GetList("ResourcesURLList").hasData() %>'>
		<ics:then>
			<ics:listget listname="ResourcesURLList" fieldname="value" output="resourcesURL"/>
			<c:set var="resourcesURL"><ics:getvar name="resourcesURL" /></c:set>
		</ics:then>
	</ics:if>	
		
	<ics:if condition='<%= ics.GetList("SWFWidthList").hasData() %>'>
		<ics:then>
			<ics:listget listname="SWFWidthList" fieldname="value" output="SWFWidth"/>
			<c:set var="swfwidth"><ics:getvar name="SWFWidth" /></c:set>
		</ics:then>
	</ics:if>
	
	<ics:if condition='<%= ics.GetList("ReplacementImageList").hasData() %>'>
		<ics:then>
			<ics:listget listname="ReplacementImageList" fieldname="value" output="ReplacementImage"/>
			<c:set var="replacementImage"><ics:getvar name="ReplacementImage" /></c:set>
		</ics:then>
	</ics:if>
	
	<ics:if condition='<%= ics.GetList("NoFlashElementIdList").hasData() %>'>
		<ics:then>
			<ics:listget listname="NoFlashElementIdList" fieldname="value" output="flashdiv"/>
			<c:set var="flashdiv"><ics:getvar name="flashdiv" /></c:set>
		</ics:then>
	</ics:if>
	
	<ics:listget listname="SWFFileList" fieldname="value" output="SWFFileID"/>
	
	<ics:listget listname="SWFHeightList" fieldname="value" output="SWFHeight"/>
	<c:set var="swfheight"><ics:getvar name="SWFHeight" /></c:set>
	<ics:listloop listname="SWFVersionList">
	<ics:listget listname="SWFVersionList" fieldname="value" output="SWFVersion"/>
		<c:set var="swfversion"><ics:getvar name="SWFVersion" /></c:set>
	</ics:listloop>
	<ics:if condition='<%= ics.GetList("YoutubeIdMobileList").hasData() %>'>
		<ics:then>
			<ics:listget listname="YoutubeIdMobileList" fieldname="value" output="youtubeID"/>
			<c:set var="youtubeID"><ics:getvar name="youtubeID" /></c:set>
		</ics:then>
	</ics:if>
	
	<blobservice:gettablename varname="blobTable"/>
        <blobservice:getidcolumn varname="blobIdColumn"/>
        <blobservice:geturlcolumn varname="blobUrlColumn"/>
        <render:getbloburl blobtable='<%=ics.GetVar("blobTable")%>' blobkey='<%=ics.GetVar("blobIdColumn")%>' blobwhere='<%=ics.GetVar("SWFFileID")%>' blobcol='<%=ics.GetVar("blobUrlColumn")%>' outstr="swfURL" /> 
	
	<c:choose>
		<c:when test="${not empty flashdiv}">
		</c:when>
		<c:when test="${not empty replacementImage}">
			<div id="flash">
			    <c:set var="flashdiv">flash</c:set>
				<media:image id="${replacementImage}" var="noFlashImage"/>
				<div id="noflash" style="background:url('${noFlashImage.imageLocation}') no-repeat top center; height:${noFlashImage.imageHeight}px;">
					<c:if test="${not empty youtubeID}">
						<div id="youtubeVid">
						</div>	
					</c:if>					
				</div>
			</div>	
		</c:when>
		<c:otherwise>
			<render:callelement elementname="Global/js/NoFlashDefault"></render:callelement>
		</c:otherwise>
	</c:choose>
	

	<c:set var="variable"></c:set>
	<c:set var="index" value="1" />
	
	<ics:listloop listname="FlashVarsList">
		<ics:listget listname="FlashVarsList" fieldname="value" output="FlashVar"/>
		<c:if test="${index ne 1}">
			<c:set var="variable">${variable},</c:set>
		</c:if>
		<c:set var="variable">${variable}<ics:getvar name="FlashVar" /></c:set>
		<c:set var="index">${index + 1}</c:set>
	</ics:listloop>
		


</cs:ftcs>