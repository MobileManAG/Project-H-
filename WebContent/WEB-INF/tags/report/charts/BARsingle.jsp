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
<%@page contentType="text/html;charset=UTF-8"%>
<%@page pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/taglibs.inc"%>
<%--0 - counter 1 - question 2 - answers array 3 - dates and values --%>
<div id="haq_chart_${currentHaqChart.id}_${currentBarItem[0]}" style="width: 640px; height: 360px; margin-bottom: 20"></div>
<script>
$(document).ready(function(){
	var colors = ['#ffd355','#54b655','#feb300','#fc9400','#ed6330 '];

	var options = [
	<c:forEach var="ans" items="${currentBarItem[2]}">
	'${ans.name}',
	</c:forEach>
	];

	
	
	var data2b = [
{name: 'DATA', data: [
	<c:forEach var="diary" items="${currentBarItem[2]}" varStatus="status">              
	
	<c:forEach var="item" items="${diary.items}">
	//{x:Date.UTC(${item.date}), y:${item.value}},
	{
		x:Date.UTC(${item.date}), 
		y:${item.value}, 
		color:colors[${status.index} % colors.length], 
		marker: { 
			//radius:${status.index}*2 +3, 
			fillColor:colors[${status.index} % colors.length]
		}

	},
	</c:forEach>
	</c:forEach>
	]},
	
	];

	//length must be (options count) + 1 !!!
	var empty = [''];
	
	var opt1 = empty.concat(options);
	var opt2 = opt1.concat(empty);
	var optionsLength = opt2.length - 1;

	var optionHeight = 50;
	var optionYOffset = 22;
	var xAxisYOffset = -11;
	var xAxisTitleYOffset = -10;
	if(optionsLength > 7){
		optionHeight = 35;
		optionYOffset = 15;
		xAxisYOffset = -2;
		xAxisTitleYOffset = -2;
	}
	$("#haq_chart_${currentHaqChart.id}_${currentBarItem[0]}").css("height", optionsLength*optionHeight + 65);
	
	new Highcharts.Chart({
		chart: { renderTo: 'haq_chart_${currentHaqChart.id}_${currentBarItem[0]}', defaultSeriesType: 'line', margin: [25, 10, 40, 30], backgroundColor: "#FFF", plotBackgroundColor: "#FFF"},
		title: { text: '${currentHaqChart.title}', style: { color: '#666' }, y: 17 },
		subtitle: { text: '${currentHaqChart.subtitle}',  style: { color: '#ccc' }, y: 32 },
		xAxis: { 
			tickLength: 0,
			lineWidth: 0,
			labels: {y: xAxisYOffset},
			title: { text: '${currentHaqChart.xAxisName}', style: { color: '#ccc' }, x: -20, y: xAxisTitleYOffset},
	   	   	type: 'datetime', 
	   	   	tickInterval: tickIntervalComp, 
	   	   	dateTimeLabelFormats: { year: '%Y', month: '%m.%Y', week: '%e.%m', day: '%e.%m', second: '%e.%m', minute: '%e.%m', hour: '%e.%m' } 
	   	   	},
		plotOptions: { 
			line: { 
				
				//color: '#6cc0e8', 
				color: '#e8e8e8',
				lineWidth: 1,
				shadow: true, 
				states: {hover: {enabled: true, lineWidth: 3}} }},
		yAxis: { 
			//lineColor: '#ccc',
	        //lineWidth: 0,
	        gridLineColor: '#e9e9e9',
			title: { text: '${currentHaqChart.yAxisName}', style: { color: '#ccc' }, x: 20,}, 
			categories: opt2, 
			labels: { align: 'left', x: 5, y: optionYOffset },
			showFirstLabel: false, showLastLabel: false,
			min:0, max:optionsLength
			},
		tooltip: { formatter: function() { return Highcharts.dateFormat('%e.%m.%Y', this.x); } },
		legend: { 
			enabled: false
			},
		series: data2b
	});
	});
</script>
