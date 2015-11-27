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
<%@ attribute name="doctor" required="true" rtexprvalue="true" type="com.mobileman.projecth.domain.doctor.Doctor"%>
<c:if test="${doctor==null}">
	Unbekannt
</c:if>
<c:if test="${doctor != null}">
	<div id="rectheadcomp">
	<label class="black">${doctor.medicalInstitution.name}</label> 
	<br />
	<h3><label class="black"><b>${doctor.title} ${doctor.name.name} ${doctor.name.surname}</b></label></h3>
	<label class="black">${doctor.medicalInstitution.address.address} ${doctor.medicalInstitution.address.number}, ${doctor.medicalInstitution.address.postalCode.code} ${doctor.medicalInstitution.address.place} </label> <br />
	<label class="black">Land: ${doctor.medicalInstitution.country.name}</label> <br />
	<label class="black">Telefon: ${doctor.medicalInstitution.phoneNumber.countryCode} ${doctor.medicalInstitution.phoneNumber.number}</label> <br />
	<label class="black">Fax: ${doctor.medicalInstitution.faxNumber.countryCode} ${doctor.medicalInstitution.faxNumber.number}</label> <br />
	<label class="black">Internet: </label><a href="http://${doctor.medicalInstitution.homePageUrl}">${doctor.medicalInstitution.homePageUrl}</a><br />
	</div>
</c:if>
