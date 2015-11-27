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
<%@ tag description="Outbox" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="prefix" required="true" %>
<br />
<div id="prepared_message" style='display: none'>
	<input type="hidden" id="is_readed"/>
	<table width="620">
		<tr>
			<!--
			<td rowspan="2" width="20">
				<input type="checkbox" name="checkbx" id="checkbx" />
			</td>
			-->
			<td rowspan="2" width="20">
				<div id="unread_symbol"></div>
			</td>
			<td rowspan="2" width="60">
				<div class="message_avatar_man"></div>
			</td>
			<td>
				<a class="message_subject"></a>
			</td>
			<td rowspan="2" width="80">
				<div class="message_date"></div>
			</td>
		</tr>
		<tr>
			<td>
				<label class="opt" style="float: left;">An:&nbsp;</label>
				<div class="message_name"></div>
			</td>
		</tr>
	</table>
	<table class="message_body_table" width="620"  style='display: none'>
		<tr>
			<!--
			<td rowspan="3" width="20">
			</td>
			-->
			<td rowspan="3" width="20">
			</td>
			<td rowspan="3" width="60">
			</td>
		</tr>
		<tr>
			<td>
				<div class="message_body_text"></div>
				<br />
			</td>
		</tr>
		<tr>
			<td>
				<a id='delete_message'>L&ouml;schen</a>
			</td>
		</tr>
	</table>
</div>
<div id="messages">
</div>
<div id="modal_delete" style="display: none; padding: 20px;"> 
	<h3>
		<font color="#000000" face="Arial, Helvetica, sans-serif">Mitteilung l&ouml;schen</font>
	</h3>
	<br /> 
	<label class="opt">
		 Sind Sie sicher, dass Sie die Mitteilung l&ouml;schen m&ouml;chten?
	</label>
	<br />
	<br /> 
	<input type="image" id='modal_delete_delete' src="<c:url value="/images/button_loeschen.png"/>"  value="1"/>
	<input type="image" id='modal_delete_cancel' src="<c:url value="/images/button_abbrechen_grau.png"/>"  value="1"/>
	
	<div style="display: none; text-align: left;" class="error" id="modal_delete_sendingError"><strong>Fehler bei der &Uuml;bermittlung</strong></div>
	<div style="display: none; text-align: left;" class="success" id="modal_delete_sendingSuccess"><strong>Mitteilung wurde erfolgreich gesendet.</strong></div>
			
</div> 
<div id="modal_new_message"> 
	<input type="hidden" id="new_message_id" />
	<input type="hidden" id="new_message_receiver_id" />
	<div id="modal_new_message_title"></div>
	<br /> 
	<label class="opt" id="modal_new_message_subtitle">
		Verfassen Sie hier eine Mitteilung.
	</label>
	<br />
	<br />
	<table width="430">
		<tr align="left">
			<td colspan="2">
				<label>To:</label>
			</td>
		</tr>
		<tr align="left">
			<td colspan="2">
				<input style="width: 422px" name="emails" type="text" id="new_message_receiver" value="pat3" disabled/>
				<div style="display: none; text-align: left;" class="error">error</div>
				
			</td>
		</tr>
		<tr align="left">
			<td colspan="2">
				<label>Subject:</label>
			</td>
		</tr>
		<tr align="left">
			<td colspan="2">
				<input style="width: 422px" name="emails" type="text" id="new_message_subject" />
				<div style="display: none; text-align: left;" class="error">Fehlermeldung</div>
				
			</td>
		</tr>
		<tr align="left">
			<td colspan="2" >
				<label>Message:</label>
			</td>
		</tr>
		<tr align="left">
			<td colspan="2">
				<textarea style="width: 418px; height: 60px; resize: none;" name="new_message_body" id="new_message_body" ></textarea>
				<div style="display: none; text-align: left;" class="error">Fehlermeldung</div>
				<br />
			</td>
		</tr>
		<tr>
			<td colspan="2" align="left">
				<!-- send --> 
				<input type="image" id='modal_send' src="<c:url value="/images/button_senden.png"/>"  value="1" style='display: none'/>
				<!-- reply --> 
				<input type="image" id='modal_reply' src="<c:url value="/images/button_senden.png"/>"  value="1" style='display: none'/>
				<!-- clear --> 
				<input type="image" id='modal_cancel' src="<c:url value="/images/button_abbrechen_grau.png"/>"  value="1"/>
			</td>
		</tr>
		<tr>
			<td colspan="2"  align="left">
				<div style="display: none; text-align: left;" class="error" id="sendingError"><strong>Fehler bei der &Uuml;bermittlung</strong></div>
				<div style="display: none; text-align: left;" class="success" id="sendingSuccess"><strong>Mitteilung wurde erfolgreich &uuml;bermittelt</strong></div>
			</td>
		</tr>
	</table> 
</div> 
<script>

