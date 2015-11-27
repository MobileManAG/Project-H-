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
<%@ include file="/WEB-INF/taglibs.inc"%><m:publicMasterMenu
	title="Benutzernamen oder Passwort vergessen?"
	caption="Benutzernamen oder Passwort vergessen?">
	<label class="opt">Kein Problem.
<br />
	<br />
	Falls Sie Ihr projecth&reg; Passwort oder Benutzernamen vergessen haben, geben Sie einfach die E-Mail Adresse ein, die Sie bei der erstmaligen Anmeldung bei projecth&reg; angegeben haben. Wir werden Ihnen die Anleitung per E-Mail senden, wie Sie Ihr Passwort zur&uuml;cksetzen k&ouml;nnen.<br />
	<br />
	Aus Sicherheitsgr&uuml;nden k&ouml;nnen wir Ihnen das aktuelle Passwort nicht zusenden lassen.</label><br />
	<br />
	<br />
	<t:form action="/behandlung/pwbnvergessen">
		<table width="640">
			<!-- email -->
			<tr>
				<td><label for="email"
					title="Ihre E-Mail Adresse^Bitte geben Sie die exakte E-Mail Adresse an, die Sie bei der Anmeldung benutzt hatten."
					class="vtip">E-Mail*</label></td>
			</tr>
			<tr>
				<td><input type="text" name="email" id="email" size="32"
					maxlength="128" /></td>
			</tr>
			<tr>
				<td><br />
				<br />
				<t:captcha /><br />
				</td>
			</tr>
			<tr>
				<td><t:error test="${erroremail}">E-Mail ist leer.</t:error> <t:error
					test="${erroremailunknown}">E-Mail ist unbekannt.</t:error> <t:error
					test="${error}">Es gab ein Problem bei der &Uuml;bermittlung Ihrer E-Mail. Bitte versuchen Sie es erneut.</t:error>
				<t:info test="${info}">Ihre Zugangsdaten wurden an die angegebene E-Mail Adresse versendet.</t:info>
				</td>
			</tr>
			<tr>
				<td><!-- send --> <br />
				<br />
				<t:imagebutton image="button_senden.png" /></td>
			</tr>
		</table>

	</t:form>
	<br />
	<label class="opt">*Pflichtfeld</label><br />
	<br />
	<br />
	<br />
</m:publicMasterMenu>
