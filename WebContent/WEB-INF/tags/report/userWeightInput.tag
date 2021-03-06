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
<div id="weightInfo" class="modal">
<h3><font color="#000000" face="Arial, Helvetica, sans-serif">Gewicht erfassen</font></h3>
<br />
<label class="opt"> Bitte erfassen Sie hier regelm&auml;ssig Ihr Gewicht, damit Sie einen l&uuml;ckenlosen Gewichtsverlauf
darstellen k&ouml;nnen. </label> <br />
<br />
<table width="430">
	<tr align="left">
		<td width="45"><label>Gewicht</label></td>
		<td><label></label></td>
		<td><label>Datum</label></td>
	</tr>
	<tr align="left">
		<td valign="top"><input style="width: 45px" name="weight" type="text" id="weightinput" align="right" onkeypress="validateNumber(event);"  maxlength="5" /></td>
		<td valign="top"><label>kg</label></td>
		<td valign="top"><input style="width: 198px; vertical-align: top; float: left;" name="date" type="text" id="datepicker"></td>
	</tr>
	<tr align="left">
		<td align="left">
		<div id="weighterror" style="display: none; text-align: left;" class="error">Fehlermeldung - Bitte nochmals versuchen.</div>
		<br />
		</td>
		<td><label></label></td>
		<td align="left">
		<div id="dateerror" style="display: none; text-align: left;" class="error">Fehlermeldung - Bitte nochmals versuchen.</div>
		<br />
		</td>
	</tr>
	<tr align="left">
		<td colspan="3" align="left"><!-- send --> <input id="enterweight" type="image" src="<c:url value="/images/button_speichern.png"/>" />
		<!-- clear --> <input id='cancelweight' type="image" src="<c:url value="/images/button_abbrechen_grau.png"/>" value="1" /> <br />
		</td>
	</tr>
	<tr>
		<td colspan="2" align="left">
		<div style="display: none; text-align: left;" class="error" id="sendingError">Fehlermeldung - Bitte nochmals versuchen.</div>
		</td>
	</tr>
</table>
</div>
<script>

	$(function() {
		
		$( "#datepicker" ).datepicker({
			showOn: "button",
			buttonImage: "<c:url value="/images/calendar.png" />",
			buttonImageOnly: true
		});
		
		$( "#datepicker" ).datepicker( "setDate" , 'Now' );
		
		$(".changeWeight").click(function(){
			resetChangeWeightModal();
			$.blockUI({ 
				message: $("#weightInfo") 
			});
		});
			
		$('#enterweight').click(function() { 
            if(validate() == true){
        		$.ajax({
					type: "POST",
					url: '<c:url value="/patient/einstellungen_profil/change_weight"/>',
					data: {
						weight: $('#weightinput').val(),
						weight_date_text: $('#datepicker').val()
					},
					success: function(msg){
					  if(msg == "ok"){
						  //var stringWeight = $('#weightinput').val()+"kg ("+ $('#datepicker').val() +")";
						  //$('#changeWeight').html(stringWeight);
						  //setTimeout($.unblockUI, 1000);
						  //$('#sendingError').hide();
						  //refresh current page - because chart dont shows new entered value
						  window.location.reload();
					  }
					  if(msg == "error"){
						  $('#sendingError').show();
					  }
					}
				});
            } 
        });  
        
        $('#cancelweight').click(function() { 
            $.unblockUI(); 
            
            $('#weightInfo').find(".error").each(function(index, domEle) {
        		$(this).css("display","none");
    		}); 
        });  
	});

	function validate() {
		var isValid = true;
		
		var input_value = $('#weightinput').val();
		if(input_value.length == 0){
			$('#weighterror').show();
			isValid = false;
		} else {
			$('#weighterror').hide();
		}

		var date_value = $('#datepicker').val();
		if(date_value.length == 0){
			$('#dateerror').show();
			isValid = false;
		} else {
			$('#dateerror').hide();
		}
	
		return isValid;
	}

	function resetChangeWeightModal() {
		$('#weightinput').val("");
		$('#datepicker').val("");
		$('#weighterror').hide();
		$('#dateerror').hide();
		$('#sendingError').hide();
	}
		
	function validateNumber(evt) {
		var theEvent = evt || window.event;
		var key = theEvent.keyCode || theEvent.which;
		key = String.fromCharCode( key );
		var regex = /[0-9]|\./;
		if( !regex.test(key) ) {
	    	theEvent.returnValue = false;
	    	theEvent.preventDefault();
	    	return false;
		}
		
		var preferredDecimalPoints =1 ;
		
		var decimalPointCount=0;
	
		var decimalNumber = document.getElementById("weightinput").value + key;
		
		if (decimalNumber.length > 5 || (decimalNumber > 400)) {
			theEvent.returnValue = false;
	    	theEvent.preventDefault();
	    	return false;
		}
	
		var pointFound=false;
	
		var decimalPlaces=0;
		
		for (var i=0;i< decimalNumber.length ;i++){
			var _char=decimalNumber.charAt(i);
			if(pointFound==true){
				decimalPlaces++;
			}
	
			if (_char==".") {
	
				pointFound=true;
	
				decimalPointCount++;
	
				if (decimalPointCount>1) {
					break;
				}
	
			} else if (isNaN(_char)) {
				alert(_char);
			}
		}
	
		if (decimalPointCount>1 || decimalPlaces > preferredDecimalPoints || isNaN(decimalNumber)) {
			theEvent.returnValue = false;
	    	theEvent.preventDefault();
	    	return false;
		}
	
		return true;
	}
			
</script>




