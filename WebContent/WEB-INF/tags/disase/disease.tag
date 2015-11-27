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
<%@ tag description="Header tag" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc" %>
<%@ attribute name="action" required="true"%>
<%@ attribute name="back" required="true"%>
<%@ attribute name="submitbutton" required="true"%>
<%@ attribute name="readonly" required="false"%>
<form id="mainForm" method="post" action="<c:url value="/patient/${action}"/>" enctype="multipart/form-data">
<span style="font-size: 20px; font-weight: bold;">Gesundheitsgruppe: ${disease_name}</span><br />
<jsp:doBody />
<c:set var="readonly" value="${readonly}" scope="request" />
<br />	<c:if test="${patientAnswerExists}"><strong>Sie können maximal 1x pro Tag Ihre Daten eingeben. Bitte versuchen Sie es morgen nochmals.</strong></c:if>
<script type="text/javascript">
	var data_values = ${data_values};
	
	$(document).ready(function() {
		<c:if test="${readonly!=null}">
		$('input:radio').attr("disabled", "disabled");
		$('input:checkbox').attr("disabled", "disabled");
		$('input:text').attr("disabled", "disabled");
		$('textarea').attr("disabled", "disabled");
		</c:if>

		//setup old values
		$.each(data_values, function(index, value) {
			//radios and checkboxes
			$('input[name="' + value[0] + '"]').filter('[value="' + value[1] + '"]').attr('checked', true);
			//hidden fields
			$('input[name="' + value[0] + '"]').filter('[type="hidden"]').val(value[1]);
			$('input[name="' + value[0] + '"]').filter('[type="text"]').val(value[1]);
			//sliders
			$('input[name="sliderinit' + value[0] + '"]').filter('[type="hidden"]').val(value[1]);
			$('input[name="comboinit' + value[0] + '"]').filter('[type="hidden"]').val(value[1]);
			//textarea
			$('textarea[name="' + value[0] + '"]').text(value[1]);
		});
	});
	
	//color
	var colorTo = '#FC7265';
	var colorFrom = '#9ECD63';
	
	function rgbToHsv(r, g, b){
	    r = r/255, g = g/255, b = b/255;
	    var max = Math.max(r, g, b), min = Math.min(r, g, b);
	    var h, s, v = max;

	    var d = max - min;
	    s = max == 0 ? 0 : d / max;

	    if(max == min){
	        h = 0; // achromatic
	    }else{
	        switch(max){
	            case r: h = (g - b) / d + (g < b ? 6 : 0); break;
	            case g: h = (b - r) / d + 2; break;
	            case b: h = (r - g) / d + 4; break;
	        }
	        h /= 6;
	    }

	    return [h, s, v];
	}

	function hsvToRgb(h, s, v){
	    var r, g, b;

	    var i = Math.floor(h * 6);
	    var f = h * 6 - i;
	    var p = v * (1 - s);
	    var q = v * (1 - f * s);
	    var t = v * (1 - (1 - f) * s);

	    switch(i % 6){
	        case 0: r = v, g = t, b = p; break;
	        case 1: r = q, g = v, b = p; break;
	        case 2: r = p, g = v, b = t; break;
	        case 3: r = p, g = q, b = v; break;
	        case 4: r = t, g = p, b = v; break;
	        case 5: r = v, g = p, b = q; break;
	    }

	    return [r * 255, g * 255, b * 255];
	 }	
	
	function colorValue(color, index) {
		return parseInt(color.substring(1 + index*2, 3 + index*2), 16);
	}
	
	function interpolate(f,t, percent) {
		return f + (t - f) * percent;
	}
	
	function makeInt(i) {
		return Math.round(Number(i));
	}
	
	function make1color(result) {
		var r1 = makeInt(result);
		
		//convert to web colors 3 6 9 C - round to nearest 3
		var r2 =  (r1) / 25;
		r1 = makeInt(r2) * 25;
		if(r1<16) {
			return "0" + r1.toString(16);
		}
		return "" + r1.toString(16);
	}
	
	function getScaleColor(index, total) {
		var maxindex = total-1;
		var f = rgbToHsv(colorValue(colorFrom, 0),colorValue(colorFrom, 1),colorValue(colorFrom, 2));
		var t = rgbToHsv(colorValue(colorTo, 0),colorValue(colorTo, 1),colorValue(colorTo, 2));
		var percent = index / maxindex;

		var h = interpolate(f[0], t[0], percent);
		var s = interpolate(f[1], t[1], percent);
		var v = interpolate(f[2], t[2], percent);

		var result = hsvToRgb(h, s, v);
		var color= "#" + make1color(result[0]) + make1color(result[1]) + make1color(result[2]);
		//alert(color);
		return color;
	}
</script>
 	<c:set var="lastHaqNum" value="-1" />
 
 	<c:if test="${initial_questions_exists}">
	<c:set var="lastHaqNum" value="${lastHaqNum + 1}" />
	<q:haqFrame type="Normal" num="${lastHaqNum + 1}" title="${initial_questions_title}">
	<c:forEach var="question" items="${initial_questions}">
		<q:question question="${question}"/>
		<br />
	</c:forEach>
	</q:haqFrame>
	</c:if>
 
	<c:forEach var="haq" items="${haq_data}">
		<c:set var="lastHaqNum" value="${lastHaqNum + 1}" />
		<q:haqFrame type="Normal" num="${lastHaqNum  + 1}" title="${haq.haqQuestion}" explanation="${haq.explanation}">
			<q:haq haq="${haq}" />
		</q:haqFrame>
	</c:forEach>
	
	<c:if test="${patientQuestions_exists}">
	<c:set var="lastHaqNum" value="${lastHaqNum + 1}" />
	<q:haqFrame type="Patient" num="${lastHaqNum + 1}" title="Ihre eigene pers&ouml;nliche Fragestellung">
	<c:forEach var="question" items="${patientQuestions}">
		<q:question question="${question}"/>
		<br />
	</c:forEach>
	</q:haqFrame>
	</c:if>
	
	<c:if test="${doctorQuestions_exists}">
	<c:set var="lastHaqNum" value="${lastHaqNum + 1}" />
	<q:haqFrame type="Doctor" num="${lastHaqNum + 1}" title="Pers&ouml;nliche Fragestellung von Ihrem Arzt">
	<c:forEach var="question" items="${doctorQuestions}">
		<q:question question="${question}"/>
		<br />
	</c:forEach>
	</q:haqFrame>
	</c:if>
	
	<br /><br />
		
		<c:if test="${patientAnswerExists}"><strong>Sie können Ihre Daten maximal 1x pro Tag eingeben. Bitte versuchen Sie es morgen nochmals.</strong></c:if>
		
		<c:if test="${!patientAnswerExists}"><input type="image" src="<c:url value="/images/${submitbutton}"/>" /></c:if>
		
	<t:apatient href="${back}"><t:img src="buttonzuruck.png" alt="" width="134" height="30" /></t:apatient>
</form>
