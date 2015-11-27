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

<m:patientMasterMenu menuitem="1" caption="Fragebogen Anpassen">
	
	  <h3><font color="#000000" face="Arial, Helvetica, sans-serif">${disease.name}</font>
	</h3><label class="opt">	Gesundheitsgruppe</label>
	<br />
	<br />
	<label class="opt">	F&uuml;gen Sie Ihrem Fragenkatalog zus&auml;tzliche, massgeschneiderte Fragen nach Gesundheitsgruppe hinzu.</label> 
	<br />
	<br />
	<c:if test="${fn:length(patient_diseases) > 1}">  
		<form id="disease_form" action="">
		<select size="1" name="diseases" id="diseases">
			<c:forEach items="${patient_diseases}" var="dis">
				<option value="${dis.id}"  <c:if test="${disease.id==dis.id}">selected</c:if>>
					${dis.name}
				</option>
			</c:forEach>
		</select>
		</form>
	</c:if>
	<q:customQuestions prefix="patient"/>
</m:patientMasterMenu>
<script>
	$(function() {
		$("#diseases").change(onSelectChange);
		function onSelectChange(){
			var selected = $("#diseases option:selected");  
			var diseaseId = selected.val();
			var page = "<c:url value='/patient/fragebogen_anpassen/" + diseaseId + "'/>";
			
			$("#disease_form").attr("action", page);
			$("#disease_form").submit();
		}			
	});
</script>
