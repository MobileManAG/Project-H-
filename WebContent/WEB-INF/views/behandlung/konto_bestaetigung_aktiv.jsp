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
<m:publicMasterMenu title="Kontoaktivierung projecth"
	caption="Ihr Konto ist aktiv">
Wir freuen uns, Sie bei uns zu haben!
  <br />
	<br />
	<br />
	<br />
	<br />
	<table width="300" align="right" bgcolor="#e8eefa"
		style="border: 1px solid #DDDEE1;">
	</table>
	<br />
	<table width="640">
		<tr>
			<td width="44%" valign="top"><t:img
				src="kontobenutzung_titel.png" alt="" width="247" height="57" /><br />
			</td>
			<td width="56%">
			<table width="300" align="left" bgcolor="#e8eefa"
				style="border: 1px solid #DDDEE1;">
				<tr>
					<td height="31" colspan="3"><font color="#000000"
						face="Arial, Helvetica, sans-serif"><strong>Bitte
					melden Sie sich an:</strong></font></td>
				</tr>
				<tr>
					<td>Benutzernamen</td>
					<td colspan="2" align="left" valign="top"><input name="dfas"
						type="password" id="dfas" /></td>
				</tr>
				<tr>
					<td>Passwort</td>
					<td colspan="2" align="left" valign="top"><input name="dfas"
						type="password" id="dfas2" /></td>
				</tr>
				<tr>
					<td height="46" valign="middle"><input type="checkbox"
						name="checkbox" id="checkbox" /> <label for="checkbox"><font
						size="1">Angemeldet bleiben</font></label></td>
					<td colspan="2" align="left" valign="middle"><t:apublic
						href="chronische_beschwerden/sicherer_zugang/patient/index">
						<t:img src="button_anmelden.png" alt="" width="134" height="30" />
					</t:apublic><br />
					</td>
				</tr>
				<tr>
					<td valign="top">&nbsp;</td>
					<td align="left" valign="top"><t:img src="sicon.png" alt=""
						width="18" height="18" /></td>
					<td align="left" valign="top"><font size="1">Sichere
					Anmeldung mit <br />
					SSL</font></td>
				</tr>
				<tr>
					<td height="37" colspan="3" align="center"><t:apublic
						href="chronische_beschwerden/pwbnvergessen">
						<br />
					Zugangsdaten vergessen?</t:apublic></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	<t:img src="front.jpg" alt="" width="660" height="282" />
	<br />
	<br />
	<br />
  F&uuml;r Fragen und weitere Ausk&uuml;nfte stehen wir Ihnen gerne zur Verf&uuml;gung. <t:apublic
		href="kontakt">Kontaktieren Sie uns hier.</t:apublic>
	<br />
	<br />
	Ihr projecth-Team <br />
	<br />
</m:publicMasterMenu>
