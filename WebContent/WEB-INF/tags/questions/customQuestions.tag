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
<%@ tag description="Custom Questions" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="prefix" required="true" %>
<form id="prepared_question1" style='display: none'>
	<input style="display: none" class="type" name="type" type="text" id="type" value="0" />
	<input style="display: none" class="q_id" name="q_id" type="text" id="q_id" />
	<input style="display: none" class="action" name="action" type="text" id="action" value="NEW"/>
	<table width="640">
		<tr>
			<td>
				<div class="questionTableHeader">
					<table>
						<tr>
							<td width="440">
								<h3>
									<font face="Arial, Helvetica, sans-serif">Ja/Nein Frage</font>
								</h3>
							</td>
							<td width="200">
								<div class="edit_question" style="display: none;">Bearbeiten</div>
								<div class="cancel_edit_question" style="display: none;">Abbrechen</div>
								<div class="save_question">Speichern</div>
								<div class="delete_question">L&ouml;schen</div>
								<div class="question_owner" style="display: none;">Owner</div>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
	<table width="640">
		<tr>
			<td>
				<table width="630">
					<tr align="left">
						<td width="220">
							<label>Erkl&auml;rung der Frage</label>
							<label class="opt">(Max. 2500 Zeichen)</label>
					    </td>
					</tr>
					<tr align="left">
						<td>
							<input style="width: 640px" class="explanation" name="explanation" type="text" id="explanation" />
						</td>
					</tr>
					<tr align="left">
					    <td>
							<label>Fragestellung</label>
							<label class="opt">(Max. 2500 Zeichen)</label>
						</td>
					</tr>
					<tr align="left">
						<td>
							<input style="width: 640px" class="questiontext" name="question" type="text" id="question" />
							<div style="display: none;" class="error">Fehlermeldung<br /></div>
						</td>
					</tr>
					<tr align="left">
					    <td>
							<label>M&ouml;gliche Antwortwerte</label>
							<label class="opt"></label>
						</td>
					</tr>
					<tr align="left">
						<td>
							<label class="opt">- Ja 	<br />- Nein 	<br />- Keine Angabe</label>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<br />
	<br />
</form>
<form id="prepared_question2" style='display: none'>
	<input style="display: none" class="type" name="type" type="text" id="type" value="1" />
	<input style="display: none" class="q_id" name="q_id" type="text" id="q_id" />
	<input style="display: none" class="action" name="action" type="text" id="action"  value="NEW"/>
	<input style="display: none" class="number_of_options" name="number_of_options" type="text" id="number_of_options" value="0"/>
	<table width="640">
		<tr>
			<td>
				<div class="questionTableHeader">
					<table>
						<tr>
							<td width="440">
								<h3>
									<font face="Arial, Helvetica, sans-serif">Mehrfachauswahl-Fragen</font>
								</h3>
							</td>
							<td width="200">
								<div class="edit_question" style="display: none;">Bearbeiten</div>
								<div class="cancel_edit_question" style="display: none;">Abbrechen</div>
								<div class="save_question">Speichern</div>
								<div class="delete_question">L&ouml;schen</div>
								<div class="question_owner" style="display: none;">Ersteller</div>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
	<table width="640">
		<tr>
			<td>
				<table width="630">
					<tr align="left">
						<td width="220">
							<label>Erkl&auml;rung der Frage</label>
							<label class="opt">(Max. 2500 Zeichen)</label>
					    </td>
					</tr>
					<tr align="left">
						<td>
							<input style="width: 640px" class="explanation" name="explanation" type="text" id="explanation" />
						</td>
					</tr>
					<tr align="left">
					    <td>
							<label>Fragestellung</label>
							<label class="opt">(Max. 2500 Zeichen)</label>
						</td>
					</tr>
					<tr align="left">
						<td>
							<input style="width: 640px" class="questiontext" name="question" type="text" id="question" />
							<div style="display: none;" class="error">Fehlermeldung<br /></div>
						</td>
					</tr>
					<tr align="left">
					    <td>
							<label>M&ouml;gliche Antwortwerte</label>
							<label class="opt"></label>
						</td>
					</tr>
					<tr align="left">
						<td>
							<div>
								<div class="add_option">
									Neue Antwortwerte hinzuf&uuml;gen
								</div>
							</div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<br />
	<br />
