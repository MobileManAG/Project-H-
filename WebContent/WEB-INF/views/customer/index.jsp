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
<m:customerMasterMenu>
	<script>
	$(document).ready(function() {
		$("#disease").change(function (){
			if($(this).val() != "0") {
				$("#exportsection").show();
			}else{
				$("#exportsection").hide();
			}
		});
	});
	</script>
	<div class="section">
	<form method="get" action="<c:url value="/customer/cd" />" name="changeDate">
	<div class="reportCaption" >Bitte w&auml;hlen Sie den gew&uuml;nschten Zeitraum aus.</div>
	<table style="width: 100%;">
		<tr>
			<td style="text-align: center;"><span id="date_from"></span></td>
			<td style="text-align: center;"><span id="date_to"" ></span></td>
		</tr>
	</table>
	<br />
	<t:daterange prefix="customer" all="true"/>	
	<br />
	<div id="dateInfoLeft">
	  Ausgew&auml;hlter Zeitraum:</div>
	<div id="dateInfoRight"><span id="date_from_text"></span> bis <span id="date_to_text"></span></div>
		<br />
	<input type="hidden" id="d_from" name="d_from" value="${date_from}" /> <input type="hidden" id="d_to" name="d_to" value="${date_to}" /></form>
	</div>
	<div class="section">
	<h3>Daten exportieren:</h3><br />
	
	<select name="disease" id="disease">
		<option value="0">Weitere Gesundheitsgruppen w&auml;hlen</option>
		<c:forEach var="dis" items="${diseases}">
			<option value="${dis.name}" <c:if test="${diseaseid}">selected</c:if>>${dis.name}</option>
		</c:forEach>
	</select>
	
	<div id="exportsection" style="display: none;">
	<br />
	<a href="<c:url value="/customer/cust/0" />">Alles exportieren</a><br /><br/>
		<c:forEach var="ex" items="${exports}">
			<a href="<c:url value="/customer/cust/${ex.id}" />">${ex.haqQuestion}</a><br />
		</c:forEach>
	</div>
	</div>

	<script>
  		var convDateFormat = 'yy-mm-dd';
		var dateFormat = '';
  		function changeDate(dateText, type) {
		   var date = $.datepicker.parseDate(dateFormat, dateText);
		   $("#" + type).val($.datepicker.formatDate(convDateFormat, date));
		   
		   document.forms["changeDate"].submit();
  		}
  		
  		$(document).ready(function() {
  			//datepickers
			$("#date_from").datepicker({
				onSelect: function(dateText, inst) {  changeDate(dateText, "d_from"); }
			});
			$("#date_to").datepicker({
					onSelect: function(dateText, inst) {  changeDate(dateText, "d_to"); }
			});
  		    dateFormat = $("#date_from").datepicker( "option", "dateFormat" );
			
  		    var dateFrom = $.datepicker.parseDate(convDateFormat, '${date_from}');
  		    var dateTo = $.datepicker.parseDate(convDateFormat, '${date_to}');
  		    $("#date_from").datepicker("setDate", dateFrom);
  		    $("#date_to").datepicker("setDate", dateTo);
  		    
  		    $("#date_from_text").text($.datepicker.formatDate(dateFormat, dateFrom));
  		  	$("#date_to_text").text($.datepicker.formatDate(dateFormat, dateTo));
  		});
</script>
</m:customerMasterMenu>
