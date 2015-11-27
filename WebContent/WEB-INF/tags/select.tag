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
<%@ attribute name="name" required="true" rtexprvalue="true" %>
<%@ attribute name="size" required="false" rtexprvalue="true" %>

<script>
	var curval = "${postValues[name]}";
	$(document).ready(function(){
		$("#${name} option[value='" + curval + "']").attr("selected", "selected");
	});
</script>
<select id="${name}" name="${name}" size="${size==null?'1':size}">
	<jsp:doBody />
</select>