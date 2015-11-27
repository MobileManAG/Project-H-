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
<m:publicMasterMenu title="Melden Sie sich hier bei projecth&reg; an" caption="Anmeldung">
	<br />

	<form method="POST" action="<c:url value="/login"/>" class="niceform">
	<table width="640">
		<tr>
			<td width="200" height="19" valign="top">
			<h3><font color="#000000" face="Arial, Helvetica, sans-serif"> Anmeldung</font> <t:img src="dottedline.png" alt="" width="212"
				height="1" /><br />
			<br />
			</h3>
			</td>
		</tr>
		<tr>
			<td><label>Benutzername:</label> <br />
			</td>
		</tr>
		<tr>
			<td><input style="width: 198px" name="login" type="text" id="login" /> <br />
			</td>
		</tr>
		<tr>

			<td><label>Passwort:</label> <br />
			</td>
		</tr>
		<tr>
			<td><input style="width: 198px" name="password" type="password" id="password" /></td>

		</tr>
		<tr>
			<td><input type="checkbox" name="staylogged" id="staylogged" /> <label for="staylogged" class="opt">Angemeldet bleiben </label></td>

		</tr>
		<c:if test="${useLoginCaptcha}">
			<tr>
				<td><br />
				<t:captcha /></td>
			</tr>
		</c:if>
		<tr>
			<td><br />
			<input type="image" src="<c:url value="/images/button_anmelden.png"/>" /> <t:error test="${login_error}">Anmeldung fehlgeschlagen</t:error>
			</td>
		</tr>
		<tr>
			<td height="18" align="left"><t:apublic href="pwbnvergessen">
				<font color="#5093c1"> <br />
				Zugangsdaten vergessen? <br />
				</font>
			</t:apublic></td>
		</tr>

	</table>
	</form>

</m:publicMasterMenu>
