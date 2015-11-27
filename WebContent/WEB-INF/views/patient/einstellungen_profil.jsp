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
<m:patientMasterMenu caption="Meine Einstellungen">
	
<label class="opt">Bitte nehmen Sie hier &Auml;nderungen in Ihren pers&ouml;nlichen Einstellungen vor.</label><br />
	<br />
	<br />
	<form method="post" action="<c:url value="/patient/einstellungen_profil"/>">
	<table width="640">
		<tr>
			<td><label title="Benutzername^Der Benutzername kann nachtr&auml;glich nicht mehr ver&auml;ndert werden."class="vtip">Benutzername</label></td>
			<td colspan="2"><strong><t:username name="${patient.name}" /></strong></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td><label title="Jahrgang^Diese Information ist freiwillig, kann eventuell zu einem sp&auml;teren Zeitpunkt wichtig sein zwecks individuellem Leistungsvergleich mit anderen projecth&reg; Mitgliedern."class="vtip">Jahrgang</label></td>
			<td colspan="2"><input type="text" name="year" id="year" value="${year}" style="width: 40px"  maxlength="4"/></td>
		</tr>		
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td><label title="Geschlecht^Diese Information ist freiwillig, kann eventuell zu einem sp&auml;teren Zeitpunkt wichtig sein zwecks individuellem Leistungsvergleich mit anderen projecth&reg; Mitgliedern."class="vtip">Geschlecht</label></td>
			<td colspan="2"> 
			<t:radio value="1" name="gender" checked="${patient.sex=='1'}" label="Mann" rtl="true"/>
		    <t:radio value="0" name="gender" checked="${patient.sex=='0'}" label="Frau" rtl="true"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		
		<tr>
			<td><label title="Land^Diese Information ist freiwillig, kann eventuell zu einem sp&auml;teren Zeitpunkt wichtig sein zwecks individuellem Leistungsvergleich mit anderen projecth&reg; Mitgliedern."class="vtip">Land</label></td>
			<td colspan="2">
				<select id="country" name="country">
				<option value="0">Keine Angabe</option>
				<c:forEach var="c" items="${countries}" varStatus="loop">
					<t:option value="${c.id}" selected="${patient.country.id}">${c.name}</t:option>
				</c:forEach>
				</select>
			</td>
		</tr>
		<!-- 
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td><label title="Nationalit&auml;t^Diese Information ist freiwillig, kann eventuell zu einem sp&auml;teren Zeitpunkt wichtig sein zwecks individuellem Leistungsvergleich mit anderen projecth&reg; Mitgliedern."class="vtip">Nationalit&auml;t</label></td>
			<td colspan="2">
				<select id="nationality" name="nationality">
				<option value="0">Keine Angabe</option>
				<c:forEach var="c" items="${nationalities}" varStatus="loop">
					<c:if test="${loop.index != 3}">
						<t:option value="${c.id}" selected="${patient.nationality.id}" >${c.name}</t:option>
					</c:if>
					<c:if test="${loop.index == 3}">
						<t:option value="${c.id}" selected="${patient.nationality.id}" >${c.name}</t:option>
						<option disabled="disabled">---------------------------------</option>
					</c:if>
				</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td><label title="Ethnizit&auml;t^Diese Information ist freiwillig, kann eventuell zu einem sp&auml;teren Zeitpunkt wichtig sein zwecks individuellem Leistungsvergleich mit anderen projecth&reg; Mitgliedern."class="vtip">Ethnizit&auml;t</label></td>
			<td colspan="2">
				<select id="race" name="race">
				<option value="0">Keine Angabe</option>
				<c:forEach var="r" items="${races}">
					<t:option value="${r.id}" selected="${patient.race.id}">${r.name}</t:option>
				</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td><label title="Bildung^Diese Information ist freiwillig, kann eventuell zu einem sp&auml;teren Zeitpunkt wichtig sein zwecks individuellem Leistungsvergleich mit anderen projecth&reg; Mitgliedern."class="vtip">Bildung</label></td>
			<td colspan="2">
				<select id="education" name="education">
				<option value="0">Keine Angabe</option>
				<c:forEach var="e" items="${educations}">
					<t:option value="${e.id}" selected="${patient.education.id}">${e.name}</t:option>
				</c:forEach>
				</select>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td><label title="Familiensituation^Diese Information ist freiwillig, kann eventuell zu einem sp&auml;teren Zeitpunkt wichtig sein zwecks individuellem Leistungsvergleich mit anderen projecth&reg; Mitgliedern."class="vtip">Familiensituation</label></td>
			<td colspan="2">
				<select id="familySituation" name="familySituation">
				<option value="0">Keine Angabe</option>
				<c:forEach var="f" items="${familySituations}">
					<t:option value="${f.id}" selected="${patient.familySituation.id}">${f.name}</t:option>
				</c:forEach>
				</select>
			</td>
		</tr>		
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td><label title="Gr&ouml;sse eingeben^Diese Information ist freiwillig, kann eventuell zu einem sp&auml;teren Zeitpunkt wichtig sein zwecks individuellem Leistungsvergleich mit anderen projecth&reg; Mitgliedern."class="vtip">Gr&ouml;sse in cm</label></td>
			<td colspan="2"><input type="text" name="height" id="height" value="${patient.height}" style="width: 40px"  maxlength="3"/>cm</td>
		</tr>
		-->
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td><label title="Weitere Gesundheitsgruppen w&auml;hlen^Sie k&ouml;nnen zus&auml;tzliche Gesundheitsgruppen kostenlos Ihrem Mitgliedskonto hinzuweisen. Unter der Rubrik Online Fragebogen erscheint Ihr neuer Fragenkatalog, welchen Sie periodisch ausf&uuml;llen sollten. Sie haben bei allen Gesundheitsgruppen die M&ouml;glichkeit, den Fragenkatalog zus&auml;tzlich Ihren Bed&uuml;rfnissen entsprechend mit eigenen Fragestellungen anzupassen."class="vtip">Gesundheitsgruppen</label></td>
			<td colspan="2">
			<table id="diseasesHolder">
			</table>
			</td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2"><select name="select" id="select">
				<option value="0">Weitere Gesundheitsgruppe w&auml;hlen</option>
				<c:forEach var="dis" items="${diseases}">
					<option value="${dis.id}">${dis.name}</option>
				</c:forEach>
			</select>	<br />	<br /></td>
		</tr>
		<tr>
			<td height="49"><label title="Automatisch anmelden^Wenn Sie dieses K&auml;stchen aktivieren, speichert Ihr Browser standardm&auml;ssig Ihre Zugangsdaten, so dass Sie sich automatisch anmelden k&ouml;nnen bei zuk&uuml;ftigen Besuchen."class="vtip">Automatisch anmelden</label></td>
		  <td colspan="2"><input type="checkbox" name="staylogged" id="staylogged" <c:if test="${autologinenabled}">checked</c:if> /><label for="staylogged">Ja</label></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td valign="middle">&nbsp;</td>
			<td colspan="2" align="left" valign="middle">
			<input type="image" src="<c:url value="/images/button_speichern.png"/>" />
			</td>
		</tr>
		<tr>
		  <td height="60" valign="middle">&nbsp;</td>
		  <td colspan="2" align="left" valign="middle"><t:error test="${passwordnotsame}">Passw&ouml;rter sind nicht identisch.</t:error>
            <t:error test="${passworderror}">Fehler bei der &Auml;nderung Ihres Passwortes.</t:error>
            <t:info test="${base_settings_saved}">Ihre &Auml;nderungen wurden erfolgreich gespeichert.</t:info>
            <t:error test="${base_settings_save_error}">Ihre &Auml;nderungen konnten nicht gespeichert werden. ${base_settings_save_error_message}</t:error>
          <t:info test="${passwordchanged}">Passwort wurde erfolgreich ge&auml;ndert.</t:info></td>
	  </tr>
	</table>
