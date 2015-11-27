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
<m:patientMasterMenu menuitem="4" caption="Eingang der Nachrichten">
<label class="opt">	 Hier k&ouml;nnen Sie Mitteilungen an Ihre Verbindungen bei projecth&reg; senden. Klicken Sie auf "Verbindungen", um Ihrer Verbindung eine Mitteilung zu versenden. 
<br />
<br />Falls Sie noch keine Verbindungen haben,
	 <t:apatient href="meineverbindungen_neue">f&uuml;gen Sie Ihrem Konto eine Verbindung hinzu </t:apatient>wie z. B. Ihren behandelnden Arzt. </label><br />
<br />
<br />
<mess:inbox prefix="patient" />
<br />
<br />
	<label class="opt"><strong>WICHTIG</strong>
<br />
<br />
Bitte beachten Sie, dass Sie für den Inhalt hier selbst verantwortlich sind. Senden Sie keine sensitiven Informationen wie Name, Adresse und/oder Telefonnummer.</label>
	<br />

</m:patientMasterMenu>
