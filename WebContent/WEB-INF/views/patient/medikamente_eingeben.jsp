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
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<m:patientMasterMenu menuitem="2" caption="${patientMedication == null ? 'Medikation eingeben' : 'Medikation bearbeiten'}">
<jsp:body>
<form method="post" action="<c:url value="/patient/medikamente_eingeben"/>" class="niceform" name="medikamente_eingeben">
	<input type="hidden" value="${patientMedicationId}" name="patientMedicationId" />
	<table width="640" >
		<c:if test="${patientMedication == null}">
			<tr>
				<td width="35%" height="27"><strong>Auswahl Medikament</strong></td>
				<td width="65%">&nbsp;</td>
			</tr>
			<tr>
				<td height="27"><t:img src="croix_small.png" alt="" width="12" height="12" />
					<label title="Historie^Wenn Sie bereits das Medikament einmal eingeben haben, so erscheint es in Ihrem Verlauf f&uuml;r eine erneute Eingabe."class="vtip">Historie</label>
				</td>
				<td >
					<select style="width: 210px" name="selecthistory" id="selecthistory">
						<option value="-1" >Aus Historie ausw&auml;hlen</option>
						<c:forEach var="med" items="${historymed}" varStatus="status">
							<option value="${status.index}" ${status.index == selected_history_medication ? 'selected' : ''}>${med.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
			  <td height="62" valign="middle">oder</td>
			  <td valign="bottom">
			  	<br />
				<t:img src="barcode.png" alt="" width="142" height="70"/></td>
			  </tr>
			<tr>
				<td height="62" valign="middle"><t:img src="croix_small.png" alt="" width="12" height="12" />
				<label title="Pharmazentralnummer (PZN)^Geben Sie einfach die 7-stellige Zahl ein. Die PZN ist ein in Deutschland bundeseinheitlicher Identifikationsschl&uuml;ssel f&uuml;r Arzneimittelprodukte. Falls Sie ein Arzneimittel dokumentieren m&ouml;chten ohne PZN, suchen Sie alternativ nach dem Medikamentenname unter Eingabe des Namens."class="vtip">Suche nach Name oder Pharmazentral-Nummer</label><br /></td>
				<td valign="middle"><input style="width: 204px" type="text" name="filter" id="filter" value="${filter}" /></td>
			</tr>
			<tr>
			  <td height="62"><a name="aftersearch" id="aftersearch"></a></td>
				<td><t:imagebutton image="buttonsuchen.png" name="search" /></td>
			</tr>
			<tr>
			  <td height="62" colspan="2"><hr /></td>
			  </tr>
	
	<c:if test="${wasSearch}">
			<tr>
				<td height="62">Bitte spezifizieren</td>
				<td>
					<t:error test="${errorsearchnodata}">Geben Sie den Barcode ein (Rückseite der Verpackung) oder geben Sie den exakten Namen Ihres Medikamentes ein.</t:error>
					<t:error test="${errorsearch}">Ihre Eingabe ergab einen internen Fehler. Bitte versuchen Sie es erneut.</t:error>
					<t:info test="${infosearchnotfound}">Es wurde kein Medikament gefunden. Bitte geben Sie nur verschreibungspflichtige Medikamente ein und stellen Sie sicher, dass Sie den Namen exakt wiedergeben.</t:info>
					<select name="selectsearchresult" id="selectsearchresult">
						<option value="-1"></option>
						<c:forEach var="med" items="${searchresult}" varStatus="status">
							<option value="${status.index}">${med.name}</option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
	</c:if>
	</c:if>
		<tr>
		  <td height="27">
		    <strong>Anzeige Medikament</strong></td>
		  <td>&nbsp;</td>
		  </tr>
		<tr>
			<td valign="top"><label title="PZN^Freiwillig: Sie k&ouml;nnen die Eingabe auch ohne PZN-Nummer vornehmen."class="vtip">Pharmazentralnummer (PZN)</label></td>
			<td valign="middle">
			<input <c:if test="${patientMedication != null}">readonly="readonly"</c:if> type="text" name="pzn" id="pzn"  value="${pzn}"/></td>
		</tr>
		<tr>
			<td valign="top"><label title="Medikamentenname^Hier erscheint der exakte Medikamentenname. Sie k&ouml;nnen aber auch einen Namen f&uuml;r ein Medikament, Therapie oder sonstige Massnahme selbst frei eingeben."class="vtip">Medikamentenname</label></td>
			<td valign="middle">
			<t:error test="${errorname}">Medikamentenname darf nicht leer sein</t:error>			
			<input <c:if test="${patientMedication != null}">readonly="readonly"</c:if> type="text" name="name" id="name"  value="${name}"/></td>
		</tr>
		<tr>
			<td valign="top"><label title="Standard Einheit^Falls Sie ein Medikament manuell erfassen, machen Sie auch eine Angabe über die Einheit wie Dragees, Tabletten, Stück, ml, Spritze, usw."class="vtip">Standard Einheit</label></td>
			<td valign="middle">
			<t:error test="${errorunits}">Bitte geben Sie eine Einheit an</t:error>
			<input <c:if test="${patientMedication != null}">readonly="readonly"</c:if> type="text" name="unitssize" id="unitssize"  value="${unitssize}"/></td>
		</tr>

		<tr>
			<td valign="top">&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		
		<tr>
			<td><label title="Grund der Angabe^Bitte w&auml;hlen Sie, f&uuml;r welche Gesundheitsgruppe dieses Medikament verwendet wird."class="vtip">Grund der Medikation</label></td>
			<td>
			<t:error test="${errordisease}">Bitte Angabe machen</t:error>
			<select name="selectdisease" id="selectdisease">
				<option value="0">Gesundheitsgruppe w&auml;hlen</option>
				<c:forEach var="dis" items="${diseases}">
					<t:option value="${dis.code}" selected="${selected_disease_code}">${dis.name}</t:option>
				</c:forEach>
			</select></td>
		</tr>
		<tr>
			<td><label title="Anzahl eingenommene Einheiten^Bitte machen Sie hier Ihre Angabe &uuml;ber die Anzahl der eingenommenen Einheiten."class="vtip">Anzahl eingenommene Einheiten</label></td>
			<td>
			<t:error test="${errorselectunits}">Bitte Angabe machen</t:error>
			<label for="units"></label> <select name="selectunits" id="selectunits">
				<t:option value=" Bitte Angabe machen">Bitte Angabe machen</t:option>
				<t:option value="1" selected="${selectedUnits}">1</t:option>
				<t:option value="2" selected="${selectedUnits}">2</t:option>
				<t:option value="3" selected="${selectedUnits}">3</t:option>
				<t:option value="4" selected="${selectedUnits}">4</t:option>
				<t:option value="5" selected="${selectedUnits}">5</t:option>
				<t:option value="6" selected="${selectedUnits}">6</t:option>
				<t:option value="7" selected="${selectedUnits}">7</t:option>
				<t:option value="8" selected="${selectedUnits}">8</t:option>
				<t:option value="9" selected="${selectedUnits}">9</t:option>
				<t:option value="10" selected="${selectedUnits}">10</t:option>
				<t:option value="11" selected="${selectedUnits}">11</t:option>
				<t:option value="12" selected="${selectedUnits}">12</t:option>
				<t:option value="13" selected="${selectedUnits}">13</t:option>
				<t:option value="14" selected="${selectedUnits}">14</t:option>
				<t:option value="15" selected="${selectedUnits}">15</t:option>
				<t:option value="16" selected="${selectedUnits}">16</t:option>
				<t:option value="17" selected="${selectedUnits}">17</t:option>
				<t:option value="18" selected="${selectedUnits}">18</t:option>
				<t:option value="19" selected="${selectedUnits}">19</t:option>
				<t:option value="20" selected="${selectedUnits}">20</t:option>
			</select></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<c:if test="${patientMedication == null}">
		<tr>
			<td><label title="Anzahl H&auml;ufigkeit der Einnahme^Bitte geben Sie hier die H&auml;ufigkeit der Einnahme an."class="vtip">Anzahl H&auml;ufigkeit der Einnahme</label></td>
			<td>
			<t:error test="${error_taking_frequency}">Bitte Angabe machen</t:error>
			<select name="select_taking_frequency" id="select_taking_frequency" >
				<t:option value="0">H&auml;ufigkeit der Einnahme w&auml;hlen</t:option>
				<c:forEach var="mf" items="${medication_frequencies}">
					<t:option value="${mf.frequency}" selected="${select_taking_frequency}">${mf.name}</t:option>
				</c:forEach>
				
			</select></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		</c:if>
		<tr>
			<td><label title="Datum der Einnahme^Bitte geben Sie das Datum der Einnahme an."class="vtip">Datum der Einnahme</label></td>
			<td>
			<t:error test="${error_consum_start_date}">Bitte Angabe machen</t:error>
				<input style="width: 120px;float:left;" name="consum_start_date" type="text" id="datepicker_start"><label class="opt"> TT/MM/JJJJ</label>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		
		<c:if test="${patientMedication == null}">
		<tr id="consumption_end_date_row">
			<td><label title="Ende der Einnahme^Bitte geben Sie Enddatum der Einnahme an."class="vtip">Ende der Einnahme</label></td>
			<td>
			<t:error test="${error_consum_end_date}">Bitte Angabe machen</t:error>
				<input style="width: 120px; float:left;" name="consum_end_date" type="text" id="datepicker_end"><label class="opt">  TT/MM/JJJJ</label>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		</c:if>
		<!-- 
		<tr>
			<td><label title="Notizen / Bemerkungen^Hier k&ouml;nnen Sie f&uuml;r sich relevante Informationen niederschreiben wie z. b. Nebenwirkungen."class="vtip">Notizen / Bemerkungen</label></td>
			<td>
			<textarea style="width: 198px; height: 50px; vertical-align: top;" id="comment" name="comment" rows="1" cols="2">${comment}</textarea>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		-->
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">
				<t:imagebutton image="button_eingeben.png" name="enter" id="submitButton"/>
				<t:keepScroll id="submitButton"/>
				<c:if test="${patientMedication != null}">
					<a id="${conn.id}" href="../medikamente_journal" dir="${dir}">
						<t:img src="button_abbrechen_grau.png"/>
					</a>
				</c:if>
				<c:if test="${patientMedication == null}">
					<input type="image" border="0" id="buttonReset" name="buttonReset" src="<c:url value="/images/button_feld_loeschen.png" />"></input>
				</c:if>
			</td>
			<td colspan="3">
				
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
	</table>
	<t:error test="${erroraddmed}">Fehlerhafte Eingabe. Bitte wiederholen Sie den Vorgang.</t:error>
	<t:error test="${errorconsume}">Fehlerhafte Eingabe. Bitte wiederholen Sie den Vorgang.</t:error>
	<t:info test="${infoconsume}">Ihre Eingabe wurde erfolgreich gespeichert.</t:info>
	<br /><br /><br /><br /><br /><br />
	<table width="2" border="0">
	</table>
</form>
</jsp:body>
</m:patientMasterMenu>
<script>
	var search_values = [
   		<c:forEach var="med" items="${searchresult}">
   		{name:"${med.name}", pzn:"${med.pzn.number}", units:"${med.standardUnitSize}" },
   		</c:forEach>
   		];

   		var history_values = [
   		             		<c:forEach var="med" items="${historymed}">
   		             		{name:"${med.name}", pzn:"${med.pzn.number}", units:"${med.standardUnitSize}" },
   		             		</c:forEach>
   		             		];

   		function changed(sel, data) {
   			$("#name").val("");
   			$("#pzn").val("");
   			$("#unitssize").val("");
   			var index = parseInt($(sel).val());
   			if(index<0){
   				return;
   			}
   			var obj = data[index];
   			$("#name").val(obj.name);
   			$("#pzn").val(obj.pzn);
   			$("#unitssize").val(obj.units);
   		}
   		
   		$(document).ready(function() {
   			   			
   			$("#selecthistory").change(function (){ changed(this, history_values);});
   			$("#selectsearchresult").change(function (){ changed(this, search_values);});
   		});
   		
   		$('#cancelweight').click(function() { 
               
           });
             		
	function ResetForm(which){
		var pass=true
		var first=-1
		if (document.images){
		for (i=0;i<which.length;i++){
		var tempobj=which.elements[i]
		 if (tempobj.type=="text"){
		  eval(tempobj.value="")
		  if (first==-1) {first=i}
		 }
		 else if (tempobj.type=="checkbox") {
		  eval(tempobj.checked=0)
		  if (first==-1) {first=i}
		 }
		 else if (tempobj.col!="") {
		  eval(tempobj.value="")
		  if (first==-1) {first=i}
		 }
		}
		}
		which.elements[first].focus()
		return false
	}
	
	$(function() {
			
		$("#buttonReset").live('click', function(){
			var form = document.forms["medikamente_eingeben"];
			form.reset();
			return false;
		});
		
		$("#consumption_end_date_row" ).hide();
		
		$( "#datepicker_start" ).datepicker({
			showOn: "both",
			buttonImage: "<c:url value="/images/calendar.png" />",
			buttonImageOnly: true
		});
		
		$( "#datepicker_end" ).datepicker({
			showOn: "button",
			buttonImage: "<c:url value="/images/calendar.png" />",
			buttonImageOnly: true
		});
		
		$( "#datepicker_start" ).datepicker( "setDate" , '${consum_start_date}' );
		$( "#datepicker_end" ).datepicker( "setDate" , '${consum_end_date}' );
		
		onSelectFrequencyChange();
		
		$("#select_taking_frequency").live('change', function(){
			onSelectFrequencyChange();
		});
		
		//select_taking_frequency handler
		function onSelectFrequencyChange(){
			var selected = $("#select_taking_frequency option:selected");
			
			if (selected.val() == 'DAILY' || selected.val() == 'WEEKLY' || selected.val() == 'BI_WEEKLY') {
				$( "#datepicker_end" ).datepicker( "setDate" , 'Now' );
				$("#consumption_end_date_row" ).show();
			} else {
				$("#consumption_end_date_row" ).hide();
			}
		}
	});


	function resetChangeWeightModal() {
		$('#weightinput').val("");
		$('#datepicker').val("");
		$('#weighterror').hide();
		$('#dateerror').hide();
		$('#sendingError').hide();
	}
	
</script>
