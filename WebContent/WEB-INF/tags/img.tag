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
<%@ tag description="Img tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@attribute name="src" required="true" rtexprvalue="true"%>
<%@attribute name="alt" required="false" %>
<%@attribute name="width" required="false" %>
<%@attribute name="height" required="false" %>
<%@attribute name="style" required="false" %>
<%@attribute name="xclass" required="false" rtexprvalue="true" %>
<%@attribute name="id" required="false" rtexprvalue="true" %>
<%@attribute name="onclick" required="false" rtexprvalue="true" %>
<%@attribute name="usemap" required="false" rtexprvalue="true"%>
<img src="<c:url value="/images/${src}" />"<t:attr attr="alt" value="${alt}"/><t:attr attr="width" value="${width}"/><t:attr attr="height" value="${height}"/><t:attr attr="style" value="${style}" /><t:attr attr="usemap" value="${usemap}"/><t:attr attr="xclass" value="${xclass}"/><t:attr attr="id" value="${id}"/><t:attr attr="onclick" value="${onclick}"/>/>
