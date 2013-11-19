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
%><%@ taglib  prefix="fn"uri="http://java.sun.com/jsp/jstl/functions" 
%><%@ page import="COM.FutureTense.Interfaces.*,
                   COM.FutureTense.Util.ftMessage,
                   COM.FutureTense.Util.ftErrors,
                   java.util.HashMap,
                   java.util.ArrayList,
                   xxx.AssetAssociation,
                   xxx.AssetAttribute,
                   xxx.BasicAssetType"
%><cs:ftcs><%-- 

INPUT

OUTPUT

--%>
<%-- Record dependencies for the SiteEntry and the CSElement --%>
<ics:if condition='<%=ics.GetVar("seid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("seid")%>' c="SiteEntry"/></ics:then></ics:if>
<ics:if condition='<%=ics.GetVar("eid")!=null%>'><ics:then><render:logdep cid='<%=ics.GetVar("eid")%>' c="CSElement"/></ics:then></ics:if>

<c:set var="cid"><ics:getvar name="cid" /></c:set>
<c:set var="c"><ics:getvar name="c" /></c:set>
<c:set var="sitename"><ics:getvar name="site" /></c:set>
<c:set var="attributes"><ics:getvar name="attributes" />,id,name,status,subtype,template</c:set>
<c:set var="assocs"><ics:getvar name="assocs" /></c:set>

<jsp:useBean id='bean' class='BasicAssetType' scope="request"/>
<asset:load name="asset" type="${c}" objectid="${cid}" />
<asset:scatter name="asset" prefix="pre" />
            
	<%-- Check asset status --%>
	<c:set target="${bean}" property="status"><ics:getvar name="pre:status" /></c:set>

	<%-- Check the asset belongs to this site --%>
	<c:set var="tempAssetId"><ics:getvar name="pre:id" /></c:set>
	<ics:setvar name="assetid" value="${tempAssetId}" />
	
	<c:if test="${bean.status ne 'VO'}">	
		<c:set target="${bean}" property="type" value="${c}" />
		<c:set target="${bean}" property="id" value="${cid}" />
		<%  ArrayList<AssetAttribute> listAttrs = new ArrayList<AssetAttribute>(); %>
		
		<%-- Get attributes and load them into the HashMap bean --%>
		<c:forEach items="${attributes}" var="attribute" varStatus="status">
			
			<c:set var="attr" value="<%= new AssetAttribute() %>" scope="page" />
			<c:set target="${attr}" property="name" value="${attribute}"/>
			<c:set target="${attr}" property="value"><ics:getvar name="pre:${fn:toLowerCase(attribute)}" /></c:set>
			<%  
				AssetAttribute lv = (AssetAttribute) pageContext.getAttribute("attr");
				listAttrs.add(lv);
			%>
		</c:forEach>
		
		<c:set target="${bean}" property="attributes" value="<%= listAttrs  %>" />
		<ics:logmsg name="cselement.Common.AssetModel.loadBasicAsset" msg="##CC" severity="debug"/>
	
		<%-- Get asset associations and load them into the HashMap --%>
		<%  ArrayList<AssetAssociation> listAssocs= new ArrayList<AssetAssociation>(); 
		%>
		<c:forEach items="${assocs}" var="item" varStatus="status">
			<%-- Named associations --%>
			<asset:children name="asset" list="list" code="${item}" order="nrank" />

			<ics:if condition='<%= ics.GetList("list") != null && ics.GetList("list").hasData() %>' >
				<ics:then>
					<c:set var="association" value="<%= new AssetAssociation()%>" scope="page"/>
					<c:set target="${association}" property="name" value="${item}" />
					<% ArrayList<BasicAssetType> basicAssets = new  ArrayList<BasicAssetType>();%>
				   
				 	<%--  loop through the assets associated to that association --%>
				    <ics:listloop listname="list">
				        <ics:listget listname="list" fieldname="oid" output="objectId" />
				        <ics:listget listname="list" fieldname="otype" output="objectType" />
				       
				        <c:set var="basicAsset" value="<%= new BasicAssetType() %>" scope="page" />
				        <c:set target="${basicAsset}" property="id"><ics:getvar name="objectId" /></c:set>
				     	<c:set target="${basicAsset}" property="type"><ics:getvar name="objectType" /></c:set>
				        <% // Load asset to retrieve template %>
				        <asset:load name="assetAssociated" type="${basicAsset.type}" objectid="${basicAsset.id}"/>
				     	<asset:get name="assetAssociated" field="template" output="assetAssociated:template" />
				     	<c:set target="${basicAsset}" property="template"><ics:getvar name="assetAssociated:template" /></c:set>

						<%  
							BasicAssetType basicAssetAssoci = (BasicAssetType) pageContext.getAttribute("basicAsset");
							basicAssets.add(basicAssetAssoci);
						%>
				    </ics:listloop>
				    <%--  Set the association --%>
				    <c:set target="${association}" property="assetDestination" value="<%= basicAssets %>" />
				    <%  
				    		AssetAssociation assoc = (AssetAssociation) pageContext.getAttribute("association");
				   			listAssocs.add(assoc);
					%>
				</ics:then>
				<ics:else>
					<%  
						ArrayList<BasicAssetType> basicAssets2 = new  ArrayList<BasicAssetType>(); %>
					<c:set var="basicAsset" value="<%= new BasicAssetType() %>" scope="page" />
					<%
						BasicAssetType basicAssetAssoci2 = (BasicAssetType) pageContext.getAttribute("basicAsset");
						basicAssets2.add(basicAssetAssoci2);
					%>
					<c:set var="association" value="<%= new AssetAssociation()%>" scope="page"/>
					<c:set target="${association}" property="assetDestination" value="<%= basicAssets2 %>" />
				    <%  
				    		AssetAssociation assoc = (AssetAssociation) pageContext.getAttribute("association");
				   			listAssocs.add(assoc);
					%>
				</ics:else>
			</ics:if>
		</c:forEach>
		<ics:logmsg name="cselement.Common.AssetModel.loadBasicAsset" msg="##ASSOCIATIONS = <%= listAssocs %>" severity="debug"/>
		<c:set target="${bean}" property="associations" value="<%= listAssocs %>" />
	</c:if>
</cs:ftcs>