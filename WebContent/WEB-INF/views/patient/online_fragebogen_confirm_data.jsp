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
<m:patientMasterMenu menuitem="1" caption="Online Fragebogen">
	<jsp:attribute name="header">
		<link href="<c:url value="/styles/diseases.css" />" rel="stylesheet" type="text/css">
	</jsp:attribute>
	<jsp:body>
	<d:disease back="online_fragebogen_enter_data" action="online_fragebogen_confirm_data" submitbutton="buttonbestaetigen.png" readonly="true">
		<br />
		<br />
    Gesundheitsgruppe: Beschwerden am St&uuml;tz- und Bewegungsapparat oder Rheumatoide Arthritis<br />
		<br />
		<table width="640" border="0">
			<tr>
				<td height="50" colspan="3">
				<input type="image" src="<c:url value="/images/buttonbestaetigen.png"/>" />
				</td>
				<td width="491">Ihre Eingabe muss noch best&auml;tigt werden!</td>
			</tr>
			<tr>
				<td height="50" colspan="3"><t:apatient href="online_fragebogen_enter_data">
					<t:img src="buttonzuruck.png" alt="" width="134" height="30" />
				</t:apatient></td>
				<td>Zur&uuml;ck um &Auml;nderungen vorzunehmen.</td>
			</tr>
		</table>
		<br />
		<strong>VORSCHAU</strong>
	</d:disease>
	</jsp:body>
</m:patientMasterMenu>
