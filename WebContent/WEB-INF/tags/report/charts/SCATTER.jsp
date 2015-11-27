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
<br />
<br />
<div id="haq_chart_${currentHaqChart.id}" style="width: 640px; height: 400px; margin-bottom: 20"></div>
<br />
<br />
<br />
<script>
$(document).ready(function(){
var questions5b = [
   	"",
   	<c:forEach var="q" items="${haqChart_data[currentHaqChart.id][1]}">formatLabel("${q}", 28),</c:forEach>
	""
];
   			
var answers5b = [
   	<c:forEach var="ans" items="${haqChart_data[currentHaqChart.id][0]}">
    {	
    	name: '${ans.name}', 
    	data: [
   	    <c:forEach var="item" items="${ans.items}">
   		{x:Date.UTC(${item.date}), y:${item.value}}, 
   		</c:forEach>
    	] ,
    	color: '${ans.color}',
    }, 
  	</c:forEach>
];
   				
var title5b= '';
var subtile5b = '';
     		  		
new Highcharts.Chart({
	chart: { renderTo: 'haq_chart_${currentHaqChart.id}', defaultSeriesType: 'scatter' , margin: [ 40, 0, 50, 200], backgroundColor: "#FFF", plotBackgroundColor: "#FFF"},
	title: { text: '${currentHaqChart.title}', style: { color: '#666' }, y: 25 },
	subtitle: { text: '${currentHaqChart.subtitle}',  style: { color: '#ccc' }, y: 40 },
   	xAxis: { 
   	   	title: { text: '', }, 
   	   	type: 'datetime', 
   	   	tickInterval: tickIntervalComp, 
   	   	label: { enabled: false }, 
   	   	dateTimeLabelFormats: { year: '%Y', month: '%m.%Y', week: '%e.%m', day: '%e.%m', second: '%e.%m', minute: '%e.%m', hour: '%e.%m' } 
   	   	},
   	yAxis: { 
   		title: { text: '', } ,
   		categories: questions5b, 
   		showFirstLabel: false, showLastLabel: false,
   		min:0, max: (questions5b.length-1),
   		labels: {
   	            x: -5
   	    }
   	},
   	legend: { 
   		itemWidth: 185,
   		itemStyle: {
   			font: 'normal 12px Arial, sans-serif'
   		},
   		backgroundColor: '#FFFFFF', 
   		align: 'left', 
   		verticalAlign: 'bottom',  
   	},
   	plotOptions: { 
   		scatter: { 
   			marker: { 
   				enabled: true, 
   				symbol: 'square', 
   				radius: 10, 
   			}
   		}
   	},
   	tooltip: { 
   		formatter: function() { return Highcharts.dateFormat('%e.%m.%Y', this.x) +'<br/><b>'+this.y + '</b>'; } }, 
   				    series: answers5b,
   	});	
});
</script>
