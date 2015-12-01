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
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<m:patientMasterMenu  print="${print}" menuitem="0" caption="Pers&ouml;nlicher Bericht">
<jsp:attribute name="header">
	<script src="<c:url value="/scripts/highcharts.js" />"></script>
	<script src="<c:url value="<script src="<c:url value="https://code.highcharts.com/highcharts.js" />"></script>" />"></script>
</jsp:attribute>
<jsp:body>
<r:report prefix="patient" />
<script>
$(document).ready(function () {
	if('${print}' == 'true'){
		$("#first_page_break").show();
		$(".page_break").each(function (index, domEle) {
			$(domEle).show();
		});
		$("#print_header").show();
		$("#print_footer").show();
		window.onload = setTimeout("window.print()", 1000);
	}
});
</script>
</jsp:body>        
</m:patientMasterMenu>

