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
<m:patientMasterMenu caption="projecth&reg; Profil">

	<form method="post" action="einstellungen_share_your_story"
		id="share_your_story" accept-charset="UTF-8">
		<table width="640">
			<tr>
				<td height="27">
				<label class="opt">Erz&auml;hlen Sie hier mehr &uuml;ber sich, damit andere Mitglieder bei projecth&reg; etwas &uuml;ber Sie erfahren k&ouml;nnen. 	<br />
				</label><br />
				<br />
				<strong>projecth&reg; Profil</strong><br />	<br />
				</td>
			</tr>
			<tr>
				<td height="27">
					<textarea id="aboutMe" name="aboutMe" rows="1" cols="2">${patient.aboutMe}</textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" valign="middle">
				  <input type="image" src="<c:url value="/images/button_aktualisieren.png"/>" />			    </td>
		  </tr>
		</table>
		<t:info test="${about_me_saved}">Ihre &Auml;nderungen wurden erfolgreich gespeichert.</t:info>
</form>
	<br />
	<br />	
	<label class="opt"><strong>WICHTIG</strong>
<br />
<br />
Bitte beachten Sie, dass Sie für den Inhalt hier selbst verantwortlich sind. Geben Sie keine sensitiven Informationen wie Name, Adresse und/oder Telefonnummer hier an.</label>
	<br />	<br />
</m:patientMasterMenu>
