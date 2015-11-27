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
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc"%>
<m:publicMasterMenu title="Gesundheitsgruppe bei projecth&reg; anmelden" caption="Neue Gesundheitsgruppe anmelden" menuitem="-1">
	<form method="post"
		action="<c:url value="/behandlung/gesundheitsgruppen_anmelden"/>"
		class="niceform">Melden Sie uns Ihre Gesundheitsgruppe an,
	damit wir eine neue Kategorie im projecth&reg; System er&ouml;ffnen k&ouml;nnen.
	Dabei spielt es keine Rolle, wie unpopul&auml;r oder popul&auml;r diese
	Gruppe ist. Wir sind stets bem&uuml;ht, das projecth System auszubauen
	und mit Ihrer Hilfe die Gesundheitsgruppen zu erweiteren.<br />
	<br />
	<table width="640">
		<tr>
			<td colspan="2"><label>Welche <strong>neue
			Gesundheitsgruppe</strong> m&ouml;chten Sie anmelden?*</label></td>
		</tr>
		<tr>
			<td colspan="2"><label for="name"></label> <input type="text"
				name="name" id="name" style="width: 300px" value="${postValues.name}"/></td>

		</tr>
		<tr>
			<td colspan="2"><t:error test="${errorname}"><label title="Gesundheitsgruppe^W&uuml;nschen Sie, dass wir das projecth System ausbauen sollen? Helfen Sie uns, damit wir wissen, mit welchen Gesundheitsgruppen (z. B. Diabetes) wir das projecth System erweiteren sollen."
					class="vtip">Bitte geben Sie eine Gesundheitsgruppe an.</label></t:error>
			</td>
		</tr>
		<tr>
			<td colspan="2"><br />
			<label>Geben Sie Ihre E-Mail Adresse an, damit wir Sie
			benachrichtigen k&ouml;nnen, wenn wir die Gesundheitsgruppe lancieren
			oder R&uuml;ckfragen haben.</label></td>
		</tr>
		<tr>
			<td colspan="2"><input type="text" name="email" id="email"
				style="width: 300px" value="${postValues.email}"/></td>
		</tr>
		<tr>
			<td colspan="2"><br />
			<label for="radio">Ich bin...*</label></td>
		</tr>
		<tr>
			<td width="22"><input type="radio" name="usertype" id="usertypepatient"
				value="P" <c:if test="${postValues.usertype=='P'}">checked</c:if> /></td>
			<td><label for="usertypepatient"><t:apublic
				href="chronisch_betroffene">Patient</t:apublic> dieser
			Gesundheitsgruppe.</label></td>
		</tr>
		<tr>
			<td width="22"><input type="radio" name="usertype" id="usertypearzt"
				value="D" <c:if test="${postValues.usertype=='D'}">checked</c:if> /></td>
			<td><label for="usertypearzt"><t:apublic href="aerzte">approbierte &Auml;rztin oder approbierter Arzt,</t:apublic>
			der diese Gesundheitsgruppe behandelt.</label></td>
		</tr>
		<tr>
			<td colspan="2"><br />
			<t:captcha /></td>
		</tr>
		<tr>
			<td colspan="2"><br />
			<t:imagebutton image="button_anmelden.png" /></td>
		</tr>
		<tr>
			<td colspan="2"><br />
			<label class="opt">*Pflichtfelder</label></td>
		</tr>
	</table>

	<t:error test="${errorsend!=null}">Fehler bei der Sendung Ihrer E-Mail. Bitte versuchen Sie es erneut. ${errorsend}</t:error>
	<t:info test="${infosend}">Ihre Anfrage &uuml;ber die Aufnahme einer Gesundheitsgruppe wurde erfolgreich versendet. Wir melden uns umgehend bei Ihnen, wenn Ihre angeforderte Gesundheitsgruppe zur Verf&uuml;gung steht.</t:info>
	<br />
	<strong> <u><br />
	</u>WICHTIG</strong><br /><br />
	Wir respektieren Ihre Privatsph&auml;re. Die Informationen die Sie uns
	hier &uuml;bermitteln, werden nur zur Beantwortung Ihres Anliegens
	verwendet, namentlich zur Beantwortung Ihrer Anfrage und zur
	Notifikation bei Lancierung einer neuen Gesundheitsgruppe. Wir benutzen
	diese Informationen nur zu diesem obbenannten Zweck. Sie erhalten keine
	Werbung oder weitere Korrespondenz auf Basis dieser Kommunikation. <br />
	<br />
	<br />
	</form>
</m:publicMasterMenu>
