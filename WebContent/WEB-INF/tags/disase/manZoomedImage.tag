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
<%@ tag description="Man tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="prefix" required="true" rtexprvalue="true"%>
<%@ attribute name="image" required="true"%>
<%@ attribute name="id" required="true" rtexprvalue="true"%>

<div id="${id}" style="display:none; text-align: center; width: 580px;" class="closeZoomEsc">
<br /><h4>Ansicht von vorne</h4>
<br /><br />Bitte tippen Sie auf den zutreffenden Bereich.
<br /><br />
<d:manImage image="${image}" prefix="${prefix}" style="margin:auto;width: 528px;">
	<jsp:doBody />
</d:manImage>
<br />
<table style="width: 100%;">
<tr><td style="text-align: right;width: 40%;"><img src="<c:url value="/images/man/rheuma/redbutton.png" />" /></td><td style="text-align: left;">Geschwollene Gelenke</td></tr>
<tr><td style="text-align: right;"><img src="<c:url value="/images/man/rheuma/clearbutton.png" />" /></td><td style="text-align: left;">Nicht geschwollene Gelenke</td></tr>
</table>
<br />
<br />
<img src="<c:url value="/images/man/rheuma/backbutton.png" />" class="closeZoom" style="vertical-align: middle;"/><span class="closeZoom"> Speichern und zur&uuml;ck</span><br />
<br />
<br />
</div>
