<!--
Copyright 2015 MobileMan GmbH
www.mobileman.com

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

  http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
-->
<%@ tag description="Public master menu tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="header" fragment="true" %>
<%@ attribute name="print" required="false" rtexprvalue="true" %>
<%@ attribute name="title" required="false" rtexprvalue="true" %>
<%@ attribute name="menuitem" required="false" rtexprvalue="true" %>
<%@ attribute name="caption" required="false" rtexprvalue="true" %>
<%
	String[] smallHorizontalText= {
		};
	String[] smallHorizontalUrl= {
		};	
%>
<%@ include file="/WEB-INF/tags/menu/menucode.menuinc" %>
<c:set var="menu2" value="${menu.items['admin']}" scope="request" />
<m:masterMenu print="${print}" title="${title}" menulink="admin" logoutmenu="true" caption="${caption}">
	<jsp:attribute name="header">
		<link href="<c:url value="/styles/patient.css" />" rel="stylesheet" type="text/css">
		<jsp:invoke fragment="header" />
    </jsp:attribute>
    <jsp:attribute name="footer">
    	<t:footer dir="customer" />
    </jsp:attribute>
	<jsp:body>
    	<jsp:doBody />
    	<t:login />
    </jsp:body>
</m:masterMenu>
