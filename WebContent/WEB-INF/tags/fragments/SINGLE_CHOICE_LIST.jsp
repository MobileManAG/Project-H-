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
	<c:when test="${question_yes_answers[currentQuestion.id]!=null}">
		<q:yesNoButtons />
	</c:when>
	<c:otherwise>
	
		<c:choose>
			<c:when test="${currentQuestion.tag=='comboBox'}">
				<select id="cv${currentQuestion.id}" name="cv${currentQuestion.id}" <c:if test="${readonly!=null}">disabled="disabled"</c:if>>
					<c:forEach var="answer" items="${currentQuestion.questionType.answers}">
					<q:answerNoAnswer answer="${answer}"> 
					<option value="${answer.id}">${answer.explanation==null?answer.answer:answer.explanation}</option>
					<br />
					</q:answerNoAnswer>
					</c:forEach>
				</select>	
				<input type="hidden" name="comboinitcv${currentQuestion.id}" id="comboinitcv${currentQuestion.id}" value="" />
				<script>
					$(document).ready(function(){
						$("#cv${currentQuestion.id}").val($("#comboinitcv${currentQuestion.id}").val());
					});
				</script>	
			</c:when>
			<c:otherwise>
			<%-- normal processing --%>
			<table>
			<c:forEach var="answer" items="${currentQuestion.questionType.answers}" varStatus="status">
			<q:answerNoAnswer answer="${answer}">
			<c:set var="totalAnswers" value="${status.index}"/> 
			<tr>
				<td><div class="scaleAnswer<c:if test='${readonly}'>Readonly</c:if> scalediv${currentQuestion.id}" id="answerdiv${answer.id}">X</div>
					<input type="hidden" id="tmpanswer${answer.id}" value="${status.index}"/>
				</td>
				<td>${answer.explanation==null?answer.answer:answer.explanation}</td>
			</tr>
			</q:answerNoAnswer>
			</c:forEach>
			</table>
			<input type="hidden" name="cv${currentQuestion.id}" id="cv${currentQuestion.id}" value="" />
			<script>
				$(document).ready(function(){
					//click jedno div - nastav hidden
					//click druhe div - nastav hidden
					var hidd = $("#cv${currentQuestion.id}");
					function updateDivs() {
						var all = $(".scalediv${currentQuestion.id}"); 
						all.css("background-color","");
						all.css("color", "");
						all.addClass("answerHover");
						
						//all.text('');
						var value = $("#cv${currentQuestion.id}").val();
						var selected = all.filter("#answerdiv" + value);
						selected.css("color","#FFFFFF");
						selected.removeClass("answerHover");
						var index = parseInt($("#tmpanswer" + value).val());
						selected.css("background-color", getScaleColor(index, ${totalAnswers} + 1));
						//selected.text('X');
					}
					
					updateDivs();
					<c:if test="${readonly!=true}">
					$(".scalediv${currentQuestion.id}").click(function(){
						var v1 = $(this).attr("id").substring(9);
						var v2 = hidd.val();
						var res = false;
						if(v1==v2){
							hidd.val('');
						}else{
							hidd.val(v1);
							res = true;
						}
						updateDivs();
						<c:if test="${currentQuestion.tag!=null}">
						var tag = "${currentQuestion.tag}";
						var spl = tag.split(" ");
						$("#" + spl[0]).val(res?spl[1]:'');
						eval(spl[2]);
						</c:if>
					});
					</c:if>				
				});
				
			</script>
			
			</c:otherwise> 
			
		</c:choose>
	
				
	</c:otherwise>
	<%--
	<c:otherwise>
		<c:forEach var="answer" items="${currentQuestion.questionType.answers}">
			<q:answerNoAnswer answer="${answer}"> 
			<t:radio name="cv${currentQuestion.id}" value="${answer.id}" label="${answer.explanation==null?answer.answer:answer.explanation}" rtl=""/>
			<br />
			</q:answerNoAnswer>
		</c:forEach>
	</c:otherwise>
	 --%>
</c:choose>
</td>
</tr>
</table>
