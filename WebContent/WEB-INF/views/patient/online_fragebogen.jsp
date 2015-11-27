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
 <label class="opt">Ihre aktuellen Gesundheitsgruppen sind:</label><br />
	<br />
	<table width="644">
		<c:forEach var="disease" items="${diseases}">
		<tr>
			<td width="166"><t:img src="${disease.imageName}" alt="" width="141" height="200" style="border: 1px solid #cccccc;" /></td>
			<td width="466"><strong>${disease.name}</strong><br />
			<br />
			<t:apatient href="online_fragebogen_enter_data/${disease.id}"><t:img src="jetzteingeben.png" alt="" width="134" height="30" /></t:apatient><br />
			</td>
		</tr>		
		</c:forEach>
	
		<%--		<tr>
			<td width="166"><t:img src="rheumatoidearthritistagebuch.png" alt="" style="border: 1px solid #cccccc;" /></td>
			<td width="466">Beschwerden am St&uuml;tz- und Bewegungsapparat oder Polyarthritis oder Rheumatoide Arthritis<br />
			<br />
			<t:apatient href="online_fragebogen_rheumatoide_arthritis"><t:img src="jetzteingeben.png" alt="" width="134" height="30" /></t:apatient><br />
			</td>
		</tr>
		<tr>
			<td><t:img src="psoriasistagebuch.png" alt="" style="border: 1px solid #cccccc;" /></td>
			<td>Chronische Schuppenflechten oder Psoriasis<br />
			<br />
			<t:apatient href="online_fragebogen_psoriasis"><t:img src="jetzteingeben.png" alt="" width="134" height="30" /></t:apatient></td>
		</tr>
		 --%>
	</table>
	
	<br />
    <label class="opt">   Falls Sie weitere Gesundheitsgruppen erfassen m&ouml;chten, gehen Sie bitte in Ihre <t:apatient href="einstellungen_profil">Einstellungen</t:apatient> und f&uuml;gen Sie die gew&uuml;nschte Gesundheitsgruppe Ihrem Mitgliedskonto hinzu.</label>
      <br />
</m:patientMasterMenu>
