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
<m:arztMasterMenu menuitem="1" caption="Verbindung hinzuf&uuml;gen">
<label class="opt">Verbinden Sie Ihr Mitgliedskonto mit Ihren Patientinnen und Patienten.</label><br />
	<c:if test="${owner.activationState == 'UNVERIFIED'}">
	<label title="Neue Verbindungen^F&uuml;gen Sie Ihrem Konto neue Verbindungen hinzu wie z. B. Ihre Patienten."class="vtip">Neue Verbindungen hinzuf&uuml;gen</label>
	<br />
    	Ihr Konto wurde noch nicht verifiziert. Wir tun dies in der Regel innerhalb eines Werktages. Bitte kontaktieren Sie unseren Support unter support@projecth.com für weitergehende Fragen in der Zwischenzeit.
    	<br />
	</c:if>
	<c:if test="${owner.activationState == 'VERIFIED'}">
	</c:if>
	<br />
	<br />
	<t:form action="/arzt/meineverbindungen">
		<c:if test="${owner.activationState == 'VERIFIED'}">
			<table width="640" style="border: 1px solid #a9aeb1;">
			<tr>
				<td valign="middle"><label
					title="Neue Kontakte hinzuf&uuml;gen^Bitte geben Sie den Benutzernamen exakt wieder und achten Sie dabei auch auf die Gross- und Kleinschreibung."
					class="vtip"><strong>Suche nach Benutzername</strong></label></td>
				<td valign="middle"><input name="login" type="text" id="login" /></td>
				<td valign="middle"><label class="opt">Exakte Eingabe erforderlich</label></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="2"><t:imagebutton image="buttonsuchen.png" /></td>
			</tr>
			</table>
		</c:if>
	</t:form>
	<br />
	<t:error test="${notfound}">Es wurde kein Benutzername gefunden. Bitte geben Sie den Benutzernamen exakt ein (Gross- und Kleinschreibung beachten) und versuchen Sie es erneut.</t:error>
	<t:error test="${userblocked}">Ihre Verbindung existiert, aber Verbindungsanfragen sind in seinen Einstellungen deaktiviert. Kontaktieren Sie Ihre Verbindung direkt über einen alternativen Kanal, um dies zu berichten und ggf. nochmals neu zu versuchen.</t:error> 
	<t:error test="${connection_exists}">Nutzer ist bereits in Ihrer Liste von Verbindungen.</t:error>
	<c:if test="${user!=null}">
	Es wurde folgender Patient gefunden:
	<table width="640" class="connectionFind">
		<tr>
			<th width="70">Type</th>
			<th width="120">Benutzername</th>
			<th width="120">Geschlecht</th>
			<th width="120">Jahrgang</th>
			<th width="160">Diseases</th>
			<th width="160">Steckbrief</th>
			<th width="160"></th>
		</tr>
	<tr>
		<td>
			<c:if test="${user.sex == null || user.sex == 1}">
				<t:img src="avatar_m.png" />
			</c:if>
			<c:if test="${user.sex == 0}">
				<t:img src="avatar_m_girl.png" />
			</c:if>
		</td>
		<td>
			<div id="infoIcon${user.id}">${user.userAccount.login} <t:img src="info-icon.png" style="vertical-align: middle;" id="infoIcon"/></div>
		</td>						
		<td>${user.gender}</td>
		<td>${user.birthday}</td>
		<td>
			<c:forEach var="disease" varStatus="status" items="${user.diseases}">${disease.name}<c:if test="${!status.last}">, </c:if>
			</c:forEach>
		</td>
		<td>${fn:substring(user.aboutMe, 0, 100)} <c:if test="${fn:length(user.aboutMe) > 100}">...</c:if></td>
		<td>
			<t:aarzt href="conn/create/${user.id}">
				<t:img src="buttonhinzufugen.png" />
			</t:aarzt>
		</td>
	</tr>
	</table>
	<br />
	
	<script>
		$(document).ready(function(){
			$("#infoIcon").mouseover(function(){
				$.blockUI({ 
					message: $("#patientInfo") 
				});
			});
			$(".closeButton").click(function(){
				$.unblockUI(); 
			});
		});
	</script>
<div id="patientInfo" style="display: none;padding: 10px;">
	<r:patientHeader readonly="true" prefix="arzt"/>
	<br />
	<div style="text-align: center;">
	<t:aarzt href="conn/create/${user.id}" ><t:img src="buttonhinzufugen.png" style="vertical-align: middle;"/></t:aarzt>
	<t:img src="button_abbrechen_grau.png" xclass="closeButton" style="vertical-align: middle;"/>
	</div>
</div>	
	
	</c:if>
	<br />
	<c:if test="${owner.activationState == 'VERIFIED'}">
		<label class="opt"><strong><br />
		WICHTIG
		</strong>
		<br />
		<br />
	    Ihre Patientinnen und Patienten müssen bei projecth&reg; registriert sein. Fragen Sie bei Ihren Patienten nach, sich bei projecth&reg; 
	    zu registrieren, damit Sie optimal den Nutzen f&uuml;r sich ziehen k&ouml;nnen. Tauschen Sie die exakten Benutzernamen aus, damit Sie hier die Verbindungsanfrage 
	    starten oder best&auml;tigen können. Die Gegenseite muss die Verbindung immer best&auml;tigen, damit Sie die Daten Ihres Patienten einsehen k&ouml;nnen.</label>
	    <br />
		<br />
	</c:if>
	
</m:arztMasterMenu>
