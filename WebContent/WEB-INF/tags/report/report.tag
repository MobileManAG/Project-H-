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
<%@ attribute name="prefix" required="true" %>

<div id="first_page_break"></div>
<div class="section"> 
	<r:patientHeader prefix="${prefix}" readonly="${prefix=='arzt' || canEditHeader==false}"/>
</div>
<c:choose>
	<c:when test="${showReportData==true}">
	<div class="section">
	<!-- 
		<div id="dateInfoLeft">Ausgew&auml;hlte Gesundheitsgruppe:</div>
		<div id="dateInfoLeft">&nbsp;${patient_selected_disease.name}</div>
	 -->
		<form method="POST" action="<c:url value="/${prefix}/changedate" />" name="changeDate">
		<div class="reportCaption" >
			Bitte w&auml;hlen Sie den gew&uuml;nschten Zeitraum aus.
		</div>
		<br />
		<table width="640" class="noborder">
			<tr>
				<td style="align: center; width: 320px">
					<label>Von</label>
				</td>
				<td style="align: left; width: 300px">
					<label>Bis</label>
				</td>
			</tr>
			<tr>
				<td style="align: center; width: 320px"><input style="width:120px; float:left; padding-left:5px;" name="date_from" type="text" id="date_from"><label class="opt">  TT/MM/JJJJ</label></td>
				<td style="align: right; width: 300px"><input style="width: 120px; float:left; padding-left:5px;" name="date_to" type="text" id="date_to"><label class="opt">  TT/MM/JJJJ</label></td>
			</tr>
		</table>
		<input type="hidden" id="d_from" name="d_from" value="${date_from}" /> 
		<input type="hidden" id="d_to" name="d_to" value="${date_to}" />
		</form>
		
		<br />
		<t:daterange prefix="${prefix}" />
				
		<br />
		<c:if test="${print}">
			<div class="section">
			<form style="display:none;" method="POST" action="<c:url value="/${prefix}/changedate" />" name="changeDate">
			<div class="reportCaption" >Bitte w&auml;hlen Sie den gew&uuml;nschten Zeitraum aus.</div>
			<br />
			<table style="width: 100%;">
				<tr>
					<td>
						<br />
						<br />
					</td>
				</tr>
				<tr>
					<td style="align: center; width: 302px">
						<label class="opt">Von</label>
					</td>
					<td style="align: left; width: 302px">
						<label class="opt">Bis</label>
					</td>
				</tr>
				<tr>
					<td style="align: center; width: 302px"><input style="width: 120px; float:left;" name="date_from" type="text" id="date_from"><label class="opt">  TT/MM/JJJJ</label></td>
					<td style="align: right; width: 302px"><input style="width: 120px; float:left;" name="date_to" type="text" id="date_to"><label class="opt">  TT/MM/JJJJ</label></td>
				</tr>
			</table>
			<input type="hidden" id="d_from" name="d_from" value="${date_from}" /> 
			<input type="hidden" id="d_to" name="d_to" value="${date_to}" />
			</form>
			</div>
		</c:if>
	</div>
	<%-- Page Break --%>
	<div class="page_break"></div>
	<div class="section">
	<%-- Medikamente --%>
	<div class="reportCaption" >Medikationstagebuch</div>
	<br />
		<c:choose>
		<c:when test="${diarydata_exists}">
		<div id="chart" style="width: 640px; height: 480px"></div>
		<br />
		<script>
			<c:if test="${wasSearch || wasEnter}">
				window.location.hash = "aftersearch";
			</c:if>
		
			///////////////
		    var tickIntervalComp = null;
		    
			var colors = [null, '#6cc0e8', '#ff6666', '#ffd355','#54b655','#feb300','#fc9400','#ed6330'];
			
			var index=0;
			
			var answers3 = [
			         <c:forEach var="diary" items="${diarydata}">
			    {	name: '${diary.name}', 
			    	data: [
						<c:forEach var="item" items="${diary.items}">{x:Date.UTC(${item.date}), y:${item.value}},
			    		</c:forEach>
			    	] , color: ((index>=colors.length)?null:colors[(index++) % colors.length])
			    	//] , color: (colors[(index++) % colors.length])
			    }, 
			    	</c:forEach>
			];
			
			$(document).ready(function() {
				
				var width = 640 - 50 -10;
				var days = ${selected_days}; //pocet dni vo vybranom intervale
				var computedPointWidth = (width/days > 2)?(width/days) : 2;
				var bottomMargin = 50 + Math.ceil((answers3.length) / 2)*16;
				var borderColor = (computedPointWidth > 2)? '#fff': null ; 
				var borderShadow = (computedPointWidth > 2)? true: false ;
				new Highcharts.Chart({
					chart: {
						renderTo: 'chart',
						defaultSeriesType: 'column',
						marginLeft: 50,
						marginRight: 10,
						marginTop: 40,
						marginBottom: bottomMargin
					},
					title: { text: 'Medikationstagebuch', style: { color: '#666' }, y: 15 },
					subtitle: { text: 'Alle Medikamente',  style: { color: '#ccc' }, y: 30 },
					xAxis: { 
						title: { text: '', style: { color: '#ccc' }, x: -20, y: 12}, 
						type: 'datetime', 
					tickInterval: tickIntervalComp,  
					dateTimeLabelFormats: { year: '%Y', month: '%m.%Y', week: '%e.%m', day: '%e.%m', second: '%e.%m', minute: '%e.%m', hour: '%e.%m' } 
					},
					
					yAxis: {
						min: 0,
						gridLineColor: '#e9e9e9',
						title: { text: 'Anzahl eingenommene Einheiten', style: { color: '#ccc' }}, 
						//minorGridLineWidth: 0.5,  minorTickInterval: 1, minorTickWidth:0 , minorGridLineColor: '#E8E8E8',
					},
					legend: { 
						margin: 100,
						itemWidth: 290,
						itemStyle: {
							font: 'normal 11px Arial, sans-serif',
							color: '#666'
						},
						backgroundColor: '#FFF', borderColor: '#fff', 
						//align: 'left', 
						verticalAlign: 'bottom',  
						//x: 440, y: 40, 
						//lineHeight: 40, 
						symbolPadding: 5,
						labelFormatter: function() {
	                        var name = this.name;
	                        var subsName = name.substring(0,45);
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
	        				shadow: false,
	        				pointWidth: computedPointWidth,
	    				}
					},
				    series: answers3
				});
		});
			
		</script>
		</c:when>
		<c:otherwise>
		<c:if test="${prefix=='patient'}">
		<div style="text-align: center;">
			<t:apatient href="medikamente_eingeben"><t:img src="dateneingeben.png" /></t:apatient>
		</div>
		</c:if>
		</c:otherwise>
	</c:choose>
	</div>
	
	<!-- KPI -->
	<div class="section">
	<c:forEach var="kpi" items="${kpis}">
		<%-- Page Break --%>
		<div class="page_break"></div>
		<div class="reportCaption" >${kpi[0].code}<c:if test="${kpi[1]!=null}">: ${kpi[1]}</c:if></div>
		<br />
		<div id="static_chart_kpi_${kpi[0].id}" style="width: 640px; height: 300px"></div>
		<c:if test="${is_doctor}">
			<br />
			<kpi:input id ="${kpi[0].id}" code="${kpi[0].code}" />
		</c:if>
		<br />
	</c:forEach>
	</div>
	
	
	<script>
	
		var day = 1000*3600*24*1;
		
		var tickIntervalComp = null;
		
		
	
		var convDateFormat = 'yy-mm-dd';
		var convDateTimeFormat = 'yy-mm-dd';
			
		var dateFormat = '';
		function changeDate(dateText, type) {
		   var date = $.datepicker.parseDate(dateFormat, dateText);
		   $("#" + type).val($.datepicker.formatDate(convDateFormat, date));
		   document.forms["changeDate"].submit();
		}
			
		var maxlentmp = 15;
		function formatLabel(text, maxlen) {
			if(maxlen==undefined) {
				maxlen = maxlentmp;
			}
			if(text.length<maxlen) {
				return text;
			}
			//find ' ' and replace
			index = text.indexOf(" ", maxlen);
			if(index<0) {
				return text;
			}
			return text.substr(0, index) + "<br/>" + formatLabel(text.substr(index+1), maxlen);
		}
	
		$(document).ready(function(){
			$("#date_from").datepicker({
				showOn: "button",
				buttonImage: "<c:url value="/images/calendar.png" />",
				buttonImageOnly: true,
				onSelect: function(dateText, inst) {  changeDate(dateText, "d_from"); }
			});
			$("#date_to").datepicker({
				showOn: "button",
				buttonImage: "<c:url value="/images/calendar.png" />",
				buttonImageOnly: true,
				onSelect: function(dateText, inst) {  changeDate(dateText, "d_to"); }
			});
	
			//fix for firefox
			$("#ui-datepicker-div").wrap('<div style="position:absolute;left:-2em;top:-1em"></div>');
			
			dateFormat = $("#date_from").datepicker( "option", "dateFormat" );
			dateFormatLong = dateFormat.replace("mm.", " MM ");
			
			$(".span_date_time").each(function (i) {
			  	var dt = $(this).text();
			  	var xx = dt.split(" ");
			  	var date = xx[0];
			  	var time = xx[1];
			
			  	var parsed_date = $.datepicker.parseDate(convDateTimeFormat, date);
			  	var new_date = $.datepicker.formatDate(dateFormatLong, parsed_date);
			
			  	var time_split = time.split(":");
			  	$(this).text(new_date + " " + time_split[0] + "." + time_split[1] + " Uhr");
			});
			  
			var dateFrom = $.datepicker.parseDate(convDateFormat, '${date_from}');
			var dateTo = $.datepicker.parseDate(convDateFormat, '${date_to}');
			
			var ms = dateTo.getTime() - dateFrom.getTime();
			if(ms < 4 * day) {
				tickIntervalComp = day;
			}
			
			$("#date_from").datepicker("setDate", dateFrom);
			$("#date_to").datepicker("setDate", dateTo);
			
			/////////////////////////////////////////////////////
			//KPI
			//chart cdai
			<c:forEach var="kpi" items="${kpis}"> 
	
			 var data_kpi = [<c:forEach var="q" items="${kpi[2]}">{${q}},</c:forEach>];
			<c:if test="${is_doctor}">
			  	var data_mkpi = [<c:forEach var="q" items="${kpi[3]}">{${q}},</c:forEach>];
			</c:if>
			  new Highcharts.Chart({
					chart: { renderTo: 'static_chart_kpi_${kpi[0].id}', margin: [40, 10, 50, 50], backgroundColor: "#FFF", plotBackgroundColor: "#FFF", defaultSeriesType: 'area'},
					title: { text: '${kpi[0].description}', style: { color: '#666' }, y: 15 },
					subtitle: { text: '${kpi[0].code}',  style: { color: '#ccc' }, y: 30 },
					xAxis: { 
						title: { text: 'Zeitlicher Verlauf', style: { color: '#ccc' }, x: -20, y: 12}, 
						type: 'datetime', 
						tickInterval: tickIntervalComp, 
						dateTimeLabelFormats: { year: '%Y', month: '%m.%Y', week: '%e.%m', day: '%e.%m', second: '%e.%m', minute: '%e.%m', hour: '%e.%m' } 
					},
					yAxis: { 
						gridLineColor: '#e9e9e9',
						title: { text: 'Schlüsselwerte', style: { color: '#ccc' }}, 

						//minorGridLineWidth: 0.5,  minorTickInterval: 1, minorTickWidth:0 , minorGridLineColor: '#E8E8E8'
					},
					plotOptions: {
   						area: {				
   							fillOpacity: 0.5,
   							marker: {
   								symbol: 'circle'
   							}
   						}
   					},
					legend: { enabled: false },
					tooltip: {
						formatter: function() {
							return this.series.name +' <b>'+
								Highcharts.numberFormat(this.y, 1, '.', ' ') +'</b><br/>'+ Highcharts.dateFormat('%e.%m.%Y', this.x);
						}
					},
					series: [
					<c:if test="${is_doctor}">
					{ 
						name: 'Manuelle Eingabe ${kpi[0].code}',  
						color: '#ff6666', 
						data: data_mkpi
						//fillOpacity: 0.001,
						//lineColor: '#f9ff00', 
					},
					</c:if>
					{ 
						name: '${kpi[0].code}',  
						color: '#6cc0e8',
						data: data_kpi
						//fillColor: '#5093c1', 
						//lineColor: '#54B655', 
					}
					
					]
			});	//new Highcharts.Chart	
	
			</c:forEach>
		});
	</script>
	
	<c:choose>
		<c:when test="${chart_data_exists}">

			<c:forEach var="haq" items="${haqs}">
				<div class="section">
					<%-- Page Break --%>
					<div class="page_break"></div>
					<div class="reportCaption" >${haq.haqQuestion}</div>
						<c:forEach var="haq_chart" items="${haq_charts[haq.id]}"  varStatus="status">
							<c:if test="${haq_chart.chartType!=null}">
								<c:set var="currentHaqChart" value="${haq_chart}" scope="request" />
								<c:choose>
									<c:when test="${haq_chart.chartType.type==null}">
										<c:import url="../../tags/report/charts/${haq_chart.chartType.extChartType}.jsp" />
									</c:when>
									<c:otherwise>
										<c:import url="../../tags/report/charts/${haq_chart.chartType.type}.jsp" />
									</c:otherwise>
								</c:choose>
								<c:if test="${status.last == false}">
									<div class="reportSeparator" ></div>
								</c:if>
							</c:if>
						</c:forEach>
					</div>
			</c:forEach>
			
			<%-- user weights --%>
			<div class="section">
				<%-- Page Break --%>
				<div class="page_break"></div>
				<div class="reportCaption" >
					<h3>
						<font face="Arial, Helvetica, sans-serif">Gewicht</font>
					</h3>
				</div>
				<r:lineImpl id="weight" data="${weights}" title="Gewicht" subtitle="Angabe über Gewichtsverlauf" 
					xlabel="Zeitlicher Verlauf" ylabel="Kilogramm" color="#54b655"/>
			</div>
		</c:when>
		<c:otherwise>
		
		<c:if test="${prefix=='patient'}">
		<div style="text-align: center;">
			<t:apatient href="online_fragebogen"><t:img src="dateneingeben.png" /></t:apatient>
		</div>
		</c:if>
		
		</c:otherwise>
	</c:choose>
	
	
	</c:when>
	<c:otherwise>
		<table style="width: 604px;">
			<tr>
				<td style="text-align: left; vertical-align: top;">
					<div>
						<div id="rectheadcomp">
							<h3>
								<label class="black">${user.name.name} ${user.name.surname}</label>
							</h3>
						</div>
							<br />
							<br />
							<label class="black">Das projecth&reg; Mitglied hat Sie nicht autorisiert, seine Daten anzuzeigen</label>
							<br />
					</div>
				</td>
			</tr>
		</table>
	</c:otherwise>
</c:choose>
