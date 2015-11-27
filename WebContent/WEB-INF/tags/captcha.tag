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

<img id="captchaImage" src="<c:url value='/captchaImg'/>" width="200" height="60"/><br />
<input type="text" name="captchaAnswer" id="captchaAnswer" style="width: 198px" autocomplete="off"/>
<div style="display: none;" class="error" id="captchaError">Fehlermeldung<br /></div>
<t:error test="${CAPTCHA_ERROR}">Fehlermeldung</t:error>
<label title="Sicherheitsfrage^Bitte geben Sie die Buchstaben und Zahlen exakt wieder (achten Sie auch auf Gross- und Kleinschreibung). Falls Sie die Buchstaben- und Zahlenreihe nicht lesen können, aktualisieren Sie einfach die Seite in Ihrem Internet Browser und versuchen Sie es erneut." class="vtip">Was ist das?</label>
