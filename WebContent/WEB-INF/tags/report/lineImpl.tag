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
<%@ attribute name="title" required="false" rtexprvalue="true" %>
<%@ attribute name="subtitle" required="false" rtexprvalue="true" %>
<%@ attribute name="xlabel" required="false" rtexprvalue="true" %>
<%@ attribute name="ylabel" required="false" rtexprvalue="true" %>
<%@ attribute name="ymax" required="false" rtexprvalue="true" %>
<%@ attribute name="color" required="false" rtexprvalue="true" %>
<%@ include file="/WEB-INF/taglibs.inc"%>
<br />
<div id="haq_chart_${id}" style="width: 640px; height: 300px;"></div>
<br />
<script>
$(document).ready(function(){
var data_1 = [<c:forEach var="q" items="${data}">{${q}},</c:forEach>];
  		  	
new Highcharts.Chart({
		chart: { renderTo: 'haq_chart_${id}', defaultSeriesType: 'line',  margin: [40, 10, 50, 30], backgroundColor: "#FFF", plotBackgroundColor: "#FFF"},
		title: { text: '${title}', style: { color: '#666' }, y: 15 },
		subtitle: { text: '${subtitle}',  style: { color: '#ccc' }, y: 30 },
		xAxis: { 
			tickLength: 0,
			lineWidth: 0,
			title: { text: '${xlabel}', style: { color: '#ccc' }, x: -20, y: 12}, 
			type: 'datetime', 
			tickInterval: tickIntervalComp,
			dateTimeLabelFormats: { year: '%Y', month: '%m.%Y', week: '%e.%m', day: '%e.%m', second: '%e.%m', minute: '%e.%m', hour: '%e.%m' } 
		},
		yAxis: { 
			//lineColor: '#ccc',
	        //lineWidth: 1,
	        gridLineColor: '#e9e9e9',
			title: { text: '${ylabel}', style: { color: '#ccc' }, x: 20}, 
			//minorGridLineWidth: 0.5, minorTickInterval: 1, minorTickWidth:0 , minorGridLineColor: '#E8E8E8',
			allowDecimals: false, 
			${ymax!=null?'max:30,':''} min: 0,
			showLastLabel: false,
			labels: { align: 'left', x: 5, y: -3, }
		},
		plotOptions: { line: { color: '${color}' }},
		legend: { enabled: false },
		tooltip: { formatter: function() { return Highcharts.dateFormat('%e.%m.%Y', this.x) +'<br/><b>'+this.y + '</b>'; } }, 
		series: [{ name: 'DATA', data: data_1 }]
});
});
</script>
