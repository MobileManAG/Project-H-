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
<c:forEach var="answer" items="${currentQuestion.questionType.answers}">
<c:if test="${answer.active}">
	<div style="text-align: center; padding-bottom: 10px;">${currentQuestion.text}</div>
	<div style="text-align: center;"><span id="slidervalue${currentQuestion.id}">${answer.minValue}</span> ${answer.selectedValueTitle}</div>
	<table><tr>
	<td><div class="sliderminmax"><t:img src="smile0.png"/></div></td>
	<td><div id="slider${currentQuestion.id}"></div>
		<input type="hidden" name="cq${currentQuestion.id}" id="cq${currentQuestion.id}" />
		<input type="hidden" name="sliderinitcq${currentQuestion.id}" id="sliderinitcq${currentQuestion.id}" /></td>
	<td><div class="sliderminmax"><t:img src="smile100.png"/></div></td>	
	</tr></table>
	<script>
		$(document).ready(function(){
			//check value from sliderinit
			var initvalue=${answer.minValue};
			var newinit = $("#sliderinitcq${currentQuestion.id}").val(); 
			if(newinit!='') {
				initvalue = parseFloat(newinit);
			}
			$("#slidervalue${currentQuestion.id}").text(initvalue);
			$( "#slider${currentQuestion.id}" ).slider({
				value: initvalue,
				min: ${answer.minValue},
				max: ${answer.maxValue},
				step: ${answer.step},
				slide: function( event, ui ) {
					$("#cq${currentQuestion.id}" ).val(ui.value);
					$("#slidervalue${currentQuestion.id}").text(ui.value);
				}
			});
		});
	</script>	
</c:if>
</c:forEach>
