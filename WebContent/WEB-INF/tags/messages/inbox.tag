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
<%@ tag description="Inbox" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="prefix" required="true" %>
<style>
.ui-autocomplete-input { width: 260px;}
</style>

<script>
(function( $ ) {
	$.widget( "ui.combobox", {
		_create: function() {
			var self = this,
				select = this.element.hide(),
				selected = select.children( ":selected" ),
				value = selected.val() ? selected.text() : "";
			var input = this.input = $( "<input>" )
				.insertAfter( select )
				.val( value )
				.autocomplete({
					delay: 0,
					minLength: 0,
					source: function( request, response ) {
						var matcher = new RegExp( $.ui.autocomplete.escapeRegex(request.term), "i" );
						response( select.children( "option" ).map(function() {
							var text = $( this ).text();
							if ( this.value && ( !request.term || matcher.test(text) ) )
								return {
									label: text.replace(
										new RegExp(
											"(?![^&;]+;)(?!<[^<>]*)(" +
											$.ui.autocomplete.escapeRegex(request.term) +
											")(?![^<>]*>)(?![^&;]+;)", "gi"
										), "<strong>$1</strong>" ),
									value: text,
									option: this
								};
						}) );
					},
					select: function( event, ui ) {
						ui.item.option.selected = true;
						self._trigger( "selected", event, {
							item: ui.item.option
						});
						button2.removeAttr("disabled");
						
					},
					change: function( event, ui ) {
						
						if ( !ui.item ) {
							var matcher = new RegExp( "^" + $.ui.autocomplete.escapeRegex( $(this).val() ) + "$", "i" ),
								valid = false;
							select.children( "option" ).each(function() {
								if ( $( this ).text().match( matcher ) ) {
									this.selected = valid = true;
									return false;
								}
							});
							
							if ( !valid ) {
								// remove invalid value, as it didn't match anything
								$( this ).val( "" );
								select.val( "" );
								input.data( "autocomplete" ).term = "";
								button2.attr("disabled","disabled");
								return false;
							} else {
								button2.removeAttr("disabled");
							}
						}
					}
				})
				.addClass( "projecth_autocomplet" )
				.css("font-size", "14px")
				.css("font-family", "Arial");

			input.data( "autocomplete" )._renderItem = function( ul, item ) {
				return $( "<li></li>" )
					.data( "item.autocomplete", item )
					.append( "<a>" + item.label + "</a>" )
					.appendTo( ul );
			};
			
			var button = this.button = $( "<input type='button' value='Verbindungen'></input>" )
				.attr( "tabIndex", -1 )
				.addClass("projecth_autocomplet_button")
				.css("left", "-2")
				.css("font-size", "13px")
				.css("font-family", "Arial")
				.insertAfter( input )
				.click(function() {
					if ( input.autocomplete( "widget" ).is( ":visible" ) ) {
						input.autocomplete( "close" );
						return;
					}
					input.autocomplete( "search", "" );
					input.focus();
				});

			var button2 = this.button2 = $( "<input type='button' value='Neue Nachricht'></input>" )
				.attr( "tabIndex", -1 )
				.attr("id", "new_message")
				.attr("disabled","disabled")
				.removeAttr("style")
				.addClass("projecth_button")
				.css("font-size", "13px")
				.css("font-family", "Arial")
				.insertAfter( this.button )
				.click(function() {
					newMessage();
				});
			
		},

		destroy: function() {
			this.input.remove();
			this.button.remove();
			this.button2.remove();
			this.element.show();
			$.Widget.prototype.destroy.call( this );
		}
	});
})( jQuery );

$(function() {
	$( "#combobox" ).combobox();
});
</script>





<div style="padding-left: 10px;">
<table width="630">	
	<tr>
		<!--
		<td width="20">
				<input type="checkbox" name="allcheckbx" id="allcheckbx" />
		</td>
		-->
		<td width="610" >
			
			<div class="ui-widget" style="float: right;">
				<select id="combobox">
					<option value=""></option>
					<c:forEach var="user" items="${connections}">
						<option value="${user.id}">${user.name.name} ${user.name.surname}</option>
					</c:forEach>
				</select>
			</div>
		</td>
	<tr>
</table>
</div>
<br />
<div id="prepared_message" style='display: none'>
	<input type="hidden" id="is_readed"/>
	<input type="hidden" id="is_spam"/>
	<table width="620">
		<tr>
			<!-- 
			<td rowspan="2" width="20">
				<input type="checkbox" name="checkbx" id="checkbx" />
			</td>
			 -->
			<td rowspan="2" width="20">
				<div id="unread_symbol"></div>
				<div id="reply_symbol"></div>
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
				<label class="opt" style="float: left;">Von:&nbsp;</label>
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
				<a id='mark_as_unread'>Als ungelesen markieren</a><span class="fsplitter"> |</span>
				<a id='reply_message'>Antworten</a><span class="fsplitter"> |</span>
				<a id='spam_message'>Missbrauch melden</a><span class="fsplitter"> |</span>
				<a id='delete_message'>L&ouml;schen</a>
			</td>
		</tr>
	</table>
