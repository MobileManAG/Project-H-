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

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="t" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="m" tagdir="/WEB-INF/tags/menu"%>

<m:publicMasterMenu title="projecth&reg; Online Rechner für die Arzt Webseite" caption="projecth&reg; Online Rechner API">
 <label class="opt"> Nutzen Sie den Online Rechner von projecth&reg; jetzt auch auf Ihrer eigenen Webseite.<br />
<br /> 
Integrieren Sie kinderleicht den Online-Rechner mit unserer statischen API (Application Programming Interface) in Ihre Webseite 
mittels Kopie von einer Linie Programm-Code. Akzeptieren Sie hierzu unsere Bedingungen, um sofort mit der Einbindung der Online 
Rechner zu beginnen.</label>
<br />
<br />
<br />
<input type="checkbox" name="checkbox" id="checkbox" />
<script>
	$(document).ready(function(){
		$("#checkbox").click(function(){
			if($('input[name=checkbox]').is(':checked')) {
				$("#infoText").show();
			}else{
				$("#infoText").hide();
			}
		});
	});
</script>
<label for="checkbox">
Mit dem Download, Einbindung und/oder Nutzung unserer Online Rechner  stimmen Sie den 
  <t:apublic
					href="nutzungsbedingungen" target="_new">
					<strong>Nutzungsbedingungen</strong>
				</t:apublic> 
  und dem <t:apublic href="datenschutz" target="_new">
					<strong>Datenschutz</strong>
  </t:apublic> von projecth&reg; zu<strong>. </strong></label>
<br />
<br />
<div id="infoText" style="display:none">
<br />
<label class="opt"><strong>1. Download</strong></label><br />
<br />
  <table width="640">
      <tr>
        <td width="38" align="center" valign="middle"><t:apublic href="online_rechner_rheuma_cdai">
		<t:img src="button_rheuma.png" alt="rheumatoide arthritis polyarthritis" width="142"
			height="103" />
	</t:apublic></td>
        <td width="106" align="left" valign="middle"><label class="opt"><strong>CDAI <br />
        Online Rechner</strong></label></td>
        <td width="480" align="left" valign="middle"><label class="opt">&lt;iframe src=&quot;https://www.projecth.ch/embed/cdai.html&quot; style=&quot;width: 700px; height: 1200px;&quot;&gt;&lt;/iframe&gt;</label></td>
      </tr>
      <tr>
        <td align="center" valign="middle"><t:apublic href="online_rechner_psoriasis_pasi">
		<t:img src="button_psoriasis.png" alt="psoriasis" width="142"
			height="103" /></t:apublic></td>
        <td align="left" valign="middle"><label class="opt"><strong>PASI <br />
        Online Rechner</strong></label></td>
        <td align="left" valign="middle"><label class="opt">&lt;iframe src=&quot;https://www.projecth.ch/embed/pasi.html&quot; style=&quot;width: 700px; height: 1400px;&quot;&gt;&lt;/iframe&gt;</label></td>
      </tr>
      <tr>
        <td align="center" valign="middle"><t:apublic href="online_rechner_morbusbechterew_basdai">
		<t:img src="button_morbusbechterew.png" alt="morbus bechterew"
			width="142" height="103" /></t:apublic></td>
        <td align="left" valign="middle"><label class="opt"><strong>BASDAI Online Rechner</strong></label></td>
        <td align="left" valign="middle"><label class="opt">&lt;iframe src=&quot;https://www.projecth.ch/embed/basdai.html&quot; style=&quot;width: 700px; height: 1000px;&quot;&gt;&lt;/iframe&gt;</label></td>
      </tr>
  </table>
<br /><br />
<label class="opt"><strong>2. Integration</strong> <br /><br />
Integrieren Sie den Online Rechner in Ihre eigene Webseite mit Bild und Quellenhinweis.<br />
<br />

Bitte platizieren Sie auf Ihrer Webseite einen anklickbaren Quellenhinweis (wahlweise DE, AT oder CH):</label><br />
<br />
<label class="opt"><a href="www.projecth.de" target="_blank"><strong>Mit freundlicher Genehmigung von projecth&reg;</strong></a></label><br />
<br />
<t:img src="de.gif" /> Link <strong>Deutschland</strong><br />
<label class="opt">&lt;a href=&quot;www.projecth.de&quot; target=&quot;_blank&quot;&gt;Mit freundlicher Genehmigung von projecth&amp;reg;&lt;/a&gt;</label><br />
<br />
<t:img src="at.gif" /> Link <strong>&Ouml;sterreich</strong><br />
<label class="opt">&lt;a href=&quot;www.projecth.at&quot; target=&quot;_blank&quot;&gt;Mit freundlicher Genehmigung von projecth&amp;reg;&lt;/a&gt;</label><br />
<br />
<t:img src="ch.gif" /> Link <strong>Schweiz</strong><br />
<label class="opt">&lt;a href=&quot;www.projecth.ch&quot; target=&quot;_blank&quot;&gt;Mit freundlicher Genehmigung von projecth&amp;reg;&lt;/a&gt;</label><br />
<br />
<br /> <t:apublic href="onlinerechner_download"></t:apublic>
  <label class="opt"> F&uuml;r Fragen oder technische Unterstützung stehen wir Ihnen gerne unter <a href="mailto:support@projecth.com">support@projecth.com</a> zur Verf&uuml;gung. 
 </label> </div>
</m:publicMasterMenu>

