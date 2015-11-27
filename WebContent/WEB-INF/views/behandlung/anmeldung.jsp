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
<%@ include file="/WEB-INF/taglibs.inc"%>
<m:publicMasterMenu title="Melden Sie sich hier an bei projecth&reg;" caption="Kostenlose Anmeldung"><br />
  <table width="640">
    <tr>
      <td width="314">	
<t:apublic href="chronisch_betroffene">
				<t:img src="patientfront2.png" alt="" width="180" height="200" />
		</t:apublic>
		<h5>Kein projecth&reg; Konto? <t:apublic href="mitmachen">
			<br />
			<br />
			<t:img src="buttongelbanmelden.png" alt="" width="198" height="39" />
				</t:apublic><br /><br />
		</h5></td>
      <td width="314">			<form method="POST" action="<c:url value="/login"/>" class="niceform">
			<table width="200" align="left" class="noborder">
				<tr>
					<td width="32px" rowspan="2" style="vertical-align: top;">
					<t:img src="secicon.png" />
					</td>
					<td width="173" height="19" align="left" style="vertical-align: top; max-height: 10px; overflow: visible;">
						<div style="max-height: 19px; overflow: visible;" >
							<t:img src="anmeldung.png"/>
                    	</div>
                    </td>
				</tr>
				<tr >
				  <td align="left" style="vertical-align: top; font-size: 10px; font-family: Arial;">
				  	<t:apublic href="sicherheit">SSL Secure Sockets Layer</t:apublic>
				  </td>
			    </tr>
			</table>
			<br />
			<br />
			<table width="200" align="left">
				<tr>
					<td colspan="2">
					<label>Benutzername:</label>
					<br />
				    </td>
				</tr>
				<tr>
					<td colspan="2">
						<input style="width: 198px" name="login" type="text" id="login" />
						<br />
					</td>
				</tr>
				<tr>
					
					<td colspan="2">
						<label>Passwort:</label>
						<br />
					</td>
				</tr>
				<tr>
					<td colspan="2">
						<input style="width: 198px" name="password" type="password"
							id="password" />
						
					</td>
					
				</tr>
				<tr>
					<td colspan="2">
						<input type="checkbox" name="staylogged" id="staylogged" />
						<label for="staylogged" class="opt">Angemeldet bleiben
					    </label>
					</td>
					
				</tr>
				<c:if test="${useLoginCaptcha}">
				<tr>
					<td colspan="2">
						<br /> <t:captcha />        
					</td>
				</tr>
				</c:if>
				<tr>	
					<td colspan="2">			  
						<br />
						<input type="image"
							src="<c:url value="/images/button_anmelden.png"/>" />
						<t:error test="${login_error}">Der eingegebene Benutzername oder Passwort ist falsch.</t:error>
                        <t:error test="${login_error_user_blocked}">Anmeldung fehlgeschlagen - Benutzer ist gesperrt</t:error>
					</td>
				</tr>
				<tr>
					<td height="18" colspan="2" align="left"><t:apublic href="pwbnvergessen">
						<font color="#5093c1">
							<br />
			      			Zugangsdaten vergessen?
			      			<br />
						</font>
						</t:apublic>
					</td>
				</tr>
				
			</table>
			</form>
</td>
    </tr>
    <tr>
      <td height="59" colspan="2"><t:img src="dottedlinelang.png" alt="" width="640" height="1" /><br /></td>
    </tr>
    <tr>
      <td height="236" colspan="2"><table width="100%">
        <tr>
          <td height="43" colspan="2"><h5>Ihre Vorteile</h5></td>
          </tr>
        <tr>
          <td width="7%"><t:img src="greenarrow.png" alt="" width="20" height="20" /></td>
          <td width="94%">Elektronisches Tagebuch f&uuml;r Krankheitsaktivit&auml;t und  Medikation</td>
          </tr>
        <tr>
          <td><t:img src="greenarrow.png" alt="" width="20" height="20" /></td>
          <td>Online Auswertungen</td>
          </tr>
        <tr>
          <td><t:img src="greenarrow.png" alt="" width="20" height="20" /></td>
          <td>St&auml;rkung Patienten-Arzt Beziehung</td>
          </tr>
        <tr>
          <td><t:img src="greenarrow.png" alt="" width="20" height="20" /></td>
          <td>Sozialer Austausch mit Betroffenen</td>
          </tr>
        <tr>
          <td><t:img src="greenarrow.png" alt="" width="20" height="20" /></td>
          <td>Unabh&auml;ngig, sicher und kostenlos</td>
          </tr>
      </table></td>
    </tr>
  </table>
<br />
Melden Sie sich an und nutzen Sie die innovativen Funktionen jetzt kostenlos!
<br />
      <br />
</m:publicMasterMenu>