</div>
<div id="messages">
</div>
<div id="modal_spam" style="display: none; padding: 20px;"> 
	<h3>
		<font color="#000000" face="Arial, Helvetica, sans-serif">Missbrauch melden</font>
	</h3>
	<br /> 
	<label class="opt">
		Sind Sie sicher, dass Sie einen Missbrauch melden m&ouml;chten?
	</label>
	<br />
	<br /> 
	
	<input type="image" id='modal_spam_send' src="<c:url value="/images/button_senden.png"/>"  value="1"/>
	<input type="image" id='modal_spam_cancel' src="<c:url value="/images/button_abbrechen_grau.png"/>"  value="1"/>
	
	<div style="display: none; text-align: left;" class="error" id="modal_spam_sendingError"><strong>Fehler bei der &Uuml;bermittlung</strong></div>
	<div style="display: none; text-align: left;" class="success" id="modal_spam_sendingSuccess"><strong>Mitteilung wurde erfolgreich gesendet.</strong></div>
			
</div> 
<div id="modal_delete" style="display: none; padding: 20px;"> 
	<h3>
		<font color="#000000" face="Arial, Helvetica, sans-serif">Nachricht l&ouml;schen</font>
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
		Verfassen Sie hier Ihre Mitteilung für den sofortigen Versand.
	</label>
	<br />
	<br />
	<table width="430">
		<tr align="left">
			<td colspan="2">
				<label>An:</label>
			</td>
		</tr>
		<tr align="left">
			<td colspan="2">
				<input style="width: 422px" name="emails" type="text" id="new_message_receiver" value="pat3" disabled/>
				<div style="display: none; text-align: left;" class="error">Fehlermeldung</div>
				
			</td>
		</tr>
		<tr align="left">
			<td colspan="2">
				<label>Titel:</label>
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
				<label>Mitteilung:</label>
			</td>
		</tr>
		<tr align="left">
			<td colspan="2">
				<textarea style="width: 418px; height: 60px; resize: none;" name="new_message_body" id="new_message_body" ></textarea>
				<div style="display: none; text-align: left;" class="error">Fehlermeldung</div>
				
			</td>
		</tr>
		<tr align="left">
			<td width="20">
				<input type="checkbox" name="copy_to_me" id="copy_to_me" />
			</td>
			<td>
				<label class="opt">Eine Kopie an meine E-Mail Adresse senden</label>
			</td>
		</tr>
		<tr>
			<td colspan="2" align="left">
				<br />
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

	$("#allcheckbx").live('click', function() {
		var check;
		if ($(this).is(":checked")){
			check = true;
		} else {
			check = false;
		}
		$("#messages").find("#checkbx").each(function(index, domEle) {						
			$(domEle).attr('checked', check);
		});
	});
	
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

		var isReaded = false;
		if(selected_message.find("#is_readed").val() == "1"){
			isReaded = true;
		}

		if(isReaded == false){
			$.ajax({
				type: "POST",
				url: '<c:url value="/${prefix}/mark_as_read"/>',
				data: {
					messageId: message_id
				},
				success: function(msg){
				  if(msg == "ok"){
					  selected_message.find("#is_readed").val("1");
					  selected_message_unread_symbol.removeClass("unread_message");
				  }
				},
				error: function(){
				},
				complete: function() { 
					
				}
			});
		}

	});

	$('#new_message').live('click', function() {
		resetModal();

        $('#modal_send').show();

        $('#new_message_id').val("-1");
        $('#modal_new_message_title').html("Neue Mitteilung");
        $('#modal_new_message_subtitle').html("Verfassen Sie hier eine neue Mitteilung.");
		$('#new_message_receiver').val($( "#combobox option:selected" ).text());
		$('#new_message_receiver_id').val($( "#combobox" ).val());
		$.blockUI({ message: $('#modal_new_message')});
    }); 

	$('#mark_as_unread').live('click', function() {
		var selected_message = $(this).parentsUntil('.prepared_message').parent();
		var message_id = selected_message.attr('id').substring(8);
		var selected_message_unread_symbol = selected_message.find("#unread_symbol");

		var message_table = selected_message.find('.message_body_table');
		
		var isReaded = false;
		if(selected_message.find("#is_readed").val() == "1"){
			isReaded = true;
		}

		if(isReaded == true){
			$.ajax({
				type: "POST",
				url: '<c:url value="/${prefix}/mark_as_unread"/>',
				data: {
					messageId: message_id
				},
				success: function(msg){
					if(msg == "ok"){
						$(selected_message).find("#is_readed").val("0");
					  	selected_message_unread_symbol.addClass('unread_message');
				  }
				},
				error: function(){
				},
				complete: function() { 
					message_table.css("display", "none");
				}
			});
		}
	}); 

	var global_selected_message = null;
	$('#spam_message').live('click', function() {
		global_selected_message = $(this).parentsUntil('.prepared_message').parent();

		$("#modal_spam_sendingSuccess").hide();
		$("#modal_spam_sendingError").hide();
		
		$.blockUI({ message: $('#modal_spam')});
	}); 

	$('#modal_spam_cancel').live('click', function() {
		global_selected_message = null;
		$.unblockUI(); 
        return false; 
	});
		
	$('#modal_spam_send').live('click', function() {
		var selected_message = global_selected_message;
		var message_id = selected_message.attr('id').substring(8);

		var isSpam = false;
		if(selected_message.find("#is_spam").val() == "1"){
			isSpam = true;
		}

		if(isSpam != true){
			$.ajax({
				type: "POST",
				url: '<c:url value="/${prefix}/mark_as_spam"/>',
				data: {
					messageId: message_id
				},
				success: function(msg){
					if(msg == "ok"){
						$(selected_message).find("#is_spam").val("1");
						$(selected_message).find(".message_subject").css("color", "#ff3333");
						$(selected_message).find("#spam_message").next().hide();
						$(selected_message).find("#spam_message").hide();
						$("#modal_spam_sendingSuccess").show();
						$.unblockUI(); 
				  	} else {
				  		$("#modal_spam_sendingError").show();
					}
				},
				error: function(){
				},
				complete: function() { 
				
				}
			});
		}
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
		
	$('#reply_message').live('click', function() {
		var selected_message = $(this).parentsUntil('.prepared_message').parent();
		var receiver = selected_message.find(".message_name").html();
		var subject = selected_message.find(".message_subject").html();
		
		resetModal();

        $('#modal_reply').show();

        $('#new_message_id').val(selected_message.attr('id').substring(8));
        $('#modal_new_message_title').html("Antworten");
        $('#modal_new_message_subtitle').html("Verfassen Sie jetzt eine Mitteilung.");
		$('#new_message_receiver').val(receiver);
		$('#new_message_subject').val(subject);
		$('#new_message_subject').attr("disabled", "disabled");
		$.blockUI({ message: $('#modal_new_message')});
    }); 

	$('#modal_send').click(function() { 

		var copy_to_me = "false";
		if($('#copy_to_me').is(":checked")) {
			copy_to_me = true;
        }
		
        if(validate() == true){
    		$.ajax({
				type: "POST",
				url: '<c:url value="/${prefix}/send_new_message"/>',
				data: {
					receiver: $('#new_message_receiver_id').val(),
					subject: $('#new_message_subject').val(),
					body: $('#new_message_body').val(),
					copy: copy_to_me
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

		var copy_to_me = "false";
		if($('#copy_to_me').is(":checked")) {
			copy_to_me = true;
        }
        
        if(validate() == true){
    		$.ajax({
				type: "POST",
				url: '<c:url value="/${prefix}/reply_to_message"/>',
				data: {
					messageId: $('#new_message_id').val(),
					subject: $('#new_message_subject').val(),
					body: $('#new_message_body').val(),
					copy: copy_to_me
				},
				success: function(msg){
				  if(msg == "ok"){
					  $('#sendingSuccess').show();
					  $("#message_"+$('#new_message_id').val()).find("#reply_symbol").addClass('reply_message');
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

    	$('#copy_to_me').attr('checked', false);
    }
    
});

function init(){
	
	<c:forEach var="message" items="${inbox}">
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

		if('${message.spam}' == "true"){
			$("#"+message_id).find("#is_spam").val("1");
		} else {
			$("#"+message_id).find("#is_spam").val("0");
		}
		
		if($("#"+message_id).find("#is_readed").val() == "0"){
			$("#"+message_id).find("#unread_symbol").addClass('unread_message');
		}

		if($("#"+message_id).find("#is_spam").val() == "1"){
			$("#"+message_id).find(".message_subject").css("color", "#ff3333");	
			$("#"+message_id).find("#spam_message").next().hide();
			$("#"+message_id).find("#spam_message").hide();
		}

		$("#"+message_id).find(".message_date").html('<fmt:formatDate value="${message.created}" type="date" pattern="dd-MMM-yyyy"/>');
		$("#"+message_id).find(".message_name").html('${message.sender.name.name} ${message.sender.name.surname}');
		$("#"+message_id).find(".message_subject").html('${message.subject}');
		
		
		<c:if test="${message.inReplyToMessage!=null}">
			$("#"+message_id).find(".message_body_text").html('${func:escapeJavaScript(message.body)}<br /><br ><label class="opt">Am <fmt:formatDate value="${message.inReplyToMessage.created}" type="date" pattern="dd-MMM-yyyy"/> schrieb ${message.inReplyToMessage.sender.name.name} ${message.inReplyToMessage.sender.name.surname}:</label><br />${func:escapeJavaScript(message.inReplyToMessage.body)}');
		</c:if>
		<c:if test="${message.inReplyToMessage==null}">
			$("#"+message_id).find(".message_body_text").html("${func:escapeJavaScript(message.body)}");
		</c:if>
		
	</c:forEach>
	
	<c:forEach var="reply" items="${replies}">
		var message_id = "message_"+'${reply}';
		$("#"+message_id).find("#reply_symbol").addClass('reply_message');
	</c:forEach>
	
	$(".prepared_message").each(function (index, domEle) {
		$(domEle).show();
	});
}

function newMessage(){
	$('#new_message').trigger('click');
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
