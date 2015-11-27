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
<%@ include file="/WEB-INF/taglibs.inc"%>
<m:publicMasterMenu title="Jetzt mitmachen bei projecth&reg;" caption="Registrierung &Auml;rztin und Arzt">
	<t:form action="/behandlung/signup">
		<table width="640">
		  <tr>
		    <td width="500" valign="top">projecth&reg; Online ist f&uuml;r Sie  kostenlos. <br />
		      <br />
		     <label class="opt"> Um ein neues Konto zu er&ouml;ffnen, f&uuml;llen Sie bitte die untenstehenden Felder aus.</label><br />
	        <br /></td>
		    <td width="140"><t:img src="arzt_male.png" /></td>
	      </tr>
	  </table>
		<table width="534">
			<tr>
				<td colspan="2">
				<label>Ich bin*...</label></td>
			</tr>
			<tr>
				<td width="20"><input type="radio" name="usertype" value="D"
					<c:if test="${usertype=='D'}">checked</c:if> /></td>
				<td width="368"><label> <t:apublic href="aerzte">approbierte &Auml;rztin oder approbierter Arzt</t:apublic></label></td>
			</tr>
		</table>
	  <t:error test="${errortype}">Bitte markieren Sie den korrekten Typ.</t:error>
		<br /><br />
		<table width="644">
			<tr>
				<td width="274"><label>Gesundheitsgruppe ausw&auml;hlen*</label><br />
				  <br />
	                <select size="1" name="disease" id="disease">
	                	<option value="0"></option>
	                	<c:forEach var="dis" items="${diseases}">
	                		<t:option value="${dis.id}" selected="${val_disease_id}">${dis.name}</t:option>
						</c:forEach>
					</select>
				</td>
				<td width="358"></td>
			</tr>
			<tr>
				<td colspan="2"><t:error test="${errordisease}">Bitte w&auml;hlen Sie eine Gesundheitsgruppe aus.</t:error>
				</td>
			</tr>
			<tr>
				<td colspan="2"><label class="opt">Ist Ihre
				Gesundheitsgruppe nicht aufgelistet? <strong><t:apublic
					href="gesundheitsgruppen_anmelden">Verlangen Sie es hier.</t:apublic></strong></label></td>
			</tr>
		</table>
		<br />


		<table>
			<tr>
				<td><br />
				<label for="login"
					title="Benutzername^Bitte w&auml;hlen Sie einen einzigartigen Benutzernamen aus. Sie k&ouml;nnen den Benutzernamen nachtr&auml;glich nicht mehr &auml;ndern und ist zugleich Ihr Mitgliedsname bei projecth&reg;. Nur Sie und von Ihnen anvertraute und authorisierte Personen wissen,
