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
<m:publicMasterMenu title="Jetzt mitmachen bei projecth&reg;" caption="Registrierung von Patienten">
	<t:form action="/behandlung/signup">
	  <table width="640">
	    <tr>
	      <td width="500" valign="top">projecth&reg; Online ist f&uuml;r Sie  kostenlos. <br />
	        <br />
	      <label class="opt">  Um ein neues Konto zu er&ouml;ffnen, f&uuml;llen Sie bitte die untenstehenden Felder aus.</label><br />
	        <br /></td>
	      <td width="140"><t:img src="patientfront3.png" /></td>
        </tr>
      </table>
		<table width="534">
			<tr>
				<td colspan="2">
				<label>Ich bin*...</label></td>
			</tr>
			<tr>
				<td width="20"><input type="radio" name="usertype" value="P"
					<c:if test="${usertype=='P'}">checked</c:if> /></td>
				<td width="368"><label><t:apublic
					href="chronisch_betroffene">Patient</t:apublic></label></td>
			</tr>
		</table>
	  <t:error test="${errortype}">Bitte markieren Sie den korrekten Typ.</t:error>
		<br /><br />
		<table width="644">
			<tr>
				<td width="274"><label>Gesundheitsgruppe ausw&auml;hlen* </label><br />
<br />
				  <select size="1" name="disease" id="disease">
				    <option value="0"></option>
                	<c:forEach var="dis" items="${diseases}">
                		<t:option value="${dis.id}" selected="${val_disease_id}">${dis.name}</t:option>
					</c:forEach>
			      </select>
				 
			  </td>
				<td width="358">&nbsp;</td>
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
					title="Benutzername^Bitte w&auml;hlen Sie einen einzigartigen Benutzernamen aus, aber vermeiden Sie die Nutzung von identifizierbaren Informationen (z. B. Hans_Muster_Basel). Sie k&ouml;nnen den Benutzernamen nachtr&auml;glich nicht mehr &auml;ndern und ist zugleich Ihr Mitgliedsname bei projecth&reg;. Nur Sie und von Ihnen anvertraute Personen wissen,
dass es Ihr Benutzername ist. Behalten Sie das projecth&reg; System 100% anonym."
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
					<t:error test="${errorlogin_too_short}" usespan="true">Fehler - Mindestl&auml;nge der Benutzername ist 5 ${min_login_length} Zeichen.</t:error>
					<t:error test="${errorlogin_too_long}" usespan="true">Fehler - maximale L&auml;nge des Benutzername ist ${max_login_length} Zeichen.</t:error>
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
				<td width="379"><label for="password2"> Passwort exakt wiederholen*</label></td>
			</tr>
			<tr>
				<td>
					<input id="password" type="password" name="password" style="width: 200px" maxlength="12"/>
				</td>
				<td><input id="password2" type="password" name="password2" style="width: 200px" maxlength="12"/>
				</td>
			</tr>
			<tr>
				<td>
					<t:error test="${errorpassword}" usespan="true">Erforderliches Feld - muss ausgef&uuml;llt werden.</t:error>
					<t:error test="${errorpassword_too_short}" usespan="true">Fehler - Passwort Mindestl&auml;nge beträgt ${min_password_length} Zeichen.</t:error>
					<t:error test="${errorpassword_too_long}" usespan="true">Fehler - Die maximale Passwortl&auml;nge ${max_password_length} Zeichen.</t:error>
				</td>
				<td>
					<t:error test="${errorpassword2}" usespan="true">Bitte geben Sie das Passwort  nochmals an.
					<br />
					</t:error> <t:error test="${errorpasssame}">Passw&ouml;rter stimmen nicht &uuml;berein.</t:error>
				</td>
			</tr>
		</table>
		<br />
		<table>
			<tr>
				<td><label
					title="E-Mail Adresse^Eine g&uuml;ltige E-Mail Adresse ist f&uuml;r die Aktivierung Ihres projecth&reg; Konto und bei Verlust Ihrer Zugangsdaten erforderlich.
			Ihre E-Mail Adresse wird nie ver&ouml;ffentlicht."
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
				<t:error
					test="${error!=null}">Bitte geben Sie eine g&uuml;ltige E-Mail Adresse an. ${error}</t:error>
				<t:info test="${info}">Der Aktivierungslink wurde Ihnen soeben per E-Mail  versendet.</t:info>
				</td>
			</tr>

			<tr>
				<td><br />
				<label class="opt">*Pflichtfelder</label></td>
			</tr>
		</table>
		<br />
	</t:form>
</m:publicMasterMenu>
