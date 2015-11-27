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
<%@ tag description="A tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="prefix" required="true" rtexprvalue="true" %>
<%@ attribute name="all" required="false" %>
<t:a href="date/1-w" dir="${prefix}" xclass="deflink">1 Woche</t:a> | 
<t:a href="date/2-w" dir="${prefix}" xclass="deflink">2 Wochen</t:a> | 
<t:a href="date/1-m" dir="${prefix}" xclass="deflink">1 Monat</t:a> | 
<t:a href="date/3-m" dir="${prefix}" xclass="deflink">3 Monate</t:a> |
<t:a href="date/6-m" dir="${prefix}" xclass="deflink">6 Monate</t:a> | 
<t:a href="date/1-y" dir="${prefix}" xclass="deflink">1 Jahr</t:a> |
<t:a href="date/2-y" dir="${prefix}" xclass="deflink">2 Jahre</t:a> |
<c:if test="${all==null}"><t:a href="date/0-a" dir="${prefix}" xclass="deflink">Gesamt</t:a></c:if>
<c:if test="${all!=null}"><t:a href="date/0-x" dir="${prefix}" xclass="deflink">Gesamt</t:a></c:if>
<br />