dass es Ihr Benutzername ist. Benutzen Sie keinen echten Namen um das projecth System 100% anonym zu behalten."
					class="vtip">Benutzername*</label> <label for="login" class="opt"></label>
				</td>
			</tr>
			<tr>
				<td><input id="login" type="text" name="login"
					style="width: 300px" value="${login}" maxlength="15"/></td>
			</tr>
			<tr>
				<td>
					<t:error test="${errorlogin}">Bitte geben Sie einen Benutzernamen an.</t:error>
					<t:error test="${errorloginexists}">Fehler - Benutzername existiert bereits. Bitte w&auml;hlen Sie anderen Benutzernamen aus.</t:error>
					<t:error test="${errorlogin_too_short}" usespan="true">Fehler - Mindestl&auml;nge der Benutzername ist 15 ${min_login_length} Zeichen.</t:error>
					<t:error test="${errorlogin_too_long}" usespan="true">Fehler - maximale Länge des Benutzername ist ${max_login_length} Zeichen.</t:error>
				</td>
			</tr>

		</table>

		<br />

		<table width="665">
			<tr>
				<td width="274"><label for="password"
					title="Passwort Eingabe^Sie k&ouml;nnen selbst Ihr Passwort bestimmen. Notieren Sie Ihr Passwort und bewahren Sie es an einem sicheren Ort auf."
					class="vtip">Passwort*</label> <label for="password" class="opt"></label>
				</td>
				<td width="379">
					<label for="password2"> Passwort exakt wiederholen*</label>
				</td>
			</tr>
			<tr>
				<td>
					<input id="password" type="password" name="password" style="width: 200px" maxlength="12"/>
				</td>
				<td>
					<input id="password2" type="password" name="password2" style="width: 200px" maxlength="12"/>
				</td>
			</tr>
			<tr>
				<td>
					<t:error test="${errorpassword}" usespan="true">Bitte geben Sie ein Passwort an.</t:error>
					<t:error test="${errorpassword_too_short}" usespan="true">Fehler - Passwort Mindestl&auml;nge beträgt ${min_password_length} Zeichen.</t:error>
					<t:error test="${errorpassword_too_long}" usespan="true">Fehler - Die maximale Passwortlänge ${max_password_length} Zeichen.</t:error>
				</td>
				<td>
					<t:error test="${errorpassword2}" usespan="true">Bitte geben Sie das Passwort nochmals an.<br /></t:error> 
					<t:error test="${errorpasssame}">Passw&ouml;rter stimmen nicht &uuml;berein.</t:error>
				</td>
			</tr>
		</table>
		<br />
		<table width="665">
			<tr>
				<td width="274">
					<label for="nameofinstitution">Name Ihrer Praxis / Institut*</label>
				</td>
				<td width="379">
					<label for="title">Titel</label>
				</td>
			</tr>
			<tr>
				<td>
					<input id="nameofinstitution" type="text" name="nameofinstitution" style="width: 200px" value="${val_nameofinstitution}" />
				</td>
				<td>
					<input id="title" type="text" name="title" style="width: 100px" />
				</td>
			</tr>
			<tr>
				<td>
					<t:error test="${errornameofinstitution}" usespan="true">Erforderliches Feld - muss ausgef&uuml;llt werden</t:error>
				</td>
				<td>
				</td>
			</tr>
		</table>
		<br />
		<table width="665">
			<tr>
				<td width="274">
					<label for="namename">Name*</label>
				</td>
				<td width="379">
					<label for="surname">Vorname*</label>
				</td>
			</tr>
			<tr>
				<td>
					<input id="namename" type="text" name="namename" style="width: 200px" value="${val_namename}"/>
				</td>
				<td>
					<input id="surname" type="text" name="surname" style="width: 200px" value="${val_surname}"/>
				</td>
			</tr>
			<tr>
				<td>
					<t:error test="${errornamename}" usespan="true">Erforderliches Feld - muss ausgef&uuml;llt werden</t:error>
				</td>
				<td>
					<t:error test="${errorsurname}" usespan="true">Erforderliches Feld - muss ausgef&uuml;llt werden</t:error>
				</td>
			</tr>
		</table>
		<br />
		<table width="665">
			<tr>
				<td width="274">
					<label for="address">Strasse*</label>
				</td>
				<td width="379">
					<label for="nr">Nr.*</label>
				</td>
			</tr>
			<tr>
				<td>
					<input id="address" type="text" name="address" style="width: 200px"  value="${val_surname}"/>
				</td>
				<td>
					<input id="nr" type="text" name="nr" style="width: 100px"  value="${val_nr}"/>
				</td>
			</tr>
			<tr>
				<td>
					<t:error test="${erroraddress}" usespan="true">Erforderliches Feld - muss ausgef&uuml;llt werden</t:error>
				</td>
				<td>
					<t:error test="${errornr}" usespan="true">Erforderliches Feld - muss ausgef&uuml;llt werden</t:error>
				</td>
			</tr>
		</table>
		<br />
		<table width="665">
			<tr>
				<td width="274">
					<label for="postcode">PLZ*</label>
				</td>
				<td width="379">
					<label for="place">Ort*</label>
				</td>
			</tr>
			<tr>
				<td>
					<input id="postcode" type="text" name="postcode" style="width: 100px" maxlength="5" value="${val_postcode}"/>
				</td>
				<td>
					<input id="place" type="text" name="place" style="width: 200px" value="${val_place}"/>
				</td>
			</tr>
			<tr>
				<td>
					<t:error test="${errorpostcode}" usespan="true">Erforderliches Feld - muss ausgef&uuml;llt werden</t:error>
				</td>
				<td>
					<t:error test="${errorplace}" usespan="true">Erforderliches Feld - muss ausgef&uuml;llt werden</t:error>
				</td>
			</tr>
		</table>
		<br />
		<table width="665">
			<tr>
				<td width="274">
					<label>W&auml;hlen Sie Ihr Land*</label>
				</td>
			</tr>
			<tr>
				<td>
					<select id="country" name="country">
						<option value="0">Land w&auml;hlen</option>
						<c:forEach var="c" items="${countries}" varStatus="loop">
							<t:option value="${c.code}" selected="${val_country}">${c.name}</t:option>
						</c:forEach>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2"><t:error test="${errorcountry}">Erforderliches Feld - muss ausgef&uuml;llt werden</t:error>
				</td>
				<td colspan="2"><t:error test="${errorcountrycode}">Erforderliches Feld - muss ausgef&uuml;llt werden</t:error>
				</td>
			</tr>
		</table>
		<br />
		<table width="665">
			<tr>
				<td width="100">
					<label for="telefoncountrycode">Vorwahl*</label>
				</td>
				<td width="565">
					<label for="telefonnumber">Telefonnummer*</label>
				</td>
			</tr>
			<tr>
				<td>
					<input id="telefoncountrycode" type="text" name="telefoncountrycode" style="width: 80px" maxlength="4" value="${val_telefoncountrycode}"/>
				</td>
				<td>
					<input id="telefonnumber" type="text" name="telefonnumber" style="width: 200px" maxlength="13" value="${val_telefonnumber}"/>
				</td>
			</tr>
			<tr>
				<td>
					<t:error test="${errortelefoncountrycode}" usespan="true">Erforderliches Feld - muss ausgef&uuml;llt werden</t:error>
				</td>
				<td>
					<t:error test="${errortelefonnumber}" usespan="true">Erforderliches Feld - muss ausgef&uuml;llt werden</t:error>
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
					<label for="faxnumber">Faxnummer</label>
				</td>
			</tr>
			<tr>
				<td>
					<input id="faxcountrycode" type="text" name="faxcountrycode" style="width: 80px" maxlength="4" value="${val_faxcountrycode}"/>
				</td>
				<td>
					<input id="faxnumber" type="text" name="faxnumber" style="width: 200px" maxlength="13"/>
				</td>
			</tr>
			<tr>
				<td>
					<t:error test="${errorfaxcountrycode}" usespan="true">Erforderliches Feld - muss ausgef&uuml;llt werden</t:error>
				</td>
				<td>
					<t:error test="${errorfax}" usespan="true">Erforderliches Feld - muss ausgef&uuml;llt werden</t:error>
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
					<input id="homepage" type="text" name="homepage" style="width: 300px" value="${val_homepage}"/>
				</td>
			</tr>
			<tr>
				<td>
					<t:error test="${errorhomepage}" usespan="true">Erforderliches Feld - muss ausgef&uuml;llt werden</t:error>
				</td>
			</tr>
		</table>
		<br />
		<table>
			<tr>
				<td><label
					title="E-Mail Adresse^Eine g&uuml;ltige E-Mail Adresse ist f&uuml;r die Aktivierung Ihres projecth Konto und bei Verlust Ihrer Zugangsdaten erforderlich.
			Ihre E-Mail Adresse wird nie ver&ouml;ffentlicht und ausschliesslich nur f&uuml;r den obbenannten Zweck verwendet."
					class="vtip">E-Mail Adresse*</label></td>
			</tr>
			<tr>
				<td><input id="email" type="text" name="email"
					style="width: 300px" value="${email}" /></td>
			</tr>
			<tr>
				<td><t:error test="${erroremail}" usespan="true">Eine g&uuml;ltige E-Mail Adresse ist Pflicht.</t:error>
				<t:error test="${erroremailexists}">Fehler - E-Mail Adresse ist bereits im System registriert. Bitte verwenden Sie eine andere E-Mail Adresse.</t:error>
				</td>
			</tr>
			<tr>
				<td><label class="opt"></label></td>
			</tr>
		</table>
		<br />
		<table width="534">
			<tr>
				<td><input type="checkbox" name="accepted" id="accepted" /></td>
				<td><label for="accepted">Ich stimme den <t:apublic
					href="nutzungsbedingungen" target="_new">
					<strong>Nutzungsbedingungen</strong>
				</t:apublic> und dem <t:apublic href="datenschutz" target="_new">
					<strong>Datenschutz</strong>
				</t:apublic> von projecth&reg; zu.</label></td>
			</tr>
		</table>
		<table>
			<tr>
				<td><t:error test="${erroraccepted}">Die Nutzungsbedingungen und der Datenschutz m&uuml;ssen akzeptiert werden.</t:error>
				</td>
			</tr>
			<tr>
				<td><br />
				<t:captcha /></td>
			</tr>
			<tr>
				<td><br />
				<label> Lesen Sie hier unsere Philosophie der<t:apublic
					href="offenheit" target="_new">
					<strong>Offenheit</strong>.</t:apublic> </label></td>
			</tr>
			<tr>
				<td><br />
				<!-- send --> <t:imagebutton image="button_anmelden.png" id="submitButton"/>
				<t:keepScroll id="submitButton" /> 
				<t:error test="${error!=null}">Bitte geben Sie eine g&uuml;ltige E-Mail Adresse an. ${error}</t:error>
				<t:info test="${info}"><strong>Der Aktivierungslink wurde Ihnen soeben per E-Mail  gesendet.</strong></t:info>
				</td>
			</tr>

			<tr>
				<td><br />
				<label class="opt">*Pflichtfelder<br />
				  <br />
				  <strong><br />
				  WICHTIG</strong><br />
				  <br />
				  Bitte beachten Sie, dass wir 
                erst nach vorheriger manueller Offline-Verifizierung Ihr Mitgliedskonto freischalten. Dies erfolgt in der Regel innerhalb eines Werktages. Wir danken Ihnen für Ihre Geduld.</label></td>
			</tr>
		</table>
		<br />
		<script>
			$(function() {

				//event
				$("#country").live('change', function(){
					onSelectChange();
				});
				
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
		</script>
	</t:form>
</m:publicMasterMenu>
