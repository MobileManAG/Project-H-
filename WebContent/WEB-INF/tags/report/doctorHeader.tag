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
<%@ tag description="A tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="readonly" required="true" rtexprvalue="true" %>
<%@ attribute name="prefix" required="true" rtexprvalue="true" %>

<c:choose>
	<c:when test="${visitorCanSeeUserData==true}">
	<table style="width: 604px;">
		<tr>
			<td style="text-align: left; vertical-align: top;" width="240px">
				<div id="${user_avatar}"></div>
				<label class="opt">Mitglied seit: <fmt:formatDate value="${user.created}" type="date" pattern="dd-MMM-yyyy"/></label>
				<br />
				<label class="opt">Letzter Besuch: <fmt:formatDate value="${user.lastLogin}" type="date" pattern="dd-MMM-yyyy"/></label>
				<br />
				<label class="opt">Letzte Aktualisierung: <fmt:formatDate value="${user.lastUpdate}" type="date" pattern="dd-MMM-yyyy"/></label>
				<br />
				<label class="opt">&Uuml;ber mich: ${user.aboutMe}<r:croix url="${readonly?'':'einstellungen_share_your_story'}" /></label>
			</td>
			<td style="text-align: left; vertical-align: top;">
				<div>
					<label class="black">${user.medicalInstitution.name}</label>
					<br />
					<div id="rectheadcomp">
						<h3>
							<label class="black">${user.title} ${user.name.name} ${user.name.surname}</label>
						</h3>
						<label class="black">${medicalInstitution}</label>
						<br />
						<label class="black">Telefon: ${medicalInstitutionPhoneNmr}</label>
						<br />
						<label class="black">Fax: ${medicalInstitutionFaxNmr}</label>
						<br />
						<label class="black">Internet: ${user.medicalInstitution.homePageUrl}</label>
						<br />
					</div>				
					<br />				
					<div id="rectheadcomp"><r:croix url="${readonly?'':'einstellungen'}" /></div>
						<br />
						<br />
						<br />					
						<label class="black">Geschlecht: ${user_gender}</label><br />
						<label class="black">Alter: ${user_age} Jahre</label><br />
						<label class="black">Land: ${user.country.name}</label>
				</div>
			</td>
			<td style="text-align: right; vertical-align: top;">
				<c:if test="${!readonly}">
				<div>
					<label class="opt"><strong>Profilaktivit&auml;t</strong></label>
					<br />
					<label class="opt"><strong>${user.loginsCount}</strong>Ansichten</label>
				</div>
				</c:if>
			</td>
		</tr>
	</table>
	</c:when>
	<c:otherwise>
		<table style="width: 604px;">
			<tr>
				<td style="text-align: left; vertical-align: top;">
					<div>
						<div id="rectheadcomp">
							<h3>
								<label class="black">${user.name.name} ${user.name.surname}</label>
							</h3>
						</div>
							<br />
							<br />
							<label class="black">Das projecth&reg; Mitglied hat Sie nicht autorisiert, seine Daten anzuzeigen</label>
							<br />
					</div>
				</td>
			</tr>
		</table>
	</c:otherwise>
</c:choose>

