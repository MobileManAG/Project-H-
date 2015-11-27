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
<m:arztMasterMenu menuitem="3" caption="Konto endg&uuml;ltig löschen">
	<t:aarzt href="einstellungen"><u>zur&uuml;ck</u></t:aarzt>
	<br />
	<br />
	<br />
	<table width="640">
		<tr>
			<td width="147"><strong>Benutzername</strong></td>
			<td width="481"><strong>${doctor.userAccount.login}</strong></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td>&nbsp;</td>
		</tr>
		<tr>
			<td valign="middle"><strong>Konto aufk&uuml;ndigen</strong></td>
			<td align="left" valign="middle">Ich m&ouml;chte mein Konto mit Benutzernamen <strong>${doctor.userAccount.login}</strong> per sofort und unwiderruflich l&ouml;schen.</td>
		</tr>
		<tr>
			<td height="75" valign="middle">&nbsp;</td>
			<td align="left" valign="middle"><t:aarzt href="index"><t:img src="button_abbrechen_grau.png" alt="" width="134" height="30" /></t:aarzt></td>
		</tr>
		<tr>
			<td height="121" valign="middle">&nbsp;</td>
			<td align="left" valign="middle"><t:aarzt href="konto_endgueltig_loeschen/confirm"><t:img src="button_unwiderruflichloeschen.png" alt="" width="227" height="30" /></t:aarzt></td>
		</tr>
	</table>
	<br />
<label class="opt">  <strong>WICHTIG</strong><br />
	<br />
Sind Sie sicher, dass Sie Ihr Konto per sofort und unwiderruflich l&ouml;schen m&ouml;chten? Dieser Vorgang kann nicht mehr r&uuml;ckg&auml;ngig gemacht werden. Ihre Daten gehen sofort verloren. Der Benutzernamen wird endg&uuml;ltig aus der Datenbank gel&ouml;scht.<br />
	<br /></label>
</m:arztMasterMenu>
