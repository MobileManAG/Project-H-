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
<m:arztMasterMenu print="${print}" menuitem="0" caption="Auswertungen nach Patient">
<jsp:attribute name="header">
	<link href="<c:url value="/styles/patient.css" />" rel="stylesheet" type="text/css">
	<script src="<c:url value="/scripts/highcharts.js" />"></script>
</jsp:attribute>
<jsp:body>
	<c:if test="${!print}">
	<h3>
		<font color="black" face="Arial, Helvetica, sans-serif">Herzlich willkommen ${doctor.title} ${doctor.name.name} ${doctor.name.surname}!</font>
	</h3>
	<br />
	<label>Auswertung</label>
	<br />
	<label class="opt">Klicken Sie auf entsprechenden Patienten, um die pers&ouml;nlichen Daten auszuwerten.</label>
	<br />	<br />
	<label>Dateineingabe</label>
	<br />
	<label class="opt">Klicken Sie auf den entsprechenden Patienten, um pers&ouml;nliche Schl&uuml;sselparameter einzugeben.</label>
	<br />	
	<br />
	<br />
	<div class="reportCaption" >
		Patienten
	</div>
	<br />
	<table width="640">
		<tr style="border-bottom: 1px solid #e9e9e9;">
			<td><label>Name</label></td>
			<td><label>Geschlecht</label></td>
			<td><label>Jahrgang</label></td>
			<td><label>Diagnosis</label></td>
			<td><label>Letzter Besuch</label></td>
			<td><label>Verbindung</label></td>
		</tr>
		<c:forEach var="pat" items="${patients}">
		<tr <c:if test="${pat.selected}">style="background-color: #f0ff00"</c:if>>
			
			<td style="border-bottom: 1px solid #e9e9e9;">
				<c:if test="${pat.enabled}">
					<label><t:aarzt href="${pat.id}/${pat.disease.id}">${pat.name}</t:aarzt></label>
				</c:if>
				<c:if test="${!pat.enabled}">
					<label class="opt">${pat.name}</label>
				</c:if>
			</td>		
			<td style="border-bottom: 1px solid #e9e9e9;"><label class="opt">${pat.gender}</label></td>
			<td style="border-bottom: 1px solid #e9e9e9;"><label class="opt">${pat.year}</label></td>
			<td style="border-bottom: 1px solid #e9e9e9;"><label class="opt">${pat.disease.name}</label></td>
			<td style="border-bottom: 1px solid #e9e9e9;"><label class="opt">${pat.lastLogin}</label></td>
			<!-- 
			<td
				<c:if test="${pat.state == 'state_accepted'}"> style="border-bottom: 1px solid #79b424; background-color: #9ecd63;"</c:if>
				<c:if test="${pat.state == 'state_pending'}"> style="border-bottom: 1px solid #f74134; background-color: #fc7265;"</c:if> 
			>
			 -->
			 <td style="border-bottom: 1px solid #e9e9e9;">
				<c:if test="${pat.state == 'state_accepted'}"><label class="opt">Best&auml;tigt</label></c:if>
				<c:if test="${pat.state == 'state_pending'}"><label class="opt">Pendent</label></c:if> 
			</td>
		</tr>
		</c:forEach>
	</table>
	<br />	
	</c:if>
	<c:if test="${patient!=null}">
	<br />
		<div class="reportCaption" >Ausgew&auml;hlter Patient</div>
		<br />
		<r:report prefix="arzt" />
	</c:if>	
</jsp:body>	
</m:arztMasterMenu>
