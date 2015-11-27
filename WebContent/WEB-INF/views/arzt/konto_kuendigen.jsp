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
<m:arztMasterMenu menuitem="3" caption="Konto k&uuml;ndigen">
	<table width="640">
		<tr>
			<td width="144" valign="middle"><label class="opt"><strong>Konto aufk&uuml;ndigen</strong></label></td>
			<td width="386" align="left" valign="middle"><label class="opt">Ich m&ouml;chte mein Konto mit Benutzernamen <strong><br />
			${doctor.name}</strong> per sofort und unwiderruflich l&ouml;schen.</label></td>
			<td width="94" align="left" valign="middle"><t:aarzt href="konto_endgueltig_loeschen"><t:img src="buttonloeschen Kopie.png" alt="" width="94" height="21" /></t:aarzt></td>
		</tr>
	</table>
	<br />
    <br />
 <label class="opt"> <strong>WICHTIG</strong><br />
	<br />
Sind Sie sicher, dass Sie Ihr Konto per sofort und unwiderruflich l&ouml;schen m&ouml;chten? Dieser Vorgang kann nicht mehr r&uuml;ckg&auml;ngig gemacht werden. Ihre Daten gehen verloren.<br />
	<br /></label>
</m:arztMasterMenu>
