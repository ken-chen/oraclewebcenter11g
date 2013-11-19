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
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Container/AssetFactory

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

	<c:set var="cid"><ics:getvar name="cidAsset" /></c:set>
	<c:set var="c"><ics:getvar name="cAsset" /></c:set>
	<c:set var="template"><ics:getvar name="templateAsset" /></c:set>
	<c:set var="dealerMode"><ics:getvar name="dealerMode" /></c:set>
	<c:set var="displayMessageAtButton"><ics:getvar name="displayMessageAtButton" /></c:set>
	
	
	<render:callelement elementname="xxx/sample">
		<render:argument name="cid" value="${cid}" />
		<render:argument name="c" value="${c}" />
		<render:argument name="attributes" value="title,css_class,columns,html_div_id" />
		<render:argument name="assocs" value="-,BackgroundImage" />
	</render:callelement>
	<c:remove var="containerBean" />
	
	<%--  Remove few vars --%>
	<ics:removevar name="img_width"/>
	<ics:removevar name="img_height"/>
	
	<jsp:useBean id='containerBean' class='java.util.HashMap' scope="request"/>
	<c:set target="${containerBean}" property="title" value="${bean.attributes[0].value}"/>
	<c:set target="${containerBean}" property="css_class" value="${bean.attributes[1].value}"/>
	<c:set target="${containerBean}" property="columns" value="${bean.attributes[2].value}"/>
	<c:set target="${containerBean}" property="html_div_id" value="${bean.attributes[3].value}"/>
	<c:set target="${containerBean}" property="image_c" value="${bean.associations[1].assetDestination[0].type}"/>
	<c:set target="${containerBean}" property="image_cid" value="${bean.associations[1].assetDestination[0].id}"/>
	
	<c:set var="unnamed" value="${bean.associations[0]}" scope="request"/>
	<render:callelement elementname="${c}/${template}" scoped="global">
		<render:argument name="cidAsset" value="${cid}" />
		<render:argument name="cAsset" value="${c}" />
	</render:callelement>

</cs:ftcs>