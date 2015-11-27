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
<m:arztMasterMenu menuitem="3" caption="Kontakteinstellungen">
      <label class="opt">Hier k&ouml;nnen Sie Ihre pers&ouml;nlichen Einstellungen vornehmen.</label><br />
	<br />
	<form method="post" action="<c:url value="/arzt/settings_password"/>">
	<table width="640">
		<tr>
			<td><label title="Verbindungsanfragen^Hier k&ouml;nnen Sie alle Verbindungsanfragen blockieren."class="vtip">Verbindungsanfragen</label></td>
	    	<td colspan="2"><input type="checkbox" name="requestblocked" id="requestblocked"  <c:if test="${requestblocked}">checked</c:if> /> <label for="">Keine weiteren Verbindungsanfragen erm&ouml;glichen</label></td>
		</tr>
		<tr>
			<td><label title="Automatische Anmeldung^Wenn Sie diese K&auml;stchen aktivieren, k&ouml;nnen Sie sich automatisch bei projecth&reg; ohne Angabe von Zugangsdaten anmelden. Sie m&uuml;ssen hierzu Cookies in Ihrem Browser aktivieren."class="vtip">Automatische Anmeldung</label></td>
			<td><input type="checkbox" name="staylogged" id="staylogged" <c:if test="${autologinenabled}">checked</c:if> /> <label for="staylogged">Ja</label></td>
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
	<br />
</m:arztMasterMenu>
