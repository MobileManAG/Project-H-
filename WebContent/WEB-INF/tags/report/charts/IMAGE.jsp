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
<div id="imagesHolder" style="height: 460px; width: 640px;">
<c:forEach var="img" items="${haqChart_data[currentHaqChart.id]}">
	<img src="<c:url value="/patient/getimage/${img[0]}"/>" style="max-width: 600px" title="Aufgenommen am ${img[1]}"/>
</c:forEach>
</div>
<div style="height: 40px;"></div>
<script>
Galleria.loadTheme('<c:url value="/scripts/galleria/themes/classic/galleria.classic.js"/>');
$('#imagesHolder').galleria();

</script>
