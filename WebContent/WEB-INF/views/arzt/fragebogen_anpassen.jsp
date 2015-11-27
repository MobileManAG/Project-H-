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
<m:arztMasterMenu menuitem="0" caption="Fragebogen Anpassen">
<jsp:body>
	<strong>Herzlich willkommen ${doctor.title} ${doctor.name.name} ${doctor.name.surname}!</strong><br />
	<br />
	<br />
	<table width="640">
		<tr style="	background-color: #5093c1; border: 1px solid #a9aeb1; color: #FFFFFF;font-weight: bold;">
			<td width="25%" height="25" >Patient</td>
			<td width="35%">Gesundheitsgruppe</td>
			<td width="15%">Geschlecht</td>
			<td width="25%">Jahrgang</td>
		</tr>
		<c:forEach var="pat" items="${patients}">
		<tr <c:if test="${pat.selected}">style="background-color: #f0ff00"</c:if> class="${pat.state}">
			<td style="border: 1px solid #a9aeb1;">
				<c:if test="${pat.enabled}"><t:aarzt href="fragebogen_anpassen/${pat.id}/${pat.disease.id}">${pat.name}</t:aarzt></c:if>
				<c:if test="${!pat.enabled}">${pat.name}</c:if>
			</td>
			<td style="border: 1px solid #a9aeb1;">${pat.disease.name}</td>
			<td style="border: 1px solid #a9aeb1;">${pat.gender}</td>
			<td style="border: 1px solid #a9aeb1;">${pat.year}</td>
		</tr>
		</c:forEach>
	</table>
	<br />
	<br />
	
	<c:if test="${patient!=null}">
		
			<label class="opt">Patient:</label> <h3><font color="#000000" face="Arial, Helvetica, sans-serif">${patient.name.name}</font></h3>	<br />
			<label class="opt">Gesundheitsgruppe:</label> <h3><font color="#000000" face="Arial, Helvetica, sans-serif">${disease.name}</font></h3>
		
		<br />
		<br />
			<label class="opt">F&uuml;gen Sie hier dem Fragenkatalog zus&auml;tzliche, massgeschneiderte Fragen nach Patient hinzu. </label>
		<br />
		<br />
		<q:customQuestions prefix="arzt"/>
	</c:if>	
</jsp:body>
</m:arztMasterMenu>
