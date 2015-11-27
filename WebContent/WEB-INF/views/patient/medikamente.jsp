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
<m:patientMasterMenu menuitem="2" caption="Medikation">
	
	<jsp:attribute name="header">
		<script src="<c:url value="/scripts/highcharts.js" />"></script>
	</jsp:attribute>
	
<jsp:body>
	
	<form method="POST" action="<c:url value="/patient/medikamente_date" />" name="changeDate">
		<br />
		<table style="width: 620px;">
			<tr>				
				<td colspan="2">
					<label class="opt">F&uuml;hren Sie ein pers&ouml;nliches und intelligentes Medikationstagebuch.</label>
				</td>			
			</tr>
			<tr>
				<td colspan="2">
					<div id="chart" style="width: 620px; height: 480px"></div>
				</td>
			</tr>
			<tr>
				<td colspan="2"><br /><label class="opt">Bitte w&auml;hlen Sie den gew&uuml;nschten Zeitraum aus.</label><br /><br /></td>
			</tr>
			<tr>
				<td style="align: center; width: 302px">
					<label class="opt"><strong>Von</strong></label>
				</td>
				<td style="align: right; width: 302px">
					<label class="opt"><strong>Bis</strong></label>
				</td>
			</tr>
			<tr>
				<td style="align: center; width: 302px">
					<input style="width: 120px; float:left;" name="date_from" type="text" id="date_from"><label class="opt">  TT/MM/JJJJ</label>
				</td>
				<td style="align: right; width: 302px">
					<input style="width: 120px;float:left;" name="date_to" type="text" id="date_to"><label class="opt"> TT/MM/JJJJ</label>
				</td>
			</tr>
			<tr>
				<td>
					<br />
				</td>
				<td>
					<br />
				</td>
			</tr>
			<tr>
				<td colspan="2"><t:daterange prefix="patient/medikamente"/></td>
			</tr>
			
		</table>
		<input type="hidden" id="d_from" name="d_from" value="${date_from}" /> 
		<input type="hidden" id="d_to" name="d_to" value="${date_to}" />
	</form>
	<br />
	
	<script>
		<c:if test="${wasSearch || wasEnter}">
			window.location.hash = "aftersearch";
		</c:if>
	
		///////////////
	    var tickIntervalComp = null;
	    
		var colors = ['#00c040', '#f9ff00', '#ed6330' ];
		
		var index=0;
		
		var answers3 = [
		         <c:forEach var="diary" items="${diarydata}">
		    {	name: '${diary.name}', 
		    	data: [
					<c:forEach var="item" items="${diary.items}">{x:Date.UTC(${item.date}), y:${item.value}},
		    		</c:forEach>
		    	] , color: ((index>=colors.length)?null:colors[(index++) % colors.length])
		    }, 
		    	</c:forEach>
		];

		var convDateFormat = 'yy-mm-dd';
		var convDateTimeFormat = 'yy-mm-dd';
		var dateFormat = '';

		function changeDate(dateText, type) {
		   var date = $.datepicker.parseDate(dateFormat, dateText);
		   $("#" + type).val($.datepicker.formatDate(convDateFormat, date));
		   document.forms["changeDate"].submit();
		}
				
		function diseaseSelected() {
			document.forms["changeDisease"].submit();
		}
		
		function datepickerUp() {
			$(".ui-datepicker").css("z-index", 100);
		}
		
		$(document).ready(function() {
			
			$("#date_from").datepicker({
				showOn: "button",
				buttonImage: "<c:url value="/images/calendar.png" />",
				buttonImageOnly: true,
				onSelect: function(dateText, inst) {  changeDate(dateText, "d_from");},
				beforeShow: function() {setTimeout(datepickerUp,100);}
			});
			$("#date_to").datepicker({
				showOn: "button",
				buttonImage: "<c:url value="/images/calendar.png" />",
				buttonImageOnly: true,
				onSelect: function(dateText, inst) {  changeDate(dateText, "d_to"); },
			beforeShow: function() {setTimeout(datepickerUp,100);}
			});

			dateFormat = $("#date_from").datepicker( "option", "dateFormat" );
			dateFormatLong = dateFormat.replace("mm.", " MM ");

			var dateFrom = $.datepicker.parseDate(convDateFormat, '${date_from}');
			var dateTo = $.datepicker.parseDate(convDateFormat, '${date_to}');
			
			$("#date_from").datepicker("setDate", dateFrom);
			$("#date_to").datepicker("setDate", dateTo);
			
			/*
			new Highcharts.Chart({
				chart: {
					renderTo: 'chart',
					defaultSeriesType: 'column',
					marginLeft: 30,
					marginRight: 150,
					marginBottom: 20,
				},
				title: {text: ''},
				subtitle: { text: '' },
				xAxis: { title: { text: '' }, type: 'datetime', tickInterval: null, label: { enabled: false }, dateTimeLabelFormats: { year: '%Y', month: '%m.%Y', week: '%e.%m', day: '%e.%m', second: '%e.%m', minute: '%e.%m', hour: '%e.%m' } },
				yAxis: {
					min: 0,
					title: {
						text: ''
					},
					minorGridLineWidth: 0.5,  minorTickInterval: 0.25, minorTickWidth:0 , minorGridLineColor: '#E8E8E8',
				},
				legend: { 
					layout: 'vertical', 
					backgroundColor: '#FFF', borderColor: '#fff', align: 'left', verticalAlign: 'top',  x: 440, y: 40, 
				},
				tooltip: {
					formatter: function() {
						return this.series.name +': <b>'+ this.y+'</b>';
					}
				},
				plotOptions: {
					column: {
						stacking: 'normal'
					}
				},
			    series: answers3
			});
			*/
			var width = 620 - 20;
			var days = ${selected_days}; //pocet dni vo vybranom intervale
			var computedPointWidth = (width/days > 2)?(width/days) : 2;
			var bottomMargin = 50 + Math.ceil((answers3.length) / 2)*16;
			var borderColor = (computedPointWidth > 2)? '#fff': null ; 
			var borderShadow = (computedPointWidth > 2)? true: false ;
			new Highcharts.Chart({
				chart: {
					renderTo: 'chart',
					defaultSeriesType: 'column',
					marginLeft: 30,
					marginRight: 3,
					marginTop: 10,
					marginBottom: bottomMargin
				},
				title: {
					text: ''
				},
				subtitle: { text: '' },
				xAxis: { title: { text: '' }, type: 'datetime', 
				tickInterval: null, 
				label: { enabled: false }, dateTimeLabelFormats: { year: '%Y', month: '%m.%Y', week: '%e.%m', day: '%e.%m', second: '%e.%m', minute: '%e.%m', hour: '%e.%m' } },
				
				yAxis: {
					min: 0,
					title: {
						text: ''
					},
					minorGridLineWidth: 0.5,  minorTickInterval: 0.25, minorTickWidth:0 , minorGridLineColor: '#E8E8E8',
				},
				legend: { 
					margin: 100,
					itemWidth: 280,
					itemStyle: {
						font: 'normal 12px Arial, sans-serif'
					},
					backgroundColor: '#FFF', borderColor: '#fff', 
					//align: 'left', 
					verticalAlign: 'bottom',  
					//x: 440, y: 40, 
					//lineHeight: 40, 
					symbolPadding: 5,
					labelFormatter: function() {
                        var name = this.name;
                        var subsName = name.substring(0,44);
                        if(subsName != name){
                            subsName+= "...";
                        }
                        return subsName;
                    }
				},
				tooltip: {
					formatter: function() {
						return Highcharts.dateFormat('%e.%m.%Y', this.x) +'<br/>'+ this.series.name +': <b>'+ this.y+'</b>';
					}
				},
				plotOptions: {
					column: {
        				stacking: 'normal',
        				borderColor: borderColor,
        				shadow: borderShadow,
        				pointWidth: computedPointWidth,
    				}
				},
			    series: answers3
			});
	});
		
	</script>
</jsp:body>	
	
</m:patientMasterMenu>
