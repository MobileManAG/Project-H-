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
<%@ attribute name="isdoctor" required="true" rtexprvalue="true" %>
<%@ attribute name="dir" required="true" rtexprvalue="true" %>

<table width="640" border="0">
	<tr style="background-color: #5093c1;border:1px solid #DDDEE1;">
		<td height="28">
			<font color="#FFFFFF"><strong> Name </strong></font>
		</td>
		
		<td>
			<font color="#FFFFFF"><strong>Geschlecht</strong></font>
		</td>
		<td>
			<font color="#FFFFFF"><strong>Jahrgang</strong></font>
		</td>
		
		<td align="center">
			<font color="#FFFFFF"><strong>Diseases</strong></font>
		</td>
	</tr>
	
	<c:forEach var ="member" items="${members}">
		<tr id="connection${conn.id}">
			<td style="border: 1px solid #DDDEE1">
				${member.name}
			</td>
			<td style="border: 1px solid #DDDEE1">
				${member.gender}
			</td>
			
		</tr>
	</c:forEach>
	
	<script>
		
	</script>
	
</table>
