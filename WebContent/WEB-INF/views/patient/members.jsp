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
<m:patientMasterMenu menuitem="3" caption="Members">
	<jsp:attribute name="header">
	<link href="<c:url value="/styles/patient.css" />" rel="stylesheet" type="text/css">
	<script src="<c:url value="<script src="<c:url value="https://code.highcharts.com/highcharts.js" />"></script>" />"></script>
	</jsp:attribute>
	<jsp:body>
		<c:if test="${!print}">
			  	  	 <label class="opt">
Klicken Sie auf den entsprechenden Benutzernamen, um Einsicht in die pers&ouml;nlichen Daten zu erhalten.</label><br />
		  		  	  <br /> 	
		<table width="280">
			<tr>
				<td width="50px" height="25" ><t:img src="redmed.png" xclass="closeButton" style="vertical-align: middle;"/></td>
				<td width="200px"><label class="opt">Verbindung ist nicht best&auml;tigt</label></td>
			</tr>
			<tr>
				<td width="50px" height="25" ><t:img src="greenmed.png" xclass="closeButton" style="vertical-align: middle;"/></td>
				<td width="200px"><label class="opt">Verbindung ist best&auml;tigt</label></td>
			</tr>
		</table>
         	  <br /> 
               	  <br /> 
		<table width="640">
		  <tr style="	background-color: #5093c1; border: 1px solid #a9aeb1; color: #FFFFFF;font-weight: bold;">
				<td width="20%" height="25" >Patienten</td>
				<td width="15%">Geschlecht</td>
				<td width="15%">Jahrgang</td>
				<td width="30%">Diagnosis</td>
				<td width="20%">Letzter Besuch</td>
			</tr>
			<c:forEach var="pat" items="${patients}">
			<tr <c:if test="${pat.selected}">style="background-color: #f0ff00"</c:if> class="${pat.state}">
				<td <c:if test="${pat.state == 'state_accepted'}">style="border: 1px solid #79b424; background-color: #9ecd63;"</c:if>
					<c:if test="${pat.state == 'state_pending'}">style="border: 1px solid #f74134; background-color: #fc7265;"</c:if> 
					>
					<c:if test="${pat.enabled}"><t:apatient href="members/${pat.id}/${pat.disease.id}">${pat.name}</t:apatient></c:if>
					<c:if test="${!pat.enabled}">${pat.name}</c:if>
				</td>
				<td style="border: 1px solid #a9aeb1;">${pat.gender}</td>
				<td style="border: 1px solid #a9aeb1;">${pat.year}</td>
				<td style="border: 1px solid #a9aeb1;">${pat.disease.name}</td>
				<td style="border: 1px solid #a9aeb1;">${pat.lastLogin}</td>
			</tr>
			</c:forEach>
		</table>
		    <br />    
		    <br />
		      <br />
		</c:if>
		<c:if test="${patient!=null}">
		<r:report prefix="patient/members" />
		</c:if>	
</jsp:body>
</m:patientMasterMenu>
