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
%><%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"
%><%@ taglib prefix="blobservice" uri="futuretense_cs/blobservice.tld"
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors"
%><cs:ftcs><%-- Common/AssetModel/loadFlexAsset

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>


<c:set var="cid"><ics:getvar name="cid" /></c:set>
<c:set var="c"><ics:getvar name="c" /></c:set>
<c:set var="assocs"><ics:getvar name="assocs" /></c:set>
<c:set var="c_attr"><ics:getvar name="c_attr" /></c:set>

<c:if test="${!empty cid && !empty c}">

	<asset:load name="flex" type="${c}" objectid="${cid}" />
	<asset:get name="flex" field="flextemplateid" output="flexType" />
	<asset:get name="flex" field="name" output="ObjectName" />
	<asset:get name="flex" field="template" output="template" />
	
	<c:set var="flexType"><ics:getvar name="flexType" /></c:set>
	<c:set var="ObjectName"><ics:getvar name="ObjectName" /></c:set>
	<c:set var="template"><ics:getvar name="template" /></c:set>

	<asset:load name="flexDef" type="${c}Def" objectid="${flexType}" />
	<asset:get name="flexDef" field="name" output="flexName" />
	<c:set var="flexName"><ics:getvar name="flexName" /></c:set>

	<c:set var="flexBean" value="<%= new java.util.HashMap() %>" scope="request" />
	<c:set target="${flexBean}" property="id" value="${cid}" />
	<c:set target="${flexBean}" property="type" value="${c}" />
	<c:set target="${flexBean}" property="flexType" value="${flexName}" />
	<c:set target="${flexBean}" property="name" value="${ObjectName}" />
	<c:set target="${flexBean}" property="template" value="${template}" />

	<c:set var="sql">
	SELECT a.id as id, attr.name as name, 
	m.stringvalue as stringvalue, m.urlvalue as urlvalue,
	m.intvalue as intvalue, m.floatvalue as floatvalue,
	m.moneyvalue as moneyvalue, m.datevalue as datevalue,
	m.textvalue as textvalue, m.blobvalue as blobvalue
	FROM ${c}_Mungo m, ${c}_AMap a, ${c_attr} attr
	WHERE 
	m.cs_attrid = a.attributeid
	and m.cs_ownerid = ${cid} and attr.id = a.attributeid
	</c:set>

	<%-- 
		CHECK FOR MULTIVALUE attributes
	--%>

	<ics:sql table="${c}_Mungo,${c}_AMap,${c_attr}" listname="results" sql="${sql}" />
	
	<ics:listloop listname="results">
		<c:set var="id"><ics:listget listname="results" fieldname="id" /></c:set>
		<c:set var="value"><ics:listget listname="results" fieldname="stringvalue" /></c:set>
		<c:set var="name"><ics:listget listname="results" fieldname="name" /></c:set>
		<c:set var="value">${value}<ics:listget listname="results" fieldname="urlvalue" /></c:set>
		<c:set var="value">${value}<ics:listget listname="results" fieldname="intvalue" /></c:set>
		<c:set var="value">${value}<ics:listget listname="results" fieldname="floatvalue" /></c:set>
		<c:set var="value">${value}<ics:listget listname="results" fieldname="moneyvalue" /></c:set>
		<c:set var="value">${value}<ics:listget listname="results" fieldname="datevalue" /></c:set>
		<c:set var="value">${value}<ics:listget listname="results" fieldname="textvalue" /></c:set>
		<c:set target="${flexBean}" property="${fn:toLowerCase(name)}" value="${value}" />
		
		<c:if test="${empty value}">
			<c:set var="value"><ics:listget listname="results" fieldname="blobvalue" /></c:set>
			<c:if test="${!empty value}">
				<c:set var="url" value="" />
				
				<blobservice:gettablename varname="blobTable"/>
				<blobservice:getidcolumn varname="blobIdColumn"/>
				<blobservice:geturlcolumn varname="blobUrlColumn"/>
				<render:getbloburl blobtable='<%=ics.GetVar("blobTable")%>' blobkey='<%=ics.GetVar("blobIdColumn")%>' blobwhere='${value}' blobcol='<%=ics.GetVar("blobUrlColumn")%>' outstr="theURL" />
  
				<c:set var="url"><ics:getvar name="theURL" /></c:set>
				<c:if test="${!empty url}">
					<c:set target="${flexBean}" property="${fn:toLowerCase(name)}" value="${url}" />
				</c:if>
			</c:if>
		</c:if>
	</ics:listloop>

</c:if>

</cs:ftcs>