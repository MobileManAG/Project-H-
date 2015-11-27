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
<m:patientMasterMenu menuitem="3" caption="Verbindungen">
<label class="opt">	Hier k&ouml;nnen Sie Ihrem Konto neue Verbindungen (Kontakte) hinzuf&uuml;gen. Sie k&ouml;nnen von Ihnen autorisierten Verbindungen Einsicht in Ihre Daten gew&auml;hren. Die genauen Privatsph&auml;re-Einstellungen k&ouml;nnen Sie selbst in Ihrem Konto einstellen.
 </label> <br />
	<br />
	<strong>Neue Verbindungen hinzuf&uuml;gen
</strong><br />
	<br />
	<t:form action="/patient/meineverbindungen_neue">
		<table width="640" style="border: 1px solid #a9aeb1;">
			<tr>
				<td width="262" valign="middle"><label
					title="Neue Verbindungen hinzuf&uuml;gen^Bitte geben Sie den Benutzernamen exakt wieder und achten Sie dabei auch auf die Gross- und Kleinschreibung."
					class="vtip"><strong>Suche nach Benutzername</strong></label></td>
				<td width="172" valign="middle"><input type="text" name="login"
					id="login" /></td>
				<td width="190" valign="middle"></td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td colspan="2"><t:imagebutton image="buttonsuchen.png" /></td>
			</tr>
		</table>
	</t:form>
	<br />
	<t:error test="${notfound}">Es wurde kein Benutzername gefunden. Bitte geben Sie den Benutzernamen exakt ein (Gross- und Kleinschreibung beachten) und versuchen Sie es erneut.</t:error>
	<t:error test="${userblocked}">Diese Verbindung existiert, aber Verbindungsanfragen sind in seinen Einstellungen deaktiviert. Kontaktieren Sie Ihre Verbindung direkt über einen alternativen Kanal um dies zu berichten und ggf. nochmals neu zu versuchen.</t:error>
	<t:error test="${connection_exists}">Nutzer ist bereits in Ihrer Liste von Verbindungen.</t:error>
	
	<c:if test="${user!=null || users!=null || doctors!=null}">
		
	<br />
	<br />
	<c:if test="${users != null}">
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

			<c:forEach var="user" items="${users}">
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
						<div id="infoIcon${user.id}">${user.userAccount.login}</div>
					</td>						
					<td>${user.gender}</td>
					<td>${user.birthday}</td>
					<td>
						<c:forEach var="disease" varStatus="status" items="${user.diseases}">${disease.name}<c:if test="${!status.last}">, </c:if>
						</c:forEach>
					</td>
					<td>${fn:substring(user.aboutMe, 0, 100)} <c:if test="${fn:length(user.aboutMe) > 100}">...</c:if></td>
					<td>
						<t:apatient href="conn/create/${user.id}">
							<t:img src="buttonhinzufugen.png" />
						</t:apatient>
					</td>
				</tr>
			</c:forEach>			
		</table>
	</c:if>
	<c:if test="${doctors != null}">
	<br />
	<br />
		<table width="640" class="connectionFindDoctor">
			<tr>
				<th width="60">Type</th>
				<th width="240">Name</th>
				<th width="240">Diseases</th>
				<c:if test="${doctors!=null}">
					<th width="80"></th>
				</c:if>
			</tr>			
			<c:forEach var="user" items="${doctors}">
				<tr>
					<td>
						<t:img src="doc_icon.png"/>
					</td>
					<td>${user.title} ${user.name.name} ${user.name.surname}<br/>${func:fmtMedicalInstitution(user.medicalInstitution)}</td>
					<td>
						<c:forEach var="disease" varStatus="status" items="${user.diseases}">${disease.name}<c:if test="${!status.last}">,<br/> </c:if>
						</c:forEach>
					</td>
					<td>
						<t:apatient href="conn/create/${user.id}">
							<t:img src="buttonhinzufugen.png" />
						</t:apatient>
					</td>
				</tr>
			</c:forEach>
		</table>
	</c:if>
	<script>
		$(document).ready(function(){
			$(".infoIcon").click(function(){
				var tid = $(this).attr("id");
				var userId = tid.substring(8);
				
				$.ajax({
					type : "GET",
					url : '<c:url value="/patient/user_info"/>',
					data : {
						userId : userId
					},
					success : function(msg) {
						
						if (msg == "ok") {
							
							$.blockUI({
								message: $("#userInfo") 
							});
						}
						if (msg == "error") {
							
						}
					}
				});
			});
			
			$(".closeButton").click(function(){
				$.unblockUI(); 
			});
		});
	</script>
	<div id="userInfo" style="display: none;padding: 10px;">
		<r:doctorHeader readonly="true" prefix="arzt"/>
		<br />
		<div style="text-align: center;">
		<t:apatient href="conn/create/${user.id}" ><t:img src="buttonhinzufugen.png" style="vertical-align: middle;"/></t:apatient>
		<t:img src="button_ablehnen_grau.png" xclass="closeButton" style="vertical-align: middle;"/>
		</div>
	</div>
	<br /><br />	<strong>WICHTIG</strong><br />
	<br />
    Ihre &Auml;rztin oder Arzt sowie andere Mitglieder m&uuml;ssen bei projecth&reg; registriert sein. Fragen Sie diese Personen an, sich bei projecth&reg;  zu registrieren damit Sie maximal profitieren k&ouml;nnen. Tauschen Sie die exakten Benutzernamen aus, damit Sie hier die Verbindungsanfrage starten oder best&auml;tigen können. Das andere projecth&reg; Mitglied muss die Verbindung best&auml;tigen.<br />
	<br />
	</c:if>
</m:patientMasterMenu>
