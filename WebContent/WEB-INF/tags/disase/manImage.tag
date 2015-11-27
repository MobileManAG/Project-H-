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
<%@ tag description="Man tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="prefix" required="true" rtexprvalue="true"%>
<%@ attribute name="image" required="true" rtexprvalue="true"%>
<%@ attribute name="style" required="false"%>
<%
	String prefix = (String)jspContext.getAttribute("prefix");
	String image = (String)jspContext.getAttribute("image");
	String prefix2 = image.replace('/','x').replace('.','x');
	jspContext.setAttribute("prefix2",prefix + prefix2);
%>
<div class="relativePos" <c:if test="${style!=null}">style="${style}"</c:if>>
<img src="<c:url value="/images/${image}" />" usemap="#${prefix2}-manmap" class="relativePos" /> 
<map name="${prefix2}-manmap">
	<jsp:doBody />
</map>
<span id="${prefix2}-holder"></span>
</div>
