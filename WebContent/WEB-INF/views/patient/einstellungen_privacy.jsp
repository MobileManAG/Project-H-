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
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<m:patientMasterMenu caption="Privatsphäre Einstellungen">
	<label class="opt">Bitte nehmen Sie hier &Auml;nderungen in Ihren pers&ouml;nlichen Einstellungen vor.</label><br />
	<br />
	<br />
	<form method="post"
		action="<c:url value="/patient/einstellungen_privacy"/>">
	<table width="640">
	
		<tr>			
			<td width="70"></td>
			<td width="70"><label class="opt"><strong>Alle registrierten projecth&reg; Mitglieder</strong></label></td>
			<td width="70"><label class="opt"><strong>Nur meine Verbindungen</strong></label></td>
			<td width="70"><label class="opt"><strong>Niemand</strong></label></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>			
			<td width="70"><label title="Basis Informationen^Zu Ihren Basis Informationen geh&ouml;ren Jahrgang, Aktivit&auml;t, Datum der Symptome und weitere Einmalangaben"class="vtip">Stammdaten</label></td>
			<td width="70"><input type="radio"
				id="BASE_DATA_ALL" name="stammdaten" value="BASE_DATA_ALL"
				<c:if test="${BASE_DATA_ALL == 'BASE_DATA_ALL'}">checked="yes"</c:if> /></td>
			<td width="70"><input type="radio"
				id="BASE_DATA_CONNECTIONS" name="stammdaten" value="BASE_DATA_CONNECTIONS"
				<c:if test="${BASE_DATA_CONNECTIONS == 'BASE_DATA_CONNECTIONS'}">checked="yes"</c:if> /></td>
			<td width="70"><input type="radio"
				id="BASE_DATA_NONE" name="stammdaten" value="BASE_DATA_NONE"
				<c:if test="${BASE_DATA_NONE == 'BASE_DATA_NONE'}">checked="yes"</c:if> /></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>			
			<td width="70"><label title="Fragebogen Daten^Sie k&ouml;nnen selbst bestimmen, mit wem Sie die Daten aus den wiederkehrenden Fragenkatalogen teilen m&ouml;chten."class="vtip">Fragebogen Daten</label></td>
			<td width="70"><input type="radio"
				id="DISEASE_DATA_ALL" name="fragebogen_daten" value="DISEASE_DATA_ALL"
				<c:if test="${DISEASE_DATA_ALL == 'DISEASE_DATA_ALL'}">checked="yes"</c:if> /></td>
			<td width="70"><input type="radio"
				id="DISEASE_DATA_CONNECTIONS" name="fragebogen_daten" value="DISEASE_DATA_CONNECTIONS"
				<c:if test="${DISEASE_DATA_CONNECTIONS == 'DISEASE_DATA_CONNECTIONS'}">checked="yes"</c:if> /></td>
			<td width="70"><input type="radio"
				id="DISEASE_DATA_NONE" name="fragebogen_daten" value="DISEASE_DATA_NONE"
				<c:if test="${DISEASE_DATA_NONE == 'DISEASE_DATA_NONE'}">checked="yes"</c:if> /></td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td><label title="Alle Verbindungsanfragen^Wenn Sie dieses K&auml;stchen aktivieren, k&ouml;nnen keine projecth&reg; Mitglieder mit Ihnen in Verbindung treten."class="vtip">Verbindungsanfragen</label></td>
	    	<td colspan="2"><t:checkbox id="requestblocked" checked="${requestblocked}" label="Keine weiteren Verbindungsanfragen erlauben"/> </td>
		</tr>
		<tr>
			<td>&nbsp;</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		<tr>
			<td valign="middle">&nbsp;</td>
			<td colspan="2" align="left" valign="middle"><input type="image"
				src="<c:url value="/images/button_speichern.png"/>" /></td>
		</tr>
		<tr>
		  <td height="56" valign="middle">&nbsp;</td>
		  <td colspan="2" align="left" valign="middle">	<t:info test="${privacy_saved}">Ihre Privatsphären-Einstellungen wurden erfolgreich ge&auml;ndert.</t:info></td>
	  </tr>
	</table>
  <br />

	</form>
</m:patientMasterMenu>