</form>
<form id="prepared_question3" style='display: none'>
	<input style="display: none" class="type" name="type" type="text" id="type" value="2" />
	<input style="display: none" class="q_id" name="q_id" type="text" id="q_id" />
	<input style="display: none" class="action" name="action" type="text" id="action"  value="NEW"/>
	<table width="640">
		<tr>
			<td>
				<div class="questionTableHeader">
					<table>
						<tr>
							<td width="440">
								<h3>
									<font face="Arial, Helvetica, sans-serif">Fragestellung als Text zum beantworten</font>
								</h3>
							</td>
							<td width="200">
								<div class="edit_question" style="display: none;">Bearbeiten</div>
								<div class="cancel_edit_question" style="display: none;">Abbrechen</div>
								<div class="save_question">Speichern</div>
								<div class="delete_question">L&ouml;schen</div>
								<div class="question_owner" style="display: none;">Owner</div>
							</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
	<table width="640">
		<tr>
			<td>
				<table width="630">
					<tr align="left">
						<td width="220">
							<label>Erkl&auml;rung der Fragestellung</label>
							<label class="opt">(Maximal 2500 Zeichen)</label>
					    </td>
					</tr>
					<tr align="left">
						<td>
							<input style="width: 640px" class="explanation" name="explanation" type="text" id="explanation" />
						</td>
					</tr>
					<tr align="left">
					    <td>
							<label>Fragestellung</label>
							<label class="opt">(Maximal 2500 Zeichen)</label>
						</td>
					</tr>
					<tr align="left">
						<td>
							<input style="width: 640px" class="questiontext" name="question" type="text" id="question" />
							<div style="display: none;" class="error">Fehlermeldung<br /></div>
						</td>
					</tr>
				</table>
			</td>
		</tr>
	</table>
	<br />
	<br />
</form>
<br />
<form id="questions"></form>
<div id="errors">
</div>
<table width="640">
	<tr>
		<td>
			Ja/Nein-Frage hinzuf&uuml;gen
		</td>
		<td>
			<input type="button" id='enterQ1' value="Frage hinzuf&uuml;gen" />
		</td>
	<tr>
	<tr>
		<td>
			Mehrfachauswahl-Frage hinzuf&uuml;gen
		</td>
		<td>
			<input type="button" id='enterQ2' value="Frage hinzuf&uuml;gen" />
		</td>
	<tr>
	<tr>
		<td>
			Text-Frage hinzuf&uuml;gen
		</td>
		<td>
			<input type="button" id='enterQ3' value="Frage hinzuf&uuml;gen" />
		</td>
	<tr>
	</table>
	<div id="modal" style="display: none; padding: 20px;"> 
		<h3>
			<font color="#000000" face="Arial, Helvetica, sans-serif">Sind Sie sicher, dass Sie die Fragestellung l&ouml;schen m&ouml;chten?</font>
		</h3>
		<br /> 
		<label class="opt">
			Klicken Sie auf l&ouml;schen, um die Fragestellung mit den Antwortwerten endg&uuml;ltig zu l&ouml;schen.
		</label>
		<br />
		<br /> 
		<input type="image" id='modal_delete' src="<c:url value="/images/button_loeschen.png"/>"  value="1"/>
		<input type="image" id='modal_cancel' src="<c:url value="/images/button_abbrechen_grau.png"/>"  value="1"/>
	</div> 
	<script>
