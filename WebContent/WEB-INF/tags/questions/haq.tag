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
<%@ attribute name="haq" required="true" rtexprvalue="true" type="com.mobileman.projecth.domain.disease.Haq"%>

<c:if test="${haq.tag==null}">
<c:forEach var="question" items="${haq.questions}" varStatus="status">
	<div class="questionFrame" <c:if test="${status.index % 2 == 1}">style="background-color: #F5F5F5"</c:if>>
	<q:question question="${question}"/>
	</div>
</c:forEach>
</c:if>
<c:if test="${haq.tag!=null}">
<c:set var="currentHaq" value="${haq}" scope="request" />
	<c:import url="../../tags/fragments/${haq.tag}.jsp" />
</c:if>
