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
<m:publicMasterMenu title="Passwort neu setzen"
	caption="Passwort neu setzen">
	<label class="opt">Bitte geben Sie Ihr neues Passwort ein.</label><br />
	<br />
	<t:form action="/behandlung/pwbnvergessen2">
		<t:error test="${error}">Fehler - Es gab ein Problem bei Ihrer Eingabe. Bitte versuchen Sie es erneut.</t:error>
		<t:error test="${errorsame}">Fehler - Ihr neues Passwort stimmt nicht &uuml;berein. Bitte geben Sie Ihr Passwort identisch zweimal wieder.</t:error>
		<t:info test="${info}">OK - Passwort wurde erfolgreich ge&auml;ndert</t:info>
		<t:error test="${errorpassword_too_short}" usespan="true">Fehler - Passwort Mindestl&auml;nge beträgt ${min_password_length} Zeichen.</t:error>
		<t:error test="${errorpassword_too_long}" usespan="true">Fehler - Die maximale Passwortl&auml;nge ${max_password_length} Zeichen.</t:error>
				

		<input type="hidden" name="code" value="${code}" />
		<table width="640">
			<tr>
				<td width="200"><label
					title="Passwort^Bitte geben Sie ein neues Passwort nach Ihrer Wahl ein und bewahren Sie es an einem sicheren Ort auf Ein Passwort besteht aus Buchstaben (a, A, b, B, ... - Z) und/oder Zahlen (0, 1, 2, ... - 9). Sonderzeichen wie &/(%_-ç-+ usw. sind nicht erlaubt."
					class="vtip"><strong>Passwort*</strong></label></td>
				<td colspan="2"><input style="width: 204px" type="password"
					id="password" name="password" maxlength="12"/></td>
					
			</tr>
			<tr>
				<td><label title="Passwort erneut eingeben^Bitte geben Sie Ihr neues Passwort erneut ein." class="vtip">Passwort nochmals eingeben*</label></td>
				<td colspan="2"><input style="width: 204px" type="password"
					id="password2" name="password2" maxlength="12"/></td>
			</tr>
		</table>
		<br />
	<br /><br />
		<t:imagebutton image="button_speichern.png" /><br /><br /><br />
<label class="opt">	*Pflichtfelder</label>
	</t:form>
</m:publicMasterMenu>