$(function() {
	
	$("#enterQ1").click(function() {
		return addQuestion("prepared_question1");
	});

	$("#enterQ2").click(function() {
		return addQuestion("prepared_question2");
	});

	$("#enterQ3").click(function() {
		return addQuestion("prepared_question3");
	});

	
	
	function addQuestion(question){
		$("#noQuestionError").hide("fast");
		
		if(addedQuestionsCount < maxAddedQuestionsCount){
			$("#"+question)
				.clone()
				.attr('id', "question")
				.attr('class', "prepared_question")
				.appendTo('#questions');
			
			reindex_questions();
			addedQuestionsCount++;
			$(".prepared_question").each(function (question_index, question_domEle) {
				$(question_domEle).show("fast");
			});
		} else {
			$("#maxAddedQuestionError").show("fast");
		}
		return null;
	}

	$(".save_question").live('click', function() {
		selected_question = $(this).parentsUntil('.prepared_question').parent();
		saveq();
	});
	
	$(".delete_question").live('click', function() {
		
		selected_question = $(this).parentsUntil('.prepared_question').parent();
		var custom_question_id = $(selected_question).find(".q_id").val();
		
		if(custom_question_id != ""){
			$.blockUI({ message: $('#modal')});
		} else {
			selected_question.hide("fast", function() {
				selected_question.remove();
				reindex_questions();
			});
			addedQuestionsCount--;
		}

	});

	function saveq(){
		var question = selected_question;
		var custom_question_id = $(question).find(".q_id").val();
		var custom_question_action = $(question).find(".action").val();

		var queryString = question.serializeArray();		
		var isValid = validateForm(question.attr('id'));
		if(isValid == true){
			$.ajax({
				type: "POST",
				url: '<c:url value="/${prefix}/save_fragebogen_anpassen"/>',
				data: queryString,
				success: function(msg){
						if(custom_question_action == "EDIT"){

							$(question).find(".action").val("NONE");

							$(question).find(".edit_question").show();
							$(question).find(".cancel_edit_question").css("display","none");
							$(question).find(".delete_question").css("display","none");
							$(question).find(".save_question").css("display","none");
							$(question).find(".add_option").each(function(index) {
							    $(this).css("display","none");
							});
							$(question).find(".delete_option").each(function(index) {
								    $(this).css("display","none");
							});
							$(question).find(":input").each(function(index) {
							    $(this).attr('disabled', true);
							});
							
						} else if(custom_question_action == "NEW") {
							
							$(question).find(".q_id").val(msg);
							$(question).find(".action").val("NONE");

							$(question).find(".edit_question").show();
							$(question).find(".delete_question").css("display","none");
							$(question).find(".save_question").css("display","none");
							$(question).find(".add_option").each(function(index) {
							    $(this).css("display","none");
							});
							$(question).find(".delete_option").each(function(index) {
								    $(this).css("display","none");
							});
							$(question).find(":input").each(function(index) {
							    $(this).attr('disabled', true);
							});
						}
				},
				error: function(){
					alert('error');
				},
				complete: function() {
				}
			});
		}

		selected_question = null;
	}

	function deleteq(){
		var question = selected_question;
		var custom_question_id = $(question).find(".q_id").val();
		var custom_question_action = $(question).find(".action").val();

		var queryString = question.serializeArray();		
		var isValid = validateForm(question.attr('id'));
		if(isValid == true){
			$.ajax({
				type: "POST",
				url: '<c:url value="/${prefix}/save_fragebogen_anpassen"/>',
				data: queryString,
				success: function(msg){
					if(msg == "ok"){
						 if(custom_question_action == "DELETE") {
							
							 question.hide("fast", function() {
								 question.remove();
								reindex_questions();
							});
							addedQuestionsCount--;
					        $.unblockUI(); 
						} 
					}
					
				},
				error: function(){
					alert('error');
				},
				complete: function() {
				}
			});
		}

		selected_question = null;
	}
	
	$(".delete_option").live('click', function() {
		var selected_option = $(this).parent().parent().parent();
		var question = $(this).parentsUntil('.prepared_question').parent();
		var question_id = $(question).attr('id');
		var question_index = question_id.substring(9, 10);
		var class_name = "option_"+question_index;
		selected_option.next().remove();
		selected_option.remove();

		var number_of_options = $(question).find(".number_of_options");
		var count = parseInt(number_of_options.val()) - 1;
		number_of_options.val(count);

		$(question).find(".add_option").each(function(index) {
			$(this).css('background-color', '#FF3333');
		});
		
		reindex_options();
	});

	$(".add_option").live('click', function() {
		var question_id = $(this).parentsUntil('.prepared_question').parent().attr('id');
		var question = $(this).parentsUntil('.prepared_question').parent();
		var number_of_options = $(question).find(".number_of_options");
		var count = parseInt(number_of_options.val());
		if(count < 5){
			var question_index = question_id.substring(9, 10);
			var class_name = "option_"+question_index;
			var new_option = $("<tr align='left'><td><div><div class='question_option'><input style='width: 340px' name='"+class_name+"' type='text' class='option' /><div style='display: none;' class='error'>Fehlermeldung<br /></div></div><div class='delete_option'>ENTFERNEN</div></div></td></tr><tr><td><div><div class='add_option'>Neuen Wert eingeben</div></div></td></tr>");
			new_option.insertAfter($(this).parent().parent().parent());
			number_of_options.val(count+1);
		}

		if(count > 3){
			$(question).find(".add_option").each(function(index) {
				$(this).css('background-color', '#e8e8e8');
			});
		}
		
		reindex_options();
	});

	function reindex_options(){
		$(".prepared_question").each(function (question_index, question_domEle) {
			var question_id = $(question_domEle).attr('id');
			var question_index = question_id.substring(9, 10);
			$(question_domEle).find(".option").each(function(index, domEle) {
				var class_name = "option_"+question_index;
		        var new_attr_value = "option_"+question_index+"_"+index;
		        $(domEle).attr('id', new_attr_value); 
		        $(domEle).attr('name', new_attr_value);  
		    });
		});
	}

	function reindex_questions(){
		$(".prepared_question").each(function (index, domEle) {
			var new_question_id = "question_"+index;
			$(domEle).attr('id', new_question_id); 	
			var question_id = $("#"+new_question_id).find(".q_id");
			var type = $("#"+new_question_id).find(".type");
			var action = $("#"+new_question_id).find(".action");	
			var explanation = $("#"+new_question_id).find(".explanation");
			var question = $("#"+new_question_id).find(".questiontext");
			$(question_id).attr('id', "q_id_"+index);
			$(question_id).attr('name', "q_id_"+index);
			$(type).attr('id', "type_"+index);
			$(type).attr('name', "type_"+index);
			$(action).attr('id', "action_"+index);
			$(action).attr('name', "action_"+index);
			$(explanation).attr('id', "explanation_"+index);
			$(explanation).attr('name', "explanation_"+index);
			$(question).attr('id', "question_"+index);
			$(question).attr('name', "question_"+index);
		});
		reindex_options();
	}

	$(".edit_question").live('click', function() {
		var question = $(this).parentsUntil('.prepared_question').parent();
		$(question).find(":input").each(function(index) {
		    $(this).removeAttr("disabled");
		});

		$(this).css("display","none");
		$(question).find(".delete_question").removeAttr("style");
		$(question).find(".save_question").removeAttr("style");
		$(question).find(".cancel_edit_question").removeAttr("style");
		$(question).find(".action").val("EDIT");
		
	});

	$(".cancel_edit_question").live('click', function() {
		var question = $(this).parentsUntil('.prepared_question').parent();
		$(question).find(":input").each(function(index) {
		    $(this).attr("disabled", "disabled");
		});

		$(this).css("display","none");
		$(question).find(".delete_question").css("display","none");
		$(question).find(".save_question").css("display","none");
		$(question).find(".edit_question").removeAttr("style");
	});

	$('#modal_delete').live('click', function() {
		$("#maxAddedQuestionError").hide("fast");
		$(selected_question).find(".action").val("DELETE");
		deleteq();
	}); 
        
	$('#modal_cancel').live('click', function() {
	    $.unblockUI(); 
	    return false; 
	}); 

	//init
	var user_id = ${user.id};
	var user_default_name = '${userdefaultname}';
	var maxAddedQuestionsCount = 20;
	var addedQuestionsCount = 0;
	var initAddedQuestionsCount = 0;
	var maxAddedQuestionError = "<div id='maxAddedQuestionError' style='display: none' class='error'>Maximum: "+maxAddedQuestionsCount+"</div>";
	var noQuestionError = "<div id='noQuestionError' style='display: none'  class='error'>Keine neue Frage</div>";
	var selected_question = null;
	
	//init
	init();
	
	function init(){

		$('#questions').html("");
		
		$("#errors").append(maxAddedQuestionError);
		$("#errors").append(noQuestionError);

		<c:forEach var="customQuestion" items="${customQuestions}">
			initAddedQuestionsCount++;
			var question_id_input_value = '${customQuestion.id}';
			var type = '${customQuestion.questionType.type}';
			var answerDataType = '${customQuestion.questionType.answerDataType}';
			var question_input_value = '${customQuestion.text}';
			var explanation_input_value = '${customQuestion.explanation}';
			var question_owner = '${customQuestion.creator.id}';
			var is_there_options = false;
			var is_my_question = false;

			if(question_owner == user_id){
				is_my_question = true;
			}

			////////////////////////////////////////
			/////////////////TO-DO//////////////////
			////////////////////////////////////////
			////////DONT FORGET SORT ORDER!/////////
			////////////////////////////////////////
			
			if(type == 'SINGLE_CHOICE_LIST' && answerDataType == 'BOOLEAN'){
				$("#enterQ1").trigger('click');
			}

			if(type == 'SINGLE_CHOICE_LIST' && answerDataType == 'TEXT'){
				$("#enterQ2").trigger('click');
				is_there_options = true;
			}

			if(type == 'SINGLE_ANSWER_ENTER' && answerDataType == 'TEXT'){
				$("#enterQ3").trigger('click');
			}

			var question = $('.prepared_question').last();
			var question_id_input = $(question).find(".q_id");
			var question_input = $(question).find(".questiontext");
			var explanation_input = $(question).find(".explanation");
			
			$(question_id_input).val(question_id_input_value);
			$(question_input).val(question_input_value);
			$(explanation_input).val(explanation_input_value);

			if(is_there_options){
				var number_of_options = $(question).find(".number_of_options");
				var count = 0;
				<c:forEach var="customQuestionOption" items="${customQuestion.questionType.answers}">
					var option_value = '${customQuestionOption.answer}';
					var last_add_option_button = $(question).find(".add_option").last();
					$(last_add_option_button).trigger('click');
					var last_added_option_input = $(question).find(".option").last();
					$(last_added_option_input).val(option_value);
					count++;
				</c:forEach>

				number_of_options.val(count);
			}

			if(is_my_question){
				$(question).find(".edit_question").removeAttr("style");
			} else {
				$(question).find(".question_owner").removeAttr("style");
				var creator_name = '${customQuestion.creator.name.name}';
				if(creator_name == ""){
					creator_name = user_default_name;
				}
				$(question).find(".question_owner").html(creator_name);
			}
			
			$(question).find(".delete_question").css("display","none");
			$(question).find(".add_option").each(function(index) {
			    $(this).css("display","none");
			});
			$(question).find(".delete_option").each(function(index) {
				    $(this).css("display","none");
			});
			$(question).find(":input").each(function(index) {
			    $(this).attr('disabled', true);
			});
			$(question).find(".action").val("NONE");
			
		</c:forEach>

		$(".prepared_question").each(function (question_index, question_domEle) {
			var action = $(question_domEle).find(".action").val();
			if(action != "NEW"){
				$(question_domEle).find(".save_question").hide();
			}
		});
	}
});

function validateForm(question_id) {
	var result = false;
	var isValid = true;
	var questions_count = 0;
	//$(".prepared_question").each(function (question_index, question_domEle) {
		questions_count++;
		//var question_id = "question_"+question_index;
		
		var question_domEle = $("#"+question_id);
		var question = question_domEle.find(".questiontext");
		var question_value = $(question).val();
		if(question_value.length == 0){
			$(question).next().show();
			isValid = false;
		} else {
			$(question).next().hide();
		}
		var question_id = $(question_domEle).attr('id');
		var question_index = question_id.substring(9, 10);
		$(question_domEle).find(".option").each(function(index, domEle) {
			var option_value = $(domEle).val();
			if(option_value.length == 0){
				$(domEle).next().show();
				isValid = false;
			} else {
				$(domEle).next().hide();
			}
		});
	//});

	if(questions_count == 0 && questions_count != initAddedQuestionsCount){
		isValid = false;
		$("#noQuestionError").show("fast");
	}

	if(isValid){
		result = true;
	} else {
		result = false;
	}
	return result;
}
</script>
