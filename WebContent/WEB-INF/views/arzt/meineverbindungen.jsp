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
<m:arztMasterMenu menuitem="1" caption="Meine Verbindungen">
<label class="opt">Verbinden Sie Ihr projecth&reg; Mitgliedskonto mit Ihren Patientinnen und Patienten.</label><br />
	<br />
	<label title="Aktuelle Verbindungen^In der untenstehenden Tabelle erkennen Sie alle Ihre ein- und ausgegangenen Verbindungsanfragen, die entweder als *Pendent* oder *Best&auml;tigt* erscheinen. Sie k&ouml;nnen Ihre Verbindungen jederzeit wieder ablehnen, sodass keine Verbindung mehr zwischen Ihnen und Ihrer alten Verbindung besteht."class="vtip">Ihre aktuellen Verbindungen</label>
	<br />
	<br />

	<conn:connections isdoctor="true" dir="arzt" />
	
	<br />
	<label class="opt">Personen, die hier als <strong>Best&auml;tigt</strong> erscheinen, wurde Zugriff auf deren Patientendaten erteilt. </label><br />
	<br />
	<label class="opt"><strong>
	WICHTIG</strong>
	<br />
	<br />
    Um Verbindungsanfragen zu stellen, muss Ihr Patient bei projecth&reg; Mitglied sein. Tauschen Sie den exakten Benutzernamen aus, damit Sie hier die 
    Verbindungsanfrage starten oder best&auml;tigen können. Die Gegenseite muss die Verbindung best&auml;tigen. Sobald eine Verbindung erfolgreich erstellt wurde, 
    können Sie die Daten Ihres Patienten einsehen.<br /></label>
	<br />
</m:arztMasterMenu>
