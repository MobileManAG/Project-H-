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
<%@ tag description="Man tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%-- yes no answers --%>
		<table>
			<tr>
			<td><div id="divcv${currentQuestion.id}${question_yes_answers[currentQuestion.id].id}" class="yesnoAnswer<c:if test='${readonly}'>Readonly</c:if>">${question_yes_answers[currentQuestion.id].explanation==null?question_yes_answers[currentQuestion.id].answer:question_yes_answers[currentQuestion.id].explanation}</div></td>
			<td><div id="divcv${currentQuestion.id}${question_no_answers[currentQuestion.id].id}" class="yesnoAnswer<c:if test='${readonly}'>Readonly</c:if>">${question_no_answers[currentQuestion.id].explanation==null?question_no_answers[currentQuestion.id].answer:question_no_answers[currentQuestion.id].explanation}</div></td>
			</tr>
		</table>		
		<input type="hidden" name="cv${currentQuestion.id}" id="cv${currentQuestion.id}" value="" />
		<script>
		
			function updateButton${currentQuestion.id}() {
				var yesdiv = $("#divcv${currentQuestion.id}${question_yes_answers[currentQuestion.id].id}");
				var nodiv = $("#divcv${currentQuestion.id}${question_no_answers[currentQuestion.id].id}");
				var hidd = $("#cv${currentQuestion.id}");

				var value = hidd.val();
				yesdiv.removeClass("yesAnswer");
				nodiv.removeClass("noAnswer");
				yesdiv.removeClass("answerHover");
				nodiv.removeClass("answerHover");
				
				if(value==${question_yes_answers[currentQuestion.id].id}) {
					//yes answer
					yesdiv.addClass("yesAnswer");
					nodiv.addClass("answerHover");
				}
				if(value==${question_no_answers[currentQuestion.id].id}) {
					//no answer
					nodiv.addClass("noAnswer");
					yesdiv.addClass("answerHover");
				}
			}
		
			$(document).ready(function(){
				//click jedno div - nastav hidden
				//click druhe div - nastav hidden
				var yesdiv = $("#divcv${currentQuestion.id}${question_yes_answers[currentQuestion.id].id}");
				var nodiv = $("#divcv${currentQuestion.id}${question_no_answers[currentQuestion.id].id}");
				var hidd = $("#cv${currentQuestion.id}");
				
				updateButton${currentQuestion.id}();
				
				<c:if test="${readonly!=true}">
				yesdiv.click(function(){
					var value = hidd.val();
					if(value==${question_yes_answers[currentQuestion.id].id}) {
						hidd.val('');
					}else{
						hidd.val(${question_yes_answers[currentQuestion.id].id});
					}
					updateButton${currentQuestion.id}();
				});

				nodiv.click(function(){
					var value = hidd.val();
					if(value==${question_no_answers[currentQuestion.id].id}) {
						hidd.val('');
					}else{
						hidd.val(${question_no_answers[currentQuestion.id].id});
					}
					updateButton${currentQuestion.id}();
				});
				</c:if>
			});
			
		</script>
		
