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
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc"%>
<c:forEach var="data" items="${haqChart_data[currentHaqChart.id]}" varStatus="status">
<r:pieImpl height="160" width="320" data="${data[0]}" id="${currentHaqChart.id}i${status.index}"
	title="${data[1]}"  style="float: left;" />
</c:forEach>
<div style="clear: both;"></div>
