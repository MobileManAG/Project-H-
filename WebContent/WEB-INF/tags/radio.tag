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
<%@ tag description="Checkbox tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="name" required="true" rtexprvalue="true"%>
<%@ attribute name="value" required="true" rtexprvalue="true"%>
<%@ attribute name="label" required="false" rtexprvalue="true"%>
<%@ attribute name="rtl" required="false" %>
<%@ attribute name="xclass" required="false" %>
<%@ attribute name="checked" required="false" rtexprvalue="true"%>
<c:if test="${rtl==null || rtl==''}">
<input type="radio" value="${value}" name="${name}" id="${name}${value}" <c:if test="${checked}" >checked</c:if><t:attr attr="xclass" value="${xclass}"/>/><label for="${name}${value}">${label}</label>
</c:if>
<c:if test="${rtl!=null && rtl!=''}">
<label for="${name}${value}">${label}</label><input type="radio" value="${value}" name="${name}" id="${name}${value}" <c:if test="${checked}" >checked</c:if><t:attr attr="xclass" value="${xclass}"/>/>
</c:if>
