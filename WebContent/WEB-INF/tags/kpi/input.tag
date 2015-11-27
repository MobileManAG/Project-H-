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
<%@ tag description="KPI INput Tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="id" required="true" %>
<%@ attribute name="code" required="true" %>
<div>
	<div class="reportSeparator" ></div>
	<br />
	<form method="post" action="<c:url value="/arzt/kpi/${id}" />">
		<table>
			<tr>
				<td>
					<div style="padding-left: 10px; padding-right: 10px;">
					<h3>
						<font face="Arial, Helvetica, sans-serif">Manuelle Eingabe  ${code}</font>
					</h3>
					</div>
				</td>
				<td>
					<input id="kpi" name="kpi" type="text">
				</td>
				<td>
					<input type="image" id='change_kpi' style="padding-top:2px; margin-left: 10px;" src="<c:url value="/images/button_eingeben.png"/>"  value="1"/>
				</td>
			</tr>
		</table> 
	</form>
</div>
