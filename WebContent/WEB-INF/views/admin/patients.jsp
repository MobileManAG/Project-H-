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
<m:adminMasterMenu menuitem="1" caption="Patients">
	<div><strong>Patients.</strong></div>

	<br />

	<table width="640" border="1">
		<tr style="background-color: #5093c1; border: 1px solid #DDDEE1;">
			<td align="center" height="28"><font color="#FFFFFF"><strong> Datum </strong></font></td>
			<td align="center" height="28"><font color="#FFFFFF"><strong> Benutzername </strong></font></td>
			<td><font color="#FFFFFF"><strong> Data </strong></font></td>
		</tr>

		<c:forEach var="patient" items="${patients}">
			<tr>
				<td style="border: 1px solid #DDDEE1"><fmt:formatDate value="${patient.created}" type="date" pattern="dd-MMM-yyyy" /></td>
				<td style="border: 1px solid #DDDEE1">${patient.userAccount.login}</td>
				<td style="border: 1px solid #DDDEE1"><t:patient_detail patient="${patient}"></t:patient_detail></td>
			</tr>
		</c:forEach>
	</table>

</m:adminMasterMenu>
