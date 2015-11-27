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
<m:publicMasterMenu title="Jetzt mitmachen&reg; bei projecth!" caption="Registrieren">
<table width="640">
  <tr>
    <td width="320" height="44"><t:apublic href="mitmachen_chronisch_betroffener"> <label class="opt">Sind Sie ein Patient?</label></t:apublic></td>
    <td width="320"><t:apublic href="mitmachen_arzt"> <label class="opt">Sind Sie  ein behandelnder Arzt?</label></t:apublic></td>
  </tr>
  <tr>
    <td><t:apublic href="mitmachen_chronisch_betroffener">
      <t:imagebutton image="pat_reg.png" />
    </t:apublic></td>
    <td><t:apublic href="mitmachen_arzt">
      <t:imagebutton image="arz_reg.png" />
    </t:apublic></td>
  </tr>
</table>
        <br />
<br />
<label class="opt">Klicken Sie auf Ihre Person und fahren Sie  mit der Registration fort.</label>
        <br /><br />
</m:publicMasterMenu>
