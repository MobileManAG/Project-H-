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
<%@ tag description="A tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<script>
	window.setTimeout(function(){
		$.blockUI({ 
			message: document.getElementById("sessionTimeout"), 
			css: {
				top: '300px'
			}
		});
	}, 1000 * ${session_timeout_seconds});
	//}, 3000 );
</script>
<div id="sessionTimeout" style="width: 430px;display:none">
	<form method="POST" action="<c:url value="/login"/>" class="niceform">
	<div style="border: 1px solid #5F9DC5; background-color: #EAEAEA;">
		<div style="background-color: #5F9DC5; color: #FFFFFF;padding: 5px;">Bitte melden Sie sich neu an</div>
		<div style="padding: 5px;">
		Fur Ihre Sicherheit werden Sie automatisch nach 30 Minuten abgemeldet,
		wenn Sie keine Aktivit&auml;t bei projecth&reg; vornehmen. Um weiterzufahren, melden
		Sie sich bitte neu an.
		<br />
		<br />
		<table>
			<tr>
				<td>Benutzername</td>
				<td>Passwort</td>
			</tr>
			<tr>
				<td><input style="width: 198px" name="login" type="text" id="login" /></td>
				<td><input style="width: 198px" name="password" type="password"	id="password" /></td>
			</tr>
			<tr>
				<td><input type="image"	src="<c:url value="/images/button_anmelden.png"/>" /></td>
				<td><t:a href="logout" dir="login"><t:img src="button_abmelden.png"/></t:a></td>
			</tr>
		</table>
		</div>
	</div>
	</form>
</div>
