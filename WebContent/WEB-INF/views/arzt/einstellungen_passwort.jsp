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
<m:arztMasterMenu menuitem="3" caption="Passwort">
      <label class="opt">Hier k&ouml;nnen Sie Ihre pers&ouml;nlichen Einstellungen vornehmen.</label><br />
	<form method="post" action="<c:url value="/arzt/settings_password"/>">
	<table width="640">
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td width="275"><label title="Neues Passwort setzen^Setzen Sie hier ein neues Passwort aus mindestens 5 Zeichen."class="vtip">Neues Passwort</label></td>
			<td><label for="textfield"></label> <input type="password" id="password" name="password" maxlength="12"/></td>
		</tr>
		<tr>
			<td><label title="Passwort wiederholen^Bitte wiederholen Sie exakt das eingegebene Passwort."class="vtip">Passwort nochmals eingeben</label></td>
			<td><input type="password" id="password2" name="password2" maxlength="12"/></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td valign="middle">&nbsp;</td>
			<td align="left" valign="middle">
			 <input type="image" src="<c:url value="/images/button_speichern.png"/>" />
			</td>
		</tr>
	</table>
	</form>
	<t:error test="${passwordnotsame}">Passw&ouml;rter stimmen nicht &uuml;berein.</t:error>
	<t:error test="${passworderror}">Fehler bei der &Auml;nderung des Passwortes.</t:error>
	<t:error test="${errorpassword_too_short}" usespan="true">Fehler - Passwort Mindestlänge beträgt ${min_password_length} Zeichen.</t:error>
	<t:error test="${errorpassword_too_long}" usespan="true">Fehler - Die maximale Passwortlänge ${max_password_length} Zeichen.</t:error>
	<t:info test="${passwordchanged}">Passwort wurde erfolgreich ge&auml;ndert.</t:info>
	<br />
</m:arztMasterMenu>
