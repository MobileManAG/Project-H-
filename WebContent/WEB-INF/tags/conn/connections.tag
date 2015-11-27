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
<%@ attribute name="isdoctor" required="true" rtexprvalue="true" %>
<%@ attribute name="dir" required="true" rtexprvalue="true" %>

<table width="640" border="0">
	<tr style="background-color: #71ab57;border:1px solid #DDDEE1;">
		<td height="28"><font color="#FFFFFF"><strong> Datum </strong></font></td>
		<td><font color="#FFFFFF"><strong>Verbindungsanfrage <br /></strong></font></td>
		
		<c:if test="${isdoctor}">
		<td><font color="#FFFFFF"><strong>Geschlecht</strong></font></td>
		<td><font color="#FFFFFF"><strong>Jahrgang</strong></font></td>
		</c:if>
		<td align="center"><font color="#FFFFFF"><strong>Aktueller Status</strong></font></td>
		<td align="center"><font color="#FFFFFF"><strong>Optionen</strong></font></td>
	</tr>
	
	<c:forEach var ="conn" items="${connections}">
	<tr id="connection${conn.id}">
		<td style="border: 1px solid #DDDEE1">${conn.date}</td>
		<td style="border: 1px solid #DDDEE1">${conn.name}</td>
		<c:if test="${isdoctor}">
		<td style="border: 1px solid #DDDEE1">${conn.gender}</td>
		<td style="border: 1px solid #DDDEE1">${conn.year}</td>
		</c:if>
		<td align="center" style="border: 1px solid #DDDEE1">
			<c:if test="${conn.accepted}">Best&auml;tigt</c:if>
			<c:if test="${conn.pending}">Pendent (Auf Best&auml;tigung warten)</c:if>
			<c:if test="${conn.pending_confirm}"><t:a href="conn/confirm/${conn.id}" dir="${dir}"><t:img src="buttonbestaetigen.png"/></t:a></c:if>
		</td>
		<td align="center" style="border: 1px solid #DDDEE1">
			<a class="cancelConnection" id="${conn.id}" href="#" dir="${dir}">
				<t:img src="button_ablehnen_grau.png"/>
			</a>
		</td>
	</tr>
	</c:forEach>
	<div id="modal_confirm_delete_connection" style="display: none;padding: 20px;"> 
		<h3>
			<font color="#000000" face="Arial, Helvetica, sans-serif">Sind Sie sicher, dass Sie die Verbindung l&ouml;schen m&ouml;chten?</font>
		</h3>
		<br /> 
		<label class="opt">
			Klicken Sie auf l&ouml;schen, um die Verbindung endg&uuml;ltig zu l&ouml;schen.
		</label>
		<br />
		<br /> 
		<input type="image" id='modal_delete_connection' src="<c:url value="/images/button_loeschen.png"/>"  value="1"/>
		<input type="image" id='modal_cancel_connection' src="<c:url value="/images/button_abbrechen_grau.png"/>"  value="1"/>
		<br />
		<label style="display: none; float: right; text-align: right;" class="error" id="sendingError"><strong>Fehler bei der &Uuml;bermittlung</strong></label>
		<label style="display: none; float: right; text-align: right;" class="success" id="sendingSuccess"><strong>Mitteilung wurde erfolgreich &uuml;bermittelt</strong></label>
	</div>
	<input type="hidden" value="${deleteConnectionId}" name="deleteConnectionId" />
	<script>
		$(".cancelConnection").live('click', function(){
			var id = $(this).attr("id");
			$('input[name="deleteConnectionId"]').val(id);
			$('#sendingSuccess').hide();
			$('#sendingError').hide();
			$.blockUI({ message: $('#modal_confirm_delete_connection')});
		});
		
		$('#modal_cancel_connection').live('click', function() {
			$.unblockUI(); 
			return false; 
		});
		
		$('#modal_delete_connection').live('click', function() {
			var id = $('input[name="deleteConnectionId"]').val();
			
			var callUrl;
			if (${isdoctor}) {
				callUrl = '<c:url value="/arzt/conn/cancel/' + id +'" />';
			} else {
				callUrl = '<c:url value="/patient/conn/cancel/' + id +'" />';
			}
			
			$.ajax({
				type: "POST",
				url: callUrl,
				data: {
				},
				success: function(msg){
				  if(msg == "ok"){
					  $('#sendingSuccess').show();
					  $('#connection' + id).hide();
					  setTimeout($.unblockUI, 1000);
				  }
				},
				error: function(){
					$('#sendingError').show();
				},
				complete: function() { 
					
				}
			});
			
			return false; 
		});
	</script>
</table>
