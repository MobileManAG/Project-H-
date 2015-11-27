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
<m:adminMasterMenu menuitem="0" caption="Arzt-Verifizierung">
	<div><strong>Click on Action item to Verify/Unverify or Block/Unblock Doctor.</strong></div>

	<br />

	<table width="640" border="1">
		<tr style="background-color: #5093c1; border: 1px solid #DDDEE1;">
			<td align="center" height="28"><font color="#FFFFFF"><strong> Datum </strong></font></td>
			<td align="center" height="28"><font color="#FFFFFF"><strong> Benutzername </strong></font></td>
			<td><font color="#FFFFFF"><strong> Doctor Data <br />
			</strong></font></td>
			<td align="center"><font color="#FFFFFF"><strong> State </strong></font></td>
			<td align="center"><font color="#FFFFFF"><strong> Action </strong></font></td>
		</tr>

		<c:forEach var="di" items="${doctors}">
			<tr>

				<td style="border: 1px solid #DDDEE1"><fmt:formatDate value="${di.created}" type="date" pattern="dd-MMM-yyyy" /></td>
				<td style="border: 1px solid #DDDEE1">${di.userAccount.login}</td>

				<td style="border: 1px solid #DDDEE1"><t:doctor_detail doctor="${di}"></t:doctor_detail></td>

				<c:if test="${di.activationState == 'VERIFIED'}">
					<td style="COLOR: #00ff40; FONT-WEIGHT: bold; border: 1px solid #DDDEE1">Verified</td>
				</c:if>
				<c:if test="${di.activationState == 'UNVERIFIED'}">
					<td style="FONT-WEIGHT: bold; border: 1px solid #DDDEE1">Unverified</td>
				</c:if>
				<c:if test="${di.activationState == 'BLOCKED'}">
					<td style="COLOR: #ff0000; FONT-WEIGHT: bold; border: 1px solid #DDDEE1">Blocked</td>
				</c:if>

				<c:if test="${di.activationState == 'VERIFIED'}">
					<td style="border: 1px solid #DDDEE1"><t:aadmin href="doctor-unverify/${di.id}">Unverify</t:aadmin></td>
				</c:if>
				<c:if test="${di.activationState == 'UNVERIFIED'}">
					<td style="border: 1px solid #DDDEE1"><t:aadmin href="doctor-verify/${di.id}">Verify</t:aadmin><t:aadmin
						href="doctor-block/${di.id}">Block</t:aadmin></td>
				</c:if>
				<c:if test="${di.activationState == 'BLOCKED'}">
					<td style="border: 1px solid #DDDEE1"><t:aadmin href="doctor-unblock/${di.id}">Unblock</t:aadmin></td>
				</c:if>

			</tr>
		</c:forEach>
	</table>

</m:adminMasterMenu>
