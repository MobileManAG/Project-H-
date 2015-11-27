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
<m:arztMasterMenu menuitem="3" caption="Einstellungen">
      <label class="opt">Nehmen Sie hier Ihre pers&ouml;nlichen Einstellungen vor.</label><br />
	<br />
	<form method="post" action="<c:url value="/arzt/settings"/>">
	<table width="665">
		<tr>
			<td width="274">
				<label>Benutzername</label>
			</td>
		</tr>
		<tr>
			<td width="379"><strong>${doctor.userAccount.login}</strong></td>
		</tr>
	</table>
		<br />
<table width="665">
			<tr>
				<td width="274"><label title="Weitere Gesundheitsgruppen w&auml;hlen^Sie k&ouml;nnen zus&auml;tzliche Gesundheitsgruppen kostenlos Ihrem Mitgliedskonto hinzuweisen. Unter der Rubrik Online Fragebogen erscheint Ihr neuer Fragenkatalog, welchen Sie periodisch ausf&uuml;llen sollten. Sie haben bei allen Gesundheitsgruppen die M&ouml;glichkeit, den Fragenkatalog zus&auml;tzlich Ihren Bed&uuml;rfnissen entsprechend mit eigenen Fragestellungen anzupassen."class="vtip">Gesundheitsgruppen</label></td>
				
			</tr>
			<tr>
				<table id="diseasesHolder">
				</table>
			</tr>
			<tr>
				<td colspan="2"><select name="select" id="select">
					<option value="0">Weitere Gesundheitsgruppe w&auml;hlen</option>
					<c:forEach var="dis" items="${diseases}">
						<option value="${dis.id}">${dis.name}</option>
					</c:forEach>
				</select>	<br />
			</tr>
		</table><br />
	<table width="665">
			<tr>
				<td width="274">
					<label for="nameofinstitution">Name Ihrer Praxis / Institut</label>
				</td>
				<td width="379">
					<label for="title">Titel</label>
				</td>
			</tr>
			<tr>
				<td>
					<input id="nameofinstitution" type="text" name="nameofinstitution" value="${doctor.medicalInstitution.name}" style="width: 200px" />
				</td>
				<td>
					<input id="title" type="text" name="title" value="${doctor.title}" style="width: 100px" />
				</td>
			</tr>
		</table>
		<br />
		<table width="665">
			<tr>
				<td width="274">
					<label for="namename">Name</label>
				</td>
				<td width="379">
					<label for="surname">Vorname</label>
				</td>
			</tr>
			<tr>
				<td>
					<input id="namename" type="text" name="namename" value="${doctor.name.name}" style="width: 200px" />
				</td>
				<td>
					<input id="surname" type="text" name="surname" value="${doctor.name.surname}" style="width: 200px" />
				</td>
			</tr>
		</table>
		<br />
		<table width="665">
			<tr>
				<td width="274">
					<label for="address">Strasse</label>
				</td>
				<td width="379">
					<label for="nr">Nr.</label>
				</td>
			</tr>
			<tr>
				<td>
					<input id="address" type="text" name="address" value="${doctor.medicalInstitution.address.address}" style="width: 200px" />
				</td>
				<td>
					<input id="nr" type="text" name="nr" value="${doctor.medicalInstitution.address.number}" style="width: 100px" />
				</td>
			</tr>
		</table>
		<br />
		<table width="665">
			<tr>
				<td width="274">
					<label for="postcode">PLZ</label>
				</td>
				<td width="379">
					<label for="place">Ort</label>
				</td>
			</tr>
			<tr>
				<td>
					<input id="postcode" type="text" name="postcode" value="${doctor.medicalInstitution.address.postalCode.code}" style="width: 100px" maxlength="5" />
				</td>
				<td>
					<input id="place" type="text" name="place" value="${doctor.medicalInstitution.address.place}" style="width: 200px" />
				</td>
			</tr>
		</table>
		<br />
		<table width="665">
			<tr>
				<td width="274">
					<label>Land</label>
				</td>
			</tr>
			<tr>
				<td>
					<select size="1" name="country" id="country">
						<option value="DE"  <c:if test="${country=='DE'}">selected</c:if>>
							Deutschland
						</option>
						<option value="CH" <c:if test="${country=='CH'}">selected</c:if>>
							Schweiz
						</option>
						<option value="AT" <c:if test="${country=='AT'}">selected</c:if>>
							&Ouml;sterreich
						</option>
						<option value="LI" <c:if test="${country=='LI'}">selected</c:if>>
							F&uuml;rstentum Liechtenstein
						</option>
					</select>
				</td>
			</tr>
		</table>
		<br />
		<table width="665">
			<tr>
				<td width="100">
					<label for="telefoncountrycode">Vorwahl</label>
				</td>
				<td width="565">
					<label for="telefonnumber">Telefon</label>
				</td>
			</tr>
			<tr>
				<td>
					<input id="telefoncountrycode" type="text" name="telefoncountrycode" value="${doctor.medicalInstitution.phoneNumber.countryCode}" style="width: 80px" maxlength="4" />
				</td>
				<td>
					<input id="telefonnumber" type="text" name="telefonnumber" value="${doctor.medicalInstitution.phoneNumber.number}" style="width: 200px" maxlength="10"/>
				</td>
			</tr>
		</table>
		<br />
		<table width="665">
			<tr>
				<td width="100">
					<label for="faxcountrycode">Vorwahl</label>
				</td>
				<td width="565">
					<label for="faxnumber">Fax</label>
				</td>
			</tr>
			<tr>
				<td>
					<input id="faxcountrycode" type="text" name="faxcountrycode" value="${doctor.medicalInstitution.faxNumber.countryCode}" style="width: 80px" maxlength="4"/>
				</td>
				<td>
					<input id="faxnumber" type="text" name="faxnumber" value="${doctor.medicalInstitution.faxNumber.number}" style="width: 200px" maxlength="10"/>
				</td>
			</tr>
		</table>
		<br />
		<table width="665">
			<tr>
				<td width="274">
					<label for="homepage">Homepage</label>
				</td>
			</tr>
			<tr>
				<td>
					<input id="homepage" type="text" name="homepage" value="${doctor.medicalInstitution.homePageUrl}" style="width: 200px" />
				</td>
			</tr>
		</table>
		<br />
		<br />
		<br />
		<table>
			<tr>
				<td align="left" valign="middle">
				 <input type="image" src="<c:url value="/images/button_speichern.png"/>" />
				</td>
			</tr>
		</table>
		<t:info test="${base_settings_saved}">Ihre &Auml;nderungen wurden erfolgreich gespeichert.</t:info>
		<t:error test="${base_settings_save_error}">Ihre &Auml;nderungen konnten nicht gespeichert werden. <br />${base_settings_save_error_message}</t:error>
	</form>
	<br />
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
			$(function() {

				//init
				onSelectChange();

				//event
				$("#country").change(onSelectChange);

				//handler
				function onSelectChange(){
					var selected = $("#country option:selected");  
					if(selected.val() == "DE"){
						output = "+49";
					}
					if(selected.val() == "CH"){
						output = "+41";
					}
					if(selected.val() == "AT"){
						output = "+43";
					}
					if(selected.val() == "LI"){
						output = "+423";
					}
					$("#faxcountrycode").val(output);
					$("#telefoncountrycode").val(output);
				}
								
			});
			
			function addDiv(id, name) {
				var str = "<tr id=\"row" + id + "\"><td id=\"col" + id + "\">" + name + 
					"</td><td><a href=\"#\" class=\"removeDisease\" id=\"" + 
					id + "\">löschen</a><input type=\"hidden\" value=\""+ id + "\" name=\"disease" + id + "\" /></td></tr>";
				$("#diseasesHolder").append(str);
			}
			
			$(document).ready(function(){
				<c:forEach var="dis" items="${doctor.diseases}">
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
</m:arztMasterMenu>
