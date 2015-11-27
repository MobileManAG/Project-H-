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

<c:if test="${visitorCanSeeUserData}">
<table style="width: 620px;">
	<tr>
		<td style="text-align: left; vertical-align: top;" width="240px">
			<div id="avatar">
				<c:if test="${patient_avatar =='avatar_man'}">
					<t:img src="avatar.png"/>
				</c:if>
				<c:if test="${patient_avatar =='avatar_woman'}">
					<t:img src="avatar_girl.png"/>
				</c:if>
			</div>
			<label class="opt">Mitglied seit: ${patient_created}</label>
			<br />
			<label class="opt">Letzter Besuch: ${patient_lastlogin}</label>
			<br />
			<label class="opt">Letzte Aktualisierung: ${patient_lastupdate}</label>
			<br />
			<r:userWeightInput />
			<label class="opt" >Gewicht </label> <label class="opt" id="changeWeight"> ${user_weight}</label><r:croix url="${readonly?'':'#'}" xclass="changeWeight"/>
			<br />
		</td>
		<td style="text-align: left; vertical-align: top;">
			<div>
				<div id="rectheadcomp">
					<h3>
						<label class="black"><strong>${patien_name} ${patien_surname}</strong></label>
					</h3>
				</div>
				<div id="rectheadcomp"><r:croix url="${readonly?'':'einstellungen_profil'}" /></div>
					<br />
					<br />
					<br />
					<label class="black">${patient_gender}</label><br />
					<label class="black">${patient_age}</label><br />
					<label class="black">${patient_place}</label>
					<br />
					<br />
					<br />
					<c:if test="${doctorOfPatient != null}">
					<table>
						<tr>
							<td>
								<t:img src="doc_icon.png"/>
							</td>
							<td>
								<label class="black">${doctorOfPatient.title} ${doctorOfPatient.name.name} ${doctorOfPatient.name.surname}</label><r:croix url="${readonly?'':'meineverbindungen_neue'}"/>
							</td>
						</tr>
					</table>
					</c:if>
					<c:if test="${doctorOfPatient == null && readonly == false}">
						<t:a dir="${prefix}" href="meineverbindungen_neue">Ihren Arzt hinzufügen</t:a><r:croix url="${readonly?'':'meineverbindungen_neue'}"/>
					</c:if>
			</div>
		</td>
		<td style="text-align: right; vertical-align: top;">
			<c:if test="${!readonly}">
			<div>
				<label class="opt"><strong>Profilaktivit&auml;t</strong></label>
				<br />
				<label class="opt"><strong>${patient_logincount}</strong> Ansichten</label>
			</div>
			</c:if>
		</td>
	</tr>
</table>
<table width="620px" >
	<tr>
		<td colspan="2">
			
			<div id=rectmystory>
				<div class="reportCaption" style="width:615px;">
					<div id="rectheadcomp">
						projecth&reg; Profil
					</div>
					<div id="rectheadcomp">
						<r:croix url="${readonly?'':'einstellungen_share_your_story'}" />
					</div>
				</div>
				<div id="rectmystoryscroll">
						<label class="opt">${patient_my_story}</label>
				</div>
			</div>
		</td>
	</tr>
	<tr>
		<td style="text-align: left; vertical-align: top;">
			<div id="rect" style="margin-right: 10px;">
				<div class="reportCaptionHalf" >
					<div id="rectheadcomp">
						Gesundheitsgruppe
					</div>
					<div id="rectheadcomp">
						<r:croix url="${readonly?'':'einstellungen'}" />
					</div>
				</div>
				<div id="rectscroll">
					<table>
						<c:forEach var="dis" items="${patient_diseases}" varStatus="status">
						<tr <c:if test="${dis.selected}">style="background-color: #f0ff00"</c:if> >
							<td>
								<label  class="opt">
									<c:if test="${dis.enabled}">
										<t:a dir="${prefix}" href="${dis.patientId}/${dis.id}">${dis.name}</t:a>
									</c:if>
									<c:if test="${!dis.enabled}">${dis.name}</c:if>
								</label>
							</td>
						</tr>
						</c:forEach>
					</table>
					<br />
					<label class="opt">Beginn der Symptome: ${patient_initialsymptomdate}</label>
					<br />
					<label class="opt">Datum Diagnose: ${patient_initialdiagnosisdate}</label>
				</div>
			</div>
		</td>
		<td style="text-align: left; vertical-align: top;">
			<div id="rect">
				
				<div class="reportCaptionHalf" >
					<div id="rectheadcomp">
						Medikation
					</div>
					<div id="rectheadcomp">
						<r:croix url="${readonly?'':'medikamente_eingeben'}" />
					</div>
				</div>
				<div id="rectscroll">
					<c:forEach var="med" items="${patient_medications}" varStatus="status">
						<label class="opt">${med.name}</label>
						<br />
					</c:forEach>
				</div>
			</div>
		</td>
	</tr>
</table>
</c:if>
<c:if test="${visitorCanSeeUserData == false}">
	<table style="width: 604px;">
		<tr>
			<td style="text-align: left; vertical-align: top;">
				<div>
					<div id="rectheadcomp">
						<h3>
							<label class="black">${patien_name} ${patien_surname}</label>
						</h3>
					</div>
					<div id="rectheadcomp"><r:croix url="${readonly?'':'einstellungen'}" /></div>
						<br />
						<br />
						<br />
						<label class="black">Der Nutzer hat diese Daten nicht freigegeben.</label>
						<br />
				</div>
			</td>
		</tr>
	</table>
</c:if>


