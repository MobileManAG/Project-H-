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
<m:patientMasterMenu menuitem="3" caption="Meine Verbindungen">
<label class="opt">Verbinden Sie Ihre Daten mit Ihrem Arzt und auf Wunsch mit weiteren Mitgliedern bei projecth&reg;.<br /> 
	<br /></label>
		<br />	<br />
	<strong>Ihre aktuellen Verbindungen</strong>
	<br />
	<br />
	<conn:connections isdoctor="false" dir="patient" />
	<br />	<br /><label class="opt"><strong>WICHTIG</strong><br /><br />
	In der obigen Tabelle sehen Sie alle Ihre ein- und ausgegangenen Verbindungsanfragen, die entweder <strong>Pendent</strong> oder <strong>Best&auml;tigt</strong> sind.
Erst nach best&auml;tigter Verbindung kann die andere Seite Ihre Daten einsehen. Sie können auch jederzeit die Dateneinsicht hier entziehen.
	</label><br />
</m:patientMasterMenu>
