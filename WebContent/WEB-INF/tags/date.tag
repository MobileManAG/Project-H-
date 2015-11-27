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
<%@ tag description="Date tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="id" required="true" rtexprvalue="true"%>
<input style="width: 100px; float:left;" name="${id}" type="text" id="${id}" />
<c:if test="${readonly==null}">
<script>
$(document).ready(function() {
	$( "#${id}" ).datepicker({
		showOn: "button",
		buttonImage: "<c:url value="/images/calendar.png" />",
		buttonImageOnly: true
	});
});
</script>
</c:if>
