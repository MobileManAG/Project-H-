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
<div style="margin-top:10px; margin-bottom: 10px; text-align: center;">${currentHaqChart.title}</div>
<div id="textHolder${currentHaqChart.id}" style="height: 400px; width: 644px; overflow: auto;">
<table id="tableTextHolder${currentHaqChart.id}">
<c:forEach var="txt" items="${haqChart_data[currentHaqChart.id]}">
	<tr><td valign="top">${txt[0]}</td><td>${txt[1]}</td></tr>
</c:forEach>
</table>
</div>
<script>
	$(document).ready(function(){
        $("#tableTextHolder${currentHaqChart.id} tr:even").css("background-color", "#F5F5F5");
	});
</script>
