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
<%@ include file="/WEB-INF/taglibs.inc"%>
<%@ attribute name="patient" required="true" rtexprvalue="true" type="com.mobileman.projecth.domain.patient.Patient"%>
<c:if test="${patient==null}">
	Unbekannt
</c:if>
<c:if test="${patient != null}">
	<div id="rectheadcomp">
		<label class="black">Jahrgang: <c:if test="${patient.birthday == null}">Unbekannt</c:if> <c:if test="${patient.birthday != null}">${patient.birthday}</c:if>
		</label> 
		<br />
		
		<label class="black">Geschlecht: <c:if test="${patient.sex == null}">Unbekannt</c:if> <c:if test="${patient.sex == 0}">Frau</c:if><c:if test="${patient.sex == 1}">Man</c:if>
		</label> 
		<br />
		
		<label class="black">Land: <c:if test="${patient.country == null}">Unbekannt</c:if> <c:if test="${patient.country != null}">${patient.country.name}</c:if>
		</label> 
		<br />
		
		<label class="black">Gesundheitsgruppen: 
			<c:forEach var="disease" varStatus="status" items="${patient.diseases}">${disease.name}<c:if test="${!status.last}">, </c:if>
			</c:forEach>
		</label> 
		<br />
							
	</div>
</c:if>
