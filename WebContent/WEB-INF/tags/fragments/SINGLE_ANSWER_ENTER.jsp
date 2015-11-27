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
<table width="100%">
<tr><td width="50%" style="vertical-align: top;">${currentQuestion.text}</td>
<td>
<c:choose> 
<c:when test="${currentQuestion.questionType.answerDataType=='DATE'}">
<t:date id="cq${currentQuestion.id}" />
</c:when>
<c:when test="${currentQuestion.questionType.answerDataType=='IMAGE'}">
<c:choose>
	<c:when test="${readonly}">
	<img src="<c:url value="/patient/previewimage"/>" width="200" />
	</c:when>
	<c:otherwise>
		<c:if test="${sessionScope.UploadedFileName!=null}" >
			<img src="<c:url value="/patient/previewimage"/>" width="200" />
		</c:if>
		<input type="file" name="file"/>
		<script>
			var suffix="/fileupload";
			var action = $("#mainForm").attr("action");
			//endswith
			if(action.indexOf(suffix, action.length - suffix.length) !== -1) {
			}else{
				$("#mainForm").attr("action", action + suffix);
			}
		</script>
	</c:otherwise>
</c:choose>
</c:when>
<c:otherwise>
	<textarea rows="10" cols="40" name="cq${currentQuestion.id}" id="cq${currentQuestion.id}"></textarea>
</c:otherwise>
</c:choose>
</td>
</tr>
</table>
