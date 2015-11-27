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
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<m:patientMasterMenu>
<div class="userCreated">
<b><label class="opt"><strong>Willkommen</strong></label> ${patient.userAccount.login}</b><br />
<br />
<label class="opt">Wir freuen uns sehr, Sie bei uns zu haben!<br /> 
<br />
Gehen Sie zuerst in Ihre <t:apatient href="einstellungen_profil"><strong>Einstellungen</strong></t:apatient> f&uuml;r allf&auml;llige Anpassungen in Ihren Einstellungen.
<br />
<br />
Ihre wiederkehrenden Schritte sind:<br />
<br />
1. F&uuml;llen Sie den <t:apatient href="online_fragebogen"><strong>Online Fragebogen</strong></t:apatient> aus.<br /> <br />
2. Geben Sie Ihre <t:apatient href="medikamente"><strong>Medikation</strong></t:apatient> ein.<br /><br />
3. Werten Sie Ihre Eingabe unter <t:apatient href="index"><strong>Pers&ouml;nlicher Bericht</strong></t:apatient> aus.<br />
<br />
Sollten Sie Probleme haben, kontaktieren Sie uns bitte &uuml;ber unser Kontaktformular oder per E-Mail. Bitte nutzen Sie keine sensitiven Daten in der Kommunikation mit uns. 
<br /><br />Wir w&uuml;nschen Ihnen alles Gute.<br /><br />Ihr projecth&reg; Team</label><br /> 
<br />
<br />
</div>
</m:patientMasterMenu>
