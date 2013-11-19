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

%><%@page import="org.apache.commons.lang.StringUtils"

%><%@ page import="COM.FutureTense.Interfaces.*,

                   COM.FutureTense.Util.ftMessage,

                   COM.FutureTense.Util.ftErrors"

%><cs:ftcs><%-- HTMLModule_C/AssetFactory



INPUT



OUTPUT



--%>

<%-- Record dependencies for the SiteEntry and the CSElement --%>

<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>

<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>



    <c:set var="cid"><ics:getvar name="cidAsset" /></c:set>

	<c:set var="c"><ics:getvar name="cAsset" /></c:set>

	

	<asset:getsubtype objectid='<%= ics.GetVar("cidAsset") %>' type='HTMLModule_C' output="subtype" />

	<ics:if condition='<%=StringUtils.isBlank(ics.GetVar("subtype")) %>'>

	   <ics:then>

	      <asset:getsubtype objectid='<%= ics.GetVar("cid") %>' type='HTMLModule_C' output="subtype" />

	   </ics:then>

	</ics:if>



	<render:calltemplate 

		tname='<%= "HLD" + ics.GetVar("subtype") + "Detail" %>'

		c='HTMLModule_C'

		cid='${cid}'

		site='<%= ics.GetVar("site") %>'

		tid='<%= ics.GetVar("tid") %>' />



</cs:ftcs>