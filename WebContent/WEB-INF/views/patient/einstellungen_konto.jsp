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
<m:patientMasterMenu caption="Konto sofort k&uuml;ndigen">
	<t:apatient href="einstellungen_endgueltig_loeschen"><t:img src="buttonloeschen Kopie.png" alt="" width="93" height="20" style="float: right;"/></t:apatient><label class="opt">Ich m&ouml;chte mein Konto mit Benutzernamen <strong>${patient.name}</strong> per sofort l&ouml;schen.</label>
	<br />
    <br />
	<label class="opt"><strong>WICHTIG</strong>
<br />
<br />
Bitte beachten Sie, dass Sie diesen Vorgang nicht mehr r&uuml;ckg&auml;ngig machen k&ouml;nnen.</label>
	<br />
</m:patientMasterMenu>