$(function() {

	init();

	$(".message_subject").live('click', function() {
		
		var selected_message = $(this).parentsUntil('.prepared_message').parent();
		var message_id = selected_message.attr('id').substring(8);
		var selected_message_unread_symbol = selected_message.find("#unread_symbol");
		
		var message_table = selected_message.find('.message_body_table');
		if(message_table.attr("style") == null){
			message_table.css("display", "none");
		} else {
			message_table.removeAttr("style");
		}

	});

	$('#new_message').live('click', function() {
		resetModal();

        $('#modal_send').show();

        $('#new_message_id').val("-1");
        $('#modal_new_message_title').html("Neue Mitteilung");
        $('#modal_new_message_subtitle').html("Verfassen Sie hier eine neue Mitteilung");
		$('#new_message_receiver').val($( "#combobox option:selected" ).text());
		$('#new_message_receiver_id').val($( "#combobox" ).val());
		$.blockUI({ message: $('#modal_new_message')});
    }); 

	
	$('#modal_delete_cancel').live('click', function() {
		global_selected_message = null;
		$.unblockUI(); 
        return false; 
	});
		
	$('#modal_delete_delete').live('click', function() {
		var selected_message = global_selected_message;
		var message_id = selected_message.attr('id').substring(8);

		$.ajax({
			type: "POST",
			url: '<c:url value="/${prefix}/delete_message"/>',
			data: {
				messageId: message_id
			},
			success: function(msg){
				if(msg == "ok"){
					$(selected_message).hide();
					$("#modal_delete_sendingSuccess").show();
					$.unblockUI(); 
				} else {
			  		$("#modal_delete_sendingError").show();
				}
			},
			error: function(){
			},
			complete: function() { 
				$(selected_message).remove();
			}
		});
	
	});
	
	$('#delete_message').live('click', function() {
		global_selected_message = $(this).parentsUntil('.prepared_message').parent();

		$("#modal_delete_sendingSuccess").hide();
		$("#modal_delete_sendingError").hide();
		
		$.blockUI({ message: $('#modal_delete')});
	}); 
		
	$('#modal_send').click(function() { 
        if(validate() == true){
    		$.ajax({
				type: "POST",
				url: '<c:url value="/${prefix}/send_new_message"/>',
				data: {
					receiver: $('#new_message_receiver_id').val(),
					subject: $('#new_message_subject').val(),
					body: $('#new_message_body').val(),
					copy: "false"
				},
				success: function(msg){
				  if(msg == "ok"){
					  $('#sendingSuccess').show();
					  setTimeout($.unblockUI, 1000);
				  }
				},
				error: function(){
					$('#sendingError').show();
				},
				complete: function() { 
					
				}
			});
        } 
    });  

	$('#modal_reply').click(function() { 
        if(validate() == true){
    		$.ajax({
				type: "POST",
				url: '<c:url value="/${prefix}/reply_to_message"/>',
				data: {
					messageId: $('#new_message_id').val(),
					subject: $('#new_message_subject').val(),
					body: $('#new_message_body').val(),
					copy: "false"
				},
				success: function(msg){
				  if(msg == "ok"){
					  $('#sendingSuccess').show();
					  setTimeout($.unblockUI, 1000);
				  }
				},
				error: function(){
					$('#sendingError').show();
				},
				complete: function() { 
					
				}
			});
        } 
    }); 
    
    $('#modal_cancel').live('click', function() {
		$.unblockUI(); 
    }); 

    function resetModal(){
    	$('#modal_reply').hide();
        $('#modal_send').hide();

		$('#sendingError').hide();
        $('#sendingSuccess').hide();
        
    	$('#modal_new_message').find(":input[type=text], textarea").each(function(index, domEle) {
			$(domEle).val("");
		});

    	$('#modal_new_message').find(".error").each(function(index, domEle) {
			$(domEle).hide();
		});

    	$('#new_message_subject').removeAttr("disabled");
    }
    
});

function init(){
	
	<c:forEach var="message" items="${outbox}">
		var message_id = "message_"+'${message.id}';
		$("#prepared_message")
		.clone()
		.attr('id', message_id)
		.attr('class', "prepared_message")
		.appendTo('#messages');

		if('${message.read}' == "true"){
			$("#"+message_id).find("#is_readed").val("1");
		} else {
			$("#"+message_id).find("#is_readed").val("0");
		}

		if($("#"+message_id).find("#is_readed").val() == "0"){
			$("#"+message_id).find("#unread_symbol").addClass('unread_message');
		}

		$("#"+message_id).find(".message_date").html('<fmt:formatDate value="${message.created}" type="date" pattern="dd-MMM-yyyy"/>');
		$("#"+message_id).find(".message_name").html('${message.receiver.name.name} ${message.receiver.name.surname}');
		$("#"+message_id).find(".message_subject").html('${message.subject}');
		
	
		<c:if test="${message.inReplyToMessage!=null}">
			$("#"+message_id).find(".message_body_text").html('${func:escapeJavaScript(message.body)}<br /><br ><label class="opt">Am <fmt:formatDate value="${message.inReplyToMessage.created}" type="date" pattern="dd-MMM-yyyy"/> schrieb ${message.inReplyToMessage.sender.name.name} ${message.inReplyToMessage.sender.name.surname}:</label><br />${func:escapeJavaScript(message.inReplyToMessage.body)}');
		</c:if>
		<c:if test="${message.inReplyToMessage==null}">
			$("#"+message_id).find(".message_body_text").html("${func:escapeJavaScript(message.body)}");
		</c:if>
		
	</c:forEach>
	
	$(".prepared_message").each(function (index, domEle) {
		$(domEle).show();
	});
}

function newMessage(){
	alert('new');

}

function validate() {
	var isValid = true;

	$('#modal_new_message').find(":input[type=text], textarea").each(function(index, domEle) {
		var input_value = $(domEle).val();
		if(input_value.length == 0){
			$(domEle).next().show();
			isValid = false;
		} else {
			$(domEle).next().hide();
		}
	});

	return isValid;
}

</script>