<br />
	<br />
	<br />
	<r:userWeightInput />
		
	<div id="modal_disease" style="display: none;padding: 20px;"> 
		<h3>
			<font color="#000000" face="Arial, Helvetica, sans-serif">Gesundheitsgruppe l&ouml;schen</font>
		</h3>
		<br /> 
		<label class="opt">
			Klicken Sie auf l&ouml;schen, um die gespeicherte Gesundheitsgruppe mit Einstellungen zu l&ouml;schen.
		</label>
		<br />
		<br /> 
		<input type="image" id='modal_delete_disease' src="<c:url value="/images/button_loeschen.png"/>"  value="1"/>
		<input type="image" id='modal_cancel_disease' src="<c:url value="/images/button_abbrechen_grau.png"/>"  value="1"/>
	</div>
	<input type="hidden" value="${deleteDiseaseId}" name="deleteDiseaseId" />
	<script>
		function addDiv(id, name) {
			var str = "<tr id=\"row" + id + "\"><td id=\"col" + id + "\">" + name + 
				"</td><td><a href=\"#\" class=\"removeDisease\" id=\"" + 
				id + "\">löschen</a><input type=\"hidden\" value=\""+ id + "\" name=\"disease" + id + "\" /></td></tr>";
			$("#diseasesHolder").append(str);
		}
		
		$(document).ready(function(){
			<c:forEach var="dis" items="${patient.diseases}">
				addDiv("${dis.id}", "${dis.name}");
			</c:forEach>
			$("#select").change(function(){
				 $("#select option:selected").each(function () {
					 //add item
					 addDiv($(this).val(), $(this).text());
					 //delte from options
					 $("#select option:selected").remove();
		         });
			});
			
			$(".removeDisease").live('click', function(){
				var id = $(this).attr("id");
				$('input[name="deleteDiseaseId"]').val(id);
				$.blockUI({ message: $('#modal_disease')});
			});
		});
		
		$('#modal_cancel_disease').live('click', function() {
			$.unblockUI(); 
			return false; 
		});
		
		$('#modal_delete_disease').live('click', function() {			
			var id = $('input[name="deleteDiseaseId"]').val();
			$("#select").append("<option value=\"" + id + "\">" + $("#col" + id).text() + "</option>");
			$("#row" + id).remove();
			$.unblockUI(); 
			return false; 
		});
		
		
		
	</script>
</m:patientMasterMenu>
