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
<m:patientMasterMenu menuitem="2" caption="Journal von eingenommenen Medikamenten">
<label class="opt">&Auml;ndern oder bearbeiten Sie hier nachtr&auml;glich Ihre Eintragungen in Ihrem pers&ouml;nlichen Medikationstagebuch.</label>
<br />
	<br />

	<table width="640" border="1">
		<tr style="background-color: #71ab57; border: 1px solid #DDDEE1;">
			<td align="left"><font color="#FFFFFF"><strong>
			Datum </strong></font></td>
			<td align="left"><font color="#FFFFFF"><strong>
			Name des Medikamentes </strong></font></td>
			<td align="left"><font color="#FFFFFF"><strong>
			Dosis <br />
			</strong></font></td>
			<td align="left"><font color="#FFFFFF"><strong>
			Optionen </strong></font></td>
		</tr>

		<c:forEach var="med" items="${medications}">
			<tr>

				<td style="border: 1px solid #DDDEE1"><fmt:formatDate value="${med.consumptionDate}" type="date" pattern="dd-MMM-yyyy" /></td>
				<td style="border: 1px solid #DDDEE1">${med.medicationName}</td>
				<td style="border: 1px solid #DDDEE1">${med.amount}</td>
				<td style="border: 1px solid #DDDEE1"><t:apatient href="medikamente_eingeben/${med.id}">Bearbeiten</t:apatient></td>

			</tr>
		</c:forEach>
	</table>

</m:patientMasterMenu>
