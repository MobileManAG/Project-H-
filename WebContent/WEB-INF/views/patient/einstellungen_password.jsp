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
<m:patientMasterMenu caption="Passwort">
      <label class="opt">Bitte nehmen Sie hier &Auml;nderungen in Ihren pers&ouml;nlichen Einstellungen vor.</label><br />
	<br />
	<br />
	<form method="post" action="<c:url value="/patient/einstellungen_password"/>">
	<table width="640">
		<tr>
			<td width="325"><label title="Neues Passwort^Bitte geben Sie hier ein neues Passwort nach Ihrer Wahl ein. Das Passwort darf Klein- und Grossbuchstaben sowie Zahlen und Zeichen beinhalten. Das Passwort muss mindestens 5 Zeichen enhalten und darf 12 Zeichen nicht überschreiten."class="vtip">Neues Passwort </label></td>
			<td width="303" colspan="2"><input type="password" id="password" name="password" maxlength="12"/></td>
		</tr>
		<tr>
			<td><label title="Passwort nochmals eingeben^Bitte geben Sie zur Sicherheit das Passwort zweimal exakt wieder."class="vtip">Neues Passwort nochmals eingeben</label></td>
			<td colspan="2"><input  type="password" id="password2" name="password2" maxlength="12"/></td>
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
	</table>
	<t:error test="${passwordnotsame}">Passw&ouml;rter sind nicht identisch.</t:error>
	<t:error test="${passworderror}">Fehler bei der &Auml;nderung Ihres Passwortes.</t:error>
	<t:error test="${errorpassword_too_short}" usespan="true">Fehler - Passwort Mindestlänge beträgt ${min_password_length} Zeichen.</t:error>
	<t:error test="${errorpassword_too_long}" usespan="true">Fehler - Die maximale Passwortlänge ${max_password_length} Zeichen.</t:error>
	<t:info test="${passwordchanged}">Passwort wurde erfolgreich ge&auml;ndert.</t:info>
	</form>
</m:patientMasterMenu>
