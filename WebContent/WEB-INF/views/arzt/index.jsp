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
<m:arztMasterMenu print="${print}" menuitem="0" caption="&Uuml;bersicht">
	<jsp:attribute name="header">
	<link href="<c:url value="/styles/patient.css" />" rel="stylesheet" type="text/css">
</jsp:attribute>
	<jsp:body>
	<h3>
		<font color="black" face="Arial, Helvetica, sans-serif">Herzlich willkommen ${doctor.title} ${doctor.name.name} ${doctor.name.surname}!</font>
	</h3>
	<br />
	<c:choose>
		<c:when test="${hasData}">
			<form method="POST" action="<c:url value="/artz/index/changedate" />" name="changeDate">
				
				<div id="kpiTimeLineChart" style="width: 640px; height: 300px"></div>
				<br />
				<div class="reportCaption">Bitte w&auml;hlen Sie den gew&uuml;nschten Zeitraum aus.</div>
				<br />
				<table style="width: 620px;">
					<tr>
						<td>
							<br />
						</td>
						<td style="align: center; width: 320px">
							<label class="opt"><strong>Von</strong></label>
						</td>
						<td style="align: right; width: 300px">
							<label class="opt"><strong>Bis</strong></label>
						</td>
					</tr>
					<tr>
						<td>
							<br />
						</td>
						<td style="align: center; width: 302px">
							<input style="width: 120px; float:left; padding-left:5px;" name="date_from" type="text" id="date_from"><label class="opt">  TT/MM/JJJJ</label>
						</td>
						<td style="align: right; width: 302px">
							<input style="width: 120px;float:left; padding-left:5px;" name="date_to" type="text" id="date_to"><label class="opt"> TT/MM/JJJJ</label>
						</td>
					</tr>
					<tr>
						<td>
							<br />
						</td>
						<td>
							<br />
						</td>
						<td>
							<br />
						</td>
					</tr>
					<tr>
						<td><br /></td>
						<td colspan="2"><t:daterange prefix="artz/index" all="true"/></td>
					</tr>
				</table>
				<input type="hidden" id="d_from" name="d_from" value="${date_from}" /> 
				<input type="hidden" id="d_to" name="d_to" value="${date_to}" />
			</form>
			<br />
			<div class="reportCaption">&Uuml;bersicht</div>
			<table width="${110 + 150 * fn:length(patientsCountByDiseases)}px">
				<tr>
					<td width="110px" height="65"></td>
					
					<c:forEach var="pc" items="${patientsCountByDiseases}"
							varStatus="loop">
					<td width="150px" align="center" ><strong>${pc.disease.name}</strong></td>
					</c:forEach>
					
				</tr>
				
				<tr>
					<td width="110px" height="91"><label title="Gesamtanzahl Ihrer Patienten^Hier sehen Sie die Gesamtanzahl Ihrer Patienten nach Gesundheitsgruppe."class="vtip"><strong>Anzahl von Patienten: </strong></label></td>
					
					<c:forEach var="pc" items="${patientsCountByDiseases}"
							varStatus="loop">
					<td width="15%" align="center" height="91" style="horizontal-align: middle;">${pc.count}</td>
					</c:forEach>
					
				</tr>
				
				<tr>
					<td width="110px" height="129"><label title="Verteilung nach Alter^Hier sehen Sie die Altersverteilung Ihrer Patienten."class="vtip"><strong>Alter:</strong></label></td>
					<c:forEach var="item" items="${patientsCountByAgeByDisease}" varStatus="loop">
					  	<td width="150px" align="center" style="horizontal-align: middle;">
					  		<div style="width: 180px; height: 260px" id="ageContainer${item.disease.id}"></div>
						</td>
					</c:forEach>
				</tr>
				
				<tr>
					<td width="110px" height="127"><label title="Aufteilung Ihrer Patienten nach Geschlecht^Hier sehen Sie die Aufteilung Ihrer Patienten nach Geschlecht."class="vtip"><strong>Geschlecht:</strong></label></td>
					
					<c:forEach var="item" items="${patientsCountByGenderByDiseases}" varStatus="loop">
					  	<td width="150px" align="center" height="150px" style="horizontal-align: middle;">
					  		<div style="height: 150px" id="genderContainer${item.disease.id}"></div>
						</td>
					</c:forEach>
				</tr>
				
				<tr>
					<td width="110px" height="128"><label title="Gesamtdurchschnitt Scores aller Patienten^Hier sehen Sie den Gesamtdurchschnitt der Scores Ihrer Patienten."class="vtip"><strong>&#x00D8;-Scores:</strong></label></td>
					
					<c:forEach var="allScores" items="${patientsKpiAverageScoreByDisease}" varStatus="loop">
				  <td width="150px" align="center" height="128" style="horizontal-align: middle;">
						<table width="120">
							<c:forEach var="subitem" items="${allScores.scores}" varStatus="loop">
								<tr>
									<td width="60px" align="right">
										<i>${subitem.kpiType.type}</i>: 
									</td>
									<td width="80px" align="right">
										<strong><fmt:formatNumber value="${subitem.score}" type="number" pattern="###.##"/></strong>
									</td>						 
								</tr>
							</c:forEach>
						</table>
					</td>
					</c:forEach>
					
				</tr>
			</table>
		</c:when>
		<c:otherwise>
			<br/>
			<t:a dir="arzt" href="meineverbindungen_neue">Ihren Patienten hinzufügen</t:a><r:croix url="${readonly?'':'meineverbindungen_neue'}"/>
		</c:otherwise>
	</c:choose>	 
	</jsp:body>
</m:arztMasterMenu>
