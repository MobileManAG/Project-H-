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
<%@ attribute name="id" required="true" rtexprvalue="true"%>
<%@ attribute name="data" required="true" rtexprvalue="true" type="java.util.List"%>
<%@ attribute name="width" required="true" rtexprvalue="true" %>
<%@ attribute name="height" required="true" rtexprvalue="true" %>
<%@ attribute name="title" required="false" rtexprvalue="true" %>
<%@ attribute name="subtitle" required="false" rtexprvalue="true" %>
<%@ attribute name="style" required="false" rtexprvalue="true" %>
<%@ include file="/WEB-INF/taglibs.inc"%>
<div id="haq_chart_${id}" style="width: ${width}px; height: ${height}px; ${style}"></div>
<script>
$(document).ready(function(){
var data_1 = [<c:forEach var="q" items="${data}">{${q}},</c:forEach>];
new Highcharts.Chart({
		chart: { renderTo: 'haq_chart_${id}', margin: [40, 0, 20, 0], backgroundColor: "#FFF", plotBackgroundColor: "#FFF"},
		title: { text: '', style: { color: '#666' }, y: 15 },
		subtitle: { text: '${title}',  style: { color: '#666' }, y: 30 },
		tooltip: { formatter: function() { return '<b>'+ this.y + '</b>'; } },
		plotOptions: { 
			pie: { 
				allowPointSelect: true, 
				cursor: 'pointer', 
				dataLabels: { 
					
					enabled: true, 
					formatter: function() { 
						return formatLabel(this.point.name,4); 
					}, 
					color: 'black', 
					style: { 
						font: '11px Trebuchet MS, Verdana, sans-serif' }
					} 
				} 
		},
		legend: {enabled: false},
	    series: [{ type: 'pie', name: 'DATA', data: data_1 }]
});
});
</script>
