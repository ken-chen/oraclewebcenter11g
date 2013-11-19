<%@ taglib prefix="cs" uri="futuretense_cs/ftcs1_0.tld"
%><%@ taglib prefix="asset" uri="futuretense_cs/asset.tld"
%><%@ taglib prefix="assetset" uri="futuretense_cs/assetset.tld"
%><%@ taglib prefix="commercecontext" uri="futuretense_cs/commercecontext.tld"
%><%@ taglib prefix="ics" uri="futuretense_cs/ics.tld"
%><%@ taglib prefix="listobject" uri="futuretense_cs/listobject.tld"
%><%@ taglib prefix="render" uri="futuretense_cs/render.tld"
%><%@ taglib prefix="searchstate" uri="futuretense_cs/searchstate.tld"
%><%@ taglib prefix="siteplan" uri="futuretense_cs/siteplan.tld"
%><%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   com.fatwire.assetapi.data.*,
                   com.fatwire.assetapi.*,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%--

INPUT
	Service/AssetFactory
OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

	<c:set var="cid"><ics:getvar name="cidAsset" /></c:set>
	<c:set var="c"><ics:getvar name="cAsset" /></c:set>
	<c:set var="template"><ics:getvar name="templateAsset" /></c:set>
	
	<render:callelement elementname="Common/AssetModel/loadBasicAsset">
		<render:argument name="cid" value="${cid}" />
		<render:argument name="c" value="${c}" />
		<render:argument name="attributes" value="sortOrder,serviceManufacturer,heading,features,body" />
		<render:argument name="assocs" value="serviceImage,youtubeVideo,serviceLink" />
	</render:callelement>
	<c:remove var="serviceBean" />
	
	<%--  Remove few vars --%>
	
	<jsp:useBean id='serviceBean' class='java.util.HashMap' scope="request"/>
	<c:set target="${serviceBean}" property="sortOrder" value="${bean.attributes[0].value}"/>
	<c:set target="${serviceBean}" property="serviceManufacturer" value="${bean.attributes[1].value}"/>
	<c:set target="${serviceBean}" property="heading" value="${bean.attributes[2].value}"/>
	<c:set target="${serviceBean}" property="features" value="${bean.attributes[3].value}"/>
	<c:set target="${serviceBean}" property="body" value="${bean.attributes[4].value}"/>
	
	
	<c:set target="${serviceBean}" property="serviceImage_c" value="${bean.associations[0].assetDestination[0].type}"/>
	<c:set target="${serviceBean}" property="serviceImage_cid" value="${bean.associations[0].assetDestination[0].id}"/>
	<c:set target="${serviceBean}" property="youtubeVideo_c" value="${bean.associations[1].assetDestination[0].type}"/>
	<c:set target="${serviceBean}" property="youtubeVideo_cid" value="${bean.associations[1].assetDestination[0].id}"/>
	<c:set target="${serviceBean}" property="serviceLink_c" value="${bean.associations[2].assetDestination[0].type}"/>
	<c:set target="${serviceBean}" property="serviceLink_cid" value="${bean.associations[2].assetDestination[0].id}"/>
	
	<render:callelement elementname="${c}/${template}" scoped="global">
		<render:argument name="cidAsset" value="${cid}" />
		<render:argument name="cAsset" value="${c}" />
	</render:callelement>

</cs:ftcs>
